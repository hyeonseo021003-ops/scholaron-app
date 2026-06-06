import 'package:flutter/material.dart';

import '../models/scholarship.dart';
import '../utils/format.dart';

/// 장학금 상세 화면
class ScholarshipDetailScreen extends StatelessWidget {
  const ScholarshipDetailScreen({super.key, required this.scholarship});

  final Scholarship scholarship;

  @override
  Widget build(BuildContext context) {
    final s = scholarship;
    return Scaffold(
      appBar: AppBar(title: const Text('장학금 상세')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: s.type.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(s.type.label,
                style: TextStyle(
                    color: s.type.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
          ).withWidth(),
          const SizedBox(height: 14),
          Text(s.name,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w900, height: 1.25)),
          const SizedBox(height: 6),
          Text(s.organization,
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          _InfoTiles(scholarship: s),
          const SizedBox(height: 24),
          const _SectionTitle('소개'),
          Text(s.description,
              style: const TextStyle(fontSize: 15, height: 1.55)),
          const SizedBox(height: 24),
          const _SectionTitle('지원 자격'),
          ...s.requirements.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle,
                        size: 18, color: Color(0xFF2563EB)),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(r,
                            style:
                                const TextStyle(fontSize: 14.5, height: 1.4))),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          const _SectionTitle('키워드'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: s.tags
                .map((t) => Chip(
                      label: Text('#$t'),
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('지원서 작성 화면으로 연결됩니다 (데모)'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.edit_document),
            label: const Text('지원하기'),
          ),
        ],
      ),
    );
  }
}

class _InfoTiles extends StatelessWidget {
  const _InfoTiles({required this.scholarship});
  final Scholarship scholarship;

  @override
  Widget build(BuildContext context) {
    final s = scholarship;
    return Row(
      children: [
        Expanded(
          child: _Tile(
            label: '지원 금액',
            value: formatWon(s.amount),
            icon: Icons.payments_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Tile(
            label: '마감',
            value: s.daysLeft >= 0 ? deadlineLabel(s.daysLeft) : '마감됨',
            icon: Icons.event_outlined,
            highlight: s.isUrgent,
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade500),
          const SizedBox(height: 10),
          Text(label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 2),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: highlight
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF111827))),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
    );
  }
}

extension on Widget {
  /// 좌측 정렬된 인라인 배지를 위해 폭을 내용에 맞춤
  Widget withWidth() => Align(alignment: Alignment.centerLeft, child: this);
}
