# Reddit Data Analyses
### Requirements
This is pretty vanilla python with preprocessing scripts written in Ruby. I did this the preprocessing
in Ruby sheerly out of laziness. This will probably be replaced later.

To preprocess the data simply import a reddit comment JSON file from the massive dump. You can find
a torrent with all of them [here](magnet:?xt=urn:btih:7690f71ea949b868080401c749e878f98de34d3d&dn=reddit%5Fdata&tr=http%3A%2F%2Ftracker.pushshift.io%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80).

It is about 160gb. I have included one month of comments in the repository, as well as sample processed
and preprocessed data.

### Running It

```bash
ruby preprocess.rb sample_data.json
python load.py processed_data.json
# you will now have 1 month of comments loaded as dictionaries in a list and be at a pdb breakpoint
```

This is a simple start. I am still downloading the rest of the dataset, and included the sample and
a single month here just as a quick start of sorts.
