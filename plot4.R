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
### Plot 4 ###
##############

    png(filename = "plot4.png", height = 480, width = 480, units = "px") # opens a png device to encapsulate the plots so it displays correctly
    par(mar = c(6,4,2,2), mfcol = c(2, 2))    # set margins to show labels with a bit of white space, tells plots to be laid out 2 by 2 filling columns first
    
        ## Repeat of plot 2
    plot(power_data_subset$Date_and_Time, power_data_subset$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
    
        ## Repeat of plot 3
    plot(power_data_subset$Date_and_Time, power_data_subset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
    lines(power_data_subset$Date_and_Time, power_data_subset$Sub_metering_2, type = "l", col = "red")
    lines(power_data_subset$Date_and_Time, power_data_subset$Sub_metering_3, type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n", cex = 0.75)
    
    plot(power_data_subset$Date_and_Time, power_data_subset$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
    
    plot(power_data_subset$Date_and_Time, power_data_subset$Global_reactive_power, yaxt = "n", type = "l", ylab = "Global_reactive_power", xlab = "datetime")
    axis(2,cex.axis=1)
    
    dev.off() # close device to finish
