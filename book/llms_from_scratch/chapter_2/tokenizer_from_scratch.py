import re
from typing import List, Dict, Tuple

class MinimalTokenizer:
    def __init__(
        self,
        pattern_to_be_splitted: str = r'([,.:;?_!"()\']|--|\s)'
    ):
        self.pattern_to_be_splitted = pattern_to_be_splitted

    def tokenize(self, text: str) -> List[str]:
        return [
            item.strip()
            for item in re.split(self.pattern_to_be_splitted, text)
            if item.strip()
        ]

class VocabularyGenerator:
    @staticmethod
    def generate_hashmap_token_to_id(text_tokenized: List[str]) -> Dict[str, int]:
        return {
            token:integer for integer,token
            in enumerate(sorted(set(text_tokenized)))
        }

    @staticmethod
    def generate_hashmap_id_to_token(text_tokenized: List[str]) -> Dict[int, str]:
        return {
            integer:token for integer,token
            in enumerate(sorted(set(text_tokenized)))
        }

    @staticmethod
    def generate(text_tokenized: List[str]) -> Tuple[Dict[str, int], Dict[int, str]]:
        return (
            VocabularyGenerator.generate_hashmap_token_to_id(
                text_tokenized
            ),
            VocabularyGenerator.generate_hashmap_id_to_token(
                text_tokenized
            ),
        )

class Preprocessor:
    def __init__(
        self,
        tokenizer: MinimalTokenizer,
        token2id: Dict[str, int],
        id2token: Dict[int, str]
    ):
        self.tokenizer = tokenizer
        self.str_to_int = token2id
        self.int_to_str = id2token

    def encode(self, text: str) -> List[int]:
        tokens = self.tokenizer.tokenize(text)
        return [self.str_to_int[token] for token in tokens]

    def decode(self, ids: List[int]) -> str:
        text = " ".join([self.int_to_str[i] for i in ids])
        # 句読点の前のスペースを削除
        return re.sub(
            r'\s+([,.?!"()\'])',
            r'\1',
            text
        )
