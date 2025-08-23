def read_text_file(filepath: str, encoding: str = "utf-8") -> str:
    """
    指定したテキストファイルを読み込み、文字列として返す関数

    Parameters
    ----------
    filepath : str
        読み込むファイルのパス
    encoding : str, optional
        ファイルの文字コード (デフォルトは utf-8)

    Returns
    -------
    str
        ファイル全体の内容
    """
    with open(filepath, mode="r", encoding=encoding) as f:
        return f.read()
