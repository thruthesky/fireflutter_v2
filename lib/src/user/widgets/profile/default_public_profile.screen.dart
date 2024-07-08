import 'dart:io';

import 'package:fireflutter/fireflutter.dart';
import 'package:fireflutter/src/user/widgets/buttons/share_button.dart';
import 'package:flutter/material.dart';

/// [chatButton] appears only if they are mutual friends.
class DefaultPublicProfileScreen extends StatelessWidget {
  const DefaultPublicProfileScreen({
    super.key,
    this.uid,
    this.user,
    this.friendRequestButton = true,
    this.chatButton = true,
    this.likeButton = true,
    this.bookmarkButton = true,
    this.reportButton = true,
    this.blockButton = true,
    this.shareButton = true,
  });

  final String? uid;
  final User? user;

  final bool friendRequestButton;
  final bool chatButton;
  final bool likeButton;
  final bool bookmarkButton;
  final bool reportButton;
  final bool blockButton;
  final bool shareButton;

  String get userUid => uid ?? user!.uid;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: UserBackgroundImage.sync(
            uid: userUid,
            user: user,
          ),
        ),
        const GradientTopDown(height: 220),
        const GradientBottomUp(height: 220),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                itemBuilder: (context) {
                  return [
                    if (userUid == myUid) ...[
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(T.profileUpdate.tr),
                      ),
                      PopupMenuItem(
                        value: 'backgroundImage',
                        child: Text(T.backgroundUpdate.tr),
                      ),
                    ],
                    const PopupMenuItem(
                      value: 'seeFriends',
                      child: Text("See Friends"),
                    ),
                    if (userUid == myUid) ...[
                      PopupMenuItem(
                        value: 'respondFriendRequests',
                        child: Text(T.respondFriendRequests.tr),
                      ),
                      PopupMenuItem(
                        value: 'pendingRequests',
                        child: Text(T.mySentFriendRequests.tr),
                      ),
                    ],
                  ];
                },
                onSelected: (value) {
                  if (value == 'edit') {
                    UserService.instance
                        .showProfileUpdateScreen(context: context);
                  } else if (value == 'backgroundImage') {
                    StorageService.instance.uploadAt(
                      context: context,
                      path:
                          "${User.node}/$userUid/${Field.profileBackgroundImageUrl}",
                    );
                  } else if (value == 'seeFriends') {
                    FriendService.instance
                        .showListScreen(context: context, uid: userUid);
                  } else if (value == 'respondFriendRequests') {
                    FriendService.instance
                        .showReceivedListScreen(context: context);
                  } else if (value == 'pendingRequests') {
                    FriendService.instance.showSentListScreen(context: context);
                  }
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                const Spacer(),
                UserAvatar.sync(uid: userUid, size: 100, radius: 40),
                const SizedBox(height: 8),
                UserDisplayName.sync(
                  uid: userUid,
                  user: user,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Value(
                  ref: Friend.myListRef.child(userUid),
                  builder: (
                    friend,
                  ) {
                    if (friend != null) {
                      return Text(
                        'Friends',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                UserStateMessage.sync(
                  uid: userUid,
                  user: user,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (friendRequestButton)
                          FriendRequestButton(uid: userUid),
                        if (chatButton) ChatButton(otherUid: userUid),
                        if (likeButton) LikeButton(uid: userUid, user: user),
                        if (bookmarkButton) BookmarkButton(uid: userUid),
                        if (reportButton) ReportButton(uid: userUid),
                        if (blockButton) BlockButton(uid: userUid),
                        if (LinkService.instance.initialized && shareButton)
                          ShareButton(
                            link: LinkService.instance
                                .generateProfileLink(userUid),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
