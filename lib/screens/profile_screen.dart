import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

/// 마이페이지 (데모용 후견인 프로필)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: AppTheme.brand,
                child: Text('차',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('차유나 후견인님',
                      style: TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w900)),
                  SizedBox(height: 2),
                  Text('의과대학 졸업생 · 매칭 후원자',
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _StatBox(
                  label: '후원 중인 학생',
                  value: '${state.sponsorships.length}명'),
              const SizedBox(width: 12),
              _StatBox(label: '누적 후원', value: formatWonShort(state.totalSponsored)),
            ],
          ),
          const SizedBox(height: 24),
          const _MenuTile(icon: Icons.favorite_border, title: '내 후원 관리'),
          const _MenuTile(icon: Icons.receipt_long, title: '기부금 영수증 / 세액공제'),
          const _MenuTile(icon: Icons.description_outlined, title: '내 지원 현황'),
          const _MenuTile(icon: Icons.notifications_none, title: '알림 설정'),
          const _MenuTile(icon: Icons.help_outline, title: '고객센터'),
          const SizedBox(height: 12),
          Center(
            child: Text('장학온 v1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title (데모)'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}
