
console.log("------------preloading", process)

process.once('loaded', () => {
    console.log("[loaded]", process)
    global.process = process;
});
