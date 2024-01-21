### DELIVRABLES
- PowerPoint for presentation to top management: Analysis takeaways, insights & business recommendations.
- Visualization tool (Power BI) to illustrate the outcome: Dynamic approach to show the distribution evolution with key indicators

## Context 
Adidas is thinking about implementing a new retailer in France and the commercial heads wants to know the potential business impact (+ / -) 
and secure if this makes sense or not, by:<br>
1. Having a clear visibility on the future distribution:<br>
    a. By using a dynamic map showing the current retailers in one color and the new ones with another.<br>
    b. OR By using a dynamic map where we can show the evolution by using slicer based on the temporality (2023 – 2024).<br>
    c. OR Having 2 maps like a before / after approach.<br>

➢ AND Showing the numerical distribution evolution (Number of doors & %).
2. Knowing the impact on the current distribution by evaluating/materializing them within a 2km distance against the new retailer. Indicate the key performance indicators on the current distribution and consider the following thresholds:

➢ 4 competitors = Low Opportunity / 2 or 3 = Medium / 1= High and 0 = Very High

- You will find the POWER BI visualisation in `adidas_Ayoub_Youssoufi_BI.pbix` and the presentation of the business case in `adidas_Ayoub_Youssoufi_BI_PPT`
- The input sales data of 2018 and 2019 are respectively `SALES DATA 2018.xlsx` and `SALES DATA 2019.xlsx` 
- The master data of all the existing retailers in the file `FRANCE CUSTOMER MASTER DATA.xlsx`
- The new retailers to be investigated are in the file `NEW RETAILER INFORMATIONS.xlsx`

## Data processing : 

The new retailers has missing geospatial information. It has been imputed by using geopy python module. Find details in `geo_location_Adidas.ipynb`. You can also use geocode API from Google Cloud Plateform (GCP)

