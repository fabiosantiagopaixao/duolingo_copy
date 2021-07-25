import 'package:duolingo_copy/models/contants.dart';
import "package:mobx/mobx.dart";

part "screen_store.g.dart";

class ScreenStore = _ScreenStore with _$ScreenStore;

abstract class _ScreenStore with Store {

  @observable
  int selectedScreen = Constants.HOME_TAB;

  @action
  void changeScreen(int screenIndex) {
    selectedScreen = screenIndex;
  }
}
