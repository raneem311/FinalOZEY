// ignore_for_file: file_names, duplicate_ignore

// ignore_for_file: file_names

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapfeature_project/Map_doctorsLocation/DoctorLocationData.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final Function(Doctor) onTap;

  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffC4DEE4),
      child: InkWell(
        onTap: () => onTap(doctor), // Call onTap with the doctor object
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${doctor.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  RatingBarIndicator(
                    rating: doctor.rate,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              Text('Location: ${doctor.government}'),
              Text('Phone: ${doctor.phone}'),
            ],
          ),
        ),
      ),
    );
  }
}
