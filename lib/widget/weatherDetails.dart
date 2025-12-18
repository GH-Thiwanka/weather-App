import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Weatherdetails extends StatefulWidget {
  final String lable;
  final String value;
  final String detail;
  const Weatherdetails({
    super.key,
    required this.lable,
    required this.value,
    required this.detail,
  });

  @override
  State<Weatherdetails> createState() => _WeatherdetailsState();
}

class _WeatherdetailsState extends State<Weatherdetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25, // Responsive width
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Lottie.asset(widget.detail),
            Text(widget.lable),
            widget.lable.toString() == 'Pressure'
                ? Text('${widget.value} hpa')
                : widget.lable.toString() == 'Wind Speed'
                ? Text('${widget.value} m/s')
                : Text('${widget.value}%'),
          ],
        ),
      ),
    );
  }
}
