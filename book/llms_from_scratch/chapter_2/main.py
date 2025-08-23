from helper import (
    read_text_file,
)

def main():
    print(read_text_file(filepath="the-verdict.txt")[:20])


if __name__ == "__main__":
    main()
