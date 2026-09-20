import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class HelloWorld {

    public static void main(String[] args) throws IOException {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));
        HttpServer server = HttpServer.create(new InetSocketAddress("0.0.0.0", port), 0);

        server.createContext("/", exchange -> {
            String host = InetAddress.getLocalHost().getHostName();
            String body = """
                    <!DOCTYPE html>
                    <html>
                      <head><title>Java on Docker</title></head>
                      <body style="font-family: sans-serif; text-align: center; padding-top: 3rem;">
                        <h1>Hello World from Java!</h1>
                        <p>Served by the JDK HTTP server inside a Docker container.</p>
                        <p>Hostname: %s</p>
                      </body>
                    </html>
                    """.formatted(host);

            byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
            exchange.getResponseHeaders().add("Content-Type", "text/html; charset=utf-8");
            exchange.sendResponseHeaders(200, bytes.length);
            try (OutputStream os = exchange.getResponseBody()) {
                os.write(bytes);
            }
        });

        server.start();
        System.out.println("Java app listening on port " + port);
    }
}
