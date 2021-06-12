import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns 
import dash
import plotly.express as px

import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output

import plotly.graph_objects as go


df = pd.read_csv("../new_data.csv")


#make a copy
df_copy = df.copy()

#####
#styling 
colors = {
    'background': '#dddddd',
    'text': '#3c8dad'
}
######
app = dash.Dash(__name__)

# for the rader 
def rader_fig(company_type_name_m , company_type_name_f):
    
    if company_type_name_m == "Pvt Ltd":
        the_range = [0,2500]
    else:
        the_range = [0,250]
    
        
    # education names
    rader_measure = df_copy["education_level"].value_counts().index.tolist()
    rader_measure.append(rader_measure[0])
    
    #male
    rader_values_m = df_copy[(df_copy["target"] == 1.0)&(df_copy["gender"] == "Male")&(df_copy["company_type"] == company_type_name_m)]\
    ["education_level"].value_counts().values.tolist()
    rader_values_m.append(rader_values_m[0])
    
    #female
    rader_values_f = df_copy[(df_copy["target"] == 1.0)&(df_copy["gender"] == "Female")&(df_copy["company_type"] == company_type_name_f)]\
    ["education_level"].value_counts().values.tolist()
    rader_values_f.append(rader_values_f[0])
    
    fig = go.Figure()
    fig.add_trace(go.Scatterpolar(
        r=rader_values_m,
        theta=rader_measure,
        fill='toself',
        name= f"Male "+company_type_name_m,
        marker_color=["#125d98"],
        
        ))
    

    fig.add_trace(go.Scatterpolar(
        r=rader_values_f,
        theta=rader_measure,
        fill='toself',
        name= f"Female "+company_type_name_f,
        marker_color=["#f5a962"]
        
        ))
    
    return fig.update_layout(
        polar=dict(
        radialaxis=dict(
        visible=True,
        range= the_range,
        color=colors['text'],
        )),
        showlegend= True,
        plot_bgcolor=colors['background'],
        paper_bgcolor=colors['background'],
        font_color=colors['text']
    )


# first html 
app.layout = html.Div([
    ##########1
    # Title
    html.H1("Employees who are looking for a job in each company with a specific degree"),
    
    # Area to hold the graph

    dcc.Graph(id="graph", figure={},),

    
    # Male
    html.Label([
        "Company Type For Male",
        dcc.Dropdown(
            id="Company_Type",
            clearable=False, # Have to pick a choice
            value="Pvt Ltd",
            options=[{'label': "Pvt Ltd", 'value': "Pvt Ltd"},
                    {'label': "Funded Startup", 'value': "Funded Startup"},
                    {'label': "Public Sector", 'value': "Public Sector"},
                    {'label': "NGO", 'value': "NGO"},
                     {'label': "Early Stage Startup", 'value': "Early Stage Startup"},
                    {'label': "Other", 'value': "Other"}                                   
                    ]
        ),
    ]),
    #Female
    html.Label([
        "Company Type For Female",
        dcc.Dropdown(
            id="Company_Type_F",
            clearable=False, # Have to pick a choice
            value="Pvt Ltd",
            options=[{'label': "Pvt Ltd", 'value': "Pvt Ltd"},
                    {'label': "Funded Startup", 'value': "Funded Startup"},
                    {'label': "Public Sector", 'value': "Public Sector"},
                    {'label': "NGO", 'value': "NGO"},
                     {'label': "Early Stage Startup", 'value': "Early Stage Startup"},
                    {'label': "Other", 'value': "Other"}                                   
                    ]
        ),
            
    ]),
   
    # Line Break
    html.Br([]),
    ##############################
    ##############################
    

    ##############2    
    html.H1("People who have experience and want to find a job or not"),
    
    # Area to hold the graph
    dcc.Graph(id="graph_B", figure={}),
    
    html.Label([
        "Chage Job",
        dcc.Dropdown(
            id="change",
            options=[
                {'label': 'Want to change', 'value': 1},
                {'label': 'Don\'t want to change', 'value': 0},
                {'label': 'Both', 'value': 2}
            ],
            value=1.0
        )
    ]),
    # Line Break
    html.Br([]),
    
    
    ##############################3  
    html.H1("People with enrolled at university or not and are looking for a job."),
    
    # Area to hold the graph
    dcc.Graph(id="graph_C", figure={}),
    
    html.Label([
        "Chage Gender",
        dcc.Checklist(
            id="change_gender",
            options=[
                {'label': 'Male', 'value': 'Male'},
                {'label': 'Female', 'value': 'Female'},
            ],
            value=['Male', 'Female'],
            labelStyle={'display': 'inline-block'}
        )
    ]),
    # Line Break
    html.Br([]),
    ##############################4
    html.H1("The count of degrees based on the major"),
    
    dcc.Graph(id="graphD"),
    
    html.Label([
    html.Label('choose the level degree'), # Add a Label
    dcc.Checklist(
      id="edu",
      options=[
      {'label': 'Bachelor', 'value': 'Bachelor'},
      {'label': 'Masters', 'value': 'Masters'},
      {'label': 'High School', 'value': 'High School'},
      {'label': 'Phd', 'value': 'Phd'},
      {'label': 'Primary School', 'value': 'Primary School'}
      ],
      value=['Bachelor', "Phd"]
      )]),


    
    
       
    # Line Break
    html.Br([]),
    
    
    ##############################
    # Line Break
    html.Br([]),
    
])

############
# first call back (1)
@app.callback(
    Output('graph', 'figure'),
    Input('Company_Type','value'),
    Input('Company_Type_F','value'),
)


def update_figure(val_company_type_M , val_company_type_F):
    
    return rader_fig(val_company_type_M , val_company_type_F)

#######
############
# second call back (2)

@app.callback(
    Output('graph_B', 'figure'),
    Input('change', 'value'),
)

def update_figure(valchange):
    df_change = df_copy[df_copy["target"] == 1.0]
    df_not_change = df_copy[df_copy["target"] == 0.0]
    
    if valchange == 2:
        fig = go.Figure(data=[
            go.Bar(
                name='Want to change',
                x=df_change["experience"].value_counts().index,
                y = df_change["experience"].value_counts().values,
                marker_color=["#125d98"]*22,
            ),
            go.Bar(
                name='Don\'t want to change', 
                x=df_not_change["experience"].value_counts().index,
                y = df_not_change["experience"].value_counts().values,
                marker_color=["#f5a962"]*22,
            )
        ])

        return fig.update_layout(
            xaxis_title="Experience Level",
            yaxis_title="Count",
            barmode='group',
            plot_bgcolor=colors['background'],
            paper_bgcolor=colors['background'],
            font_color=colors['text']
        )
    elif valchange == 1 :
        
        fig = go.Figure(data=[
            go.Bar(
                name='Want to change',
                x=df_change["experience"].value_counts().index,
                y = df_change["experience"].value_counts().values,
                marker_color=["#125d98"]*22,
            )
        ])

        return fig.update_layout(
            xaxis_title="Experience Level",
            yaxis_title="Count",
            plot_bgcolor=colors['background'],
            paper_bgcolor=colors['background'],
            font_color=colors['text'])
    else :
        
        fig = go.Figure(data=[
            go.Bar(
                name='Don\'t want to change',
                x=df_not_change["experience"].value_counts().index,
                y = df_not_change["experience"].value_counts().values,
                marker_color=["#f5a962"]*22,
            )
        ])

        return fig.update_layout(
            xaxis_title="Experience Level",
            yaxis_title="Count",
            plot_bgcolor=colors['background'],
            paper_bgcolor=colors['background'],
            font_color=colors['text'])

#################
############
# Third call back (3)

@app.callback(
    Output('graph_C', 'figure'),
    Input('change_gender', 'value'),
)


def update_figure(val_gender):
    df_target_Male = df_copy[(df_copy["target"] == 1.0) & (df_copy["gender"] == "Male")]
    df_target_Female = df_copy[(df_copy["target"] == 1.0) & (df_copy["gender"] == "Female")]
    
    if val_gender == ['Male']:
        fig = px.bar(
        data_frame = df_target_Male,
        x = df_target_Male["enrolled_university"].value_counts().index,
        y = df_target_Male["enrolled_university"].value_counts().values,
        labels = {"x": "Enrolled University", "y":"Count"},
        color_discrete_sequence=["#125d98"],
        )
        
        return fig.update_layout(
                plot_bgcolor=colors['background'],
                paper_bgcolor=colors['background'],
                font_color=colors['text']
            )
    elif val_gender == ['Female']:
        fig = px.bar(
        data_frame = df_target_Female,
        x = df_target_Female["enrolled_university"].value_counts().index,
        y = df_target_Female["enrolled_university"].value_counts().values,
        labels = {"x": "Enrolled University", "y":"Count"},
        color_discrete_sequence=["#f5a962"],
        )
        return fig.update_layout(
            plot_bgcolor=colors['background'],
            paper_bgcolor=colors['background'],
            font_color=colors['text']
        )
    else:
        fig = go.Figure(data=[
            go.Bar(
                name='Male',
                x=df_target_Male["enrolled_university"].value_counts().index,
                y = df_target_Male["enrolled_university"].value_counts().values,
                marker_color=["#125d98","#125d98","#125d98"],
            ),
            go.Bar(
                name='Female', 
                x=df_target_Female["enrolled_university"].value_counts().index,
                y = df_target_Female["enrolled_university"].value_counts().values,
                marker_color=["#f5a962","#f5a962","#f5a962"],
            )
            
        ])

        return fig.update_layout(
            xaxis_title="Enrolled University",
            yaxis_title="Count",
            barmode='group',
            plot_bgcolor=colors['background'],
            paper_bgcolor=colors['background'],
            font_color=colors['text'],
        )
            
        

#################
############
# Fourth call back (4)
@app.callback(
    Output('graphD', 'figure'),
    Input('edu', 'value'),
    
    
)

def update_figure(edu):
    
    df_new = df_copy[df_copy["education_level"].isin(edu)]
    
    fig =  px.histogram(
        df_new, 
        x="major_discipline", 
        color="education_level",
        color_discrete_sequence=["#125d98", "#3c8dad", "#f5a962", "#1eae98", "#f29191"],
    )
    
    return fig.update_layout(
        plot_bgcolor=colors['background'],
        paper_bgcolor=colors['background'],
        font_color=colors['text'],
        
    )


    

if __name__ == '__main__':
    app.run_server(debug=True)
    
    