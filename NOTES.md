title tag prompt:

This query will be summarized:
{{prompt:middletruncate:8000}}

Ignore all previous instructions.

Generate a concise and accurate title (no more than 6 words) that summarizes the query in natural English. The title should start with a suitable Emoji to enhance understanding, but avoid quotation marks or special formatting. RESPOND ONLY WITH THE EMOJI FOLLOWED BY TITLE TEXT.

Example titles:
📉 Stock Market Trends
🍪 Perfect Chocolate Chip Recipe
🎵 Evolution of Music Streaming
🤖 Artificial Intelligence in Healthcare
🎮 Video Game Development Insights

Examples of bad titles:
"Query Interrogation Explained"
Title: The Best Way to Cook Pasta
"Frustrated!"
Query: Awesome! Title: Amazing feats

<chat_history>
{{MESSAGES:END:2}}
</chat_history>

## jupyter

/home/jupyter/.jupyter/jupyter_notebook_config.py

# c.ServerApp.allow_remote_access = False

to

c.ServerApp.allow_remote_access = True
