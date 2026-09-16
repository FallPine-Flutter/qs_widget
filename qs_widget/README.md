# qs_widget

`qs_widget` 是一个 Flutter 常用 UI 组件库，提供容器、按钮、文本、富文本、
输入框、图片、开关、键盘避让、页面保活和全局浮层等组件。

## 环境要求

- Dart SDK：`^3.10.3`
- Flutter：`>=3.3.0`

## 安装

在项目的 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  qs_widget: ^1.0.8
```

然后执行：

```shell
flutter pub get
```

当前组件按文件分别导出，使用时需要导入对应文件：

```dart
import 'package:qs_widget/qs_box.dart';
import 'package:qs_widget/qs_button.dart';
import 'package:qs_widget/qs_label.dart';
```

## QsBox

`QsBox` 是支持尺寸、间距、背景、边框、圆角、阴影、渐变、约束和内容裁剪的通用容器。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_box.dart';

const QsBox(
  width: 200,
  height: 100,
  padding: EdgeInsetsDirectional.all(16),
  color: Colors.white,
  outerRadius: BorderRadiusDirectional.all(Radius.circular(12)),
  innerRadius: BorderRadiusDirectional.all(Radius.circular(12)),
  border: Border.fromBorderSide(
    BorderSide(color: Colors.black12),
  ),
  boxShadows: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ],
  child: Text('QsBox 内容'),
)
```

设置 `isCircle: true` 可以创建圆形容器。`outerRadius` 控制外层装饰圆角，
`innerRadius` 控制子组件的裁剪圆角。圆角参数使用 `BorderRadiusGeometry`，
可以传入 `BorderRadiusDirectional` 适配 RTL 布局。存在边框时，内容裁剪圆角会结合边框宽度计算，
避免子组件内容覆盖到边框区域。

## QsButton

`QsButton` 支持普通、选中和禁用三种状态。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_button.dart';
import 'package:qs_widget/qs_label.dart';

QsButton(
  width: 160,
  height: 48,
  normalBackgroundColor: Colors.blue,
  selectedBackgroundColor: Colors.green,
  disabledBackgroundColor: Colors.grey,
  outerRadius: BorderRadius.circular(8),
  isSelected: false,
  isEnabled: true,
  normalChild: const QsLabel(
    text: '提交',
    textColor: Colors.white,
  ),
  selectedChild: const QsLabel(
    text: '已选择',
    textColor: Colors.white,
  ),
  disabledChild: const QsLabel(
    text: '不可用',
    textColor: Colors.white,
  ),
  onTap: () {
    debugPrint('点击按钮');
  },
)
```

未设置 `selectedChild` 或 `disabledChild` 时，会回退使用 `normalChild`。
当 `isEnabled` 为 `false` 时，不会触发 `onTap`。

## QsLabel

`QsLabel` 用于显示普通文本，也可以根据可用空间自动缩放文字。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_label.dart';

const QsLabel(
  text: '这是一段文本',
  textColor: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  textAlign: TextAlign.left,
  maxLines: 2,
)
```

启用自动字号：

```dart
const QsLabel(
  text: '文字会根据可用空间自动调整大小',
  isAutoSize: true,
  fontSize: 20,
  maxLines: 1,
)
```

如需显示不限制行数的多行文本，请同时设置：

```dart
const QsLabel(
  text: '多行文本内容',
  maxLines: null,
  overflow: null,
)
```

## QsRichLabel

`QsRichLabel` 可以为指定文字设置独立样式、点击事件和描边效果。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_rich_label.dart';

QsRichLabel(
  text: '阅读并同意用户协议和隐私政策',
  baseStyle: const TextStyle(
    color: Colors.black54,
    fontSize: 14,
  ),
  matchedStrings: {
    '用户协议': QsRichLabelStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      onTap: () {
        debugPrint('点击用户协议');
      },
    ),
    '隐私政策': QsRichLabelStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      onTap: () {
        debugPrint('点击隐私政策');
      },
    ),
  },
)
```

通过 `borderWidth` 和 `borderColor` 可以添加文字描边。

## QsTextView

`QsTextView` 是无默认边框的轻量文本输入框。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_text_view.dart';

final controller = TextEditingController();

QsTextView(
  controller: controller,
  placeholder: '请输入手机号',
  keyboardType: TextInputType.number,
  maxLength: 11,
  textColor: Colors.black,
  placeholderColor: Colors.grey,
  onChanged: (value) {
    debugPrint('当前内容：$value');
  },
  onSubmitted: (value) {
    debugPrint('提交内容：$value');
  },
)
```

当 `keyboardType` 为 `TextInputType.number` 时，组件只允许输入数字。
默认隐藏字符计数器，可通过 `isShowCounterText: true` 显示。

## QsKeyboardAvoidanceView

`QsKeyboardAvoidanceView` 仅移动其内部被键盘遮挡的输入区域，不会将整个页面向上顶起。
使用时需要将页面的 `resizeToAvoidBottomInset` 设置为 `false`，并确保组件的父布局
有足够空间供内容上移。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_keyboard_avoidance_view.dart';

Scaffold(
  resizeToAvoidBottomInset: false,
  body: QsKeyboardAvoidanceView(
    spacing: 16,
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeOutCubic,
    child: const Column(
      children: [
        Spacer(),
        TextField(),
        SizedBox(height: 24),
      ],
    ),
  ),
)
```

当获得焦点的输入框位于组件内部时，组件会优先滚动内部的垂直滚动视图；
滚动距离不足时，再将剩余内容向上平移。可通过 `enabled` 动态启用或关闭避让，
通过 `spacing` 设置输入框与键盘之间的额外间距。

## QsImageView

`QsImageView` 统一支持资源图片、SVG、网络图片和本地文件图片。

### 资源图片

```dart
import 'package:qs_widget/qs_image_view.dart';

const QsImageView(
  type: QsImageType.asset,
  imageSrc: 'assets/images/avatar.png',
  width: 80,
  height: 80,
  isCircle: true,
)
```

### SVG 图片

```dart
const QsImageView(
  type: QsImageType.svg,
  imageSrc: 'assets/images/icon.svg',
  width: 24,
  height: 24,
)
```

### 网络图片

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_image_view.dart';

QsImageView(
  type: QsImageType.network,
  imageSrc: 'https://example.com/image.png',
  width: 200,
  height: 120,
  outerRadius: BorderRadius.circular(12),
  placeholder: const Center(child: CircularProgressIndicator()),
  error: const Center(child: Icon(Icons.broken_image)),
)
```

### 本地文件图片

```dart
QsImageView(
  type: QsImageType.file,
  imageSrc: imageFile.path,
  width: 120,
  height: 120,
)
```

图片类型与 `imageSrc` 的对应关系：

| 类型 | `imageSrc` 内容 |
| --- | --- |
| `QsImageType.asset` | Flutter 资源路径 |
| `QsImageType.svg` | Flutter SVG 资源路径 |
| `QsImageType.network` | 网络图片 URL |
| `QsImageType.file` | 设备本地文件路径 |

## QsSwitchButton

`QsSwitchButton` 使用白色滑块，并隐藏默认轨道轮廓。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_switch_button.dart';

QsSwitchButton(
  value: isEnabled,
  activeTrackColor: Colors.blue,
  inactiveTrackColor: Colors.grey.shade300,
  onChanged: (value) {
    setState(() {
      isEnabled = value;
    });
  },
)
```

## QsAliveView

`QsAliveView` 用于在 `TabBarView`、`PageView` 等可滚动视图中保留子组件状态。

```dart
import 'package:qs_widget/qs_alive_view.dart';

const QsAliveView(
  keepAlive: true,
  child: YourPage(),
)
```

设置 `keepAlive: false` 可以关闭状态保活。

## QsKeyWindow

`QsKeyWindow` 通过 `Overlay` 显示全局浮层。同一时间只保留一个浮层，
重复调用 `show` 会先移除已有内容。

```dart
import 'package:flutter/material.dart';
import 'package:qs_widget/qs_key_window.dart';

QsKeyWindow.show(
  context: context,
  top: 100,
  right: 16,
  child: Material(
    color: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(12),
      color: Colors.black87,
      child: const Text(
        '浮层内容',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
);
```

隐藏浮层：

```dart
QsKeyWindow.hide();
```

## 许可证

请根据项目仓库中的许可证文件使用本插件。
