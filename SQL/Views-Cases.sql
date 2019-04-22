# To view the basic details about the given Dataset
select D_MDta.Name, D_MDta.Date_Created, D_MDta.Number_of_Columns, D_MDta.Number_of_Rows, D_VarDt.Name_of_Variables, D_VarDt.Datatype_of_Variable
from dataset_metadata as D_MDta
inner join dataset_variable_details as D_VarDt
on  D_MDta.Dataset_ID = D_VarDt.Dataset_ID
where D_MDta.Dataset_ID = 1;

# List the different datasets present in given domain
select D_MDta.Name, Tags.Tag_Name
from Tag_Map as TM 
inner join dataset_metadata as D_Mdta on TM.Dataset_ID = D_Mdta.Dataset_ID
inner join Tags on Tags.Tag_ID = TM.Tag_ID
where Tags.Tag_Name = "employee";

# List the different runs and their details for which a dataset was tested
select LDR_MData.Run_ID, LDR_MData.Start_Time, LDR_MData.End_Time, LDR_MData.Run_Path
from Data_Map as DMap
inner join Leaderboard_Metadata as LDR_MData
on DMap.Run_ID = LDR_MData.Run_ID
where DMap.Dataset_ID = 1;

# Display all the models present in the database for a particular Model-Type (GBM/GLM/Linear etc.)
select  id_map.Model_ID, leaderboard.Model_Name
from id_map
inner join model_map on  id_map.Model_Type_ID = model_map.Model_Type_ID
inner join leaderboard on leaderboard.Model_ID = id_map.Model_ID
where model_map.Model_Type_Name ="GBM";

# Check the default values of all hyperparameters of a particular model type
select H_DF_Val.Hyperparameter_ID, H_DF_Val.Default_Value
from hyperparameter_def_values as H_DF_Val
inner join Model_Map as MM
on H_DF_Val.Model_type_ID = MM.Model_Type_ID
where MM.Model_Type_Name = "GLM";

# Display the different models present in the BestofFamily out of all models generated in that run
select LDR_Mdata.Run_Id, LDR_Mdata.Run_Time,MR.Model_ID, leaderboard.Presence_StackedEnsembled_Best_of_Family
from model_run as MR
inner join Leaderboard_metadata as LDR_Mdata on LDR_Mdata.Run_ID = MR.Run_ID
inner join leaderboard on leaderboard.Model_ID = MR.Model_ID
where LDR_Mdata.Run_Time = 300 ;

# Display all the performance measures for all the models of a particular run
select LDR.Model_ID, LDR.Model_Name, LDR.RMSE, LDR.RMSE, LDR.MSE, LDR.MAE, LDR.RMSLE
from Leaderboard_metadata as LDR_MData
inner join Model_Run as MR on LDR_MData.Run_ID = MR.Run_ID
inner join Leaderboard as LDR on LDR.Model_ID = MR.Model_ID
where LDR_MData.Run_Time = 300;

# Display top 10 datasets with least no. of null values in all the columns
select dataset_ID, SUM(Null_Values_in_each_column) as Sum_NULL
from dataset_variable_details
group by dataset_id
order by Sum_NULL desc
LIMIT 10;

# Display top 10 datasets with max no. of unique values in all the columns
select dataset_ID, SUM(Unique_Values_In_Each_Column) as Sum_Unique
from dataset_variable_details
group by dataset_id
order by Sum_Unique desc
LIMIT 10;

# List the max repeated model for a particular run
select count(IM.Model_Type_ID)
from  model_run as MR
inner join leaderboard_metadata as LDR_Mdata on LDR_MData.Run_ID = MR.Run_ID
inner join ID_Map as IM on IM.Model_ID = MR.Model_ID
where LDR_Mdata.Run_ID = "XBL7h1dtl" ;

# Display the No. of Datasets present in each domain
select tags.tag_name, count(Tag_map.Dataset_ID) as Dataset_Count
from tag_Map 
inner join Tags on tag_Map.Tag_ID = Tags.Tag_ID
group by tag_Map.Tag_ID
order by Dataset_Count ;

# Check if a particular model is present in the BestofFamily for that run
select Model_ID, Model_Name,Presence_StackedEnsembled_Best_of_Family
from leaderboard 
where Model_Name = "GBM_1_AutoML_20190410_190849";

# Display the max. no. of models generated for a dataset in a particular run
select LDR_Mdata.Run_ID, LDR_Mdata.Max_Models, DM.Dataset_ID
from  data_map as DM
inner join leaderboard_metadata as LDR_Mdata on LDR_MData.Run_ID = DM.Run_ID
where  DM.Dataset_ID = 1 and LDR_Mdata.Run_ID = "XBL7h1dtl";

# List top 5 datasets with max no of observations decided based on a metric
select dataset_ID, (Number_of_Rows* Number_of_columns) as obser 
from dataset_metadata 
order by obser desc
LIMIT 5;

# List no. of variables of each data-type present in a given dataset
select datatype_of_variable, count(datatype_of_variable) as datatype_count
from dataset_variable_details 
where dataset_ID = 1
group by datatype_of_variable
order by datatype_count desc ;
