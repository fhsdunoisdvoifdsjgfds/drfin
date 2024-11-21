import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/my_fonts.dart';
import '../../../core/models/newss.dart';
import '../../../core/widgets/my_button.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.newss,
    this.balanceCard = false,
  });

  final Newss newss;
  final bool balanceCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: balanceCard ? 12 : 22),
      height: 42,
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(42),
              child: CachedNetworkImage(
                imageUrl: newss.image,
                height: 42,
                width: 42,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Container();
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newss.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: MyFonts.w600,
                  ),
                ),
                Text(
                  newss.time,
                  style: const TextStyle(
                    color: Color(0xffA7A7A7),
                    fontSize: 10,
                    fontFamily: MyFonts.w400,
                  ),
                ),
              ],
            ),
          ),
          MyButton(
            onPressed: () {
              context.push('/news_read', extra: newss);
            },
            minSize: 30,
            child: Container(
              height: 30,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xff404040),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: MyFonts.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
