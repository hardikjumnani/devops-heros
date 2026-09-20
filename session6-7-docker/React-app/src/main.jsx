import React from "react";
import { createRoot } from "react-dom/client";

function App() {
  return (
    <div style={{ fontFamily: "sans-serif", textAlign: "center", paddingTop: "3rem" }}>
      <h1>Hello World from React!</h1>
      <p>Built with Vite, served by nginx inside a Docker container.</p>
    </div>
  );
}

createRoot(document.getElementById("root")).render(<App />);
