import 'package:intl/intl.dart';

final _won = NumberFormat('#,###', 'ko_KR');

/// 1300000 -> "1,300,000원"
String formatWon(int amount) => '${_won.format(amount)}원';

/// 1300000 -> "130만원" (요약 표기)
String formatWonShort(int amount) {
  if (amount >= 10000) {
    final man = amount / 10000;
    final text = man == man.roundToDouble()
        ? man.toInt().toString()
        : man.toStringAsFixed(1);
    return '$text만원';
  }
  return '${_won.format(amount)}원';
}

/// 마감일 안내 문구
String deadlineLabel(int daysLeft) {
  if (daysLeft < 0) return '마감';
  if (daysLeft == 0) return '오늘 마감';
  if (daysLeft <= 7) return 'D-$daysLeft 마감 임박';
  return 'D-$daysLeft';
}
