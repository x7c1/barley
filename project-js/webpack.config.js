const path = require("path");
const CopyPlugin = require("copy-webpack-plugin");
const WasmPackPlugin = require("@wasm-tool/wasm-pack-plugin");

const dist = path.resolve(__dirname, "dist");

module.exports = {
  mode: "production",
  entry: {
    index: "./src/index.js"
  },
  output: {
    path: dist,
    filename: "[name].js"
  },
  devServer: {
    contentBase: dist,
  },
  // target: "web",

  // rf. https://webpack.js.org/configuration/target/
  target: "electron-renderer",

  // target: "electron-main",
  // target: ""
  // target: "node",
  // target: "electron-preload",
  // externals: {
  //   process: 'process'
  // },

  plugins: [
    new CopyPlugin([
      path.resolve(__dirname, "static")
    ]),

    new WasmPackPlugin({
      // crateDirectory: __dirname,
      crateDirectory: path.resolve(__dirname, "..", "project-rs", "app"),
      // crateDirectory: path.resolve("/sssbarley", "project.rs", "app"),

      // The same as the `--out-dir` option for `wasm-pack`
      outDir: path.resolve(__dirname, "pkg"),

      // rf. https://rustwasm.github.io/docs/wasm-bindgen/reference/deployment.html
      // default target
      // extraArgs: "--target bundler",
    }),
  ]
};
