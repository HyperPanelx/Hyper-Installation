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
  // db.api.insertOne(
  //   { 'admin': {
  //       "username": "admin",
  //       "full_name": "admin",
  //       "hashed_password": "$2b$12$JkaHfpyWMpwSrK93WFI30eMz9R5HBcYjiWPB4.26EevNObfoT/Ljm",
  //       }}
  // );