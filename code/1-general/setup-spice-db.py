#%% [markdown]
# # This script sets up a sqlite3 database based on the 4-tiered SpiCE textgrids.
# For more detail about what this script does, see: https://www.khiajohnson.com/post/2021-03/textgrid-sqlite-database/

#%% Imports
import os
import re
import sqlite3 as sql
import pandas as pd 
from textgrid import TextGrid, IntervalTier

#%% Get list of textgrids paths from both the Cantonese and English subdirectories
edir = '/Users/khia/Corpora/spice/english'
cdir = '/Users/khia/Corpora/spice/cantonese'
paths = [os.path.join(edir,f) for f in os.listdir(edir) if f.endswith('TextGrid')]
paths.extend([os.path.join(cdir,f) for f in os.listdir(cdir) if f.endswith('TextGrid')])

# %% Create pandas dataframes for each of the tiers with file, annotation, and timestamps
tasks = []
utterances = []
words = []
phones = []

for p in paths:
    name = re.split(r'[\./]', p)[-2]
    tg = TextGrid.fromFile(p)
    task_tier = tg.getFirst(tierName='task')
    tasks.extend([(name, i.mark, i.minTime, i.maxTime) for i in task_tier if i.mark])
    utter_tier = tg.getFirst(tierName='utterance')
    utterances.extend([(name, i.mark, i.minTime, i.maxTime) for i in utter_tier if i.mark])
    word_tier = tg.getFirst(tierName='word')
    words.extend([(name, i.mark, i.minTime, i.maxTime) for i in word_tier if i.mark])
    phone_tier = tg.getFirst(tierName='phone')
    phones.extend([(name, i.mark, i.minTime, i.maxTime) for i in phone_tier if i.mark])

tasks = pd.DataFrame(tasks, columns = ['file', 'task', 'task_onset', 'task_offset'])
utterances = pd.DataFrame(utterances, columns = ['file', 'utterance', 'utterance_onset', 'utterance_offset'])
words = pd.DataFrame(words, columns = ['file', 'word', 'word_onset', 'word_offset'])
phones = pd.DataFrame(phones, columns = ['file', 'phone', 'phone_onset', 'phone_offset'])

#%% Build the spice.db database with with the pandas dataframes and sqlite3, with one table per tier
con = sql.connect('spice.db')
tasks.to_sql('tasks', con)
utterances.to_sql('utterances', con)
words.to_sql('words', con)
phones.to_sql('phones', con)

# %% Check database with a few basic queries
pd.read_sql(
    sql = """
    SELECT file,
           task,
           task_onset,
           task_offset
    FROM tasks
    LIMIT 10
    """, 
    con = con
    )

#%%
pd.read_sql(
    sql = """
    SELECT file,
           utterance,
           utterance_onset,
           utterance_offset
    FROM utterances
    LIMIT 10
    """, 
    con = con
    )

#%%
pd.read_sql(
    sql = """
	SELECT file, 
	       word, 
	       word_onset
	FROM words
	WHERE word = 'like'
	LIMIT 10
    """, 
    con = con
    )

#%%
pd.read_sql(
    sql = """
	SELECT file,
	       phone,
	       phone_onset,
	       LAG(phone) OVER(PARTITION BY file
	                       ORDER BY phone_onset) AS preceding,
	       LEAD(phone) OVER(PARTITION BY file
	                        ORDER BY phone_onset) AS following
	FROM phones
	LIMIT 10
    """, 
    con = con
    )

# %% close the connection
con.close()
