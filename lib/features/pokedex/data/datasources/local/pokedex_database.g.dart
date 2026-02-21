// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_database.dart';

// ignore_for_file: type=lint
class $PokemonListCacheTableTable extends PokemonListCacheTable
    with TableInfo<$PokemonListCacheTableTable, PokemonListCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonListCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pageOffsetMeta = const VerificationMeta(
    'pageOffset',
  );
  @override
  late final GeneratedColumn<int> pageOffset = GeneratedColumn<int>(
    'page_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    pageOffset,
    position,
    pokemonId,
    name,
    imageUrl,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_list_cache_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonListCacheTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('page_offset')) {
      context.handle(
        _pageOffsetMeta,
        pageOffset.isAcceptableOrUnknown(data['page_offset']!, _pageOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_pageOffsetMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pageOffset, position};
  @override
  PokemonListCacheTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonListCacheTableData(
      pageOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_offset'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PokemonListCacheTableTable createAlias(String alias) {
    return $PokemonListCacheTableTable(attachedDatabase, alias);
  }
}

class PokemonListCacheTableData extends DataClass
    implements Insertable<PokemonListCacheTableData> {
  final int pageOffset;
  final int position;
  final int pokemonId;
  final String name;
  final String imageUrl;
  final int updatedAt;
  const PokemonListCacheTableData({
    required this.pageOffset,
    required this.position,
    required this.pokemonId,
    required this.name,
    required this.imageUrl,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['page_offset'] = Variable<int>(pageOffset);
    map['position'] = Variable<int>(position);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  PokemonListCacheTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonListCacheTableCompanion(
      pageOffset: Value(pageOffset),
      position: Value(position),
      pokemonId: Value(pokemonId),
      name: Value(name),
      imageUrl: Value(imageUrl),
      updatedAt: Value(updatedAt),
    );
  }

  factory PokemonListCacheTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonListCacheTableData(
      pageOffset: serializer.fromJson<int>(json['pageOffset']),
      position: serializer.fromJson<int>(json['position']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pageOffset': serializer.toJson<int>(pageOffset),
      'position': serializer.toJson<int>(position),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  PokemonListCacheTableData copyWith({
    int? pageOffset,
    int? position,
    int? pokemonId,
    String? name,
    String? imageUrl,
    int? updatedAt,
  }) => PokemonListCacheTableData(
    pageOffset: pageOffset ?? this.pageOffset,
    position: position ?? this.position,
    pokemonId: pokemonId ?? this.pokemonId,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PokemonListCacheTableData copyWithCompanion(
    PokemonListCacheTableCompanion data,
  ) {
    return PokemonListCacheTableData(
      pageOffset: data.pageOffset.present
          ? data.pageOffset.value
          : this.pageOffset,
      position: data.position.present ? data.position.value : this.position,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonListCacheTableData(')
          ..write('pageOffset: $pageOffset, ')
          ..write('position: $position, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(pageOffset, position, pokemonId, name, imageUrl, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonListCacheTableData &&
          other.pageOffset == this.pageOffset &&
          other.position == this.position &&
          other.pokemonId == this.pokemonId &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.updatedAt == this.updatedAt);
}

class PokemonListCacheTableCompanion
    extends UpdateCompanion<PokemonListCacheTableData> {
  final Value<int> pageOffset;
  final Value<int> position;
  final Value<int> pokemonId;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const PokemonListCacheTableCompanion({
    this.pageOffset = const Value.absent(),
    this.position = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonListCacheTableCompanion.insert({
    required int pageOffset,
    required int position,
    required int pokemonId,
    required String name,
    required String imageUrl,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : pageOffset = Value(pageOffset),
       position = Value(position),
       pokemonId = Value(pokemonId),
       name = Value(name),
       imageUrl = Value(imageUrl),
       updatedAt = Value(updatedAt);
  static Insertable<PokemonListCacheTableData> custom({
    Expression<int>? pageOffset,
    Expression<int>? position,
    Expression<int>? pokemonId,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pageOffset != null) 'page_offset': pageOffset,
      if (position != null) 'position': position,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonListCacheTableCompanion copyWith({
    Value<int>? pageOffset,
    Value<int>? position,
    Value<int>? pokemonId,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return PokemonListCacheTableCompanion(
      pageOffset: pageOffset ?? this.pageOffset,
      position: position ?? this.position,
      pokemonId: pokemonId ?? this.pokemonId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pageOffset.present) {
      map['page_offset'] = Variable<int>(pageOffset.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonListCacheTableCompanion(')
          ..write('pageOffset: $pageOffset, ')
          ..write('position: $position, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonDetailCacheTableTable extends PokemonDetailCacheTable
    with TableInfo<$PokemonDetailCacheTableTable, PokemonDetailCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonDetailCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typesJsonMeta = const VerificationMeta(
    'typesJson',
  );
  @override
  late final GeneratedColumn<String> typesJson = GeneratedColumn<String>(
    'types_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageUrl,
    height,
    weight,
    typesJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_detail_cache_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonDetailCacheTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('types_json')) {
      context.handle(
        _typesJsonMeta,
        typesJson.isAcceptableOrUnknown(data['types_json']!, _typesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_typesJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonDetailCacheTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonDetailCacheTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
      typesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}types_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PokemonDetailCacheTableTable createAlias(String alias) {
    return $PokemonDetailCacheTableTable(attachedDatabase, alias);
  }
}

class PokemonDetailCacheTableData extends DataClass
    implements Insertable<PokemonDetailCacheTableData> {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final String typesJson;
  final int updatedAt;
  const PokemonDetailCacheTableData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.typesJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['height'] = Variable<int>(height);
    map['weight'] = Variable<int>(weight);
    map['types_json'] = Variable<String>(typesJson);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  PokemonDetailCacheTableCompanion toCompanion(bool nullToAbsent) {
    return PokemonDetailCacheTableCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      height: Value(height),
      weight: Value(weight),
      typesJson: Value(typesJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory PokemonDetailCacheTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonDetailCacheTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      height: serializer.fromJson<int>(json['height']),
      weight: serializer.fromJson<int>(json['weight']),
      typesJson: serializer.fromJson<String>(json['typesJson']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'height': serializer.toJson<int>(height),
      'weight': serializer.toJson<int>(weight),
      'typesJson': serializer.toJson<String>(typesJson),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  PokemonDetailCacheTableData copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? height,
    int? weight,
    String? typesJson,
    int? updatedAt,
  }) => PokemonDetailCacheTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    typesJson: typesJson ?? this.typesJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PokemonDetailCacheTableData copyWithCompanion(
    PokemonDetailCacheTableCompanion data,
  ) {
    return PokemonDetailCacheTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      typesJson: data.typesJson.present ? data.typesJson.value : this.typesJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonDetailCacheTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('typesJson: $typesJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, imageUrl, height, weight, typesJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonDetailCacheTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.typesJson == this.typesJson &&
          other.updatedAt == this.updatedAt);
}

class PokemonDetailCacheTableCompanion
    extends UpdateCompanion<PokemonDetailCacheTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> height;
  final Value<int> weight;
  final Value<String> typesJson;
  final Value<int> updatedAt;
  const PokemonDetailCacheTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.typesJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PokemonDetailCacheTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required int height,
    required int weight,
    required String typesJson,
    required int updatedAt,
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       height = Value(height),
       weight = Value(weight),
       typesJson = Value(typesJson),
       updatedAt = Value(updatedAt);
  static Insertable<PokemonDetailCacheTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? height,
    Expression<int>? weight,
    Expression<String>? typesJson,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (typesJson != null) 'types_json': typesJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PokemonDetailCacheTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? height,
    Value<int>? weight,
    Value<String>? typesJson,
    Value<int>? updatedAt,
  }) {
    return PokemonDetailCacheTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      typesJson: typesJson ?? this.typesJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (typesJson.present) {
      map['types_json'] = Variable<String>(typesJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonDetailCacheTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('typesJson: $typesJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$PokedexDatabase extends GeneratedDatabase {
  _$PokedexDatabase(QueryExecutor e) : super(e);
  $PokedexDatabaseManager get managers => $PokedexDatabaseManager(this);
  late final $PokemonListCacheTableTable pokemonListCacheTable =
      $PokemonListCacheTableTable(this);
  late final $PokemonDetailCacheTableTable pokemonDetailCacheTable =
      $PokemonDetailCacheTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemonListCacheTable,
    pokemonDetailCacheTable,
  ];
}

typedef $$PokemonListCacheTableTableCreateCompanionBuilder =
    PokemonListCacheTableCompanion Function({
      required int pageOffset,
      required int position,
      required int pokemonId,
      required String name,
      required String imageUrl,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$PokemonListCacheTableTableUpdateCompanionBuilder =
    PokemonListCacheTableCompanion Function({
      Value<int> pageOffset,
      Value<int> position,
      Value<int> pokemonId,
      Value<String> name,
      Value<String> imageUrl,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$PokemonListCacheTableTableFilterComposer
    extends Composer<_$PokedexDatabase, $PokemonListCacheTableTable> {
  $$PokemonListCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pageOffset => $composableBuilder(
    column: $table.pageOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonListCacheTableTableOrderingComposer
    extends Composer<_$PokedexDatabase, $PokemonListCacheTableTable> {
  $$PokemonListCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pageOffset => $composableBuilder(
    column: $table.pageOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonListCacheTableTableAnnotationComposer
    extends Composer<_$PokedexDatabase, $PokemonListCacheTableTable> {
  $$PokemonListCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pageOffset => $composableBuilder(
    column: $table.pageOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PokemonListCacheTableTableTableManager
    extends
        RootTableManager<
          _$PokedexDatabase,
          $PokemonListCacheTableTable,
          PokemonListCacheTableData,
          $$PokemonListCacheTableTableFilterComposer,
          $$PokemonListCacheTableTableOrderingComposer,
          $$PokemonListCacheTableTableAnnotationComposer,
          $$PokemonListCacheTableTableCreateCompanionBuilder,
          $$PokemonListCacheTableTableUpdateCompanionBuilder,
          (
            PokemonListCacheTableData,
            BaseReferences<
              _$PokedexDatabase,
              $PokemonListCacheTableTable,
              PokemonListCacheTableData
            >,
          ),
          PokemonListCacheTableData,
          PrefetchHooks Function()
        > {
  $$PokemonListCacheTableTableTableManager(
    _$PokedexDatabase db,
    $PokemonListCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonListCacheTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonListCacheTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonListCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> pageOffset = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> pokemonId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonListCacheTableCompanion(
                pageOffset: pageOffset,
                position: position,
                pokemonId: pokemonId,
                name: name,
                imageUrl: imageUrl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pageOffset,
                required int position,
                required int pokemonId,
                required String name,
                required String imageUrl,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PokemonListCacheTableCompanion.insert(
                pageOffset: pageOffset,
                position: position,
                pokemonId: pokemonId,
                name: name,
                imageUrl: imageUrl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonListCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$PokedexDatabase,
      $PokemonListCacheTableTable,
      PokemonListCacheTableData,
      $$PokemonListCacheTableTableFilterComposer,
      $$PokemonListCacheTableTableOrderingComposer,
      $$PokemonListCacheTableTableAnnotationComposer,
      $$PokemonListCacheTableTableCreateCompanionBuilder,
      $$PokemonListCacheTableTableUpdateCompanionBuilder,
      (
        PokemonListCacheTableData,
        BaseReferences<
          _$PokedexDatabase,
          $PokemonListCacheTableTable,
          PokemonListCacheTableData
        >,
      ),
      PokemonListCacheTableData,
      PrefetchHooks Function()
    >;
typedef $$PokemonDetailCacheTableTableCreateCompanionBuilder =
    PokemonDetailCacheTableCompanion Function({
      Value<int> id,
      required String name,
      required String imageUrl,
      required int height,
      required int weight,
      required String typesJson,
      required int updatedAt,
    });
typedef $$PokemonDetailCacheTableTableUpdateCompanionBuilder =
    PokemonDetailCacheTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> imageUrl,
      Value<int> height,
      Value<int> weight,
      Value<String> typesJson,
      Value<int> updatedAt,
    });

class $$PokemonDetailCacheTableTableFilterComposer
    extends Composer<_$PokedexDatabase, $PokemonDetailCacheTableTable> {
  $$PokemonDetailCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get typesJson => $composableBuilder(
    column: $table.typesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonDetailCacheTableTableOrderingComposer
    extends Composer<_$PokedexDatabase, $PokemonDetailCacheTableTable> {
  $$PokemonDetailCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get typesJson => $composableBuilder(
    column: $table.typesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonDetailCacheTableTableAnnotationComposer
    extends Composer<_$PokedexDatabase, $PokemonDetailCacheTableTable> {
  $$PokemonDetailCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get typesJson =>
      $composableBuilder(column: $table.typesJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PokemonDetailCacheTableTableTableManager
    extends
        RootTableManager<
          _$PokedexDatabase,
          $PokemonDetailCacheTableTable,
          PokemonDetailCacheTableData,
          $$PokemonDetailCacheTableTableFilterComposer,
          $$PokemonDetailCacheTableTableOrderingComposer,
          $$PokemonDetailCacheTableTableAnnotationComposer,
          $$PokemonDetailCacheTableTableCreateCompanionBuilder,
          $$PokemonDetailCacheTableTableUpdateCompanionBuilder,
          (
            PokemonDetailCacheTableData,
            BaseReferences<
              _$PokedexDatabase,
              $PokemonDetailCacheTableTable,
              PokemonDetailCacheTableData
            >,
          ),
          PokemonDetailCacheTableData,
          PrefetchHooks Function()
        > {
  $$PokemonDetailCacheTableTableTableManager(
    _$PokedexDatabase db,
    $PokemonDetailCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonDetailCacheTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PokemonDetailCacheTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PokemonDetailCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> height = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<String> typesJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => PokemonDetailCacheTableCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                height: height,
                weight: weight,
                typesJson: typesJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                required int height,
                required int weight,
                required String typesJson,
                required int updatedAt,
              }) => PokemonDetailCacheTableCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                height: height,
                weight: weight,
                typesJson: typesJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonDetailCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$PokedexDatabase,
      $PokemonDetailCacheTableTable,
      PokemonDetailCacheTableData,
      $$PokemonDetailCacheTableTableFilterComposer,
      $$PokemonDetailCacheTableTableOrderingComposer,
      $$PokemonDetailCacheTableTableAnnotationComposer,
      $$PokemonDetailCacheTableTableCreateCompanionBuilder,
      $$PokemonDetailCacheTableTableUpdateCompanionBuilder,
      (
        PokemonDetailCacheTableData,
        BaseReferences<
          _$PokedexDatabase,
          $PokemonDetailCacheTableTable,
          PokemonDetailCacheTableData
        >,
      ),
      PokemonDetailCacheTableData,
      PrefetchHooks Function()
    >;

class $PokedexDatabaseManager {
  final _$PokedexDatabase _db;
  $PokedexDatabaseManager(this._db);
  $$PokemonListCacheTableTableTableManager get pokemonListCacheTable =>
      $$PokemonListCacheTableTableTableManager(_db, _db.pokemonListCacheTable);
  $$PokemonDetailCacheTableTableTableManager get pokemonDetailCacheTable =>
      $$PokemonDetailCacheTableTableTableManager(
        _db,
        _db.pokemonDetailCacheTable,
      );
}
