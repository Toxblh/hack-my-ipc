const Telnet = require('telnet-client')

async function execCMD(connection, command) {
  let res = await connection.exec(command)
  console.log(command, '\n → ', res, '\n')
}

async function run() {
  let connection = new Telnet()

  const params = {
    host: '192.168.1.9',
    port: 23,
    loginPrompt: '? login:',
    passwordPrompt: 'Password:',
    username: 'root',
    password: 'noty',
    shellPrompt: '[root@GM]#',
    timeout: 1500
  }

  try {
    await connection.connect(params)
  } catch (error) {
    // handle the throw (timeout)
  }

  console.log('Telnet is open...\n')

  const cmd = execCMD.bind(null, connection)

  await cmd('cd /tmp')
  await cmd('mkdir /tmp/www')
  await cmd('mkdir /tmp/www/cgi-bin')
  await cmd('ftpget 192.168.1.14 /tmp/busybox busybox')
  await cmd('ftpget 192.168.1.14 /tmp/rtspd rtspd')
  await cmd('ftpget 192.168.1.14 /tmp/ftpd.sh ftpd.sh')
  await cmd('ftpget 192.168.1.14 /tmp/www/index.html index.html')
  await cmd('ftpget 192.168.1.14 /tmp/www/cgi-bin/webui webui')
  await cmd('chmod +x /tmp/busybox')
  await cmd('chmod +x /tmp/rtspd')
  await cmd('chmod +x /tmp/ftpd.sh')
  await cmd('chmod 700 /tmp/www/cgi-bin/webui')
  await cmd('/tmp/ftpd.sh &')
  // await cmd('/tmp/busybox httpd -h /tmp/www')
  // await cmd('uptime')

  await connection.end()
}

run()
