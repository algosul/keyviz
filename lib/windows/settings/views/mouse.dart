import 'package:flutter/material.dart';
import 'package:keyviz/windows/settings/widgets/cross_number_input.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_event.dart';
import 'package:keyviz/providers/key_style.dart';

import '../widgets/widgets.dart';

class MouseTabView extends StatelessWidget {
  const MouseTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PanelItem(
          title: "鼠标点击可视化",
          subtitle: "点击鼠标时显示高亮",
          action: Selector<KeyEventProvider, bool>(
            selector: (_, keyEvent) => keyEvent.showMouseClicks,
            builder: (context, showMouseClicks, _) => XSwitch(
              value: showMouseClicks,
              onChange: (value) {
                context.keyEvent.showMouseClicks = value;
              },
            ),
          ),
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (context, enabled, _) {
            return PanelItem(
              enabled: enabled,
              title: "点击动画",
              action: Selector<KeyStyleProvider, MouseClickAnimation>(
                selector: (_, keyStyle) => keyStyle.clickAnimation,
                builder: (context, value, _) {
                  return XDropdown<MouseClickAnimation>(
                    value: value,
                    options: MouseClickAnimation.values,
                    onChanged: (value) {
                      context.keyStyle.clickAnimation = value;
                    },
                  );
                },
              ),
            );
          },
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (context, enabled, _) => PanelItem(
            enabled: enabled,
            title: "高亮颜色",
            subtitle: "鼠标光标周围高亮的颜色",
            actionFlex: 2,
            action: RawColorInputSubPanelItem(
              label: "鼠标高亮颜色",
              defaultValue: context.keyStyle.clickColor,
              onChanged: (color) => context.keyStyle.clickColor = color,
            ),
          ),
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (_, enabled, __) => PanelItem(
            enabled: enabled,
            title: "保持高亮",
            subtitle: "一直显示鼠标光标周围的高亮",
            action: Selector<KeyEventProvider, bool>(
              selector: (_, keyEvent) => keyEvent.highlightCursor,
              builder: (context, highlightCursor, _) => XSwitch(
                value: highlightCursor,
                onChange: (value) {
                  context.keyEvent.highlightCursor = value;
                },
              ),
            ),
          ),
        ),
        const Divider(),
        PanelItem(
          title: "拖动阈值",
          subtitle: "显示拖动事件的最小距离。设置为较高的值，可避免意外显示拖动事件。",
          action: XNumberInput(
            title: "拖动阈值",
            suffix: "px",
            defaultValue: context.keyEvent.dragThreshold.toInt(),
            onChanged: (value) {
              context.keyEvent.dragThreshold = value.toDouble();
            },
          ),
        ),
        const Divider(),
        PanelItem(
          title: "显示鼠标事件",
          subtitle: "可视化鼠标事件，例如点击，拖动等事件",
          action: Selector<KeyEventProvider, bool>(
            selector: (_, keyEvent) => keyEvent.showMouseEvents,
            builder: (context, showMouseEvents, _) => XSwitch(
              value: showMouseEvents,
              onChange: (value) {
                context.keyEvent.showMouseEvents = value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
