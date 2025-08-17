import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/windows/shared/shared.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: defaultBorderRadius,
                border: Border.all(color: context.colorScheme.outline),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/img/logo.svg",
                    height: defaultPadding * 3.5,
                  ),
                  const SmallColumnGap(),
                  Text(
                    "Keyviz 2.0.0-alpha3",
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    "by Rahul Mula",
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SmallRowGap(),
            Expanded(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: defaultBorderRadius,
                  border: Border.all(color: context.colorScheme.outline),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SvgPicture.asset(
                        "assets/img/keycap-grid.svg",
                        width: defaultPadding * 9,
                        height: defaultPadding * 9,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        defaultPadding * 1.5,
                      ).copyWith(right: defaultPadding * 4),
                      child: Text(
                        "这是一个alpha测试版本，因此有很多BUG。"
                        "如果您发现任何错误请报告给我们！",
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: defaultPadding * 1.5,
                    //   bottom: defaultPadding * 1.5,
                    //   child: RichText(
                    //     text: const TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: "⌨️",
                    //           style: TextStyle(fontSize: 40),
                    //         ),
                    //         TextSpan(
                    //           text: "🖱️",
                    //           style: TextStyle(fontSize: 30),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      left: defaultPadding * 1.5,
                      bottom: defaultPadding * 1.5,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => launchUrlString(
                              "https://discord.gg/qyrKWCvtEq",
                            ),
                            tooltip: "Discord",
                            icon: const SvgIcon(
                              icon: "assets/img/discord-logo.svg",
                              size: defaultPadding * .8,
                            ),
                          ),
                          IconButton(
                            onPressed: () => launchUrl(
                              Uri.parse(
                                  "https://mail.google.com/mail/u/0/#inbox?compose=DmwnWtMgBvjfGQMlLgJZwhjKxPxXLmmfCXbkrBKwrtdFgVwmlDQmmNRjhbJdnQzGhwwPMDsdQnLv"),
                            ),
                            tooltip: "邮箱（rahulmula10@gmail.com）",
                            icon: const SvgIcon(icon: VuesaxIcons.mail),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SmallColumnGap(),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: defaultBorderRadius,
                  border: Border.all(color: context.colorScheme.outline),
                ),
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "💻 来自开发者的话",
                      style: context.textTheme.titleLarge,
                    ),
                    const VerySmallColumnGap(),
                    Text(
                      "嗨，我是keyviz的开发者Rahul Mula。"
                      "我是一名老师，在线上课。\n\n"
                      "在录制我的屏幕时，我总是觉得需要"
                      "向观众展示我的按键。那时我"
                      "决定开发keyviz，并与他人分享，"
                      "帮助和我有相同需求的人。",
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SmallRowGap(),
            Container(
              height: 250,
              width: 200,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: defaultBorderRadius,
                border: Border.all(color: context.colorScheme.outline),
              ),
              padding: const EdgeInsets.all(defaultPadding * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "💖 支持",
                    style: context.textTheme.titleLarge,
                  ),
                  const VerySmallColumnGap(),
                  Text(
                    "由于keyviz是免费软件，我唯一可以赚钱的方法是"
                    "通过您的慷慨捐赠。这有助于解放我的时间"
                    "并在keyviz上投入更多时间。",
                    style: context.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => launchUrlString(
                          "https://github.com/sponsors/mulaRahul",
                        ),
                        tooltip: "通过 Github 赞助",
                        icon: const SvgIcon(icon: "assets/img/github-logo.svg"),
                      ),
                      IconButton(
                        onPressed: () => launchUrlString(
                          "https://opencollective.com/keyviz",
                        ),
                        tooltip: "通过 Open Collective 赞助",
                        icon: SvgPicture.asset(
                          "assets/img/opencollective-logo.svg",
                          width: defaultPadding,
                          height: defaultPadding,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
