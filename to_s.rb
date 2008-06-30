#ファイルをsjisに変換
#
require 'nkf'

# 引数ファイル群を逐次変換
ARGV.each{ |fname|
  bak = fname + Time.now.strftime("%Y%m%d%H%M") 
  # バックアップ確保
  File.rename(fname, bak)
  open(fname, "w"){|out| 
    open(bak){|from|
      while line = from.gets
        line = NKF.nkf('-m0 -s', line)
        out.print line.chomp, "\r\n"
      end
    }
  }
}
