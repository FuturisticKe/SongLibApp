import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/song.dart';
import '../../model/base/songext.dart';
import '../../model/tables/db_song_table.dart';
import '../songlib_db.dart';

part 'song_dao_storage.g.dart';

@lazySingleton
abstract class SongDaoStorage {
  @factoryMethod
  factory SongDaoStorage(SongLibDb db) = _SongDaoStorage;

  Future<List<SongExt>> getLikedSongs();
  Future<List<SongExt>> getAllSongs();
  Future<void> createSong(Song song);
  Future<void> updateSong(SongExt song);
  Future<void> deleteSong(SongExt song);
}

@DriftAccessor(tables: [
  DbSongTable,
])
class _SongDaoStorage extends DatabaseAccessor<SongLibDb>
    with _$_SongDaoStorageMixin
    implements SongDaoStorage {
  _SongDaoStorage(SongLibDb db) : super(db);

  @override
  Future<List<SongExt>> getLikedSongs() async {
    final Stream<List<SongExt>> streams = customSelect(
      'SELECT songs.${db.dbSongTable.book.name}, songs.${db.dbSongTable.songNo.name}, '
      'songs.${db.dbSongTable.title.name}, songs.${db.dbSongTable.alias.name}, songs.${db.dbSongTable.content.name}, '
      'songs.${db.dbSongTable.key.name}, songs.${db.dbSongTable.author.name}, songs.${db.dbSongTable.views.name}, '
      'songs.${db.dbSongTable.likes.name}, songs.${db.dbSongTable.createdAt.name}, songs.${db.dbSongTable.updatedAt.name}, '
      'songs.${db.dbSongTable.liked.name}, songs.${db.dbSongTable.id.name}, '
      'books.${db.dbBookTable.title.name} AS songbook '
      'FROM ${db.dbSongTable.actualTableName} AS songs '
      'LEFT JOIN ${db.dbBookTable.actualTableName} AS books '
      'ON songs.${db.dbSongTable.book.name}=books.${db.dbBookTable.bookNo.name} '
      'WHERE songs.${db.dbSongTable.liked.name}=true '
      'ORDER BY songs.${db.dbSongTable.updatedAt.name} DESC;',
      readsFrom: {db.dbSongTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => SongExt.fromData(row.data)).toList();
      },
    );
    return await streams.first;
  }

  @override
  Future<List<SongExt>> getAllSongs() async {
    final Stream<List<SongExt>> streams = customSelect(
      'SELECT songs.${db.dbSongTable.book.name}, songs.${db.dbSongTable.songNo.name}, '
      'songs.${db.dbSongTable.title.name}, songs.${db.dbSongTable.alias.name}, songs.${db.dbSongTable.content.name}, '
      'songs.${db.dbSongTable.key.name}, songs.${db.dbSongTable.author.name}, songs.${db.dbSongTable.views.name}, '
      'songs.${db.dbSongTable.likes.name}, songs.${db.dbSongTable.createdAt.name}, songs.${db.dbSongTable.updatedAt.name}, '
      'songs.${db.dbSongTable.liked.name}, songs.${db.dbSongTable.id.name}, '
      'books.${db.dbBookTable.title.name} AS songbook '
      'FROM ${db.dbSongTable.actualTableName} AS songs '
      'LEFT JOIN ${db.dbBookTable.actualTableName} AS books '
      'ON songs.${db.dbSongTable.book.name}=books.${db.dbBookTable.bookNo.name} '
      'ORDER BY ${db.dbSongTable.songNo.name} ASC;',
      readsFrom: {db.dbSongTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => SongExt.fromData(row.data)).toList();
      },
    );
    return await streams.first;
  }

  @override
  Future<void> createSong(Song song) => into(db.dbSongTable).insert(
        DbSongTableCompanion.insert(
          objectId: song.objectId!,
          book: Value(song.book!),
          songNo: Value(song.songNo!),
          title: Value(song.title!),
          alias: Value(song.alias!),
          content: Value(song.content!),
          key: Value(song.key!),
          author: Value(song.author!),
          views: Value(song.views!),
          createdAt: Value(song.createdAt!),
          updatedAt: Value(song.updatedAt!),
        ),
      );

  @override
  Future<void> updateSong(SongExt song) =>
      (update(db.dbSongTable)..where((row) => row.id.equals(song.id))).write(
        DbSongTableCompanion(
          book: Value(song.book!),
          songNo: Value(song.songNo!),
          title: Value(song.title!),
          alias: Value(song.alias!),
          content: Value(song.content!),
          key: Value(song.key!),
          author: Value(song.author!),
          views: Value(song.views!),
          updatedAt: Value(song.updatedAt!),
          liked: Value(song.liked!),
        ),
      );

  @override
  Future<void> deleteSong(SongExt song) =>
      (delete(db.dbSongTable)..where((row) => row.id.equals(song.id))).go();
}
