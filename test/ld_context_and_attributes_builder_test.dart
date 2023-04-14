import 'package:flutter_test/flutter_test.dart';
import 'package:launchdarkly_flutter_client_sdk/launchdarkly_flutter_client_sdk.dart';

void main() {
  test('context builder simple case', () {
    LDContextBuilder builder = LDContextBuilder();
    builder.kind('user', 'uuid').name('Todd');
    builder.kind('company', 'key').name('LaunchDarkly');
    LDContext context = builder.build();
    List<dynamic> output = context.toCodecValue();

    List<dynamic> expectedOutput = [
      {
        'kind': 'user',
        'key': 'uuid',
        'name': 'Todd',
      },
      {
        'kind': 'company',
        'key': 'key',
        'name': 'LaunchDarkly',
      }
    ];

    expect(output, equals(expectedOutput));
  });

  test('context builder anonymous', () {
    LDContextBuilder builder = LDContextBuilder();
    builder.kind('user', 'uuid').name('Todd');
    builder.kind('company', 'key').name('LaunchDarkly').anonymous(true);
    LDContext context = builder.build();
    List<dynamic> output = context.toCodecValue();

    List<dynamic> expectedOutput = [
      {
        'kind': 'user',
        'key': 'uuid',
        'name': 'Todd',
      },
      {
        'kind': 'company',
        'key': 'key',
        'anonymous': true,
        'name': 'LaunchDarkly',
      }
    ];

    expect(output, equals(expectedOutput));
  });

  test('context builder with custom type', () {
    LDContextBuilder builder = LDContextBuilder();
    builder
        .kind('user', 'uuid')
        .name('Todd')
        .set(
            'level1',
            LDValue.buildObject()
                .addValue('level2',
                    LDValue.buildObject().addNum('aNumber', 7).build())
                .build())
        .set('customType', LDValue.ofString('customValue'));
    builder.kind('company', 'key').name('LaunchDarkly');
    LDContext context = builder.build();
    List<dynamic> output = context.toCodecValue();

    List<dynamic> expectedOutput = [
      {
        'kind': 'user',
        'key': 'uuid',
        'name': 'Todd',
        'level1': {
          'level2': {
            'aNumber': 7,
          }
        },
        'customType': 'customValue'
      },
      {
        'kind': 'company',
        'key': 'key',
        'name': 'LaunchDarkly',
      }
    ];

    expect(output, equals(expectedOutput));
  });
}
