const express = require("express");
const { postgraphile } = require("postgraphile");
const { rootPgPool } = require("./serverDetails");
const { loadEnv } = require("../loadEnv");
loadEnv();
const auth = require("./auth/index.js");
const course = require("./course/index.js");
const cors = require("cors");
const { NodePlugin } = require("graphile-build");

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("GCP Express Supabase Backend Root");
});

app.get("/health", (req, res) => {
  res.json({ status: "OK" });
});

app.use(auth);
app.use(course);

app.use(
  postgraphile(rootPgPool, ["public"], {
    watchPg: true,
    graphiql: true,
    enableCors: true,
    enhanceGraphiql: true,
    dynamicJson: true,
    retryOnInitFail: true,
    showErrorStack: true,
    subscriptions: true,
    enableQueryBatching: true,
    ownerConnectionString: process.env.DATABASE_URL,
    appendPlugins: [
      require("@graphile-contrib/pg-simplify-inflector"),
      require("postgraphile-plugin-connection-filter"),
    ],
    classicIds: true,
    // skipPlugins: [NodePlugin],
    graphileBuildOptions: {
      connectionFilterArrays: false, // default: true
      connectionFilterComputedColumns: true, // default: true
      connectionFilterRelations: true,
    },
  })
);

app.listen(8080, () => console.log("HTTP listening at port ", 8080));
