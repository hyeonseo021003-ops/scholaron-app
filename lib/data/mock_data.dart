import '../models/scholarship.dart';
import '../models/mentee.dart';
import '../models/sponsorship.dart';

/// 데모용 목업 데이터 (실제 서비스에서는 API 연동 예정)
class MockData {
  static final List<Scholarship> scholarships = [
    Scholarship(
      id: 's1',
      name: '국가장학금 Ⅰ유형',
      organization: '한국장학재단',
      type: ScholarshipType.national,
      amount: 2600000,
      deadline: DateTime(2026, 6, 20),
      tags: ['소득연계', '전학년', '재학생'],
      description: '소득 수준에 연계하여 등록금 부담을 경감해 주는 대표적인 국가 지원 장학금입니다.',
      requirements: ['소득 8구간 이하', '직전 학기 12학점 이상 이수', '성적 80/100 이상'],
    ),
    Scholarship(
      id: 's2',
      name: '성적우수 장학금',
      organization: '서울대학교',
      type: ScholarshipType.merit,
      amount: 1500000,
      deadline: DateTime(2026, 6, 10),
      tags: ['성적우수', '전공무관', '재학생'],
      description: '직전 학기 성적이 우수한 재학생에게 등록금의 일부를 지원합니다.',
      requirements: ['직전 학기 평점 4.0/4.5 이상', '15학점 이상 이수'],
    ),
    Scholarship(
      id: 's3',
      name: '꿈사다리 생활지원 장학금',
      organization: '꿈드림재단',
      type: ScholarshipType.need,
      amount: 1200000,
      deadline: DateTime(2026, 7, 15),
      tags: ['생활비', '사각지대', '면접'],
      description:
          '소득분위 산정에서 제외되었으나 실질적 지원이 필요한 학생을 위한 생활비 지원 장학금입니다.',
      requirements: ['자기소개서 제출', '재정 곤란 사유서', '추천서 1부'],
      incomeBracketFree: true,
    ),
    Scholarship(
      id: 's4',
      name: '인문학 진흥 전공장학금',
      organization: '한울인문재단',
      type: ScholarshipType.major,
      amount: 1000000,
      deadline: DateTime(2026, 6, 30),
      tags: ['인문', '국문', '사학', '철학', '전공특화'],
      description: '활동 지원이 부족한 인문계열 전공자의 학술·문화 활동을 지원합니다.',
      requirements: ['인문계열 전공 재학생', '활동 계획서 제출'],
      incomeBracketFree: true,
    ),
    Scholarship(
      id: 's5',
      name: '이공계 우수인재 장학금',
      organization: '미래과학장학회',
      type: ScholarshipType.major,
      amount: 3000000,
      deadline: DateTime(2026, 8, 1),
      tags: ['이공계', '공학', '연구', '전공특화'],
      description: '이공계 연구 역량이 우수한 학생에게 등록금과 연구 활동비를 지원합니다.',
      requirements: ['이공계 전공', '연구계획서', '지도교수 추천서'],
    ),
    Scholarship(
      id: 's6',
      name: '선배가 후배에게, 1:1 매칭후원',
      organization: '장학온 매칭 펀드',
      type: ScholarshipType.matching,
      amount: 800000,
      deadline: DateTime(2026, 6, 8),
      tags: ['매칭후원', '사각지대', '선배후원', '전공무관'],
      description:
          '소득분위와 무관하게, 학업계획서와 자기소개서를 바탕으로 후견인과 1:1로 매칭되는 후원입니다.',
      requirements: ['학업계획서 작성', '자기소개서 작성', '활동 리포트 동의'],
      incomeBracketFree: true,
    ),
  ];

  static final List<Mentee> mentees = [
    Mentee(
      id: 'm1',
      name: '한경석',
      university: '서울대학교',
      major: '국어국문학과',
      grade: '3학년',
      goalAmount: 2000000,
      raisedAmount: 1300000,
      headline: '문헌 디지털 아카이빙으로 사라지는 우리말을 지키고 싶습니다.',
      statement:
          '저는 지방 소도시에서 자라며 일찍부터 우리말과 옛 문헌에 관심을 가졌습니다. '
          '국문과는 공대에 비해 활동 지원이 부족해 자비로 답사와 자료 수집을 이어왔지만, '
          '후원을 통해 더 많은 학생들이 인문학을 포기하지 않도록 돕고 싶습니다.',
      studyPlan:
          '1) 조선 후기 한글 문헌 100건 디지털 전사 및 공개\n'
          '2) 교내 인문학 답사 동아리 운영 및 후배 멘토링\n'
          '3) 졸업 후 디지털 인문학 대학원 진학 목표',
      achievements: ['교내 국어국문 학술제 우수상', '한글 아카이브 프로젝트 팀장', '교양 국어 튜터 2학기'],
      sponsorCount: 4,
    ),
    Mentee(
      id: 'm2',
      name: '임다현',
      university: '연세대학교',
      major: '전기전자공학부',
      grade: '2학년',
      goalAmount: 2500000,
      raisedAmount: 600000,
      headline: '저전력 IoT 센서로 농촌 독거 어르신을 돌보는 시스템을 만들고 있습니다.',
      statement:
          '국가장학금 소득 구간에서는 아슬아슬하게 제외되어 지원을 받지 못했지만, '
          '학업과 아르바이트를 병행하며 공학도의 꿈을 이어가고 있습니다. '
          '후원이 이어진다면 아르바이트 시간을 줄이고 연구에 더 집중하겠습니다.',
      studyPlan:
          '1) 저전력 환경 센서 노드 프로토타입 완성\n'
          '2) 교내 창업경진대회 출전\n'
          '3) 임베디드 시스템 연구실 인턴 지원',
      achievements: ['아두이노 기반 헬스케어 시제품 제작', '교내 해커톤 2위', '전공 평점 4.1/4.5'],
      sponsorCount: 2,
    ),
    Mentee(
      id: 'm3',
      name: '이시연',
      university: '고려대학교',
      major: '사회학과',
      grade: '4학년',
      goalAmount: 1500000,
      raisedAmount: 1500000,
      headline: '청소년 교육 격차 해소를 위한 데이터 기반 정책 연구를 합니다.',
      statement:
          '교육 봉사를 하며 지역과 소득에 따른 교육 격차를 직접 목격했습니다. '
          '사회학적 분석과 데이터를 결합해 실효성 있는 정책을 제안하는 연구자가 되고 싶습니다.',
      studyPlan:
          '1) 교육 격차 데이터 분석 졸업 논문 완성\n'
          '2) 교육 NGO 정책 인턴십\n'
          '3) 정책대학원 진학 준비',
      achievements: ['교육 봉사 320시간', '학부 연구생 1년', '사회조사분석사 2급'],
      sponsorCount: 6,
    ),
  ];

  /// 현재 로그인한 후견인의 후원 내역 (데모)
  static final List<Sponsorship> mySponsorships = [
    Sponsorship(
      id: 'sp1',
      menteeId: 'm1',
      menteeName: '한경석',
      amount: 300000,
      date: DateTime(2026, 3, 15),
      recurring: true,
    ),
    Sponsorship(
      id: 'sp2',
      menteeId: 'm3',
      menteeName: '이시연',
      amount: 500000,
      date: DateTime(2026, 1, 10),
      recurring: false,
    ),
  ];
}
