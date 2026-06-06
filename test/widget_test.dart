import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:scholaron/main.dart';

void main() {
  testWidgets('장학온 앱이 시작되고 핵심 탭이 보인다', (WidgetTester tester) async {
    await initializeDateFormatting('ko_KR', null);
    await tester.pumpWidget(const ScholarOnApp());
    await tester.pumpAndSettle();

    // 브랜드명과 하단 탭이 렌더링되는지 확인
    expect(find.text('장학온'), findsWidgets);
    expect(find.text('1:1 후원'), findsOneWidget);
    expect(find.text('내 후원'), findsOneWidget);
  });
}
