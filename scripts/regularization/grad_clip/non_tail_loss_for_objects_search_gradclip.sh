#!/bin/bash
source activate self_critical_vqa
cd /hdd/robik/projects/self_critical_vqa

hint_type=caption_based_hints

for grad_clip in 0.1 0.5 1.0; do
    expt=non_tail_loss_for_objects_search_grad_clip_${grad_clip}

    CUDA_VISIBLE_DEVICES=0 python -u main.py \
    --learning_rate 1e-5 \
    --split train \
    --hint_type ${hint_type} \
    --split_test test \
    --max_epochs 12 \
    --checkpoint_path saved_models/${expt} \
    --load_checkpoint_path saved_models/pretrained_1_default/model-best.pth \
    --use_non_tail_loss_for_objects \
    --grad_clip ${grad_clip} > /hdd/robik/scr_experiments/${expt}.log
done