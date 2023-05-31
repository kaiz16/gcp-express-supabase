const { Pool } = require("pg");
const { loadEnv } = require("../loadEnv");
loadEnv();

const dbConnection = {
  connectionString: process.env.DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
};

const rootPgPool = new Pool(dbConnection);
rootPgPool.on("error", (err, client) => {
  console.error(err);
});

module.exports = {
  rootPgPool,
};
