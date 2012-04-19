winston = require 'winston'
{_} = require 'underscore'

optimist = require('optimist')
  .options('output', alias: 'o', default: 'output', describe: 'Name for the output file.')
  .options('log', alias: 'l', default: 'info', describe: 'Log level (debug, info, notice, warning, error).')
  .options('help', alias: 'h', describe: 'Show this help message.')
argv = optimist.argv

winston.setLevels winston.config.syslog.levels
winston.remove winston.transports.Console
winston.add winston.transports.Console, colorize: true, level: argv.log, handleExceptions: true


winston.debug 'Parsed arguments', argv

files = _.uniq argv._
if argv.help || !files.length
  winston.error 'No input files specified.' unless argv.help
  winston.info 'Usage: audio-sprite [options] file1.mp3 file2.mp3 *.wav'
  winston.info optimist.help()

