# UCI Human Activity Recognition

### `specdata`
This directory contains the necessary data sets to be manipulated in this project. 

* `train` - this subdirectory contains the training data set. It includes the text files *subject_test.txt*, *X_test.txt*, and *y_test.txt*.
* `test` - this subdirectory contains the training data set
* `activity_labels.txt` - text file that contains the labels for each activity. e.g. *WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING*
* `features.txt` - text file that contains the names of the features. 
* `featuresinfo.txt` - text file that contains the explanation of the variables used. 

### `run_analysis.R`
#### Step 1. MERGING of *test* and *train* data sets
* Test and training data sets are loaded in this part from their subfolders in specdata. 
* The necessary files from their corresponding folders are accessed with the correct file path. e.g. `"./specdata/test/X_test.txt"`
* Once loaded, both data sets are merged and stored into one variable, `merged_data`. 
#### Step 2. EXTRACTING the *mean* and *std (standard deviation)*
* The name of the features to be used are loaded from `features.txt`.
* Once loaded, it is then filtered using the `grepl()` function from `dplyr` to get only the necessary variables.
* The data with filtered features is then stored in `extracted_data`. 
### Step 3. DESCRIPTIVE *activity names*
* From the `extracted_data` variable, the *subject* and *activity* columns are copied to a separate variable, `extracted_sub_act`.
* The activities are then loaded from `activity_labels.txt`. 
* Once loaded, the activity names in `extracted_sub_act` are updated accordingly.
### Step 4. DESCRIPTIVE *variable names*
* From the `extracted_data` variable, the *features* columns are copied to a separate variable, `extracted_features`.
* The feature names are then stored in `feature_names`.
* To make it more descriptive, the feature names are adjusted using the `gsub()` function.
* Afterwhich, the columns in `extracted_features` are updated with the adjusted feature names. 
### Step 5. INDEPENDENT *Tiny Data*
* To finish off, the separated `extracted_sub_act` and `extracted_features` are binded back together in `extracted_data` to form one single data table. 
* The extracted data is then tidied up with a combination of `tibble`, `group_by()` and `summarise_all()` functions and stored in `tidy_data`. 
* The data is now **clean**. 
