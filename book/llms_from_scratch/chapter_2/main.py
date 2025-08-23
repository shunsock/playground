def check_torch_version() -> None:
    from importlib.metadata import version
    print("torch version:", version("torch"))
    print("tiktoken version:", version("tiktoken"))

def main():
    check_torch_version()


if __name__ == "__main__":
    main()
