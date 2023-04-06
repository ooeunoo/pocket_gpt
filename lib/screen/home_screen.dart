import 'package:flutter/material.dart';

class RoleChatScreen extends StatefulWidget {
  const RoleChatScreen({super.key});

  @override
  State<RoleChatScreen> createState() => _RoleChatScreenState();
}

class _RoleChatScreenState extends State<RoleChatScreen> {
  @override
  Widget build(BuildContext context) {
    // 테마
    ThemeData theme = Theme.of(context);

    // 사이즈
    double screenHeight = MediaQuery.of(context).size.height;
    double storyHeight = screenHeight * 0.15; // 스토리
    double feedHeight = screenHeight * 0.85; // 피드

    return Scaffold(
        appBar: AppBar(
          title: Text('', style: theme.textTheme.titleLarge),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: storyHeight,
              child: ListView.builder(
                itemCount: stories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final story = stories[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: 70,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(story.userAvatar),
                          radius: 35,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          story.username,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: feedHeight,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(post.userAvatar),
                        ),
                        title: Text(
                          post.username,
                          style: theme.textTheme.bodyLarge,
                        ),
                        subtitle: Text(post.location),
                        trailing: const Icon(Icons.more_vert),
                      ),
                      Image.asset(post.imageUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${post.likes} likes",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${post.username} ${post.caption}",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        )));
  }
}

class Post {
  final String username;
  final String userAvatar;
  final String imageUrl;
  final String location;
  final String caption;
  final int likes;

  Post({
    required this.username,
    required this.userAvatar,
    required this.imageUrl,
    required this.location,
    required this.caption,
    required this.likes,
  });
}

final List<Post> posts = [
  Post(
    username: 'user1',
    userAvatar: 'assets/images/avatar1.png',
    imageUrl: 'assets/images/post1.jpg',
    location: 'Seoul, South Korea',
    caption: 'Enjoying the view! 😍',
    likes: 1000,
  ),
  Post(
    username: 'user2',
    userAvatar: 'assets/images/avatar2.png',
    imageUrl: 'assets/images/post2.jpg',
    location: 'Busan, South Korea',
    caption: 'Beautiful beach day! 🌊',
    likes: 500,
  ),
  Post(
    username: 'user3',
    userAvatar: 'assets/images/avatar3.png',
    imageUrl: 'assets/images/post3.jpg',
    location: 'Jeju Island, South Korea',
    caption: 'Exploring the island 🌴',
    likes: 1500,
  ),
  Post(
    username: 'user4',
    userAvatar: 'assets/images/avatar4.png',
    imageUrl: 'assets/images/post4.jpg',
    location: 'Gyeongbokgung Palace, South Korea',
    caption: 'Historical trip! 🏯',
    likes: 1200,
  ),
];

class Story {
  final String userAvatar;
  final String username;

  Story({required this.userAvatar, required this.username});
}

final List<Story> stories = [
  Story(userAvatar: 'assets/images/avatar1.png', username: 'user1'),
  Story(userAvatar: 'assets/images/avatar2.png', username: 'user2'),
  Story(userAvatar: 'assets/images/avatar3.png', username: 'user3'),
  Story(userAvatar: 'assets/images/avatar4.png', username: 'user4'),
  // Add more stories if needed
];
