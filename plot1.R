####################
### Read in File ###
####################
    
        # read in data from working directory. Reading in all data.
            # skip first 66636 lines (46.275 days between first date and beginning of target date, multiplied by 24 hours by 60 minutes).
            # only read 2880 rows which equals 2 days counted in minutes.
            # Alternative would be to read lines while grepping for the dates of interest.
    power_data_subset <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, skip = 66637, nrows = 2880)
    
        # pull header data from file (using header = TRUE pulls row directly before pulled data)
    power_data_header <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE, nrows = 1)
    
        # set header
    colnames(power_data_subset) <- unlist(power_data_header)
    
        # Combined date and time columns and format.
    power_data_subset$Date <- strptime(paste(power_data_subset$Date, power_data_subset$Time), format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
    
        # Remove old "Time" column
    power_data_subset$Time <- NULL
    
        # Rename column name "Date" to "Date and Time"
    colnames(power_data_subset)[1] <- "Date_and_Time"



##############
### Plot 1 ###
##############

    png(filename = "plot1.png", height = 480, width = 480, units = "px") # opens a png device to encapsulate the plots so it displays correctly
    par(mar = c(6,6,3,3))    # set margins to show labels with a bit of white space
    hist(power_data_subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")  # produce a red histogram of Global Active power with labeled x axis
    dev.off()    # close device to finish
