import 'dart:async';
import 'package:flutter/material.dart';
// If your file is named differently, change this path accordingly:
import '../services/api service_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with TickerProviderStateMixin {
  final ApiService _api = ApiService();

  bool _busy = true;
  String? _error;

  // Search (Switches)
  final TextEditingController _searchCtl = TextEditingController();
  Timer? _debounce;
  String? _switchSearchTerm;

  // Section data
  GalleryCategories? _cats;

  // Uses the tolerant API (supports limit/limits)
  late final _switches = _SectionController(
    label: 'Switches',
    loader: () => _api.getSwitches(limit: 4, page: 1, search: _switchSearchTerm),
  );

  late final _routers   = _SectionController(label: 'Routers',   loader: () => _api.getRouters(limits: 12));
  late final _firewalls = _SectionController(label: 'Firewalls', loader: () => _api.getFirewalls(limits: 12));
  late final _others    = _SectionController(label: 'Others',    loader: () => _api.getOthers(limits: 12));

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      await _api.login(
        email: 'sales@change-networks.com',
        password: 'c68a959e662c728d42ca667d2f7ae5df:913d4a3dc50337840ed46120cc3bc199',
      );

      final catsF = _api.getCategories(limits: 10);
      await Future.wait([_switches.load(), _routers.load()]);
      _cats = await catsF;

      // Preload optional sections
      unawaited(_firewalls.load());
      unawaited(_others.load());

      setState(() { _busy = false; _error = null; });
    } catch (e) {
      setState(() {
        _busy = false;
        _error = 'Failed to initialize: ${e.toString()}';
      });
    }
  }

  Future<void> _refresh() async {
    setState(() => _busy = true);
    for (final c in [_switches, _routers, _firewalls, _others]) {
      c.reset();
    }
    await _bootstrap();
  }

  // ----------------------------- Search UX -----------------------------------

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _performSearch(value.trim().isEmpty ? null : value.trim());
    });
  }

  Future<void> _performSearch(String? term) async {
    _switchSearchTerm = term;
    setState(() => _switches.loading = true);
    await _switches.load();

    if (_switches.error != null) {
      _showAlert('Search failed', _switches.error!);
      return;
    }
    if (_switches.items.isEmpty) {
      _showAlert('No images found', 'Try a different part code.');
    }
    setState(() {});
  }

  void _clearSearch() {
    if (_searchCtl.text.isEmpty) return;
    _searchCtl.clear();
    _performSearch(null);
  }

  void _showAlert(String title, String msg) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  // ----------------------------- Build ---------------------------------------

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    if (_busy) return const _PageLoader();
    if (_error != null) return _PageError(message: _error!, onRetry: _refresh);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Gallery', style: t.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
              const Spacer(),
              IconButton.filledTonal(onPressed: _refresh, icon: const Icon(Icons.refresh)),
            ],
          ),
          const SizedBox(height: 12),

          // Search (targets Switches list)
          TextField(
            controller: _searchCtl,
            onChanged: _onSearchChanged,
            onSubmitted: (v) => _performSearch(v.trim().isEmpty ? null : v.trim()),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search switches by part code (e.g. WS-C2960G-48TC-L)',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchCtl.text.isEmpty
                  ? null
                  : IconButton(onPressed: _clearSearch, icon: const Icon(Icons.close)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              isDense: true,
            ),
          ),
          const SizedBox(height: 14),

          if (_cats != null) _CategoryChipsRow(categories: _cats!),

          const SizedBox(height: 16),
          _SectionBlock(controller: _switches, onViewAll: () => _openFull('Switches')),
          const SizedBox(height: 24),
          _SectionBlock(controller: _routers, onViewAll: () => _openFull('Routers')),
          const SizedBox(height: 24),
          _SectionBlock(controller: _firewalls, onViewAll: () => _openFull('Firewalls')),
          const SizedBox(height: 24),
          _SectionBlock(controller: _others, onViewAll: () => _openFull('Others')),
        ],
      ),
    );
  }

  void _openFull(String title) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => FullCategoryGrid(
        title: title,
        loader: () {
          switch (title) {
            case 'Switches': return _api.getSwitches(limit: 24, page: 1, search: _switchSearchTerm);
            case 'Routers':  return _api.getRouters(limits: 24, page: 1);
            case 'Firewalls':return _api.getFirewalls(limits: 24, page: 1);
            default:         return _api.getOthers(limits: 24, page: 1);
          }
        },
        loadMore: (page) {
          switch (title) {
            case 'Switches': return _api.getSwitches(limit: 24, page: page, search: _switchSearchTerm);
            case 'Routers':  return _api.getRouters(limits: 24, page: page);
            case 'Firewalls':return _api.getFirewalls(limits: 24, page: page);
            default:         return _api.getOthers(limits: 24, page: page);
          }
        },
      ),
    ));
  }
}

/// --------------------------- UI Pieces --------------------------------------

class _PageLoader extends StatelessWidget {
  const _PageLoader();
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(padding: EdgeInsets.only(top: 80), child: CircularProgressIndicator()),
  );
}

class _PageError extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;
  const _PageError({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline, size: 56, color: t.colorScheme.error),
          const SizedBox(height: 10),
          Text('Couldn’t load gallery', style: t.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(message, style: t.textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ]),
      ),
    );
  }
}

class _CategoryChipsRow extends StatelessWidget {
  final GalleryCategories categories;
  const _CategoryChipsRow({required this.categories});

  @override
  Widget build(BuildContext context) {
    final chips = <String>[];
    chips.addAll(categories.switches.take(6));
    chips.addAll(categories.routers.take(4));
    if (categories.firewalls.isNotEmpty) chips.addAll(categories.firewalls.take(2));
    if (categories.others.isNotEmpty) chips.addAll(categories.others.take(2));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(width: 2),
        for (final c in chips)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(
              label: Text(c, overflow: TextOverflow.ellipsis),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              shape: StadiumBorder(side: BorderSide(color: Theme.of(context).dividerColor)),
            ),
          ),
      ]),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final _SectionController controller;
  final VoidCallback onViewAll;
  const _SectionBlock({required this.controller, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: t.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(radius: 18, backgroundColor: t.colorScheme.surfaceContainerHighest, child: const Icon(Icons.grid_view, size: 18)),
            const SizedBox(width: 10),
            Text(controller.label, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const Spacer(),
            TextButton.icon(onPressed: onViewAll, icon: const Icon(Icons.chevron_right), label: const Text('View All')),
          ]),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Builder(builder: (context) {
              if (controller.loading) return const _GridSkeleton();
              if (controller.items.isEmpty) return const _InlineEmpty();
              if (controller.error != null) return _InlineError(message: controller.error!, onRetry: controller.reload);
              return _CardGrid(items: controller.items);
            }),
          ),
        ],
      ),
    );
  }
}

class _InlineError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _InlineError({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        Text(message, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        OutlinedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry')),
        const SizedBox(height: 12),
      ]),
    );
  }
}

class _InlineEmpty extends StatelessWidget {
  const _InlineEmpty();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Center(child: Text('No images yet', style: Theme.of(context).textTheme.bodyMedium)),
  );
}

class _CardGrid extends StatelessWidget {
  final List<GalleryItem> items;
  const _CardGrid({required this.items});

  int _cols(double w) {
    if (w >= 1400) return 4;
    if (w >= 1100) return 3;
    if (w >= 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final cols = _cols(c.maxWidth);
      return GridView.builder(
        padding: const EdgeInsets.only(top: 6),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 4 / 3,
        ),
        itemCount: items.length.clamp(0, 12),
        itemBuilder: (_, i) => _GalleryCard(item: items[i]),
      );
    });
  }
}

class _GalleryCard extends StatelessWidget {
  final GalleryItem item;
  const _GalleryCard({required this.item});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Material(
      color: t.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16),
      elevation: 0.8,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showDialog(context: context, builder: (_) => _DetailDialog(item: item)),
        child: Column(
          children: [
            Expanded(child: Ink.image(image: NetworkImage(item.url), fit: BoxFit.cover, child: const SizedBox.expand())),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.productCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.grid_on, size: 18, color: t.colorScheme.outline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridSkeleton extends StatelessWidget {
  const _GridSkeleton();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      int cols = 2;
      final w = c.maxWidth;
      if (w >= 1400) cols = 4;
      else if (w >= 1100) cols = 3;
      else if (w >= 800) cols = 2;
      else cols = 1;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cols * 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 4 / 3,
        ),
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    });
  }
}

class _DetailDialog extends StatelessWidget {
  final GalleryItem item;
  const _DetailDialog({required this.item});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 860, maxHeight: 660),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(item.url, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
              child: Row(
                children: [
                  Expanded(child: Text(item.productCode, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700))),
                  FilledButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close), label: const Text('Close')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// --------------------------- Section controller ------------------------------

class _SectionController {
  final String label;
  final Future<GalleryResponse> Function() loader;

  _SectionController({required this.label, required this.loader});

  bool loading = true;
  String? error;
  List<GalleryItem> items = [];

  Future<void> load() async {
    loading = true;
    error = null;
    try {
      final r = await loader();
      items = r.items;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
    }
  }

  void reset() {
    loading = true;
    error = null;
    items = [];
  }

  void reload() {
    load();
  }
}

/// --------------------------- Full Category Page ------------------------------

class FullCategoryGrid extends StatefulWidget {
  final String title;
  final Future<GalleryResponse> Function() loader;
  final Future<GalleryResponse> Function(int page) loadMore;

  const FullCategoryGrid({
    super.key,
    required this.title,
    required this.loader,
    required this.loadMore,
  });

  @override
  State<FullCategoryGrid> createState() => _FullCategoryGridState();
}

class _FullCategoryGridState extends State<FullCategoryGrid> {
  final List<GalleryItem> _items = [];
  PaginationMeta? _meta;
  bool _loading = true;
  String? _error;
  int _page = 1;

  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _init();
    _sc.addListener(() {
      if (_meta?.hasMore == true &&
          _sc.position.pixels >= _sc.position.maxScrollExtent - 300 &&
          !_loading) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    setState(() { _loading = true; _error = null; });
    try {
      final r = await widget.loader();
      setState(() {
        _items..clear()..addAll(r.items);
        _meta = r.meta;
        _page = 1;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _loadMore() async {
    if (!(_meta?.hasMore ?? false)) return;
    setState(() => _loading = true);
    try {
      final next = _page + 1;
      final r = await widget.loadMore(next);
      setState(() {
        _items.addAll(r.items);
        _meta = r.meta;
        _page = next;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Load more failed: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _error != null
          ? Center(child: _PageError(message: _error!, onRetry: _init))
          : _loading && _items.isEmpty
          ? const _PageLoader()
          : RefreshIndicator(
        onRefresh: _init,
        child: LayoutBuilder(builder: (context, c) {
          int cols = 5;
          final w = c.maxWidth;
          if (w >= 1500) cols = 6;
          else if (w >= 1200) cols = 5;
          else if (w >= 1000) cols = 4;
          else if (w >= 700) cols = 3;
          else if (w >= 500) cols = 2;
          else cols = 1;

          return GridView.builder(
            controller: _sc,
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 4 / 3,
            ),
            itemCount: _items.length + ((_meta?.hasMore ?? false) ? 1 : 0),
            itemBuilder: (_, i) {
              if (i >= _items.length) {
                return const Center(child: CircularProgressIndicator());
              }
              return _GalleryCard(item: _items[i]);
            },
          );
        }),
      ),
    );
  }
}
