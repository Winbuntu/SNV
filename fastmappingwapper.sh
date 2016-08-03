#!/bin/bash
# myFunc2FastWrapper.sh
echo $SGE_TASK_ID
sh ./Call_variant.sh `sed -n ${SGE_TASK_ID}p files.txt`
