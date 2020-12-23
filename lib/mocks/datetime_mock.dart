import 'dart:math' as math;

class AppointmentsMock {
  static List<String> createRandomDateTimes({int length}) {
    List<String> appointments = [];
    int customLength = length == null ? math.Random().nextInt(15) + 1 : length;
    DateTime now = DateTime.now();

    for (int i = 0; i < customLength; i++) {
      String year = '2021';
      String month = now.month == 12
          ? (math.Random().nextInt(11) + 1).toString()
          : (now.month + math.Random().nextInt(12 - now.month)).toString();
      String day = month == now.month.toString()
          ? (math.Random().nextInt(30 - now.day) + now.day).toString()
          : (math.Random().nextInt(30) + 1).toString();

      bool isToday = int.parse(day) == now.day && int.parse(month) == now.month;

      bool halfHour = math.Random().nextBool();
      String hour = isToday
          ? (math.Random().nextInt(12 - now.hour) + (12 - now.hour)).toString()
          : (math.Random().nextInt(12) + 1).toString();
      hour = int.parse(hour) > 12 ? (int.parse(hour) - 12).toString() : hour;
      bool am = isToday ? now.hour < 12 : math.Random().nextBool();

      String appointment =
          '${hour.length == 1 ? '0$hour' : hour}:${halfHour ? '30' : '00'} ${am ? 'am' : 'pm'}, ${month.length == 1 ? '0$month' : month}.${day.length == 1 ? '0$day' : day}.$year';

      appointments.add(appointment);
    }

    //appointments.sort((a, b) => int.parse(a.split('.').first.split(',').last.trim()).compareTo(int.parse(b.split('.').first.split(',').last.trim())));

    appointments.sort((a, b) {
      String firstDate = _formatString(a.split(',').last.trim());
      String secondDate = _formatString(b.split(',').last.trim());

      return DateTime.parse(firstDate).compareTo(DateTime.parse(secondDate));
    });

    return appointments;
  }

  static _formatString(String string) {
    List<String> split = string.split('.');
    String year = split.last;
    String month = split.first;
    String day = split[1];

    String formattedString = '$year-$month-$day';

    print(formattedString);
    return formattedString;
  }
}
