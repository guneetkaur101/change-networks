import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../providers/auth_provider.dart';


class TopNavbar extends StatelessWidget {
  // const TopNavbar({super.key});
  // final bool isLoggedIn;
  final VoidCallback onLoginPressed;
    const TopNavbar({
    super.key,
    // required this.isLoggedIn,
    required this.onLoginPressed,
  });
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final Color bgColor = const Color(0xFFF2F4F8); // theme appBar background
    final Color borderColor = const Color(0xFFE5E6EC);
    final Color iconColor = const Color(0xFF2C3E50); // dark neutral
    final Color blue = const Color(0xFF0078D7); // primary
    final Color accentRed = const Color(0xFFFF4A5B); // secondary
    final Color textColor = const Color(0xFF2C3E50);
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: borderColor, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Cloud icon with green check
          _CloudSync(iconColor: blue),
          const SizedBox(width: 16),
          // Sync button
          _SyncButton(blue: blue, accentRed: accentRed),
          const Spacer(),
          // Center: Search bar
          _SearchBar(
            blue: blue,
            textColor: textColor,
            borderColor: borderColor,
          ),
          const Spacer(),
          // Right: Profile or Login
          if (!auth.isLoggedIn)
            SizedBox(
              height: 40,
              child: ElevatedButton(
                // onPressed: () => auth.login(),
                    onPressed: onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.login_rounded, size: 20),
                    SizedBox(width: 6),
                    Text("Login"),
                  ],
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: PopupMenuButton<String>(
                icon: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF0078D7),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "profile",
                    child: Text("View Profile"),
                  ),
                  const PopupMenuItem(
                    value: "settings",
                    child: Text("Settings"),
                  ),
                  const PopupMenuItem(value: "logout", child: Text("Logout")),
                ],
                onSelected: (value) {
                  if (value == "logout") {
                    auth.logout();
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _CloudSync extends StatelessWidget {
  final Color iconColor;
  const _CloudSync({this.iconColor = const Color(0xFF0078D7)});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Icon(Icons.cloud_outlined, color: iconColor, size: 36),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFB2F2BB),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.check, color: Color(0xFF38B000), size: 12),
          ),
        ),
      ],
    );
  }
}

class _SyncButton extends StatelessWidget {
  final Color blue;
  final Color accentRed;
  const _SyncButton({required this.blue, required this.accentRed});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.sync, color: blue),
      label: Text(
        'Sync',
        style: TextStyle(color: blue, fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: blue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        foregroundColor: accentRed,
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final Color blue;
  final Color textColor;
  final Color borderColor;
  const _SearchBar({
    required this.blue,
    required this.textColor,
    required this.borderColor,
  });
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RawKeyboard.instance.addListener(_handleKey);
    });
  }

  void _handleKey(RawKeyEvent event) {
    if (event.isControlPressed &&
        event.logicalKey.keyLabel.toLowerCase() == 'f' &&
        event is RawKeyDownEvent) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKey);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.borderColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(Icons.circle, color: widget.blue, size: 16),
          const SizedBox(width: 8),
          Icon(Icons.search, color: widget.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search App',
                hintStyle: TextStyle(
                  color: Color(0xFFB0B4C1),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Text(
              'Ctrl+F',
              style: TextStyle(
                color: Color(0xFFB0B4C1),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}