
#[macro_use]
extern crate rouille;

fn main() {
    println!("Now listening on port 5000");

    rouille::start_server("0.0.0.0:5000", move |request| {
        router!(request,
            (GET) (/secret) => {
                rouille::Response::text(format!("Welcome to the secret"))
            },
            (GET) (/{path: String}) => {
                rouille::Response::text(format!("Hello path: {}", path))
            },
            _ => rouille::Response::empty_404()
        )
    });
}
