import csv
import re
import numpy
from scipy.stats import chisquare

# 正規表現
reReal = re.compile('^[+-]?[0-9]+(\.[0-9]+)?$')

# カウント用のハッシュ
counter = {}
for i in range(1, 10):
	counter[str(i)] = 0

# ファイルを捜査する
with open('20180419_0708.txt', 'r') as f:
	reader = csv.reader(f, delimiter='\t')
	for row in reader:
		# print(row)
		for item in row:
			# 実数のフォーマットに従っているか
			if reReal.search(item):
				# print(item)
				# 1-9の文字以外を捨てる
				item = re.sub('[\D0]', '', item)
				if item == '':
					item = '0'
				initialNum = item[0]
				# 有効数字の最上位が0のときは無視して次へ
				if initialNum == '0':
					continue
				counter[initialNum] += 1

print(counter)

# サンプル数
nSample = sum(counter.values())
print(nSample)

# 理想と実際を比較
actual = counter.values()
expected = []

for i in range(1, 10):
	expected.append(nSample * numpy.log10((i+1)/i))
print(expected)

# タプルに変換
actual = tuple(actual)
expected = tuple(expected)

# print(len(actual))
# print(len(expected))

# 検定
chisq, p = chisquare(actual, f_exp = expected)
print('X^2 = ', chisq)
print('p = ', p)