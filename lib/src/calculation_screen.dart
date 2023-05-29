import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Performs timing calculations.
class CalculationScreen extends StatefulWidget {
  /// Creates a new [CalculationScreen].
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  var _sleepTime = const TimeOfDay(hour: 22, minute: 0);
  var _wakeTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay? _melatoninTime;

  void _calculateMelatoninTime() {
    final totalSleepDuration = ((_wakeTime.hour + _wakeTime.minute / 60) -
            (_sleepTime.hour + _sleepTime.minute / 60)) %
        24;

    final midpoint = TimeOfDay(
      hour: _sleepTime.hour + (totalSleepDuration / 2).round(),
      minute: _sleepTime.minute,
    );

    _melatoninTime = TimeOfDay(
      hour: (midpoint.hour - 11) % 24,
      minute: midpoint.minute,
    );
  }

  Future<TimeOfDay> _pickTime(TimeOfDay initialTime) async {
    return await showTimePicker(
          context: context,
          initialTime: initialTime,
          initialEntryMode: TimePickerEntryMode.input,
        ) ??
        initialTime;
  }

  @override
  void initState() {
    _calculateMelatoninTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              spacing: 40,
              runSpacing: 20,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Natural sleep time',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        final newTime = await _pickTime(_sleepTime);
                        _sleepTime = newTime;
                        _calculateMelatoninTime();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(_sleepTime.format(context)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Natural wake time',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        final newTime = await _pickTime(_wakeTime);
                        _wakeTime = newTime;
                        _calculateMelatoninTime();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(_wakeTime.format(context)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_melatoninTime != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Take 0.5mg-3mg of melatonin at:'),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _melatoninTime!.format(context),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text('Advance by one hour every day.'),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3558560/',
                    ),
                  );
                },
                child: const Text(
                  'Source',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
