import 'package:agriiku/model/article_model.dart';
import 'package:agriiku/service/article_service.dart';
import 'package:agriiku/view/detail/detailarticle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late ArticleApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ArticleApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: apiService.getArticles(),
        builder: (context, snapshot) {
          final List<Article>? article = snapshot.data;
          if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [Text("Server sedang bermasalah.")],
            ));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: article?.length,
                itemBuilder: (context, index) {
                  Article? a = article![index];
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: const FaIcon(
                        FontAwesomeIcons.newspaper,
                        size: 60,
                      ),
                      title: Text(a.title ?? ""),
                      subtitle: Text(a.tanggal ?? ''),
                      trailing: const Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailAritcle(
                                        id: (a.id ?? ''),
                                        key: ValueKey(a.id))));
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
