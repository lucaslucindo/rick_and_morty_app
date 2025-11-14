class ApiResponse<T> {
  final ApiInfo info;
  final List<T> results;

  ApiResponse({required this.info, required this.results});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse(
      info: ApiInfo.fromJson(json['info']),
      results: (json['results'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ApiInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  ApiInfo({required this.count, required this.pages, this.next, this.prev});

  factory ApiInfo.fromJson(Map<String, dynamic> json) {
    return ApiInfo(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}
