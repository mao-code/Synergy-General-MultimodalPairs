#!/bin/bash
################## VICUNA ##################
PROMPT_VERSION=v1
MODEL_VERSION="lmsys/vicuna-7b-v1.3"
################## VICUNA ##################

deepspeed /content/LLaVA/llava/train/train_mem.py     --deepspeed /content/LLaVA/scripts/zero2.json     --lora_enable True     --model_name_or_path $MODEL_VERSION     --version $PROMPT_VERSION     --data_path /content/train_data_lora.json     --image_folder ""     --vision_tower openai/clip-vit-large-patch14     --pretrain_mm_mlp_adapter /content/checkpoints/mm_projector.bin     --mm_vision_select_layer -2     --mm_use_im_start_end False     --mm_use_im_patch_token False     --bf16 True     --output_dir /content/checkpoints/llava-$MODEL_VERSION-7000-finetune_lora     --num_train_epochs 1     --per_device_train_batch_size 16     --per_device_eval_batch_size 4     --gradient_accumulation_steps 1     --evaluation_strategy "no"     --save_strategy "steps"     --save_steps 50000     --save_total_limit 1     --learning_rate 2e-5     --weight_decay 0.     --warmup_ratio 0.03     --lr_scheduler_type "cosine"     --logging_steps 1     --tf32 True     --model_max_length 2048     --gradient_checkpointing True     --lazy_preprocess True     --dataloader_num_workers 4     --report_to wandb
