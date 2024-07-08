import 'package:example/screens/buyandsell/buyandsell.screen.dart';
import 'package:example/screens/chat/chat.screen.dart';
import 'package:example/screens/chat/open_chat.domain.screen.dart';
import 'package:example/screens/chat/open_chat.screen.dart';
import 'package:example/screens/entry/entry.screen.dart';
import 'package:example/screens/forum/forum.screen.dart';
import 'package:example/screens/forum/forum_search.screen.dart';
import 'package:example/screens/forum/latest.posts.screen.dart';
import 'package:example/screens/forum/post_list_by_group.screen.dart';
import 'package:example/screens/meetup/meetup.screen.dart';
import 'package:example/screens/password_reset/password_reset.screen.dart';
import 'package:example/screens/user/user.search.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Login(
            yes: (uid) {
              return Column(
                children: [
                  UserAvatar(
                    uid: uid,
                    sync: true,
                  ),
                  Text(
                      "Logged in as ${my?.displayName}, ${FirebaseAuth.instance.currentUser?.email}, $uid"),
                  Text("Admin: ${AdminService.instance.isAdmin}"),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                          onPressed: () => UserService.instance
                              .showProfileUpdateScreen(context: context),
                          child: const Text('Profile Update')),
                      ElevatedButton(
                        onPressed: () async {
                          await UserService.instance.signOut();
                          if (context.mounted) {
                            context.go(EntryScreen.routeName);
                          }
                        },
                        child: const Text('Sign Out'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(ChatScreen.routeName),
                        child: const Text('Chat'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(OpenChatScreen.routeName),
                        child: const Text('Open Chat'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(ForumScreen.routeName),
                        child: const Text('Forum'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(PostListByGroupScreen.routeName),
                        child: const Text('Post list by group'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(LatestPostsScreen.routeName),
                        child: const Text('Latest Posts'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(ForumSearchScreen.routeName),
                        child: const Text('Forum Search'),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(MeetupScreen.routeName),
                        child: const Text('Meetup'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(BuyAndSellScreen.routeName),
                        child: const Text('Buy & Sell'),
                      ),
                      ElevatedButton(
                        onPressed: () => AdminService.instance
                            .showDashboard(context: context),
                        child: const Text('Admin dashboard'),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(UserSearchScreen.routeName),
                        child: const Text('User Search'),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     _backfillSearchValue();
                      //   },
                      //   child: const Text("Backfill Search Value"),
                      // ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(PasswordResetScreen.routeName),
                        child: const Text("Reset password"),
                      ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showListScreen(context: context),
                      //   child: const Text("Friend List"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showReceivedListScreen(context: context),
                      //   child: const Text("My Friend Requests (received)"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showSentListScreen(context: context),
                      //   child: const Text("My Friend Requests (sent)"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showListScreen(context: context),
                      //   child: const Text("Friend List"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showReceivedListScreen(context: context),
                      //   child: const Text("My Friend Requests (received)"),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () => FriendService.instance
                      //       .showSentListScreen(context: context),
                      //   child: const Text("My Friend Requests (sent)"),
                      // ),
                      ElevatedButton(
                        onPressed: () =>
                            context.push(OpenChatDomainScreen.routeName),
                        child: const Text("Open Chat Domain Screen"),
                      ),
                    ],
                  ),
                ],
              );
            },
            no: () => const Text("Not logged in"),
          ),
          const Expanded(
            child: UserListView(),
          )
        ],
      ),
    );
  }

  /// This will add searchValue field in all users under users node
  // _backfillSearchValue() async {
  //   // Get all users
  //   final users = FirebaseDatabase.instance.ref('users');
  //   final snapshot = await users.get();
  //   final usersMapList = snapshot.children.map((e) {
  //     // e.value!.["displayName"];
  //     final user = Map<String, dynamic>.from(e.value! as Map<dynamic, dynamic>);
  //     final searchValue = ((user["displayName"] ?? "") as String)
  //         .trim()
  //         .replaceAll(' ', '')
  //         .toLowerCase();
  //     e.ref.child('searchValue').set(searchValue);
  //     return e.value;
  //   }).toList();
  //   dog("Snapshot: $usersMapList");
  //   // On each user set searchValue: ""
  // }
}
