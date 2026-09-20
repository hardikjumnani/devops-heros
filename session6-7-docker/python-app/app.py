import os
import socket

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello():
    return f"""
    <!DOCTYPE html>
    <html>
      <head><title>Python on Docker</title></head>
      <body style="font-family: sans-serif; text-align: center; padding-top: 3rem;">
        <h1>Hello World from Python!</h1>
        <p>Served by Flask inside a Docker container.</p>
        <p>Hostname: {socket.gethostname()}</p>
      </body>
    </html>
    """


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
