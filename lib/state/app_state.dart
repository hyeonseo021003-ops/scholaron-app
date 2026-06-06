import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/scholarship.dart';
import '../models/mentee.dart';
import '../models/sponsorship.dart';

/// 앱 전역 상태. 장학금 검색/필터와 후원 내역을 관리한다.
class AppState extends ChangeNotifier {
  // ---- 장학금 검색 / 필터 ----
  String _query = '';
  final Set<ScholarshipType> _typeFilters = {};
  bool _onlyIncomeFree = false;

  String get query => _query;
  Set<ScholarshipType> get typeFilters => _typeFilters;
  bool get onlyIncomeFree => _onlyIncomeFree;

  int get activeFilterCount =>
      _typeFilters.length + (_onlyIncomeFree ? 1 : 0);

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void toggleType(ScholarshipType type) {
    if (!_typeFilters.add(type)) _typeFilters.remove(type);
    notifyListeners();
  }

  void setOnlyIncomeFree(bool value) {
    _onlyIncomeFree = value;
    notifyListeners();
  }

  void clearFilters() {
    _typeFilters.clear();
    _onlyIncomeFree = false;
    notifyListeners();
  }

  /// 검색어 + 필터를 적용해 정렬된 장학금 목록을 반환한다.
  List<Scholarship> get filteredScholarships {
    final q = _query.trim().toLowerCase();
    final result = MockData.scholarships.where((s) {
      if (_typeFilters.isNotEmpty && !_typeFilters.contains(s.type)) {
        return false;
      }
      if (_onlyIncomeFree && !s.incomeBracketFree) return false;
      if (q.isEmpty) return true;
      final haystack = [
        s.name,
        s.organization,
        s.description,
        ...s.tags,
      ].join(' ').toLowerCase();
      return haystack.contains(q);
    }).toList();

    // 마감 임박 순으로 정렬 (지난 건은 뒤로)
    result.sort((a, b) {
      final aPast = a.daysLeft < 0;
      final bPast = b.daysLeft < 0;
      if (aPast != bPast) return aPast ? 1 : -1;
      return a.daysLeft.compareTo(b.daysLeft);
    });
    return result;
  }

  /// 맞춤 추천: 사각지대 해소형 + 마감 임박 장학금 우선 노출
  List<Scholarship> get recommended {
    final list = [...MockData.scholarships];
    list.sort((a, b) {
      int score(Scholarship s) {
        var v = 0;
        if (s.incomeBracketFree) v += 2;
        if (s.isUrgent) v += 3;
        return v;
      }

      return score(b).compareTo(score(a));
    });
    return list.take(3).toList();
  }

  // ---- 피후견인 / 후원 ----
  final List<Sponsorship> _sponsorships = [...MockData.mySponsorships];

  List<Mentee> get mentees => MockData.mentees;
  List<Sponsorship> get sponsorships => List.unmodifiable(_sponsorships);

  int get totalSponsored =>
      _sponsorships.fold(0, (sum, s) => sum + s.amount);

  int get totalTaxDeduction =>
      _sponsorships.fold(0, (sum, s) => sum + s.estimatedTaxDeduction);

  bool isSponsoring(String menteeId) =>
      _sponsorships.any((s) => s.menteeId == menteeId);

  /// 새 후원을 추가한다.
  void addSponsorship({
    required Mentee mentee,
    required int amount,
    required bool recurring,
  }) {
    _sponsorships.insert(
      0,
      Sponsorship(
        id: 'sp${DateTime.now().millisecondsSinceEpoch}',
        menteeId: mentee.id,
        menteeName: mentee.name,
        amount: amount,
        date: DateTime(2026, 6, 6),
        recurring: recurring,
      ),
    );
    notifyListeners();
  }
}
