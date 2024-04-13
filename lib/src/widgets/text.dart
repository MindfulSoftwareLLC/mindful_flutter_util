import 'package:flutter/material.dart';

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
