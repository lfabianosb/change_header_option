import 'package:flutter/foundation.dart';

enum InfoOption { option1, option2 }

class InfoModel extends ChangeNotifier {
  bool _loading = false;
  InfoOption _option = InfoOption.option1;
  String _message = 'Option option1 selected';

  void setOption(InfoOption info) async {
    _loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _option = info;
    _message = 'Option ${info.name} selected';
    _loading = false;
    notifyListeners();
  }

  String get message => _message;
  bool get loading => _loading;
  InfoOption get option => _option;
}
