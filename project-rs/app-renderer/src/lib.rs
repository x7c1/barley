use wasm_bindgen::prelude::*;

use yew::{ComponentLink, Component, ShouldRender, Html, html};

// no need to use wildcard?
// use yew::prelude::*;

/*
rf. https://github.com/yewstack/yew/blob/master/docs/getting-started/build-a-sample-app.md
*/

enum Msg {
    AddOne,
}

struct Model {
    // `ComponentLink` is like a reference to a component.
    // It can be used to send messages to the component
    link: ComponentLink<Self>,
    value: i64,
}

impl Component for Model {
    type Message = Msg;
    type Properties = ();

    fn create(_props: Self::Properties, link: ComponentLink<Self>) -> Self {
        Self {
            link,
            value: 0,
        }
    }

    fn update(&mut self, msg: Self::Message) -> ShouldRender {
        let sample = format!("system version is {}", process.get_system_version());
        log(sample.as_str());

        let sample = format!("type is {}", process.get_type());
        log(sample.as_str());

        match msg {
            Msg::AddOne => {
                self.value += 1;
                // the value has changed so we need to
                // re-render for it to appear on the page
                true
            }
        }
    }

    fn change(&mut self, _props: Self::Properties) -> ShouldRender {
        // Should only return "true" if new properties are different to
        // previously received properties.
        // This component has no properties so we will always return "false".
        false
    }

    fn view(&self) -> Html {
        html! {
            <div>
                <button onclick=self.link.callback(|_| Msg::AddOne)>{ "+1" }</button>
                <p>{ self.value }</p>
            </div>
        }
    }
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

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
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

#[wasm_bindgen(start)]
pub fn main_js() -> Result<(), JsValue> {
    yew::start_app::<Model>();
    Ok(())
}
