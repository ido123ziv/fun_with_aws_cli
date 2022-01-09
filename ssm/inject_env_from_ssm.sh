#!/bin/bash
aws ssm get-parameters-by-path --path $PATH_NAME --with-decryption | jq --raw-output '.Parameters | .[] | [.Name,.Value] | @tsv' | while IFS=$'\t' read -r Name Value; do echo export ${Name//$PATH_NAME\/}=$Value; done
