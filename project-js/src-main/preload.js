process.once('loaded', () => {
    /*
    // it's unsafe to make original `process` public as it is:
    // (especially when your app opens external sites)
    global.process = process

    // decorate it instead, with an object which has minimum fields for your app:
    */
    global.process = {
        getSystemVersion() {
            return process.getSystemVersion()
        },
        get type() {
            return process.type
        }
    };
});
