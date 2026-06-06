/// 피후견인(후원을 받고자 하는 학생) 모델
class Mentee {
  const Mentee({
    required this.id,
    required this.name,
    required this.university,
    required this.major,
    required this.grade,
    required this.goalAmount,
    required this.raisedAmount,
    required this.headline,
    required this.statement,
    required this.studyPlan,
    required this.achievements,
    required this.sponsorCount,
  });

  final String id;
  final String name;
  final String university;
  final String major;

  /// 학년 (예: 2학년)
  final String grade;

  /// 목표 후원 금액 (원)
  final int goalAmount;

  /// 현재까지 모인 후원 금액 (원)
  final int raisedAmount;

  /// 한 줄 소개
  final String headline;

  /// 자기소개서
  final String statement;

  /// 학업계획서
  final String studyPlan;

  /// 주요 활동/성과 내역
  final List<String> achievements;

  /// 현재 후원자 수
  final int sponsorCount;

  double get progress =>
      goalAmount == 0 ? 0 : (raisedAmount / goalAmount).clamp(0.0, 1.0);
}
