import 'package:flutter/material.dart';
import 'package:translate/http_internet/network.dart';
import 'package:translate/http_internet/post.dart';
import 'package:translate/http_internet/post_item.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  List<Post> posts = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _getPostsList();
  }

  @override
  Widget build(BuildContext context) {
    Post post = Post(
      id: 1,
      title: "Lorem5",
      body: "google com search bu  text",
      userId: 9,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder:
                      (context, index) => MaterialButton(
                        onPressed: () {
                          setState(() {
                            _createPost(post);
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            deletePost(post);
                          });
                        },
                        child: PostItem(post: posts[index]),
                      ),
                ),
      ),
    );
  }

  void _getPostsList() async {
    setState(() {
      isLoading = true;
    });
    final response = await Network.GET(
      Network.POST_LIST,
      Network.paramsEmpty(),
    );
    if (response != null) {
      setState(() {
        isLoading = false;
        posts = Network.parsePostList(response);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void deletePost(Post post) {
    Network.DELETE(Network.POST_DELETE, Network.paramsEmpty()).then((response) {
      print(response);
      _getPostsList();
    });
  }

  void _updatePost(Post post) {
    Network.PUT(Network.POST_UPDATE, Network.paramsUpdate(post)).then((
      response,
    ) {
      print(response);
    });
  }

  void _createPost(Post post) {
    Network.POST(Network.POST_CREATE, Network.paramsCreate(post)).then((
      response,
    ) {
      print(response);
      _getPostsList();
    });
  }
}
