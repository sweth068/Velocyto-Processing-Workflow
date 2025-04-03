This repository contains two scripts used for processing single-cell RNA sequencing data with Velocyto:

velocyto.sh: A Bash script that reads input sample details from a CSV file and runs Velocyto for each sample.

velocyto_slurm.sh: A SLURM batch script that submits velocyto.sh as a job on an HPC cluster.


**Description**

velocyto.sh automates the processing of single-cell RNA sequencing data by reading sample details from a CSV file, validating input files, and executing Velocyto with appropriate parameters. 
velocyto_slurm.sh is a SLURM batch script designed to run velocyto.sh efficiently on an HPC cluster, handling resource allocation and job execution.

**Script Descriptions**

***velocyto.sh***

This script automates the execution of Velocyto for multiple samples based on input parameters from a CSV file.

Input:

A CSV file (sarcoma_list.csv) containing sample information with columns:
SAMPLE_NAME: Name of the sample
BAM_FILE: Path to the BAM file
GTF_FILE: Path to the GTF annotation file
MASK_FILE: Optional path to the mask file

The base directory for output (/path/to/file/output_velocyto/sarcoma).

Functionality:
Checks if the input CSV file exists.
Iterates through each row in the CSV file, skipping the header.
Validates the existence of the BAM and GTF files for each sample.
Creates an output directory for each sample.
Runs Velocyto with or without a mask file, depending on availability.
Outputs the resulting .loom files to the respective sample directories.

Displays messages indicating errors or completion of processing.

***velocyto_slurm.sh***

This script is a SLURM batch script designed to submit velocyto.sh as a high-performance computing (HPC) job.

SLURM Parameters:
Job Name: velocyto
Memory: 200GB
CPUs: 24
Runtime: 78 hours
Email Notifications: Sent at job start, end, and failure.
Standard Output/Error Logging: Logs are saved with job ID and node information.

**Functionality:**
Loads required modules (conda and samtools).
Activates the velocyto_env Conda environment.
Navigates to the directory containing velocyto.sh.
Grants execution permissions to velocyto.sh.
Runs velocyto.sh.

**Usage:**
Submit the job using:
***sbatch velocyto_slurm.sh***

**Requirements**
Velocyto installed in a Conda environment (velocyto_env).
SLURM workload manager for job submission.
Samtools v1.10 for BAM file processing.
A properly formatted CSV file containing sample information.

**Output**
Processed .loom files are stored in OUTPUT_DIR_BASE/SAMPLE_NAME/.
SLURM logs are saved in std-<job_id>-<node>.out and std-<job_id>-<node>.err.
