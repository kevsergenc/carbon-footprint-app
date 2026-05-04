from pydantic import BaseModel

class CarbonInput(BaseModel):
    Body_Type: str
    Sex: str
    Diet: str
    How_Often_Shower: str
    Heating_Energy_Source: str
    Transport: str
    Social_Activity: str
    Frequency_of_Traveling_by_Air: str
    Waste_Bag_Size: str
    Energy_efficiency: str
    Monthly_Grocery_Bill: float
    Vehicle_Monthly_Distance_Km: float
    Waste_Bag_Weekly_Count: float
    How_Long_TV_PC_Daily_Hour: float
    How_Long_Internet_Daily_Hour: float
    How_Many_New_Clothes_Monthly: float