#!/bin/bash
declare -a arr=("https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.001"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.002"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.003"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.004"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.005"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.006"
		"https://www.kaggle.com/c/diabetic-retinopathy-detection/download/test.zip.007"
)

for i in "${arr[@]}"
do
   echo "$i"
   curl "$i" -H 'Cookie: <place your cookie here>' -H 'DNT: 1' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36' -H 'Accept: image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Connection: keep-alive' -H 'If-Modified-Since: Fri, 17 Apr 2015 15:41:49 GMT' -H 'Referer: https://www.kaggle.com/c/diabetic-retinopathy-detection/data' --compressed -O -J -L
done
