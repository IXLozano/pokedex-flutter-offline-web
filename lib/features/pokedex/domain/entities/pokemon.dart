import 'package:equatable/equatable.dart';

/// Lightweight domain entity used by list and pagination views.
class Pokemon extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const Pokemon({required this.id, required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];
}
