import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color grey = Color(0xFFDCDCDC);
  static const Color grey_30 = Color(0x4DDCDCDC);
  static const Color white_95 = Color(0xfff2f2f2);
  static const Color black_50 = Color(0x80000000);

  static Color colorType(String type) {
    var color = Colors.white;
    switch (type.toLowerCase()) {
      case 'normal':
        color = Color(0xFFAA895F);
        break;
      case 'fighting':
        color = Color(0xFFFF5F65);
        break;
      case 'flying':
        color = Color(0xFF808DC7);
        break;
      case 'poison':
        color = Color(0xFFB265A1);
        break;
      case 'ground':
        color = Color(0xFFE5B15E);
        break;
      case 'rock':
        color = Color(0xFFA99F64);
        break;
      case 'bug':
        color = Color(0xFF97AA44);
        break;
      case 'ghost':
        color = Color(0xFF836C97);
        break;
      case 'steel':
        color = Color(0xFF8CB4BE);
        break;
      case 'fire':
        color = Color(0xFFF67B53);
        break;
      case 'water':
        color = Color(0xFF51C6DA);
        break;
      case 'grass':
        color = Color(0xFF7AC85B);
        break;
      case 'electric':
        color = Color(0xFFF4C912);
        break;
      case 'psychic':
        color = Color(0xFFF96289);
        break;
      case 'ice':
        color = Color(0xFF6BDDD2);
        break;
      case 'dragon':
        color = Color(0xFF5A63B0);
        break;
      case 'dark':
        color = Color(0xFF5A5050);
        break;
      case 'fairy':
        color = Color(0xFFFF78AC);
        break;
    }
    return color;
  }

  static Color colorStat(String type) {
    var color = Colors.white;
    switch (type.toLowerCase()) {
      case 'normal':
        color = Color(0xFFAA895F);
        break;
      case 'attack':
        color = Color(0xFFFF5F65);
        break;
      case 'defense':
        color = Color(0xFF808DC7);
        break;
      case 'poison':
        color = Color(0xFFB265A1);
        break;
      case 'ground':
        color = Color(0xFFE5B15E);
        break;
      case 'rock':
        color = Color(0xFFA99F64);
        break;
      case 'bug':
        color = Color(0xFF97AA44);
        break;
      case 'ghost':
        color = Color(0xFF836C97);
        break;
      case 'steel':
        color = Color(0xFF8CB4BE);
        break;
      case 'fire':
        color = Color(0xFFF67B53);
        break;
      case 'water':
        color = Color(0xFF51C6DA);
        break;
      case 'grass':
        color = Color(0xFF7AC85B);
        break;
      case 'electric':
        color = Color(0xFFF4C912);
        break;
      case 'psychic':
        color = Color(0xFFF96289);
        break;
      case 'ice':
        color = Color(0xFF6BDDD2);
        break;
      case 'dragon':
        color = Color(0xFF5A63B0);
        break;
      case 'dark':
        color = Color(0xFF5A5050);
        break;
      case 'hp':
        color = Color(0xFFFF78AC);
        break;
    }
    return color;
  }
}

//100% — FF
// 99% — FC
// 98% — FA
// 97% — F7
// 96% — F5
// 95% — F2
// 94% — F0
// 93% — ED
// 92% — EB
// 91% — E8
// 90% — E6
// 89% — E3
// 88% — E0
// 87% — DE
// 86% — DB
// 85% — D9
// 84% — D6
// 83% — D4
// 82% — D1
// 81% — CF
// 80% — CC
// 79% — C9
// 78% — C7
// 77% — C4
// 76% — C2
// 75% — BF
// 74% — BD
// 73% — BA
// 72% — B8
// 71% — B5
// 70% — B3
// 69% — B0
// 68% — AD
// 67% — AB
// 66% — A8
// 65% — A6
// 64% — A3
// 63% — A1
// 62% — 9E
// 61% — 9C
// 60% — 99
// 59% — 96
// 58% — 94
// 57% — 91
// 56% — 8F
// 55% — 8C
// 54% — 8A
// 53% — 87
// 52% — 85
// 51% — 82
// 50% — 80
// 49% — 7D
// 48% — 7A
// 47% — 78
// 46% — 75
// 45% — 73
// 44% — 70
// 43% — 6E
// 42% — 6B
// 41% — 69
// 40% — 66
// 39% — 63
// 38% — 61
// 37% — 5E
// 36% — 5C
// 35% — 59
// 34% — 57
// 33% — 54
// 32% — 52
// 31% — 4F
// 30% — 4D
// 29% — 4A
// 28% — 47
// 27% — 45
// 26% — 42
// 25% — 40
// 24% — 3D
// 23% — 3B
// 22% — 38
// 21% — 36
// 20% — 33
// 19% — 30
// 18% — 2E
// 17% — 2B
// 16% — 29
// 15% — 26
// 14% — 24
// 13% — 21
// 12% — 1F
// 11% — 1C
// 10% — 1A
// 9% — 17
// 8% — 14
// 7% — 12
// 6% — 0F
// 5% — 0D
// 4% — 0A
// 3% — 08
// 2% — 05
// 1% — 03
// 0% — 00