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
    alert("Hello, barley-main!");
}

#[wasm_bindgen(js_name = explainSystem)]
pub fn explain_system() -> String {
    format!("system version is {}", get_system_version())
}
