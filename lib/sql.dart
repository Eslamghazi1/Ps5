// ignore: depend_on_referenced_packages
import "package:sqflite/sqflite.dart";
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class sql{

  static Database? _db;
  Future<Database?> get db async{
    if (_db ==null){
      _db =await initialdb();
      return _db;
    }
    else {
      return _db;
    }
  }

  Future<bool> isDatabaseOpen() async {
    final database = await getDatabasesPath();
    String path = join(database, "SQL_PATH.db");
    final db = await openDatabase(path);
    final isOpen = await db.isOpen;
    db.close();
    return isOpen;
  }

  initialdb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "SQL_PATH.db");
    return await openDatabase(path, onCreate: _oncreate, version: 2, onUpgrade: _onupgrade);
  }
  _onupgrade (Database db,int oldv ,int newv)async{

    print("you have upgraded the data pass");
  }
  _oncreate(Database db, int version)async{
   ///////// // ps played tables
    await db.execute(' CREATE TABLE rooms(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,room TEXT) ');
    await db.execute(' CREATE TABLE hourprices(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,play INTEGER,offer INTEGER) ');

    await db.execute(' CREATE TABLE types(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,type TEXT) ');
    await db.execute(' CREATE TABLE prices(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,price INTEGER) ');
    ///////////
    await db.execute(' CREATE TABLE tables(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,kind TEXT,place TEXT,frm TEXT,too TEXT,cost TEXT,state TEXT) ');
    await db.execute(' CREATE TABLE offers(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,kind TEXT,place TEXT,frm TEXT,too TEXT,cost TEXT,state TEXT) ');
    await db.execute('CREATE TABLE orders (key INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,position TEXT,name TEXT, payment INTEGER, state TEXT,time TEXT,hint TEXT)');
    await db.execute('CREATE TABLE disorders (key INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,position TEXT,name TEXT, payment INTEGER, state TEXT,time TEXT,hint TEXT)');

    await db.execute('CREATE TABLE costs (prim INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, day TEXT, tasks INTEGER, play INTEGER)');
    await db.execute('CREATE TABLE payments (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, day TEXT,hint TEXT, tasks INTEGER)');
    await db.execute('CREATE TABLE monthly (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,month TEXT,prices INTEGER)');
  }

  readdb(String sql)async{
    Database? check= await db;
    List<Map>? response =(await check?.rawQuery(sql))?.cast<Map>();
    return response;
  }
  insertdb(String sql) async {
    Database? check = await db;
    if (check != null) {
      int response = await check.rawInsert(sql);
      return response;
    } else {
      print('Database is null');
      return -1;
    }
  }
  deletedb(String sql)async{
    Database? check= await db;
    int response =await check!.rawDelete(sql);
    return response;
  }
  updatedb(String sql)async{
    Database? check= await db;
    int response =await check!.rawUpdate(sql);
    return response;
  }
  read(String table)async{
    Database? check= await db;
    List<Map>? response =(await check?.query(table))?.cast<Map>();
    return response;
  }
  insert(String table,Map<String,Object> values) async {
    Database? check = await db;
    if (check != null) {
      int response=  await check.insert(table,values);
      return response;
    } else {
      print('Database is null');
      return -1;
    }


  }
  delete(String table, String? Where)async{
    Database? check= await db;
    int response =await check!.delete( table,where: Where);
    return response;
  }
  update(String table, Map<String , Object?> values,String? Where,)async{
    Database? check= await db;
    int response =await check!.update(table,values,where: Where);
    return response;
  }
  Future Deletesql()async{
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "SQL_PATH.db");
    await deleteDatabase(path);
    print("deleted is confimed");
  }
}