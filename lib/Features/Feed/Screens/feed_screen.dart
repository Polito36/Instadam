import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Core/Constants/pallete.dart';
import '../Widgets/feed_card.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.bgColor,
        appBar: AppBar(
          backgroundColor: Pallete.bgColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: 27,
                color: Colors.black,
              )),
          title: const Text(
            'LensLyfe',
            style: TextStyle(
              color: Pallete.primaryTextColor,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 27,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Post Collections')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Feeds',
                      style: TextStyle(
                        color: Pallete.primaryTextColor,
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FeedCard(
                          description: snapshot.data!.docs[index]
                              ['description'],
                          image: snapshot.data!.docs[index]['profileURL'],
                          username: snapshot.data!.docs[index]['username'],
                          postImage: snapshot.data!.docs[index]['postPhotoURL'],
                          postId: snapshot.data!.docs[index]['postId'],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 17,
                      ),
                      itemCount: snapshot.data!.docs.length,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
