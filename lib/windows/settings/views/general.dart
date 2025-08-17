import 'package:flutter/material.dart';
import 'package:keyviz/windows/settings/widgets/hotkey_input.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_event.dart';

import '../widgets/widgets.dart';

class GeneralTabView extends StatelessWidget {
  const GeneralTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PanelItem(
          title: "显示模式",
          subtitle: "显示模式",
          action: Selector<KeyEventProvider, TopWindowMode>(
            selector: (_, keyEvent) => keyEvent.topWindow,
            builder: (context, historyMode, __) {
              return XDropdown<TopWindowMode>(
                value: historyMode,
                options: TopWindowMode.values,
                onChanged: (value) {
                  context.keyEvent.topWindow = value;
                },
              );
            },
          ),
        ),
        const Divider(),
        PanelItem(
          title: "热键过滤器",
          subtitle: "过滤字母，数字，符号等。"
              "而且仅显示热键/键盘快捷键",
          action: Selector<KeyEventProvider, bool>(
            selector: (_, keyEvent) => keyEvent.filterHotkeys,
            builder: (_, filterHotkeys, __) => XSwitch(
              value: filterHotkeys,
              onChange: (bool value) {
                context.keyEvent.filterHotkeys = value;
              },
            ),
          ),
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.filterHotkeys,
          builder: (_, filterHotkeys, __) => PanelItem(
            asRow: false,
            enabled: filterHotkeys,
            title: "忽略按键",
            subtitle: "根据下面的控制键忽略按键",
            action: const _IgnoreKeyOptions(),
          ),
        ),
        const Divider(),
        PanelItem(
          title: "显示历史记录",
          subtitle: "将之前按下的键保留",
          action: Selector<KeyEventProvider, VisualizationHistoryMode>(
            selector: (_, keyEvent) => keyEvent.historyMode,
            builder: (context, historyMode, __) {
              return XDropdown<VisualizationHistoryMode>(
                value: historyMode,
                options: VisualizationHistoryMode.values,
                onChanged: (value) {
                  context.keyEvent.historyMode = value;
                },
              );
            },
          ),
        ),
        const Divider(),
        PanelItem(
          asRow: false,
          title: "可视化切换快捷方式",
          action: HotkeyInput(
            initialValue: context.keyEvent.keyvizToggleShortcut,
            onChanged: (value) => context.keyEvent.keyvizToggleShortcut = value,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showDialog(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.red.withOpacity(.2),
                textStyle: context.textTheme.labelSmall,
                padding: const EdgeInsets.all(defaultPadding * .5),
                minimumSize: const Size(defaultPadding, defaultPadding * 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultPadding * .6),
                ),
              ),
              child: const Text("还原为默认值"),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("您要恢复为默认设置吗？"),
        backgroundColor: context.colorScheme.primaryContainer,
        titleTextStyle: context.textTheme.titleLarge,
        actions: [
          OutlinedButton(
            onPressed: () {
              // revert to defaults
              context.keyEvent.revertToDefaults();
              context.keyStyle.reverToDefaults();

              Navigator.of(context).pop();
            },
            child: const Text("还原"),
          ),
          OutlinedButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("取消"),
          ),
        ],
        elevation: 0,
      ),
    );
  }
}

class _IgnoreKeyOptions extends StatelessWidget {
  const _IgnoreKeyOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * .5),
      decoration: BoxDecoration(
        color: context.isDark
            ? context.colorScheme.primaryContainer
            : context.colorScheme.background,
        borderRadius: BorderRadius.circular(defaultPadding * .5),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          for (final modifierKey in ModifierKey.values)
            Selector<KeyEventProvider, bool>(
              selector: (_, keyEvent) => keyEvent.ignoreKeys[modifierKey]!,
              builder: (context, ignoring, __) => _KeyOption(
                name: modifierKey.keyLabel,
                ignoring: ignoring,
                onTap: () {
                  context.keyEvent.setModifierKeyIgnoring(
                    modifierKey,
                    !ignoring,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _KeyOption extends StatelessWidget {
  const _KeyOption({
    required this.name,
    required this.ignoring,
    required this.onTap,
  });

  final String name;
  final bool ignoring;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bgColor =
        ignoring ? context.colorScheme.tertiary.withOpacity(.35) : Colors.black;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: defaultPadding * 1.5,
          margin: const EdgeInsets.only(
            right: defaultPadding * .5,
            bottom: defaultPadding * .2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * .5),
          decoration: BoxDecoration(
            color: ignoring
                ? context.colorScheme.secondaryContainer
                : context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(defaultPadding * .4),
            border: Border.all(color: bgColor),
            boxShadow: [
              BoxShadow(
                color: bgColor,
                offset: const Offset(0, defaultPadding * .2),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
              color: context.isDark && !ignoring ? Colors.white : bgColor,
              fontSize: defaultPadding * .75,
            ),
          ),
        ),
      ),
    );
  }
}
