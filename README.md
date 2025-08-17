# ml-infra

`ml-infra` is the **infrastructure layer** of the ML homelab system.  
It ensures that every run has the same **filesystem layout, configs, logs, and network setup** that the rest of the pipeline depends on.

You normally **don’t run this repo directly** (although you can). It is automatically executed in **pipeline mode** through [`ml-pipeline`](https://github.com/Ben0112358/ml-pipeline).

---

## 🗂️ What It Sets Up

- **Root folder** → `$ML_HOMELAB_ROOT`
- **Subfolders**:
  - `data/raw` → raw datasets  
  - `data/clean` → processed datasets  
  - `models/` → trained model artifacts  
  - `configs/` → generated YAML configs  
  - `logs/infra` → infra logs  
  - `logs/data` → data preprocessing logs  
  - `logs/training` → training logs  
  - `logs/serving` → serving logs  
  - `logs/ui` → UI logs  
  - `logs/pipeline` → pipeline logs  

- **Generated config file** for each run → `${ML_HOMELAB_ROOT}/configs/config_<project>_<mode>_<timestamp>.yaml`  
- **Project- and mode-specific infra** via Terraform modules. Docker networks are handled here for example.

---

## ⚡ Usage
You don’t interact with `ml-infra` directly.  
Instead, it runs automatically when you launch the pipeline from [`ml-pipeline`](https://github.com/Ben0112358/ml-pipeline):

```bash
bash execute.sh <project_name> <mode>
```

---

### As a Developer
The repo is organized like this:

```
├── main.tf              # shared infra setup
├── outputs.tf           # defines exported outputs (env vars)
├── variables.tf         # input variables
├── globals.tf           # global Terraform settings
├── modules/
│   ├── dev/
│   │   └── <project>/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   └── prod/
│       └── <project>/
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
└── templates/
    └── config.yaml.tmpl # template for generated configs
```

- Every **project must exist in both `dev/` and `prod/`** under `modules/`. The implementation of `dummy_project` can be used as inspiration for your own projects. 
- `main.tf` wires up the shared infra and invokes the appropriate project+mode module.  
- `templates/config.yaml.tmpl` defines the config file structure that will be generated for each run.  
- `outputs.tf` outputs of the run.

---

## 📜 Terraform Outputs
A special feature of `outputs.tf` is that if you define an **UPPER CASE output**, it will become an environment variable which can be used by stages further down the ml pipeline. This is the case with `CONFIG_PATH` for example, which is used by stages down the pipeline in config.py so that we can conveniently import all relevant paths in python.

---

## 🌍 Role in the Ecosystem

- **First stage** of any pipeline execution.  
- Guarantees a **consistent directory structure** for data, models, logs, and configs. 
- Generates configs and env vars that later stages (`ml-data`, `ml-training`, `ml-serving`, etc.) rely on.  
---
