
extern crate serde;
#[macro_use] extern crate rouille;
#[macro_use] extern crate serde_derive;

use rouille::Response;

#[derive(Serialize)]
struct ResponsePayload {
    message: String,
}

fn main() {
    println!("Now listening on port 5000");

    rouille::start_server("0.0.0.0:5000", move |request| {
        router!(request,
            (GET) (/secret) => {
                Response::json(&ResponsePayload{ message: "Welcome to the secret".to_owned() })
            },
            (GET) (/{path: String}) => {
                Response::json(&ResponsePayload{ message: format!("Hello path: {}", path) })
            },
            _ => Response::empty_404()
        )
    });
}
