import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fireflutter/fireflutter.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting>
    with FireFlutterMixin {
  final commentNotification = "notify-new-comment-under-my-posts-and-comments";

  List<CategoryModel>? categories;

  bool loadingAllNotification = false;

  @override
  void initState() {
    super.initState();

    /// TODO let developer customize the listing of categories.
    CategoryService.instance
        .loadCategories(categoryGroup: 'community')
        .then((value) => setState(() => categories = value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MySettingsDoc(builder: (settings) {
          return SwitchListTile(
            title: Text('Notify new comments'),
            subtitle: Text(
                'Receive notifications of new comments under my posts and comments'),
            value: settings?[commentNotification] ?? false,
            onChanged: ((value) async {
              await updateMySettings({commentNotification: value});
            }),
          );
        }),
        SizedBox(height: 32),
        if (categories != null) ...[
          Text('Notifications for new posts'),
          for (final category in categories!)
            NotificationSettingsItem(category: category, type: 'post'),
          SizedBox(height: 32),
          Text('Notifications for new comments'),
          for (final category in categories!)
            NotificationSettingsItem(category: category, type: 'comment'),
        ],
      ],
    );
  }
}

class NotificationSettingsItem extends StatelessWidget with FireFlutterMixin {
  const NotificationSettingsItem({
    Key? key,
    required this.category,
    required this.type,
  }) : super(key: key);

  final CategoryModel category;
  final String type;

  @override
  Widget build(BuildContext context) {
    String id = '$type-create.${category.id}';
    return MySettingsDoc(
      id: id,
      builder: (settings) {
        return CheckboxListTile(
          value: settings == null ? false : true,
          onChanged: ((value) async {
            if (value == true) {
              await updateMySettings(id: id, {
                'action': '$type-create',
                'category': category.id,
              });
            } else {
              await deleteMySettings(id);
            }
          }),
          title: Text(category.title),
        );
      },
    );
  }
}
