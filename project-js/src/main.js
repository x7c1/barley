const barley = require("../barley-main");

const path = require('path');
const { app, BrowserWindow, screen, Menu, Tray } = require('electron')

function createWindow () {
  const screenArea = screen.getPrimaryDisplay().workArea
  const [ width, height ] = [ 900, 900 ]
  const win = new BrowserWindow({
    x: screenArea.x + screenArea.width / 2 - width / 2,
    y: screenArea.y + screenArea.height / 2 - height / 2,
    width,
    height,
    webPreferences: {
      // nodeIntegration: true,
      preload: path.join(__dirname, 'preload.js'),
    }
  })
  // sample to use fields through barley-main wasm
  console.log(barley.explainSystem())
  console.log("config: " + barley.createConfig())

  win.loadFile('dist/index.html')
  win.webContents.openDevTools()
}

app.whenReady().then(createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})

let tray = null;

const createTray = () =>{
  const icon = path.join(__dirname, 'barley-icon.png')
  tray = new Tray(icon);
  tray.setToolTip('This is my application.');

  const contextMenu = Menu.buildFromTemplate([
    { label: 'Item1', type: 'radio' },
    { label: 'Item2', type: 'radio' }
  ])

  // Make a change to the context menu
  contextMenu.items[1].checked = false

  // Call this again for Linux because we modified the context menu
  tray.setContextMenu(contextMenu)
};

app.whenReady().then(createTray)
