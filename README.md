# GATK-Based Variant Calling Pipeline (Bash)

This repository contains a bash-based pipeline for germline variant calling using the GATK Best Practices workflow.  
It processes paired-end FASTQ files and generates variant calls through a series of read alignment, processing, and variant detection steps.

---

## 🧪 Current Workflow Status

✅ Step 1: Directory structure setup and data prep logic written  
✅ Step 2: Reference genome preparation section added  
✅ Step 3: FastQC 
✅ Step 4: BWA-MEM alignment (scripted but computationally intensive)  
🔜 Step 5: SAMtools sorting & indexing  
🔜 Step 6: MarkDuplicates (Picard)  
🔜 Step 7: Base Recalibration & ApplyBQSR (GATK)  
🔜 Step 8: Variant Calling using GATK HaplotypeCaller

> ⚠️ BWA alignment was found to be too computationally intensive on a local machine.  
> I plan to re-run the pipeline up to this point on an AWS EC2 instance for smoother performance.

---

## 📦 Tools Used

- `bwa`
- `samtools`
- `gatk4`
- `picard`
- `fastqc`

---

## 🛠️ Setup Instructions

Install the required tools via Conda:

```bash
conda env create -f environment.yml
conda activate gatk_env
```

---

## 🚀 Usage

```bash
bash variant_calling.sh
```

Make sure to update the paths in the script according to your local environment.

---

## 👩‍💻 Author

**Sai Harshitha Muddamsetty**  
[LinkedIn](https://www.linkedin.com/in/harshitha-muddamsetty) | [GitHub](https://github.com/Harshitha-MI)
