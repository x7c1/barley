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
            return !shouldInclude
        },
    },
    "makers": [
        {
            "name": "@electron-forge/maker-deb",
            "config": {}
        }
    ]
}
