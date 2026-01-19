from fastapi import FastAPI
import uvicorn
from mylib.logic import wiki as wikilogic
from mylib.logic import search_wiki
from mylib.logic import phrase as wikiphrase

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Wikipedia API. Call /search or /wiki"}


@app.get("/search/{query}")
async def search(query: str):
    result = search_wiki(query)
    return {"result": result}


@app.get("/wiki/{topic}")
async def wiki(topic: str):
    result = wikilogic(topic)
    return {"result": result}


@app.get("/phrase/{text}")
async def phrase(text: str):
    result = wikiphrase(text)
    return {"result": result}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)
