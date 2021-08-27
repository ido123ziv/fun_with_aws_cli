#!/bin/bash
aws s3 ls >> buckets.txt
cat buckets.txt | while read line
do
        echo $line | awk '{print $3}' >> bucket_names
done
cat bucket_names | while read line
do
echo $line
aws s3api get-bucket-website --bucket $line
done

rm -f buckets.txt
rm -f bucket_names