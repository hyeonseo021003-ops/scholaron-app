import 'package:flutter/material.dart';

/// 장학금 유형
enum ScholarshipType {
  national('국가장학금', Color(0xFF2563EB)),
  merit('성적우수', Color(0xFF7C3AED)),
  need('생활지원', Color(0xFF059669)),
  major('전공특화', Color(0xFFEA580C)),
  matching('1:1 매칭후원', Color(0xFFDB2777));

  const ScholarshipType(this.label, this.color);
  final String label;
  final Color color;
}

/// 장학금 정보 모델
class Scholarship {
  const Scholarship({
    required this.id,
    required this.name,
    required this.organization,
    required this.type,
    required this.amount,
    required this.deadline,
    required this.tags,
    required this.description,
    required this.requirements,
    this.incomeBracketFree = false,
  });

  final String id;
  final String name;
  final String organization;
  final ScholarshipType type;

  /// 지원 금액 (원)
  final int amount;
  final DateTime deadline;

  /// 검색 매칭에 사용하는 키워드 태그
  final List<String> tags;
  final String description;
  final List<String> requirements;

  /// 소득분위와 무관하게 지원 가능한지 여부 (사각지대 해소)
  final bool incomeBracketFree;

  int get daysLeft => deadline.difference(DateTime(2026, 6, 6)).inDays;

  bool get isUrgent => daysLeft >= 0 && daysLeft <= 7;
}
