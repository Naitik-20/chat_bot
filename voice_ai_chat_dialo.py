import speech_recognition as sr
import pyttsx3
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

# Initialize recognizer, speech engine
recognizer = sr.Recognizer()
tts = pyttsx3.init()
tts.setProperty('rate', 160)

# Load DialoGPT model and tokenizer
print("⏳ Loading AI model...")
tokenizer = AutoTokenizer.from_pretrained("microsoft/DialoGPT-medium")
model = AutoModelForCausalLM.from_pretrained("microsoft/DialoGPT-medium")
print("✅ AI model ready!")

# Greet the user
print("🎙️ Say something to the AI (say 'exit' to quit)")
tts.say("Hello, I am your AI assistant. Talk to me.")
tts.runAndWait()

# Track conversation
chat_history_ids = None

while True:
    with sr.Microphone() as source:
        print("\n🎧 Listening...")
        recognizer.adjust_for_ambient_noise(source, duration=0.5)
        audio = recognizer.listen(source)

    try:
        user_input = recognizer.recognize_google(audio)
        print(f"🧑 You: {user_input}")

        if "exit" in user_input.lower():
            print("👋 Exiting. Goodbye!")
            tts.say("Goodbye!")
            tts.runAndWait()
            break

        # Encode the user input and add to chat history
        new_user_input_ids = tokenizer.encode(user_input + tokenizer.eos_token, return_tensors='pt')
        bot_input_ids = torch.cat([chat_history_ids, new_user_input_ids], dim=-1) if chat_history_ids is not None else new_user_input_ids

        # Generate response
        chat_history_ids = model.generate(
            bot_input_ids,
            max_length=1000,
            pad_token_id=tokenizer.eos_token_id,
            do_sample=True,
            temperature=0.7,
            top_p=0.9
        )

        # Decode and speak the reply
        response = tokenizer.decode(chat_history_ids[:, bot_input_ids.shape[-1]:][0], skip_special_tokens=True)
        print(f"🤖 AI: {response}")
        tts.say(response)
        tts.runAndWait()

    except sr.UnknownValueError:
        print("❌ Could not understand your voice.")
        tts.say("Sorry, I didn't catch that.")
        tts.runAndWait()
    except Exception as e:
        print(f"⚠️ Error: {e}")
        tts.say("Something went wrong.")
        tts.runAndWait()
