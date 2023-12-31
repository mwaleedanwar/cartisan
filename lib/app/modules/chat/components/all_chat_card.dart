import 'package:cartisan/app/data/constants/constants.dart';
import 'package:cartisan/app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllChatCard extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;
  const AllChatCard({
    required this.chat,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: AppColors.kGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.kPrimary,
              child: chat.imageURL == null
                  ? Text(
                      chat.name[0],
                      style: AppTypography.kMedium18
                          .copyWith(color: AppColors.kWhite),
                    )
                  : Hero(
                      tag: chat.name,
                      child: ClipOval(child: Image.network(chat.imageURL!)),
                    ),
            ),
            SizedBox(width: 13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: AppTypography.kMedium14,
                  ),
                  Text(
                    'You : ${chat.messageText}',
                    style: AppTypography.kLight14
                        .copyWith(color: AppColors.kHintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
