require "csv"


# メソッドの定義
# 引数の上1桁を返す。文字列、空白、0の場合0を返す
def first_num(number)
	if(number==nil)
		return 0
	end

	number = number.delete("^0-9")
	number = number.to_i
	while number>9
		number = number/10
	end
	return number
end


# 読み込むファイルの指定
# tab区切りTSVのみ対応。
# 同一ディレクトリに入ったファイルを読む気がする
arr = CSV.read('20180419_0708.txt','r:UTF-8',col_sep:"\t")

# 個数配列
n_num = [0,0,0,0,0,0,0,0,0,0]

# 個数をカウント
for i in 2..arr.length-1
	for j in 2..arr[2].length-1
		n_num[first_num(arr[i][j])]+=1
	end
end

# 合計…0は足さない
sum=0
for i in 1..9
	sum+=n_num[i]
end

# 割合
r_num=[]
for i in 1..9
	r_num[i]=n_num[i].to_f/sum*100
end

# ベンフォードの法則
ben=[]
for i in 1..9
	ben[i]=Math.log10(1.0+1.0/i)*100
end

# 出力
print "　 集計した数値：     N個：　割合 :　参考\n"
for i in 1..9
	printf("%dから始まる数値：%6d個：%6.3f%%: %6.3f%%\n",i,n_num[i],r_num[i],ben[i])
end