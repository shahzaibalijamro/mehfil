import 'package:flutter/material.dart';

enum TableShape {
  round('Round', Icons.circle_outlined),
  rectangular('Rectangle', Icons.crop_square_rounded);

  final String label;
  final IconData icon;

  const TableShape(this.label, this.icon);
}

class SeatingTable {
  final String id;
  String name;
  TableShape shape;
  int seatCapacity;
  List<String> assignedGuestIds;

  SeatingTable({
    required this.id,
    required this.name,
    this.shape = TableShape.round,
    required this.seatCapacity,
    List<String>? assignedGuestIds,
  }) : assignedGuestIds = assignedGuestIds ?? [];

  SeatingTable copyWith({
    String? id,
    String? name,
    TableShape? shape,
    int? seatCapacity,
    List<String>? assignedGuestIds,
  }) {
    return SeatingTable(
      id: id ?? this.id,
      name: name ?? this.name,
      shape: shape ?? this.shape,
      seatCapacity: seatCapacity ?? this.seatCapacity,
      assignedGuestIds: assignedGuestIds != null
          ? List<String>.from(assignedGuestIds)
          : List<String>.from(this.assignedGuestIds),
    );
  }
}
