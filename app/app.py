"""DevOps Student Application.

Prints student information on start and serves it over HTTP.
All values come from environment variables (see Dockerfile / docker-compose.yml).
"""
import os
import signal
import socket
import sys
from datetime import datetime
from http.server import BaseHTTPRequestHandler, HTTPServer

NAME = os.getenv("STUDENT_NAME", "Not set")
SURNAME = os.getenv("STUDENT_SURNAME", "Not set")
GROUP = os.getenv("STUDENT_GROUP", "Not set")
STUDENT_ID = os.getenv("STUDENT_ID", "Not set")
PORT = int(os.getenv("APP_PORT", "5000"))

LINE = "=" * 32


def banner() -> str:
    return "\n".join([
        LINE,
        "DevOps Student Application",
        LINE,
        f"Name: {NAME}",
        f"Surname: {SURNAME}",
        f"Group: {GROUP}",
        f"Student ID: {STUDENT_ID}",
        LINE,
        f"Container hostname: {socket.gethostname()}",
        f"Started at: {datetime.now():%Y-%m-%d %H:%M:%S}",
        "Application is running successfully!",
    ])


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            body, ctype = "OK", "text/plain"
        else:
            body = (
                "<html><head><meta charset='utf-8'><title>DevOps Student App</title></head>"
                "<body style='font-family:sans-serif;max-width:600px;margin:40px auto'>"
                f"<pre style='font-size:16px'>{banner()}</pre></body></html>"
            )
            ctype = "text/html; charset=utf-8"
        data = body.encode()
        self.send_response(200)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def log_message(self, fmt, *args):
        print(f"{datetime.now():%Y-%m-%d %H:%M:%S} INFO {self.address_string()} {fmt % args}", flush=True)


def stop(signum, _frame):
    print(f"Received signal {signum}. Application stopped.", flush=True)
    sys.exit(0)


if __name__ == "__main__":
    signal.signal(signal.SIGTERM, stop)   # `docker stop` sends SIGTERM
    print(banner(), flush=True)
    print(f"Listening on port {PORT} (open http://localhost:{PORT})", flush=True)
    try:
        HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
    except KeyboardInterrupt:
        stop("SIGINT", None)
