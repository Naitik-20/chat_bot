from transformers import pipeline

generator = pipeline("text-generation", model="distilgpt2")
output = generator("Once upon a time", max_length=30, do_sample=True)
print(output[0]["generated_text"])
