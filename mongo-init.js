db.createUser(
    {
      user: "admin",
      pwd: "$MONGO_PASSWD",
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

  
