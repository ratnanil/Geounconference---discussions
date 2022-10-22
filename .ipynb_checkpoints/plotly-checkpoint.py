import plotly.express as px
import numpy as np
import pandas as pd

df = pd.read_csv("data.csv")

fig = px.sunburst(df, path=['Kategorie', 'Initiative', 'Steuerung'])


fig.write_html("index.html")