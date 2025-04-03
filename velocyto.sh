#!/bin/bash



#Input Parameters
CSV_FILE="/path/to/file/sarcoma_list.csv"
OUTPUT_DIR_BASE="/path/to/file/output_velocyto/sarcoma"

#Check if Excel (CSV) file exists
if [ ! -f "$CSV_FILE" ]; then
    echo "Error: Excel file not found at $CSV_FILE"
    exit 1
fi

#Read and process each row from the Excel file
while IFS=',' read -r SAMPLE_NAME BAM_FILE GTF_FILE MASK_FILE; do
    # Skip header or empty rows
    if [[ "$SAMPLE_NAME" == "SAMPLE_NAME" || -z "$SAMPLE_NAME" ]]; then
        continue
    fi

    #Check if BAM file exists
    if [ ! -f "$BAM_FILE" ]; then
        echo "Error: BAM file not found for $SAMPLE_NAME at $BAM_FILE"
        continue
    fi

    #Check if GTF file exists
    if [ ! -f "$GTF_FILE" ]; then
        echo "Error: GTF annotation file not found for $SAMPLE_NAME at $GTF_FILE"
        continue
    fi

    #Set up output directory for the sample
    OUTPUT_DIR="$OUTPUT_DIR_BASE/$SAMPLE_NAME"
    mkdir -p "$OUTPUT_DIR"

    #Run Velocyto with or without a mask file
    if [ -n "$MASK_FILE" ] && [ -f "$MASK_FILE" ]; then
        echo "Running Velocyto for $SAMPLE_NAME with a mask file..."
        velocyto run -o "$OUTPUT_DIR" -m "$MASK_FILE" "$BAM_FILE" "$GTF_FILE"
    else
        echo "Running Velocyto for $SAMPLE_NAME without a mask file..."
        velocyto run -o "$OUTPUT_DIR" "$BAM_FILE" "$GTF_FILE"
    fi

    #Completion message for the current sample
    echo "Velocyto processing complete for $SAMPLE_NAME. Loom file saved to $OUTPUT_DIR."

done < <(tail -n +2 "$CSV_FILE")  #Skip header row

echo "All samples processed."
