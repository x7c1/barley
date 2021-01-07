mod js;

use js::{console, process, Date};
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
            <>
            <section>
                <h2>{"callback sample"}</h2>
                <button onclick=self.link.callback(|_| Msg::AddOne)>{ "+1" }</button>
                <p>{ self.value }</p>
            </section>
            <section>
                <h2>{"wasm_bindgen sample"}</h2>
                <pre>{self.show_sample()}</pre>
            </section>
            </>
        }
    }
}

impl Model {
    fn show_sample(&self) -> String {
        let sample = Sample {
            timestamp: Date::now().to_string(),
            system_version: process.get_system_version(),
            process_type: process.get_type(),
        };
        let dumped = format!("{:#?}", sample);
        console.log(&dumped);

        return dumped;
    }
}

#[derive(Debug)]
struct Sample {
    timestamp: String,
    system_version: String,
    process_type: String,
}

#[wasm_bindgen(start)]
pub fn main_js() -> Result<(), JsValue> {
    yew::start_app::<Model>();
    Ok(())
}
