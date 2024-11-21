import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/my_fonts.dart';
import '../../../core/models/newss.dart';
import '../../../core/utilsss.dart';
import '../../../core/widgets/my_button.dart';
import '../../../core/widgets/pop_button.dart';

class NewsReadPage extends StatelessWidget {
  const NewsReadPage({
    super.key,
    required this.news,
  });

  final Newss news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getStatusBar(context, height: 6)),
          Row(
            children: [
              const SizedBox(width: 22),
              PopButton(
                title: 'Back',
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              children: [
                const SizedBox(height: 7),
                Text(
                  news.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: MyFonts.w800,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: news.image,
                    width: double.infinity,
                    height: 285,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Container();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  news.time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: MyFonts.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xff343434),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    news.body,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: MyFonts.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 113,
      decoration: BoxDecoration(
        color: const Color(0xff343434),
        borderRadius: BorderRadius.circular(36),
      ),
      child: MyButton(
        onPressed: () {},
        minSize: 36,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              title == 'Like' ? Icons.favorite : Icons.ios_share_rounded,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: MyFonts.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
