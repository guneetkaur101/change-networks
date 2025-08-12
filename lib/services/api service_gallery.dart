import 'dart:async';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiService {
  static final ApiService _i = ApiService._internal();
  factory ApiService() => _i;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _base,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    _jar = CookieJar();
    _dio.interceptors.add(CookieManager(_jar));
  }

  static const _base = 'https://dev.api.change-networks.com/api/v1';
  late final Dio _dio;
  late final CookieJar _jar;

  String? _bearerToken;
  String? get bearerToken => _bearerToken;

  // ------------------------------- Auth ---------------------------------------
  Future<void> login({required String email, required String password}) async {
    final r = await _dio.post('/admin/login', data: {
      'email': email,
      'password': password,
    });
    final m = (r.data is Map<String, dynamic>) ? r.data as Map<String, dynamic> : {};
    if (m['success'] != true) {
      throw DioException(
        requestOptions: r.requestOptions,
        response: r,
        error: m['message'] ?? 'Login failed',
        type: DioExceptionType.badResponse,
      );
    }
    if (m['token'] is String && (m['token'] as String).isNotEmpty) {
      _bearerToken = m['token'];
      _dio.options.headers['Authorization'] = 'Bearer $_bearerToken';
    }
  }

  // ------------------------------- Models -------------------------------------
  GalleryItem _item(Map<String, dynamic> j) => GalleryItem(
    id: (j['_id'] ?? '').toString(),
    productCode: (j['productCode'] ?? '').toString(),
    slug: (j['slug'] ?? '').toString(),
    url: (j['url'] ?? '').toString(),
  );

  GalleryResponse _emptyResponse({
    required int page,
    required int limit,
    String message = 'No images found.',
  }) {
    return GalleryResponse(
      items: const [],
      meta: PaginationMeta(
        currentPage: page,
        totalPages: 1,
        totalItems: 0,
        itemsPerPage: limit,
      ),
      message: message,
    );
  }

  Future<GalleryResponse> _fetchCategory(
      String path, {
        int limits = 10,
        int page = 1,
      }) async {
    try {
      final r = await _dio.get(path, queryParameters: {'limits': limits, 'page': page});
      final b = (r.data is Map<String, dynamic>) ? r.data as Map<String, dynamic> : {};
      if (b['success'] != true) {
        throw DioException(
          requestOptions: r.requestOptions,
          response: r,
          error: b['message'] ?? 'Failed to fetch $path',
          type: DioExceptionType.badResponse,
        );
      }

      final list = (b['data'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
      final items = list.map(_item).toList();

      final metaMap = (b['meta'] as Map<String, dynamic>?) ?? const {};
      final meta = PaginationMeta(
        currentPage: (metaMap['currentPage'] ?? page) as int,
        totalPages: (metaMap['totalPages'] ?? 1) as int,
        totalItems: (metaMap['totalItems'] ?? items.length) as int,
        itemsPerPage: (metaMap['itemsPerPage'] ?? limits) as int,
      );
      return GalleryResponse(items: items, meta: meta, message: (b['message'] ?? '').toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return _emptyResponse(page: page, limit: limits, message: 'No images yet.');
      }
      rethrow;
    }
  }

  Future<GalleryResponse> _fetchCategoryWith(
      String path, {
        required Map<String, dynamic> query,
        required int fallbackPage,
        required int fallbackLimit,
      }) async {
    try {
      final r = await _dio.get(path, queryParameters: query);
      final b = (r.data is Map<String, dynamic>) ? r.data as Map<String, dynamic> : {};
      if (b['success'] != true) {
        throw DioException(
          requestOptions: r.requestOptions,
          response: r,
          error: b['message'] ?? 'Failed to fetch $path',
          type: DioExceptionType.badResponse,
        );
      }

      final list = (b['data'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
      final items = list.map(_item).toList();

      final metaMap = (b['meta'] as Map<String, dynamic>?) ?? const {};
      final meta = PaginationMeta(
        currentPage: (metaMap['currentPage'] ?? (query['page'] as int? ?? fallbackPage)) as int,
        totalPages: (metaMap['totalPages'] ?? 1) as int,
        totalItems: (metaMap['totalItems'] ?? items.length) as int,
        itemsPerPage: (metaMap['itemsPerPage'] ?? (query['limit'] as int? ?? fallbackLimit)) as int,
      );
      return GalleryResponse(items: items, meta: meta, message: (b['message'] ?? '').toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return _emptyResponse(
          page: (query['page'] as int?) ?? fallbackPage,
          limit: (query['limit'] as int?) ?? fallbackLimit,
          message: 'No images found.',
        );
      }
      rethrow;
    }
  }

  // --------------------------- Gallery endpoints ------------------------------
  Future<GalleryResponse> getRouters({int limits = 10, int page = 1}) =>
      _fetchCategory('/gallery/routers', limits: limits, page: page);

  /// Accepts **both** `limit` and `limits` so UI won't break.
  /// - Without search → server expects `limits` (plural)
  /// - With search/new style → server accepts `limit` (singular)
  Future<GalleryResponse> getSwitches({
    int? limit,
    int? limits,
    int page = 1,
    String? search,
  }) {
    final effectiveLimit = (limit ?? limits ?? 10);

    if (search == null || search.trim().isEmpty) {
      return _fetchCategory('/gallery/switches', limits: effectiveLimit, page: page);
    }

    return _fetchCategoryWith(
      '/gallery/switches',
      query: {'limit': effectiveLimit, 'page': page, 'search': search.trim()},
      fallbackPage: page,
      fallbackLimit: effectiveLimit,
    );
  }

  Future<GalleryResponse> getFirewalls({int limits = 10, int page = 1}) =>
      _fetchCategory('/gallery/firewalls', limits: limits, page: page);

  Future<GalleryResponse> getOthers({int limits = 10, int page = 1}) =>
      _fetchCategory('/gallery/others', limits: limits, page: page);

  Future<GalleryCategories> getCategories({int limits = 10}) async {
    final r = await _dio.get('/gallery/cateogries', queryParameters: {'limits': limits}); // server spelling
    final b = (r.data is Map<String, dynamic>) ? r.data as Map<String, dynamic> : {};
    if (b['success'] != true) {
      throw DioException(
        requestOptions: r.requestOptions,
        response: r,
        error: b['message'] ?? 'Failed to fetch categories',
        type: DioExceptionType.badResponse,
      );
    }
    final data = (b['data'] as Map<String, dynamic>? ?? {});
    final routers = (data['routers'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    final switches = (data['switches'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    final firewalls = (data['firewalls'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    final others = (data['others'] as List<dynamic>? ?? []).map((e) => e.toString()).toList();
    return GalleryCategories(
      routers: routers,
      switches: switches,
      firewalls: firewalls,
      others: others,
      message: (b['message'] ?? '').toString(),
    );
  }
}

// -------------------------------- Data classes --------------------------------

class GalleryItem {
  final String id;
  final String productCode;
  final String slug;
  final String url;
  const GalleryItem({
    required this.id,
    required this.productCode,
    required this.slug,
    required this.url,
  });
}

class PaginationMeta {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  const PaginationMeta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
  });
  bool get hasMore => currentPage < totalPages;
}

class GalleryResponse {
  final List<GalleryItem> items;
  final PaginationMeta meta;
  final String message;
  const GalleryResponse({required this.items, required this.meta, required this.message});
}

class GalleryCategories {
  final List<String> routers;
  final List<String> switches;
  final List<String> firewalls;
  final List<String> others;
  final String message;
  const GalleryCategories({
    required this.routers,
    required this.switches,
    required this.firewalls,
    required this.others,
    required this.message,
  });
}
