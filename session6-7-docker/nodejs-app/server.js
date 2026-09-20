const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
      <head><title>Node.js on Docker</title></head>
      <body style="font-family: sans-serif; text-align: center; padding-top: 3rem;">
        <h1>Hello World from Node.js!</h1>
        <p>Served by Express inside a Docker container.</p>
        <p>Hostname: ${require("os").hostname()}</p>
      </body>
    </html>
  `);
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Node.js app listening on port ${PORT}`);
});
