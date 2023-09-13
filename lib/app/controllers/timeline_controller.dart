import 'dart:developer';

import 'package:cartisan/api_root.dart';
import 'package:cartisan/app/controllers/auth_service.dart';
import 'package:cartisan/app/models/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineController extends GetxController {
  final as = Get.find<AuthService>();
  final dio = Dio();

  Rx<List<PostModel>> timelinePosts = Rx<List<PostModel>>(<PostModel>[]);

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchPostsTheFirstTime();
    super.onInit();
  }

  Future<void> addItems() async {
    final posts = await fetchPosts(5);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        log('adding new posts');
        timelinePosts.value.addAll(posts);
        update();
      }
    });
  }

  Future<void> fetchPostsTheFirstTime() async {
    await fetchPosts(10);
    update();
  }

  Future<List<PostModel>> fetchPosts(
    int count,
  ) async {
    try {
      final apiCall = '$apiRoot/api/timeline/fetchPosts/${as.user!.uid}/$count';
      if(timelinePosts.value.isNotEmpty){
        final lastPost = timelinePosts.value.;
        docRef ;
      }
      final result = await dio.get<Map>(apiCall);
      if (result.statusCode != 200) {
        throw Exception('Error fetching posts');
      }
      final posts = result.data!['result'] as List;
      final newPosts = <PostModel>[];
      for (final post in posts) {
        final newPost = PostModel.fromMap(post as Map<String, dynamic>);
        newPosts.add(newPost);
      }
      return newPosts;
    } on Exception catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
      );
      return <PostModel>[];
    }
  }
}
