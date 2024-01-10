from mage_ai.io.file import FileIO
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
import requests
import io
import pandas as pd


@data_loader
def load_data_from_file(*args, **kwargs):
    """
    Template for loading data from filesystem.
    Load data from 1 file or multiple file directories.

    For multiple directories, use the following:
        FileIO().load(file_directories=['dir_1', 'dir_2'])

    Docs: https://docs.mage.ai/design/data-loading#fileio
    """
    url = "https://media.githubusercontent.com/media/kmk2977/NYC-TLC-Trip/main/yellow_tripdata_2023-10.csv?token=ANEIS7PFR5H3BKUEHZJN6JTFT3EHE"
    response = requests.get(url)
    nrows_to_read=100000

    return pd.read_csv(io.StringIO(response.text), nrows=nrows_to_read, sep=',')


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
