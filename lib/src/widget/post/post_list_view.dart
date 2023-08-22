import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:fireflutter/src/model/post.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// PostListView
///
/// Dispaly posts in a list view.
class PostListView extends StatefulWidget {
  const PostListView({
    super.key,
    this.itemBuilder,
    this.emptyBuilder,
    this.pageSize = 10,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.category,
  });

  final int pageSize;
  final Widget Function(BuildContext, Post)? itemBuilder;
  final Widget Function(BuildContext)? emptyBuilder;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Clip clipBehavior;
  final Category? category;

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Category Id: ${widget.category?.id ?? ''}");
    return FirestoreListView(
      query: widget.category ==
              null // TODO review because it will display a full list first before adding the category filter
          ? PostService.instance.postCol
          : PostService.instance.postCol.where('categoryId', isEqualTo: widget.category!.id),
      itemBuilder: (context, QueryDocumentSnapshot snapshot) {
        final post = Post.fromDocumentSnapshot(snapshot);
        if (widget.itemBuilder != null) {
          return widget.itemBuilder!(context, post);
        } else {
          return ListTile(
            title: Text(post.title),
            onTap: () {
              PostService.instance.showPostDialog(context, post);
            },
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.content),
              ],
            ),
          );
        }
      },
      emptyBuilder: (context) {
        if (widget.emptyBuilder != null) {
          return widget.emptyBuilder!(context);
        } else {
          return Center(child: Text(tr.post.noPost));
        }
      },
      errorBuilder: (context, error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return Center(child: Text('Error loading posts $error'));
      },
      pageSize: widget.pageSize,
      controller: widget.scrollController,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      clipBehavior: widget.clipBehavior,
    );
  }
}