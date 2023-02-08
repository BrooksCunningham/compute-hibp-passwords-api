use fastly::ObjectStore;
use fastly::{Error, Request, Response};


#[fastly::main]
fn main(req: Request) -> Result<Response, Error> {
    // Log out which version of the Fastly Service is responding to this request.
    // This is useful to know when debugging.
    if let Ok(fastly_service_version) = std::env::var("FASTLY_SERVICE_VERSION") {
        println!("FASTLY_SERVICE_VERSION: {}", fastly_service_version);
    }

    let store = "hibp-store";
        
    let path = req.get_path();
    let mut qs: Vec<(String, String)> = req.get_query()?;
    let hash_qs = req.get_query_parameter("hash").unwrap();
    println!("hash_qs query: {}", hash_qs);

    if path == "/range" {
        /*
            Construct an ObjectStore instance which is connected to the Object Store named `my-store`
            [Documentation for the ObjectStore open method can be found here](https://docs.rs/fastly/latest/fastly/struct.ObjectStore.html#method.open)
        */
        

        let mut store =
            ObjectStore::open(&store).map(|store| store.expect("ObjectStore exists"))?;

        let entry = store.lookup(hash_qs)?;

        return Ok(Response::from_body(entry.unwrap()))
        
    } 
    return Ok(Response::from_body(format!("{}", "missed")));
}