### Roadmap

- [x] Testing
- [x] Have multiple endpoints
- [x] Add endpoints that dont map to a file (routes concept)
- [ ] Mime types
    - [ ] including the right Content-Type header in response
    - [ ] parsing the Accept header in request
    - [ ] router is aware of Accept header in case route wants to return different mime types
- [ ] Query string parsing (posts?name=test and filter results)
- [ ] POST body parsing
    - [ ] router is aware of Content-Type header in POST/PUT request
- [ ] Every REST action type (GET, POST, PUT, DELETE, PATCH)
- [ ] Access control (basic auth, api key, etc)
- [ ] Multi-threading (taking multiple requests at a time)
- [ ] Data compression (gzipping)
- [ ] Browser caching (response code 304)
- [ ] Redirects
- [ ] Virtual hosting (deploying)