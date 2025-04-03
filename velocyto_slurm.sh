#!/bin/bash

#SBATCH --job-name="velocyto"
#SBATCH --mem=200G
#SBATCH --mincpus=24
#SBATCH --time=78:00:00
#SBATCH --mail-user=email_id
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output="std-%j-%N.out" 
#SBATCH --error="std-%j-%N.err" 

#LOAD MODULES
module load conda

source /environment/miniconda3/bin/activate velocyto_env

module load samtools/1.10

cd /user/scripts/ #velocyto.sh is located in this path

chmod +x velocyto.sh

./velocyto.sh
