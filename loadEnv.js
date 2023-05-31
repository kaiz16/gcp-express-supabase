const loadEnv = () => {
  if (process.env.NODE_ENV === "production") {
    require("dotenv").config({ path: __dirname + "/.env.production" });
  } else if (process.env.NODE_ENV === "staging") {
    require("dotenv").config({ path: __dirname + "/.env.staging" });
  } else {
    require("dotenv").config({ path: __dirname + "/.env.development" });
  }
};
module.exports = {
  loadEnv,
};
