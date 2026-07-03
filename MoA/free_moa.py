import os
import time
import concurrent.futures
from openai import OpenAI

# 1. Initialize clients
groq_client = OpenAI(
    base_url="https://api.groq.com/openai/v1",
    api_key=os.environ.get("GROQ_API_KEY")
)

gemini_client = OpenAI(
    base_url="https://generativelanguage.googleapis.com/v1beta/openai/",
    api_key=os.environ.get("GEMINI_API_KEY")
)

openrouter_client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=os.environ.get("OPENROUTER_API_KEY")
)

# 2. Define reliable, state-of-the-art free models
worker_models = [
    {"client": groq_client, "model": "llama-3.3-70b-versatile", "name": "qwen/qwen3-32b"},
    {"client": gemini_client, "model": "gemini-3.5-flash", "name": "gemini-3.1-flash-lite-image"},
    # Using reliable free OpenRouter model
    {"client": openrouter_client, "model": "nvidia/nemotron-3-ultra-550b-a55b:free", "name": "poolside/laguna-m.1:free"}
]

def get_worker_response(client_info, prompt):
    try:
        response = client_info["client"].chat.completions.create(
            model=client_info["model"],
            messages=[{"role": "user", "content": prompt}],
        )
        return f"Response from {client_info['name']}:\n{response.choices[0].message.content}"
    except Exception as e:
        return f"Error from {client_info['name']}: {e}"

def run_moa(user_prompt):
    print("🧠 Phase 1: Gathering answers from AI Agents...\n")
    
    agent_responses = []
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = {executor.submit(get_worker_response, model, user_prompt): model for model in worker_models}
        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            agent_responses.append(result)
            status = "✅" if "Error" not in result else "❌"
            print(f"{status} {result.split(':')[0].replace('Response from ', '').replace('Error from ', '')} finished.")

    print("\n🛠️  Phase 2: Aggregating the final answer...")
    
    combined_text = "\n\n---\n\n".join(agent_responses)
    
    aggregator_prompt = f"""
    You are the Aggregator in a Mixture of Agents system.
    Below are responses from multiple top-tier AI models to the user's prompt.
    Please synthesize these responses into a single, high-quality, comprehensive answer.
    Remove any duplicates and keep the best parts of each response.

    User Prompt: {user_prompt}

    Agent Responses:
    {combined_text}

    Final Synthesized Answer:
    """

    # Try OpenRouter first, fallback to Groq if rate-limited
    final_answer = None
    
    try:
        print("Attempting aggregation via nemotron-3-ultra-550b-a55b:free...")
        final_response = openrouter_client.chat.completions.create(
            model="nvidia/nemotron-3-ultra-550b-a55b:free",
            messages=[{"role": "user", "content": aggregator_prompt}],
        )
        final_answer = final_response.choices[0].message.content
    except Exception as e:
        print(f"⚠️ OpenRouter failed ({str(e)[:50]}...). Falling back to nemotron-3-ultra-550b-a55b:free...")
        time.sleep(2) # Small pause before retry
        final_response = groq_client.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=[{"role": "user", "content": aggregator_prompt}],
        )
        final_answer = final_response.choices[0].message.content

    return final_answer

if __name__ == "__main__":
    user_input = input("Enter your prompt: ")
    final_answer = run_moa(user_input)
    print("\n" + "="*50)
    print("✨ FINAL MOA ANSWER:")
    print("="*50)
    print(final_answer)
