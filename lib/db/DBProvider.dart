import 'dart:io';
import 'package:diablo_season_6p/db/ChallengeModel.dart';
import 'package:diablo_season_6p/db/TierModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String dbName = 'd3_seasonal';

final String tableChallenges = 'challenges';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnTier = 'tier';
final String columnIsCompleted = 'isCompleted';
final String createChallengeSql = "CREATE TABLE $tableChallenges ("
      "$columnId INTEGER AUTO_INCREMENT PRIMARY KEY,"
      "$columnTitle TEXT,"
      "$columnTier TEXT,"
      "$columnIsCompleted INTEGER DEFAULT 0)";

final String tableTiers = 'tiers';
final String columnReward = 'reward';
final String createTiersSql = "CREATE TABLE $tableTiers ("
      "$columnId INTEGER AUTO_INCREMENT PRIMARY KEY,"
      "$columnTitle TEXT,"
      "$columnReward TEXT)";


class DBProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(createChallengeSql);
      await db.execute(createTiersSql);
    });
  }

  void insert(Challenge challenge) async {
    await checkDB();
    await db.insert(tableChallenges, challenge.toMap());
  }

  Future<Challenge> getChallenge(int id) async {
    await checkDB();
    List<Map> maps = await db.query(tableChallenges,
        columns: [columnId, columnTitle, columnTier, columnIsCompleted],
        where: '$columnId = ?',
        whereArgs: [id]);
    print('maps length: ${maps.length}');
    if (maps.length > 0) {
      return Challenge.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map>> getChallengesFromTier(String tier) async {
    await checkDB();
    List<Map> maps = await db.query(tableChallenges,
        columns: [columnId, columnTitle, columnTier, columnIsCompleted],
        where: '$columnTier = ?',
        whereArgs: [tier]);
    return maps;
  }

  Future getTierChecked(String tier) async {
    await checkDB();
    List<Map> maps = await db.query(tableChallenges,
        columns: [columnId, columnTitle, columnTier, columnIsCompleted],
        where: '$columnIsCompleted = ? AND $columnTier = ?',
        whereArgs: ['1', tier]);
    return maps.length;
  }

  Future<int> getAllChecked() async {
    await checkDB();
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT(*) as checked FROM $tableChallenges WHERE $columnIsCompleted=1');
    Map<String, dynamic> row = result.first;
    return row['checked'];
  }

  Future<String> getTierRewards(String tier) async {
    await checkDB();
    List<Map> rows = await db.query(tableTiers,
        columns: [columnId, columnTitle, columnReward],
        where: '$columnTitle = ?',
        whereArgs: [tier]);
    if (rows.length > 0) {
      Tier tier = Tier.fromMap(rows.first);
      return tier.reward;
    }
    return '';
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableChallenges, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(String title, int isCompleted) async {
    await checkDB();
    return await db.rawUpdate(
        'UPDATE $tableChallenges SET $columnIsCompleted = ? WHERE $columnTitle = ?',
        [isCompleted, title]);
  }

  Future checkDB() async {
    if (db == null) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, dbName);
      await open(path);
    }
  }

  Future close() async => db.close();

  Future<int> isDbEmpty() async {
    await checkDB();
    List<Map> maps = await db.query(tableChallenges);
    print('maps length: ${maps.length}');
    return maps.length;
  }

  Future insertChallenges() async {
    Batch batch = db.batch();

    // Chapter I
    batch.insert(tableChallenges, Challenge(title: 'Normal rift', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Level 50', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Siegebreaker', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Butcher', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: '5 bounties', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Socket 5 gems', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Blacksmith level 10', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Jeweler level 10', tier: 'Chapter I').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Mystic level 10', tier: 'Chapter I').toMap());

    // Chapter II
    batch.insert(tableChallenges, Challenge(title: 'Expert rift', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Level 70', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Belial (Hard, lvl 60+)', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Cydaea (Hard, lvl 60+)', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Unlock Kanais cube', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Fully equip follower', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'All artisans lvl 12', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Craft lvl 70 item at Blacksmith', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Craft lvl 70 item at Jeweler', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Enchant at mystic', tier: 'Chapter II').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Transmogrify at mystic', tier: 'Chapter II').toMap());

    // Chapter III
    batch.insert(tableChallenges, Challenge(title: 'Act I bounty cache', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Act II bounty cache', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Act III bounty cache', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Act IV bounty cache', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Act V bounty cache', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Buy item from Kadala', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Craft an Imperial gem', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Extract one Cube power', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Ghom (Master, level 70+)', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Master Rift', tier: 'Chapter III').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Skeleton King (Master, level 70+)', tier: 'Chapter III').toMap());

    // Chapter IV
    batch.insert(tableChallenges, Challenge(title: 'GR20 solo', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Keywarden Act 1 (T4)', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Keywarden Act 2 (T4)', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Keywarden Act 3 (T4)', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Keywarden Act 4 (T4)', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Learn 5 blacksmith recipes', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Learn 5 jewelcrafter designs', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Rakanoth (T4, level 70)', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Reforge socket on weapon', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T1 Rift', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Upgrade rare to legendary', tier: 'Chapter IV').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Urzael (T2, level 70)', tier: 'Chapter IV').toMap());

    // Slayer
    batch.insert(tableChallenges, Challenge(title: '(A1) Realm of Regret (T1)', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: '(A2) Realm of Putridness (T1)', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Adria (T7)', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Azmodan (T7)', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Complete a Set Dungeon', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Equip all three Cube slots', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Get legendary from Kadala', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'GR30 solo', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'One gem to rank 25', tier: 'Slayer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T5 Rift', tier: 'Slayer').toMap());

    // Champion
    batch.insert(tableChallenges, Challenge(title: '(A3) Realm of Terror (T10)', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: '(A4) Realm of Fright (T10)', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Convert a set item', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Craft a Flawless Royal gem', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'GR40 solo', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Izual (T10)', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Maghda (T10)', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Master a Set Dungeon', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T10 Rift in under 6 minutes', tier: 'Champion').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Three gems to rank 35', tier: 'Champion').toMap());

    // Destroyer
    batch.insert(tableChallenges, Challenge(title: 'Araneae (T13)', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Complete 1 conquest', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Craft Hellfire Amulet', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Diablo (T13)', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Extract 20 Cube powers', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'GR50 solo', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T12 Rift in under 6 minutes', tier: 'Destroyer').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Three gems to rank 45', tier: 'Destroyer').toMap());


    // Conqueror
    batch.insert(tableChallenges, Challenge(title: 'Complete 2 conquests', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'GR60 solo', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Greed (T13)', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Malthael in under 90 sec.', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'One 50+ augment', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Reforge a legendary', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T13 Rift in under 5 minutes', tier: 'Conqueror').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Three gems to rank 55', tier: 'Conqueror').toMap());

    // Guardian
    batch.insert(tableChallenges, Challenge(title: 'Complete 3 conquests', tier: 'Guardian').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Extract 40 Cube powers', tier: 'Guardian').toMap());
    batch.insert(tableChallenges, Challenge(title: 'GR70 solo', tier: 'Guardian').toMap());
    batch.insert(tableChallenges, Challenge(title: 'T13 Rift in under 4 minutes', tier: 'Guardian').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Three gems to rank 70', tier: 'Guardian').toMap());
    batch.insert(tableChallenges, Challenge(title: 'Zoltun Kulle in under 10 sec.', tier: 'Guardian').toMap());


    await batch.commit(noResult: true);
  }

  Future insertTiers() async {
    Batch batch = db.batch();

    // Chapters
    batch.insert(tableTiers, Tier(title: 'Chapter I', reward: 'No reward').toMap());
    batch.insert(tableTiers, Tier(title: 'Chapter II', reward: '1st Haedrig - head+hands. Transmog (lvl 70)').toMap());
    batch.insert(tableTiers, Tier(title: 'Chapter III', reward: '2nd Haedrig - feet+shoulders/Wizard: belt+neck)').toMap());
    batch.insert(tableTiers, Tier(title: 'Chapter IV', reward: '3rd Haedrig, Belphegor (pet), Portrait frame.').toMap());
    batch.insert(tableTiers, Tier(title: 'Slayer', reward: 'Portrait frame').toMap());
    batch.insert(tableTiers, Tier(title: 'Champion', reward: 'Portrait frame').toMap());
    batch.insert(tableTiers, Tier(title: 'Destroyer', reward: 'Portrait frame').toMap());
    batch.insert(tableTiers, Tier(title: 'Conqueror', reward: 'Stash tab, Portrait frame').toMap());
    batch.insert(tableTiers, Tier(title: 'Guardian', reward: 'Portrait frame').toMap());

    await batch.commit(noResult: true);
  }

  Future initialize() async {
    await checkDB();
    int rows = await isDbEmpty();
    if (rows == 0) {
      await insertChallenges();
      await insertTiers();
    }
    await isDbEmpty();
  }
}
