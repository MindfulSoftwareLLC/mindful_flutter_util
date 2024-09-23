import 'package:flutter/material.dart';

///Set of Text replacements that match the Web and Material standards

class DisplayLarge extends H1 {
  const DisplayLarge(super.text, {super.textAlign});
}

/// H1('Hello, World') shows displayLarge
class H1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H1(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

/// H2('Hello, World') shows displayMedium
class DisplayMedium extends H2 {
  const DisplayMedium(super.text, {super.textAlign});
}

class H2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H2(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

// Continue from previous definitions

/// H2('Hello, World') shows displayMedium
class DisplaySmall extends BodyText1 {
  const DisplaySmall(super.text, {super.textAlign});
}

class H3 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H3(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class HeadlineMedium extends H4 {
  const HeadlineMedium(super.text, {super.textAlign});
}

/// H2('Hello, World') shows headlineMedium
class H4 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H4(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class HeadlineSmall extends H5 {
  const HeadlineSmall(super.text, {super.textAlign});
}

/// H2('Hello, World') shows headlineSmall
class H5 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H5(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class TitleLarge extends H6 {
  const TitleLarge(super.text, {super.textAlign});
}

/// H2('Hello, World') shows displayMedium
class H6 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const H6(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class TitleMedium extends Subtitle1 {
  TitleMedium(super.text, {super.textAlign});
}

/// H2('Hello, World') shows titleMedium
class Subtitle1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const Subtitle1(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class TitleSmall extends Subtitle2 {
  TitleSmall(super.text, {super.textAlign});
}

/// H2('Hello, World') shows titleSmall
class Subtitle2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const Subtitle2(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

class BodyLarge extends BodyText1 {
  const BodyLarge(super.text, {super.textAlign});
}

/// H2('Hello, World') shows bodyLarge
class BodyText1 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const BodyText1(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class BodyMedium extends BodyText2 {
  const BodyMedium(super.text, {super.textAlign});
}

/// BodyText2('Hello, World') shows bodyMedium
class BodyText2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const BodyText2(this.text, {this.textAlign = TextAlign.start, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
