/// 후원 내역 모델 (후견인 → 피후견인)
class Sponsorship {
  const Sponsorship({
    required this.id,
    required this.menteeId,
    required this.menteeName,
    required this.amount,
    required this.date,
    required this.recurring,
  });

  final String id;
  final String menteeId;
  final String menteeName;

  /// 후원 금액 (원)
  final int amount;
  final DateTime date;

  /// 정기 후원 여부 (매월)
  final bool recurring;

  /// 기부금 세액공제 추정액.
  /// 현행 기부금 세액공제율(1천만원 이하 15%)을 단순 적용한 추정치.
  int get estimatedTaxDeduction => (amount * 0.15).round();
}
