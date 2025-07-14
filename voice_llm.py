from transformers import pipeline

# Load the small LLM
generator = pipeline("text-generation", model="distilgpt2")

# Input prompt
prompt = "The future of AI is"

# Generate a response
output = generator(prompt, max_length=40, do_sample=True, temperature=0.7)

# Show result
print("AI Response:")
print(output[0]["generated_text"])
