db.createUser(
    {
      user: "admin",
      pwd: _mongo_password_,
      roles: [
        {
          role: "readWrite",
          db: "dbuser"
        }
      ]
    }
  );
  db.createCollection('user');
  db.createCollection('killer');
  db.createCollection('api');
  db.createCollection('server');

  
