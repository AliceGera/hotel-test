extension IntSerialNumberExtension on int {
  String serialNumberString() {
    switch (this) {
      case 1:
        return 'Первый';
      case 2:
        return 'Второй';
      case 3:
        return 'Третий';
      case 4:
        return 'Четвертый';
      case 5:
        return 'Пятый';
      case 6:
        return 'Шестой';
      case 7:
        return 'Седьмой';
      case 8:
        return 'Восьмой';
      case 9:
        return 'Девятый';
      case 10:
        return 'Десятый';
      default:
        return '';
    }
  }
}
