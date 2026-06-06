import 'package:flutter/material.dart';

import '../models/mentee.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

/// 1:1 후원 매칭 화면의 피후견인 카드
class MenteeCard extends StatelessWidget {
  const MenteeCard({
    super.key,
    required this.mentee,
    required this.onTap,
    this.isSponsoring = false,
  });

  final Mentee mentee;
  final VoidCallback onTap;
  final bool isSponsoring;

  @override
  Widget build(BuildContext context) {
    final m = mentee;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.brandAccent.withValues(alpha: 0.15),
                    child: Text(
                      m.name.characters.first,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.brandAccent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              m.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (isSponsoring)
                              const Icon(Icons.favorite,
                                  size: 16, color: AppTheme.brandAccent),
                          ],
                        ),
                        Text(
                          '${m.university} · ${m.major} ${m.grade}',
                          style: TextStyle(
                              fontSize: 12.5, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                m.headline,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: m.progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation(AppTheme.brandAccent),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${formatWonShort(m.raisedAmount)} 모금',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    ' / 목표 ${formatWonShort(m.goalAmount)}',
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Icon(Icons.people_outline,
                      size: 15, color: Colors.grey.shade500),
                  const SizedBox(width: 3),
                  Text(
                    '후원자 ${m.sponsorCount}명',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
