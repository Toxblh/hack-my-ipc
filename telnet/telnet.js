const Telnet = require('telnet-client')
const { exec } = require('child_process')
const os = require('os')
const ifaces = os.networkInterfaces()
const path = require('path')
const fs = require('fs')

const CAMERA_IP = '192.168.123.9'

function startFTPServer() {
  console.info('# Start FTPServer')
  exec('sudo busybox tcpsvd -vE 0.0.0.0 21 ftpd -Aw ../files', (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`)
      return
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`)
      return
    }
    console.log(`stdout: ${stdout}`)
  })
}

function getMyIp() {
  let address = ''

  Object.keys(ifaces).forEach(function (ifname) {
    ifaces[ifname].forEach(function (iface) {
      if ('IPv4' !== iface.family || iface.internal !== false) {
        return
      }
      address = iface.address
    })
  })

  console.info('# My IP: ' + address)
  return address
}

function getFiles(pathToFolder) {
  const directoryPath = path.join(__dirname, pathToFolder)

  try {
    const files = fs.readdirSync(directoryPath)

    console.log('# Files:')
    files.forEach(function (file) {
      console.log(file)
    })

    return files
  } catch (err) {
    return console.log('Error read directory: ' + err)
  }
}

async function execCMD(connection, command) {
  let res = await connection.exec(command)
  console.log(command, '\n → ', res, '\n')
}

async function upload(ip, files) {
  let connection = new Telnet()

  const params = {
    host: CAMERA_IP,
    port: 23,
    loginPrompt: '? login:',
    passwordPrompt: 'Password:',
    username: 'root',
    password: 'noty',
    shellPrompt: '[root@GM]#',
    timeout: 1500,
  }

  try {
    await connection.connect(params)
  } catch (error) {
    // handle the throw (timeout)
  }

  console.log('Telnet is open...\n')

  const cmd = execCMD.bind(null, connection)

  async function asyncCMD(ip, files) {
    for (const file of files) {
      await cmd(`ftpget ${ip} /tmp/${file} ${file}`)
      await cmd(`chmod +x /tmp/${file}`)
    }
  }

  await cmd('cd /tmp')
  // await cmd('mkdir /tmp/www')
  // await cmd('mkdir /tmp/www/cgi-bin')

  await asyncCMD(ip, files)

  // await cmd('chmod 700 /tmp/www/cgi-bin/webui')
  await cmd('/tmp/ftpd.sh &')
  // await cmd('/tmp/busybox httpd -h /tmp/www')
  // await cmd('uptime')

  await connection.end()
}

function uploadFolder(pathToFolder) {
  const myIP = getMyIp()
  const files = getFiles(pathToFolder)

  startFTPServer(pathToFolder)
  upload(myIP, files)
}

uploadFolder('../files')

return
