import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mentee.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

/// 피후견인 상세 - 학업계획서/자기소개서 확인 후 후원 결정
class MenteeDetailScreen extends StatelessWidget {
  const MenteeDetailScreen({super.key, required this.mentee});

  final Mentee mentee;

  @override
  Widget build(BuildContext context) {
    final m = mentee;
    return Scaffold(
      appBar: AppBar(title: const Text('피후견인 프로필')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppTheme.brandAccent.withValues(alpha: 0.15),
                child: Text(m.name.characters.first,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.brandAccent)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text('${m.university} · ${m.major} ${m.grade}',
                        style: const TextStyle(
                            fontSize: 13.5, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ProgressCard(mentee: m),
          const SizedBox(height: 24),
          const _SectionTitle(icon: Icons.format_quote, text: '한 줄 소개'),
          Text(m.headline,
              style: const TextStyle(
                  fontSize: 16, height: 1.5, fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          const _SectionTitle(icon: Icons.person_outline, text: '자기소개서'),
          Text(m.statement,
              style: const TextStyle(fontSize: 14.5, height: 1.6)),
          const SizedBox(height: 24),
          const _SectionTitle(icon: Icons.school_outlined, text: '학업계획서'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(m.studyPlan,
                style: const TextStyle(fontSize: 14.5, height: 1.7)),
          ),
          const SizedBox(height: 24),
          const _SectionTitle(icon: Icons.emoji_events_outlined, text: '주요 활동·성과'),
          ...m.achievements.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.brandAccent)),
                    Expanded(
                        child: Text(a,
                            style: const TextStyle(
                                fontSize: 14.5, height: 1.4))),
                  ],
                ),
              )),
        ],
      ),
      bottomSheet: _SponsorBar(mentee: m),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.mentee});
  final Mentee mentee;

  @override
  Widget build(BuildContext context) {
    final m = mentee;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(formatWon(m.raisedAmount),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900)),
              Text('  / 목표 ${formatWon(m.goalAmount)}',
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFF6B7280))),
              const Spacer(),
              Text('${(m.progress * 100).round()}%',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.brandAccent)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: m.progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(AppTheme.brandAccent),
            ),
          ),
          const SizedBox(height: 10),
          Text('후원자 ${m.sponsorCount}명이 함께하고 있어요',
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.brandAccent),
          const SizedBox(width: 6),
          Text(text,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _SponsorBar extends StatelessWidget {
  const _SponsorBar({required this.mentee});
  final Mentee mentee;

  @override
  Widget build(BuildContext context) {
    final already = context.watch<AppState>().isSponsoring(mentee.id);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
          20, 12, 20, 12 + MediaQuery.of(context).padding.bottom),
      child: SafeArea(
        top: false,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.brandAccent,
          ),
          onPressed: () => _openSponsorSheet(context, mentee),
          icon: Icon(already ? Icons.favorite : Icons.favorite_border),
          label: Text(already ? '추가 후원하기' : '후원하기'),
        ),
      ),
    );
  }

  void _openSponsorSheet(BuildContext context, Mentee mentee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _SponsorSheet(mentee: mentee),
    );
  }
}

class _SponsorSheet extends StatefulWidget {
  const _SponsorSheet({required this.mentee});
  final Mentee mentee;

  @override
  State<_SponsorSheet> createState() => _SponsorSheetState();
}

class _SponsorSheetState extends State<_SponsorSheet> {
  static const _presets = [100000, 300000, 500000, 1000000];
  int _amount = 300000;
  bool _recurring = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('${widget.mentee.name} 학생 후원하기',
              style:
                  const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text('후원 금액을 선택해 주세요',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _presets.map((p) {
              final selected = _amount == p;
              return ChoiceChip(
                label: Text(formatWonShort(p)),
                selected: selected,
                showCheckmark: false,
                selectedColor: AppTheme.brandAccent,
                labelStyle: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : null,
                ),
                onSelected: (_) => setState(() => _amount = p),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeThumbColor: AppTheme.brandAccent,
            title: const Text('매월 정기 후원',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            subtitle: const Text('언제든 해지할 수 있어요'),
            value: _recurring,
            onChanged: (v) => setState(() => _recurring = v),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.receipt_long,
                    size: 18, color: Color(0xFF059669)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '예상 세액공제 약 ${formatWon((_amount * 0.15).round())} '
                    '(기부금 15% 기준)',
                    style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF059669),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style:
                FilledButton.styleFrom(backgroundColor: AppTheme.brandAccent),
            onPressed: () {
              context.read<AppState>().addSponsorship(
                    mentee: widget.mentee,
                    amount: _amount,
                    recurring: _recurring,
                  );
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${widget.mentee.name} 학생을 ${formatWonShort(_amount)} 후원했어요 💜'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('${formatWon(_amount)} 후원하기'),
          ),
        ],
      ),
    );
  }
}
