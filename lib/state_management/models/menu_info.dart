import 'package:clock_bloc/state_management/models/enums.dart';

class MenuInfo {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(
    this.menuType, {
    required this.title,
    required this.imageSource,
  });

  updateMenu(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;
  }
}
