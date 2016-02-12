$ = jQuery = require 'jquery'

$ ->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', '/public/template.xlsm', true
  xhr.responseType = "arraybuffer"
  xhr.onload = ->
    data = _.map new Uint8Array(@response), (char) =>
      String.fromCharCode(char)
    workbook = XLSX.read(data.join(""), {type:"binary"})
    console.log workbook.SheetNames[0]
  xhr.send()
