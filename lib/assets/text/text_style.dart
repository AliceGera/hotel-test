//ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// App text style.
enum AppTextStyle {
  regular14(TextStyle(fontSize: 14, height: 1.40)),
  regular16(TextStyle(fontSize: 16, height: 1.24)),

  medium14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w500)),
  medium16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w500)),
  medium18(TextStyle(fontSize: 18, height: 1.24, fontWeight: FontWeight.w500)),
  medium22(TextStyle(fontSize: 22, height: 1.24, fontWeight: FontWeight.w500)),

  semiBold30(TextStyle(fontSize: 30, height: 1.40, fontWeight: FontWeight.w600)),

  bold14(TextStyle(fontSize: 14, height: 1.40, fontWeight: FontWeight.w700)),
  bold16(TextStyle(fontSize: 16, height: 1.24, fontWeight: FontWeight.w700));

  final TextStyle value;

  const AppTextStyle(this.value);
}
