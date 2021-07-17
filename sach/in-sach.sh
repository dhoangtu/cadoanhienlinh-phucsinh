#!/bin/bash

set -x

FOLDERS="//home/dhtu/Desktop/CATH/cadoanhienlinh-phucsinh/nhac"
lilypondcmd="/home/dhtu/bin/lilypond"

GEN=./pdf-generated
rm -rf ${GEN}
mkdir ${GEN}

CONTENT=./content-table.csv
rm ${CONTENT}

# xuất PDF từ file nhạc lilypond
IFS=' '
pagecounter=1
filelist=()
for fullname in ${FOLDERS}/*.ly
do
    echo "=== Generating $fullname "
    name=`basename -- "$fullname"`
    shortname="${name%.*}"
    
    # lấy tiêu đề
    title=`cat ${fullname} | grep " title" | grep "=" | sed 's/^[^"]*"//g' | sed -e 's/[[:space:]]*$//' | sed 's/\"[[:space:]]//g'`
    # bỏ ký tự cuối
    title=${title%?}
    #echo "title: ${title}"

    # xuất PDF
    ${lilypondcmd} --output="${GEN}/${shortname}" -dno-point-and-click --pdf "$fullname"
    
    # đếm số trang
    echo "${title};${pagecounter}" >> ${CONTENT}
    # bắt đầu trang kế tiếp
    pageno=`pdfinfo "${GEN}/${shortname}.pdf" | grep "Pages" | grep -Eo '[0-9]+'`
    echo "${title} : ${pageno} pages"
    pagecounter=$(( $pageno + $pagecounter ))
	
	filelist+=( "${GEN}/${shortname}.pdf" )
    
    echo "" 
done

# gộp những file PDF thành 1 file
pdftk "${filelist[@]}" cat output nhac.pdf

# đánh số trang chẵn lẻ
pdflatex so-trang-chan-le.tex

# thêm lời mở đầu
pdftk so-trang-chan-le.pdf blank-a4.pdf cat output sach-nhac.pdf

# chỉnh lệch trang chẵn lẻ
pdfjam --twoside --paper a4paper --offset '0.3cm 0cm' sach-nhac.pdf --outfile in-lech-trang.pdf

pdftk BiaPhucSinh.pdf blank-a4.pdf in-lech-trang.pdf cat output phucsinh.pdf

# xóa những file tạm
rm -rf ${GEN} nhac.pdf sach-nhac.pdf so-trang-chan-le.pdf in-lech-trang.pdf *.aux *.log

