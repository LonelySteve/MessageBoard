CREATE TABLE posts(
  pid serial NOT NULL PRIMARY KEY,
  name varchar(50) NOT NULL,
  qq varchar(15) NULL,
  email varchar(50) NULL,
  title varchar(50) NOT NULL,
  homepage varchar(50) NULL,
  content text NOT NULL,
  create_time timestamp NOT NULL,
  reply text NULL,
  reply_admin_name varchar(50) NULL,
  reply_create_time timestamp NULL,
  state smallint NOT NULL
);

CREATE TABLE admins(
    aid serial NOT NULL PRIMARY KEY,
    username varchar(30) NOT NULL,
    password varchar(32) NOT NULL
);

-- 默认密码是 "password"，经过 md5 加密后即 5f4dcc3b5aa765d61d8327deb882cf99
INSERT INTO admins(username, password) VALUES ('admin', '5f4dcc3b5aa765d61d8327deb882cf99');
