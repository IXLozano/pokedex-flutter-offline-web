import 'package:equatable/equatable.dart';

class PokemonDetail extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int heigh;
  final int weight;
  final List<String> types;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.heigh,
    required this.weight,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, heigh, weight, types];
}
