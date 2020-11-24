#!/bin/bash

. path.sh
if [ $# -lt 1 ]; then
    if [ -z $KALDI_ROOT ]; then
        echo "$0: KALDI_ROOT is not defined and no argument found to the script".
        exit 1
    fi
else
    KALDI_ROOT=$1
fi

unlink steps
unlink utils
ln -s $MAIN_ROOT/egs/wsj/s5/{utils,steps} .

files="data_prep.sh download_and_untar.sh download_lm.sh format_lms.sh prepare_dict.sh" # score_kaldi_wer.sh"
for f in $files; do
	echo $f
	unlink local/$f
	ln -s "$MAIN_ROOT/egs/mini_librispeech/s5/local/$f" local/
done

unlink local/score_kaldi_wer.sh
ln -s $MAIN_ROOT/egs/wsj/s5/steps/scoring/score_kaldi_wer.sh local/
