$ = require 'jquery'
_ = require 'underscore'
saveAs = require 'file-saver'

$ ->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', '/public/template.xlsm', true
  xhr.responseType = "arraybuffer"
  xhr.onload = ->
    data = _.map new Uint8Array(@response), (char) =>
      String.fromCharCode(char)
    book = XLSX.read(data.join(""), {type:"binary"})
    sheet = book.Sheets['勤務報告書(上)']
    sheet.A1.v = "修正後タイトル"
    wbout = XLSX.write book,
      bookType:'xlsx', bookSST:false, type:'binary'
    s2ab = (s) =>
      buf = new ArrayBuffer(s.length)
      view = new Uint8Array(buf)
      _(s.length).times (i) =>
        view[i] = s.charCodeAt(i) & 0xFF
      buf
    saveAs(new Blob([s2ab(wbout)],{type:""}), "test.xlsm")
  xhr.send()
