from helper import (
    read_text_file,
)
from tokenizer_from_scratch import (
    MinimalTokenizer,
    VocabularyGenerator,
    Preprocessor,
)
from typing import List, Dict, Tuple

def main():
    verdict: str = read_text_file(filepath="the-verdict.txt")
    verdict_tokenized: List[str] = MinimalTokenizer().tokenize(text=verdict)
    token2id, id2token = VocabularyGenerator.generate(
        text_tokenized=verdict_tokenized
    )
    print("I  -(encode)-> ", token2id["I"])
    print("53 -(decode)-> ", id2token[0])

    preprocessed: List[int] = Preprocessor(
        tokenizer=MinimalTokenizer(),
        token2id=token2id,
        id2token=id2token,
    ).encode("\"It's the last he painted, you know")
    print(preprocessed)


if __name__ == "__main__":
    main()
