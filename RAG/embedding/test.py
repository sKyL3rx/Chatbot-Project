from fastapi import FastAPI, Request
from pydantic import BaseModel
import torch
from transformers import AutoModel, AutoTokenizer
import uvicorn

app = FastAPI()

def initialize_models(model_name: str = "BAAI/bge-m3"):
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModel.from_pretrained(model_name)

    return tokenizer, model

class TextInput(BaseModel):
    input_text:  str

def text2vec(text):
    tokenizer, model = initialize_models()
    tokens_pt = tokenizer(text, padding=True, truncation=True, max_length=500, add_special_tokens=True, return_tensors="pt")
    outputs = model(**tokens_pt)
    return outputs.pooler_output.detach().cpu().tolist()[0] 

if __name__ == '__main__':
    print(text2vec("con cac  ne"))

    
