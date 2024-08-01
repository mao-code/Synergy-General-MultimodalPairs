# Synergy-General-MultimodalPairs

<div style="text-align: center;">
    <a href="https://link.springer.com/chapter/10.1007/978-981-97-6125-8_12">Paper</a> &nbsp;|&nbsp; <a href="https://huggingface.co/datasets/MaoXun/Synergy-General-MultimodalPairs">🤗 HuggingFace Dateset Link</a>
</div>

---

> This is a visual-text pair dataset synergistically generated by text-to-image model and multimodal large language model.

> This paper is accepted by the international top conference IJCAI 2024 - GLOW Workshop full paper

This research aims to collaboratively generate data using multimodal large language models, large language models, and the text-to-image model. Through the generation of diverse datasets resulting from interactions among multiple models, we endeavor to automatically generate a visual-text pair dataset.

# Generation Process
## Description
1. Initially, a conventional large language model is employed to generate a primary narrative, which is then paired with an image produced by the text-to-image model. 
2. Subsequently, this image is described by the multimodal large language model, and this new narrative is relayed to the text-to-image model to produce a subsequent image, establishing an iterative data generation cycle. 
3. Through numerous cycles of collaborative generation, we have accumulated a substantial set of text-image pairs.

## Steps
1. Using a multimodal language model (MLLM) or a large language model (LLM), a simple initial description is randomly generated through a fixed prompt.
   
$$ D^{init} \space = H(P) $$

1. The description is then given to a text-to-image model (G) to generate a corresponding image (M).
   
$$ M_1 = G(D^{init}) $$

1. The image and a fixed instruction (I) are then given to the LLM (F) to generate a corresponding variant description ($D^{variant}$). The variant description is then used to generate an image by the text-to-image model (back to step 2).
   
$$ D^{variant}_1 = F(I, M_1) $$

1. Steps 2-4 are repeated to generate many image-description pairs. The stopping criteria is when the number of iterations reaches the maximum number set.
   
$$ \begin{align*} 
    G(D_i) &= M_{i+1} \\
    F(I, M_i) &= D^{variant}_i 
\end{align*} $$

## Evaluation
We trained LLaVA-v1.3-vicuna-7b (a lower-parameter multimodal LLMs compared to the generation model) on our dataset, which varies in size from 1,000 to 7,000 instances. We employed an evaluation method using the mean BERTScore (focusing on recall), BLEU and ROUGE-L score based on the descriptions of 100 images with the output of GPT-4 to assess the performance post-training on our dataset. 

Our findings of the increase in mean BERT Score, BLEU, and ROUGE-L scores with larger dataset sizes indicates a positive correlation between dataset size and the descriptive capabilities of the models. Additionally, the decrease in the standard deviation of the BERT Score suggests improved consistency in model performance across different dataset sizes. 

## Conclusion
In conclusion, for different topics, the initial descriptions $D_i^{init}$ will generate a set of text-photo pairs with slightly different descriptions ($D_{i,j}, M_{i,j}$). Finally, the overall dataset of different initial descriptions $S_{m\times n}$ is obtained, where $m$ is the number of initial descriptions and $n$ is the number of iterations to generate variants for each initial description. As can be seen from the following equation, the final dataset is highly dependent on the initial descriptions, as well as the performance of the text-to-image model. The image-to-text model is also important, but it is usually the target model that you want to approximate.

$$ \begin{align*} 
&S_{i,j} = (M_{i,j}, D_{i,j}) \\
\because \space &M_{i,j} = G(D_{i, j-1}) \\
&D_{i, j}= F(I, M_{i,j}) = F(I, G(D_{i, j-1})) \\
\therefore \space &S_{i, j} = (F(I, G(D_{i, j-1})), G(D_{i, j-1}))
\end{align*} $$

In the process of experiment, it can be found that generating too many initial descriptions at once is not good. Therefore, we use multiple batches to generate initial descriptions. Therefore, the final dataset will be ⇒ batch number number of initial descriptions in a single batch number of iterations to generate variants for each initial description.

$$S_{b \times m \times n}$$

## Citation

```bibtex
@incollection{huang2024synergistic,
  author    = {Mao Xun Huang and Hen-Hsen Huang},
  title     = {Integrating Text-to-Image and Vision Language Models for Synergistic Dataset Generation: The Creation of Synergy-General-Multimodal Pairs},
  booktitle = {Generalizing from Limited Resources in the Open World},
  editor    = {Jinyang Guo and Yuqing Ma and Yifu Ding and Ruihao Gong and Xingyu Zheng and Changyi He and Yantao Lu and Xianglong Liu},
  series    = {Communications in Computer and Information Science},
  volume    = {2160},
  pages     = {147--161},
  year      = {2024},
  publisher = {Springer},
  address   = {Singapore},
  doi       = {10.1007/978-981-97-6125-8_12},
  url       = {https://link.springer.com/chapter/10.1007/978-981-97-6125-8_12}
}
```