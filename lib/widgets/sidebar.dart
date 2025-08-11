// File: widgets/second_top_navbar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SecondTopNavbar extends StatefulWidget {
  final int selectedIndex;
  final int? selectedDropdownIndex;
  final void Function(String label, int index, [int? dropdownIndex])? onSelect;
  const SecondTopNavbar({
    super.key,
    this.selectedIndex = 0,
    this.selectedDropdownIndex,
    this.onSelect,
  });

  @override
  State<SecondTopNavbar> createState() => _SecondTopNavbarState();
}

class _SecondTopNavbarState extends State<SecondTopNavbar> {
  int? expandedDropdownIndex;

  @override
  void initState() {
    super.initState();
    expandedDropdownIndex = widget.selectedIndex == widget.selectedDropdownIndex
        ? widget.selectedIndex
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final bool loggedIn = auth.isLoggedIn;

    // Theme colors
    final Color primaryBlue = const Color(0xFF0078D7); // theme primary
    final Color accentRed = const Color(0xFFFF4A5B); // theme secondary
    final Color navBg = Colors.white; // base color
    final Color selectedColor = accentRed;
    final Color unselectedColor = const Color(0xFF2C3E50); // dark neutral
    final Color iconColor = const Color(0xFF2C3E50);
    final Color textColor = const Color(0xFF2C3E50);
    final Color dropdownBg = Colors.white;
    final Color dropdownText = const Color(0xFF2C3E50);
    final Color dropdownSelectedBg = primaryBlue.withOpacity(0.10);
    final Color dropdownSelectedText = primaryBlue;

    final List<_NavItem> items = [
      _NavItem('Dashboard', Icons.dashboard_outlined),
      _NavItem('Gallery', Icons.photo_library_outlined),
      _NavItem('Products', Icons.inventory_2_outlined),
      if (loggedIn) _NavItem('Order Matrix', Icons.build),
      if (loggedIn)
        _NavItem.dropdown('Quote Module', Icons.menu_book_outlined, [
          _NavItem('Quote Matrix', Icons.grid_3x3),
          _NavItem('Quote Tools', Icons.table_chart),
        ]),
      if (loggedIn) _NavItem('Sales Matrix', Icons.analytics),
      _NavItem('Cisco GPL', Icons.code),
    ];

    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: navBg,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE5E6EC), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          for (int i = 0; i < items.length; i++)
            items[i].isDropdown
                ? _NavDropdown(
              item: items[i],
              expanded: expandedDropdownIndex == i,
              selectedDropdownIndex: expandedDropdownIndex == i
                  ? widget.selectedDropdownIndex
                  : null,
              onSelect: (subIdx) {
                setState(() {
                  // When a dropdown item is selected, set the selectedIndex to the dropdown parent and selectedDropdownIndex to the subIdx
                  widget.onSelect?.call(
                    items[i].children[subIdx].label,
                    i,
                    subIdx,
                  );
                  // Focus the dropdown parent and subitem
                  expandedDropdownIndex = i;
                });
              },
              onTap: () {
                setState(() {
                  // Remove focus from all other menu items
                  if (expandedDropdownIndex == i) {
                    expandedDropdownIndex = null;
                  } else {
                    expandedDropdownIndex = i;
                  }
                  // Deselect any other selectedIndex/DropdownIndex
                  widget.onSelect?.call(items[i].label, i, null);
                });
              },
              navBg: navBg,
              accentRed: accentRed,
              iconColor: iconColor,
              textColor: textColor,
              dropdownBg: dropdownBg,
              dropdownText: dropdownText,
              dropdownSelectedBg: dropdownSelectedBg,
              dropdownSelectedText: dropdownSelectedText,
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _NavTile(
                label: items[i].label,
                icon: items[i].icon,
                selected:
                widget.selectedIndex == i &&
                    expandedDropdownIndex == null,
                selectedColor: selectedColor,
                unselectedColor: unselectedColor,
                iconColor: iconColor,
                textColor: textColor,
                onTap: () {
                  setState(() {
                    expandedDropdownIndex = null;
                  });
                  widget.onSelect?.call(items[i].label, i);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final bool isDropdown;
  final List<_NavItem> children;
  const _NavItem(this.label, this.icon)
      : isDropdown = false,
        children = const [];
  const _NavItem.dropdown(this.label, this.icon, this.children)
      : isDropdown = true;
}

class _NavDropdown extends StatefulWidget {
  final _NavItem item;
  final bool expanded;
  final int? selectedDropdownIndex;
  final Function(int) onSelect;
  final VoidCallback onTap;
  final Color navBg;
  final Color accentRed;
  final Color iconColor;
  final Color textColor;
  final Color dropdownBg;
  final Color dropdownText;
  final Color dropdownSelectedBg;
  final Color dropdownSelectedText;

  const _NavDropdown({
    required this.item,
    required this.expanded,
    required this.selectedDropdownIndex,
    required this.onSelect,
    required this.onTap,
    required this.navBg,
    required this.accentRed,
    required this.iconColor,
    required this.textColor,
    required this.dropdownBg,
    required this.dropdownText,
    required this.dropdownSelectedBg,
    required this.dropdownSelectedText,
  });

  @override
  State<_NavDropdown> createState() => _NavDropdownState();
}

class _NavDropdownState extends State<_NavDropdown> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: widget.expanded
              ? widget.accentRed.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onTap,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.item.icon,
                    color: widget.expanded
                        ? widget.accentRed
                        : widget.iconColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.item.label,
                    style: TextStyle(
                      color: widget.expanded
                          ? widget.accentRed
                          : widget.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    widget.expanded ? Icons.expand_less : Icons.expand_more,
                    color: widget.iconColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.expanded)
          Positioned(
            top: 56,
            left: 0,
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color: widget.dropdownBg,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(widget.item.children.length, (idx) {
                  final sub = widget.item.children[idx];
                  final bool selected = widget.selectedDropdownIndex == idx;
                  return Material(
                    color: selected
                        ? widget.dropdownSelectedBg
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onSelect(idx);
                        // Close the dropdown after selection
                        widget.onTap(); // This will toggle the dropdown closed
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              sub.icon,
                              color: selected
                                  ? widget.dropdownSelectedText
                                  : widget.dropdownText,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              sub.label,
                              style: TextStyle(
                                color: selected
                                    ? widget.dropdownSelectedText
                                    : widget.dropdownText,
                                fontWeight: selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onTap;
  const _NavTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.iconColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? selectedColor.withOpacity(0.12) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? selectedColor : iconColor, size: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? selectedColor : textColor,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}