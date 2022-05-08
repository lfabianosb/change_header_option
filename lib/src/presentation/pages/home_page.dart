import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/info_model.dart';
import 'second_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = context.watch<InfoModel>();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Page 1',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xff003918),
                borderRadius: BorderRadius.all(
                  Radius.circular(48),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      info.option.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: info.loading
                        ? null
                        : () async {
                            InfoOption? selected = await showMenu<InfoOption>(
                              context: context,
                              position:
                                  RelativeRect.fromLTRB(width, 110, width, 110),
                              items: [
                                const PopupMenuItem<InfoOption>(
                                  value: InfoOption.option1,
                                  child: Text('Option 1'),
                                ),
                                const PopupMenuItem<InfoOption>(
                                  value: InfoOption.option2,
                                  child: Text('Option 2'),
                                ),
                              ],
                            );
                            if (selected != null) {
                              info.setOption(selected);
                            }
                          },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoModel info = context.watch<InfoModel>();
    if (info.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Expanded(
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SecondPage(),
                  ),
                );
              },
              child: const Text('Page 1'),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(info.message),
          ),
        ),
      ],
    );
  }
}
