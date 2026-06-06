import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/scholarship.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/scholarship_card.dart';
import 'scholarship_detail_screen.dart';

/// 장학금 맞춤 추천 + 검색/필터 화면 (홈)
class ScholarshipListScreen extends StatelessWidget {
  const ScholarshipListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final results = state.filteredScholarships;
    final showRecommended = state.query.isEmpty && state.activeFilterCount == 0;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            SliverToBoxAdapter(child: _SearchBar(state: state)),
            SliverToBoxAdapter(child: _TypeFilterRow(state: state)),
            if (showRecommended)
              SliverToBoxAdapter(child: _RecommendedSection(state: state)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  showRecommended ? '전체 장학금' : '검색 결과 ${results.length}건',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            if (results.isEmpty)
              const SliverToBoxAdapter(child: _EmptyState())
            else
              SliverList.builder(
                itemCount: results.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: ScholarshipCard(
                    scholarship: results[i],
                    onTap: () => _open(context, results[i]),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Scholarship s) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ScholarshipDetailScreen(scholarship: s)),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('장학온',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2563EB))),
              Text('흩어진 장학금, 한 곳에서 맞춤으로',
                  style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.notifications_none, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: TextField(
        onChanged: state.setQuery,
        decoration: InputDecoration(
          hintText: '전공, 키워드, 기관으로 검색 (예: 인문, 생활비)',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _TypeFilterRow extends StatelessWidget {
  const _TypeFilterRow({required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          FilterChip(
            label: const Text('소득분위 무관'),
            selected: state.onlyIncomeFree,
            showCheckmark: false,
            avatar: Icon(Icons.volunteer_activism,
                size: 16,
                color: state.onlyIncomeFree
                    ? Colors.white
                    : const Color(0xFF059669)),
            selectedColor: const Color(0xFF059669),
            labelStyle: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: state.onlyIncomeFree ? Colors.white : null,
            ),
            onSelected: state.setOnlyIncomeFree,
          ),
          const SizedBox(width: 8),
          for (final type in ScholarshipType.values) ...[
            FilterChip(
              label: Text(type.label),
              selected: state.typeFilters.contains(type),
              showCheckmark: false,
              selectedColor: type.color,
              labelStyle: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color:
                    state.typeFilters.contains(type) ? Colors.white : null,
              ),
              onSelected: (_) => state.toggleType(type),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection({required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final recs = state.recommended;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 18, 16, 4),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, size: 18, color: Color(0xFF2563EB)),
              SizedBox(width: 6),
              Text('맞춤 추천',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text('사각지대 해소 · 마감 임박 장학금을 먼저 보여드려요',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF6B7280))),
        ),
        SizedBox(
          height: 196,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, i) => SizedBox(
              width: 260,
              child: ScholarshipCard(
                scholarship: recs[i],
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        ScholarshipDetailScreen(scholarship: recs[i]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text('조건에 맞는 장학금이 없어요',
              style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
