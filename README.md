# Reddit Data Analyses
### Requirements
The data sets given (month by month bz2 files) are newline-delimited JSON blocks. I have written preprocessing scripts
that are detailed further in here

You can find the torrent with all of it with this magnet link:

```
(magnet:?xt=urn:btih:7690f71ea949b868080401c749e878f98de34d3d&dn=reddit%5Fdata&tr=http%3A%2F%2Ftracker.pushshift.io%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80).
```

It is about 160gb compressed, < 1TB unzipped. I have included one month of comments in the repository that are already
formatted to the style mentioned above (`data_sample.json`) and preprocessed data.

### Running It

#### Sample
```bash
ruby analyze.rb data_sample.json
# =>
Comment Set Size: 10000

Result Three Avg Sentiment (threshold 0.4): 0.12837111622858283

Result Three Positive Sentiment Count: 4983

Result Three Negative Sentiment Count: 2097

Result Three Neutral Sentiment Count: 4983



Result One Avg Sentiment (threshold 0.6): 0.12837111622858283

Result One Positive Sentiment Count: 6001

Result One Negative Sentiment Count: 1663

Result One Neutral Sentiment Count: 6001



Result Two Avg Sentiment (threshold 0.8): 0.12837111622858283

Result Two Positive Sentiment Count: 7006

Result Two Negative Sentiment Count: 1199

Result Two Neutral Sentiment Count: 7006

```

#### Month
You can fine a file containing ~1,200,000 comments and their data [here](http://www.filedropper.com/data_6). In order to turn this
into the proper individual JSON files in the form `{"comments: [..]}` that I utilize you can simple run

`mkdir processed`

`split -l 10000 data.json processed/data-`

`ruby run_preprocessing.rb`

Now, `analyze.rb` will be set up to handle all of this with `run_month`.

This is a simple start. I am still downloading the rest of the dataset, and included the sample and
a single month here just as a quick start of sorts.
