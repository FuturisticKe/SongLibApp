import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../model/base/song.dart';
import '../../model/tables/db_song_table.dart';
import '../songlib_db.dart';

part 'song_dao_storage.g.dart';

@lazySingleton
abstract class SongDaoStorage {
  @factoryMethod
  factory SongDaoStorage(SongLibDb db) = _SongDaoStorage;

  Stream<List<DbSong>> getAllSongsStream();

  Future<List<Song>> getLikedSongs();

  Future<List<Song>> getAllSongs();

  Future<void> createSong(Song song);

  Future<void> updateSong(Song song);
}

@DriftAccessor(tables: [
  DbSongTable,
])
class _SongDaoStorage extends DatabaseAccessor<SongLibDb>
    with _$_SongDaoStorageMixin
    implements SongDaoStorage {
  _SongDaoStorage(SongLibDb db) : super(db);

  @override
  Future<List<Song>> getLikedSongs() async {
    final Stream<List<DbSong>> streams = customSelect(
      'SELECT * FROM ${db.dbSongTable.actualTableName} '
      'WHERE ${db.dbSongTable.liked.name}=true;',
      readsFrom: {db.dbSongTable},
    ).watch().map(
      (rows) {
        return rows.map((row) => DbSong.fromData(row.data)).toList();
      },
    );

    final List<DbSong> dbsongs = await streams.first;
    final List<Song> songs = [];

    for (int i = 0; i < dbsongs.length; i++) {
      songs.add(
        Song(
          id: dbsongs[i].id,
          objectId: dbsongs[i].objectId,
          book: dbsongs[i].book,
          songNo: dbsongs[i].songNo,
          title: dbsongs[i].title,
          alias: dbsongs[i].alias,
          content: dbsongs[i].content,
          author: dbsongs[i].author,
          key: dbsongs[i].key,
          views: dbsongs[i].views,
          createdAt: dbsongs[i].createdAt,
          updatedAt: dbsongs[i].updatedAt,
          liked: dbsongs[i].liked,
        ),
      );
    }
    return songs;
  }

  @override
  Future<List<Song>> getAllSongs() async {
    final List<DbSong> dbsongs = await select(db.dbSongTable).get();
    final List<Song> songs = [];

    for (int i = 0; i < dbsongs.length; i++) {
      songs.add(
        Song(
          id: dbsongs[i].id,
          objectId: dbsongs[i].objectId,
          book: dbsongs[i].book,
          songNo: dbsongs[i].songNo,
          title: dbsongs[i].title,
          alias: dbsongs[i].alias,
          content: dbsongs[i].content,
          author: dbsongs[i].author,
          key: dbsongs[i].key,
          views: dbsongs[i].views,
          createdAt: dbsongs[i].createdAt,
          updatedAt: dbsongs[i].updatedAt,
          liked: dbsongs[i].liked,
        ),
      );
    }
    return songs;
  }

  @override
  Stream<List<DbSong>> getAllSongsStream() => select(db.dbSongTable).watch();

  @override
  Future<void> createSong(Song song) => into(db.dbSongTable).insert(
        DbSongTableCompanion.insert(
          objectId: Value(song.objectId!),
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
  Future<void> updateSong(Song song) =>
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
}