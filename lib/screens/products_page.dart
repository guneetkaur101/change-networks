import 'package:change_user/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool isGrid = true;
  String selectedCategory = 'All';
  List<CategoryNode> displayList = topLevelCategories;
  final Set<String> expandedCategories = {};

  final Map<LogicalKeySet, Intent> shortcutMap = {
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit1): const CategoryIntent('All'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit2): const CategoryIntent('Switches'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit3): const CategoryIntent('Wireless'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit4): const CategoryIntent('Routers'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit5): const CategoryIntent('Gateways'),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.digit6): const CategoryIntent('Accessories'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shortcuts(
        shortcuts: shortcutMap,
        child: Actions(
          actions: {
            CategoryIntent: CallbackAction<CategoryIntent>(
              onInvoke: (intent) {
                _onCategorySelect(intent.category);
                return null;
              },
            ),
          },
          child: Focus(
            autofocus: true,
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 260,
                  color: const Color(0xFFEFF3FA),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8),
                          child: Text('Products',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 8),
                        _buildSidebarWithAllOption(),
                      ],
                    ),
                  ),
                ),

                // Main area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with search & toggle aligned under title
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20 + 260, 20, 20, 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Products',
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: const Icon(Icons.filter_alt_outlined),
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            TextButton.icon(
                              style: TextButton.styleFrom(backgroundColor: Colors.blue.shade50),
                              onPressed: () => setState(() => isGrid = !isGrid),
                              icon: Icon(isGrid ? Icons.view_list : Icons.grid_view, color: Colors.blue),
                              label: Text(isGrid ? 'List' : 'Grid',
                                  style: const TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                      ),

                      // Display grid or list
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: isGrid
                              ? GridView.builder(
                            itemCount: displayList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.1,
                            ),
                            itemBuilder: (_, i) => _buildGridCard(displayList[i]),
                          )
                              : ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (_, i) => _buildListCard(displayList[i]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Sidebar with All Categories and navigation
  Widget _buildSidebarWithAllOption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSidebarTile('All Categories', 0, shortcut: 'Alt+1'),
        const SizedBox(height: 8),
        _buildSidebar(sidebarCategories),
      ],
    );
  }

  // A single sidebar tile with indent & optional shortcut
  Widget _buildSidebarTile(String name, int level,
      {String? shortcut, CategoryNode? node}) {
    final isSelected = selectedCategory == name;
    final hasKids = node?.subCategories?.isNotEmpty == true;

    return InkWell(
      onTap: () {
        _onCategorySelect(name);
        if (hasKids) {
          setState(() {
            expandedCategories.add(name);
          });
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16 + 24.0 * level, 12, 16, 12),
        color: isSelected ? Colors.blue.shade100 : Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Text(name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blue : Colors.black87,
                  )),
            ),
            if (shortcut != null)
              Text(shortcut, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            if (hasKids)
              Icon(
                expandedCategories.contains(name) ? Icons.expand_less : Icons.expand_more,
                size: 20,
                color: Colors.black54,
              ),
          ],
        ),
      ),
    );
  }

  // Builds categories and subcategories without collapsing
  Widget _buildSidebar(List<CategoryNode> cats, [int level = 0]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cats.map((cat) {
        final isTop = level == 0;
        String? shortcut;
        if (isTop) {
          final idx = topLevelCategories.indexWhere((t) => t.name == cat.name);
          if (idx != -1) shortcut = 'Alt+${idx + 2}';
        }
        final isExpanded = expandedCategories.contains(cat.name);

        return Column(
          children: [
            _buildSidebarTile(cat.name, level, shortcut: shortcut, node: cat),
            if (cat.subCategories != null && (isExpanded || selectedCategory == cat.name))
              _buildSidebar(cat.subCategories!, level + 1),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildGridCard(CategoryNode node) {
    return InkWell(
      onTap: node.subCategories?.isNotEmpty == true ? () => _onCategorySelect(node.name) : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(1, 2))],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(child: Image.network(node.imageUrl ?? '', fit: BoxFit.contain)),
            const SizedBox(height: 6),
            Text(node.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(CategoryNode node) {
    return InkWell(
      onTap: node.subCategories?.isNotEmpty == true ? () => _onCategorySelect(node.name) : null,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.network(node.imageUrl ?? '', width: 60),
              const SizedBox(width: 16),
              Expanded(child: Text(node.name, style: const TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }

  void _onCategorySelect(String cat) {
    if (cat == 'All' || cat == 'All Categories') {
      setState(() {
        selectedCategory = 'All';
        displayList = topLevelCategories;
      });
    } else {
      final match = findNode(sidebarCategories, cat);
      if (match != null) {
        setState(() {
          selectedCategory = cat;
          displayList = match.subCategories ?? [];
          if (match.subCategories?.isNotEmpty == true) expandedCategories.add(cat);
        });
      }
    }
  }

  CategoryNode? findNode(List<CategoryNode> nodes, String name) {
    for (var n in nodes) {
      if (n.name == name) return n;
      final sub = n.subCategories != null ? findNode(n.subCategories!, name) : null;
      if (sub != null) return sub;
    }
    return null;
  }
}

class CategoryIntent extends Intent {
  final String category;
  const CategoryIntent(this.category);
}
