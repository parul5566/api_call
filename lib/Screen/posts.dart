import 'package:api_call/Screen/post_detail.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';


class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post>? posts = snapshot.data;
            return ListView(
              children: posts!
                  .map(
                    (Post post) => InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PostDetail(post: post)),
                        );
                      },
                      child: Column(
                        children: [
                          Text("${post.id}"),
                          SizedBox(height: 10),
                          Text(post.title),
                          SizedBox(height: 20),
                          Text("${post.userId}"),

                        ],
                      ),
                    ),
              )
                  .toList(),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}