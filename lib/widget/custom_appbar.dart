import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // AppBar title
  final bool showTitle; // Show or hide the title
  final bool showProfileIcon; // Show profile icon
  final String? profileImageUrl; // Optional profile image
  final VoidCallback? onProfileTap; // Callback for profile icon tap

  const CustomAppBar({
    Key? key,
    this.title,
    this.showTitle = true,
    this.showProfileIcon = true,
    this.profileImageUrl,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green.shade600,
      elevation: 0,
      centerTitle: true, // Title always centered
      title: showTitle
          ? Text(
        title ?? '',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )
          : null,
      actions: showProfileIcon
          ? [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: onProfileTap ?? () {},
            child: CircleAvatar(
              backgroundColor: Colors.green.shade700,
              backgroundImage: profileImageUrl != null
                  ? NetworkImage(profileImageUrl!)
                  : null,
              child: profileImageUrl == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
          ),
        ),
      ]
          : null,
    );
  }
}
