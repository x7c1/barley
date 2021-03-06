/*
see also:
- https://electron.github.io/electron-packager/master/interfaces/electronpackager.options.html
- https://www.electronforge.io/configuration
*/
module.exports = {
    "packagerConfig": {
        "ignore": path => {
            const allowlist = [
                "/src-main",
                "/package.json",
                "/app-main",
                "/dist",
                /*
                no need to include /node_modules dir
                because this app is composed only of wasm generated by yew!
                "/node_modules",
                */
            ];
            // tell me why this empty string should be allowed...
            const shouldInclude = (path === "") || allowlist.some(_ => path.startsWith(_))
            const denylist = [
                /*
                uncomment this block if /node_modules dir is included in allowlist above.
                "/node_modules/.bin",
                "/node_modules/electron",
                "/node_modules/@electron",
                */
            ]
            const shouldExclude = denylist.some(_ => path.startsWith(_))
            return shouldExclude || !shouldInclude
        },
    },
    "makers": [
        {
            "name": "@electron-forge/maker-deb",
            "config": {}
        }
    ]
}
