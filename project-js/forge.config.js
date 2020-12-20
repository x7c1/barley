/*
see also:
- https://electron.github.io/electron-packager/master/interfaces/electronpackager.options.html
- https://www.electronforge.io/configuration
*/
module.exports = {
    "packagerConfig": {
        "ignore": path => {
            const allowlist = [
                "/src",
                "/node_modules",
                "/package.json",
            ];
            // tell me why this empty string should be allowed...
            const shouldInclude = (path === "") || allowlist.some(_ => path.startsWith(_))

            const denylist = [
                "/node_modules/.bin",
                "/node_modules/electron",
                "/node_modules/@electron",
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
