# BlueGranite BlogBot

BlueGranite Blogging Bot using the OpenAI GPT-2 Model

<h3 align="right"><img src="https://raw.githubusercontent.com/BlueGranite/BlogBot/master/img/bg_logo.png" width="200px" alt="BlueGranite, Inc."></h3>

<h3 align="right">Colby T. Ford and Thomas J. Weinandy</h3>

## Purpose

To showcase the power and utility of generative AI models, specifically in technical writing. Also, we aim to show the inherent bias that comes with imbalanced training of such models.

This repository hosts the companion code our blog post: [A BlueGranite Blog Post Written (Mostly) by AI](https://www.blue-granite.com/blog/a-bluegranite-blog-post-written-mostly-by-ai)

<img src="https://raw.githubusercontent.com/BlueGranite/BlogBot/master/img/BlogBot.png" width="200px" alt="">

## Getting Started

Navigate to the _gpt-2_ folder from the command line and run `docker build` command:
```
docker build --tag gpt-2 -f Dockerfile.cpu .
```

Once the image is finished being built, run the image:
```
docker run --name gpt-2 -d gpt-2
```

To get into the command line of the container, run:
```
docker exec -it gpt-2 /bin/bash
```

Copy the corpus of BlueGranite blogs to the container
```
docker cp ../scraper/BlueGranite_BlogBodies.txt gpt-2:./gpt-2/
```

Tune the existing GPT-2 model on the corpus of BlueGranite blogs
```
# PYTHONPATH=src ./train.py --dataset BlueGranite_BlogBodies.txt --model_name 124M
python ./train.py --dataset BlueGranite_BlogBodies.txt --model_name 124M
```

Have the model provide writing samples
```
# PYTHONPATH=src src/interactive_conditional_samples.py --model_name 124M --seed 1337 --nsamples 1 --top_k 40 --temperature 0.7
python src/interactive_conditional_samples.py --model_name 124M --seed 1337 --nsamples 1 --top_k 40 --temperature 0.7
```

Then, type the desired prompt into the command line.

Once you're finished, you can copy data from the container using:
```
docker cp gpt-2:./gpt-2/checkpoint ./checkpoint
docker cp gpt-2:./gpt-2/samples ./samples
```


## Source
GPT-2 was created by [OpenAI](https://openai.com/blog/better-language-models/). Model tuning code was referenced from [github.com/nshepperd/gpt-2](https://github.com/nshepperd/gpt-2)
