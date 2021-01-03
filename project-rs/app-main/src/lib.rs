mod utils;

use wasm_bindgen::prelude::*;

// When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
// allocator.
#[cfg(feature = "wee_alloc")]
#[global_allocator]
static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;

#[wasm_bindgen]
extern {
    fn alert(s: &str);

    #[wasm_bindgen(js_namespace = process, js_name = getSystemVersion)]
    fn get_system_version() -> String;
}

#[wasm_bindgen]
pub fn greet() {
    alert("Hello, app-main!");
}

#[wasm_bindgen(js_name = explainSystem)]
pub fn explain_system() -> String {
    format!("system version is {}", get_system_version())
}

#[wasm_bindgen]
extern {
    #[wasm_bindgen]
    pub type BrowserWindowOptions;

    #[wasm_bindgen(method, getter)]
    pub fn x(this: &BrowserWindowOptions) -> Option<usize>;

    #[wasm_bindgen(method, setter)]
    pub fn set_x(this: &BrowserWindowOptions, value: Option<usize>);

    #[wasm_bindgen(method, getter)]
    pub fn y(this: &BrowserWindowOptions) -> Option<usize>;

    #[wasm_bindgen(method, setter)]
    pub fn set_y(this: &BrowserWindowOptions, value: Option<usize>);
}

#[wasm_bindgen]
#[derive(Debug)]
pub struct BarleyConfig {
    foo_bar: String,
    num: f64,
}

#[wasm_bindgen]
impl BarleyConfig {
    #[wasm_bindgen(getter, js_name = fooBar)]
    pub fn foo_bar(&self) -> String {
        self.foo_bar.clone()
    }

    #[wasm_bindgen(getter)]
    pub fn num(&self) -> f64 {
        self.num
    }

    #[wasm_bindgen(method, js_name = toString)]
    pub fn to_string(&self) -> String {
        format!("{:#?}", self)
    }
}

#[wasm_bindgen(module = "electron")]
extern {
    #[wasm_bindgen(typescript_type = "electron.BrowserWindow")]
    pub type BrowserWindow;

    #[wasm_bindgen(constructor)]
    pub fn new() -> BrowserWindow;
}

#[wasm_bindgen(js_name = setupWindow)]
pub fn setup_window() -> BrowserWindow {
    println!("[start] setup_window");
    BrowserWindow::new()
}

#[wasm_bindgen(js_name = createConfig)]
pub fn create_config() -> BarleyConfig {
    println!("[start] create_config");
    BarleyConfig {
        foo_bar: "hoge".to_string(),
        num: 123.123
    }
}
