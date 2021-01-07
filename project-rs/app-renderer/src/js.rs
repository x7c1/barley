use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern {
    #[wasm_bindgen]
    pub type Console;

    pub static console: Console;

    #[wasm_bindgen(method)]
    pub fn log(this: &Console, s: &str);
}

#[wasm_bindgen]
extern {
    #[wasm_bindgen]
    pub type Date;

    #[wasm_bindgen(static_method_of = Date)]
    pub fn now() -> f64;
}

#[wasm_bindgen]
extern {
    #[wasm_bindgen]
    pub type Process;

    pub static process: Process;

    #[wasm_bindgen(method, getter, js_name = type)]
    pub fn get_type(this: &Process) -> String;

    #[wasm_bindgen(method, js_name = getSystemVersion)]
    pub fn get_system_version(this: &Process) -> String;
}

#[wasm_bindgen(module = "electron")]
extern {
    #[wasm_bindgen]
    pub type BrowserWindow;

    /// Cannot call this method if running untrusted content
    /// since it requires following BrowserWindow settings:
    ///
    /// ```js
    /// webPreferences: {
    ///   nodeIntegration: true,
    ///   enableRemoteModule: true
    /// ```
    ///
    /// See also https://www.electronjs.org/docs/tutorial/security
    #[wasm_bindgen(constructor, js_namespace = remote)]
    pub fn new() -> BrowserWindow;
}
