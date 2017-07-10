<?php

try {
  $conn = new PDO("mysql:host=mariadb:3306;dbname=sample", "sample", "sample");
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  echo "Connected successfully"; 
} catch (PDOException $e) {
  echo "Connection failed: " . $e->getMessage();
}

phpinfo();

phpinfo(INFO_MODULES);
