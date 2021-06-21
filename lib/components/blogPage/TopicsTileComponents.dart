import 'package:flutter/material.dart';

/// Topics are the coding languages that are being explained in blog posts
///
/// Most viewed and written topics are shown below the featured post section.
class Topic {
  /// The name of the topic.
  final String name;

  /// Official logo/mascot of the coding language.
  final ImageProvider icon;

  /// The number of posts written under this topic.
  ///
  /// This will be read from the metadata of the website.
  final int noOfPosts;

  const Topic({required this.name, required this.icon, required this.noOfPosts});

  @override
  String toString() {
    return 'Topic{name:${this.name}, icon:${this.icon.toString()}, number of posts: ${this.noOfPosts}}';
  }

  @override
  noSuchMethod(Invocation invocation) {
    return '$invocation is not defined in ${this.runtimeType}';
  }
}

/// The container that shows the topic
class TopicContainer extends StatefulWidget {
  _TopicContainerState createState() => _TopicsContainerState();
}

class _TopicContainerState extends State<TopicContainer> {}
