const { app, BrowserWindow, screen } = require('electron')

function createWindow () {
  const screenArea = screen.getPrimaryDisplay().workArea
  const [ width, height ] = [ 800, 600 ]
  const win = new BrowserWindow({
    x: screenArea.x + screenArea.width / 2 - width / 2,
    y: screenArea.y + screenArea.height / 2 - height / 2,
    width,
    height,
    webPreferences: {
      nodeIntegration: true
    }
  })

  win.loadFile('index.html')
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

