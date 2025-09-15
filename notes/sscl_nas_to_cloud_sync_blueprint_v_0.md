# SSCL NAS ↔ Cloud Sync Blueprint (v0.1)

2025-09-10 管理NAS新增檔案命名原則與新型態整理方法與基本子目錄模版

**Scope:** Naming standards, folder templates, cloud‑sync mapping, archive triage, CLI preflight checks, and migration playbook for encrypted shares: `/research`, `/teaching`, `/references`, `/personal`, `/archive`.

**目標：** 檔案命名標準；資料夾範本；雲端連結對應；存檔檢傷分類；命令列檢查以及如何有效放置資料於：`/research`, `/teaching`, `/references`, `/personal`, `/archive`工作子目錄中。 

---

## 1) Principles & Source of Truth
- **Single Source of Truth:** NAS (encrypted shares). Cloud drives are **distribution mirrors** or **collab inboxes**.
- **Minimal Surprises:** Prefer **NAS → Cloud (one‑way)** sync unless collaboration demands two‑way.
- **Cross‑platform safety:** Filenames must be Windows/macOS/Linux compatible.
- **Short, meaningful, consistent.**

[重點]
* NAS為核心資料，所有的網路雲端連結：google-ME, google-NTUST, ms-NTUST 只是用來雲端備份或是對外合作交流用。所有資料夾在NAS端都預設為 Encrypted share folders 有加密。
* 預防核心被無心竄改，基本預設內訂為「上傳型單向性syncornization同步」(NAS->cloud)，除非因為外部合作特別需要兩方面同時修改內容才「雙向同步」
* 跨系統通用的安全性：因為檔案會跨 Ubuntu/Windows/OSx所以一定要一致取檔名
* 短檔名；有用而且一致

---

## 2) Filename & Folder Naming Standard
**Goals:** cross‑platform safe, human‑readable, machine‑sortable.

**目標：** 可跨平台、人眼可懂、電腦可自動分類抓取

### 2.1 Length Budgets
- **File name (base + extension):** ≤ **80** chars
- **Folder name:** ≤ **40** chars
- **Total path (NAS view):** target ≤ **200** chars (hard Linux limit ~4096, but 200 is a safe cross‑platform working budget)

### 2.2 Allowed Characters
- Use: `a–z 0–9 - _ .` (lowercase recommended)
- Avoid/forbid: spaces, non‑ASCII, and **Windows‑illegal**: `< > : " / \ | ? *` ; no trailing space/dot.

### 2.3 Case & Separators
- **lowercase** everything.
- Use **kebab‑case** for words: `vehicle-control` and **snake_case** for tokens if needed: `dataset_v02`.

### 2.4 Dates & Versions
- Date: **YYYY‑MM‑DD**. Example: `2025-09-10`.
- Version: `v01, v02, ...` (no “final”).
- Recommended ordering: `<token>-<shortname>_v02_2025-09-10.ext` for stable alpha sort.

### 2.5 Project/Course/Person Codes
- **Project code:** `prj-<yy><nn>-<tag>` (e.g., `prj-25a1-lidar`).
- **Course code:** `me1132-vehicle-control-2025f` (dept+num+shortname+term).
- **Student code:** Wade‑Giles‑style shortname, e.g., `stu-chang-philip` or `stu-chu-chih-wu`.
- **Hardware/Software tokens:** `hw-stm32f4`, `sw-matlab2024b`, `os-ubuntu24.04`.

### 2.6 Examples
- `prj-25a1-lidar_report_v03_2025-09-10.pdf`
- `course-me1132-2025f_lab03-inverted-pendulum_v01.pptx`
- `dataset_battery-cycling_v02_2025-08-21.csv`

[重點翻譯]
* 檔名少於80 char 資料夾少於 40 char，大約十三到十六個左右的英文字當檔名，六七個字當作資料夾名稱。
* 使用字元為 0~9, a~z, 橫線- 與底線_ 當然還點 .
* 基本上全小寫，現在資料夾內有大寫的就算了，使用 **kebab-case** 字-串連 **snake_case** 檔案_版本。
* 日期放最後（避免一開始就始用數字；MATLAB不允許）格式為 yyyy-mm-dd 所以一致的檔名為：**<分類檔名代號等>_<檔案-解釋>_v02_2025-09-10.ext**作為標準形式
*  建議檔名前面與子目錄`/project-dna`, `/module-thermal`, `/code-matlab-dcmotor`, `/dataset-cordon-cocoput`, '/course-embedded system' 這一類型的任務資料夾，做全面的配合如：
    * prj-dna-paper-draft_v01_2025-10-10.tex
    * mod-thermal-physical-matlab-simulation_v03_2025-09-13.docx
    * crs-embedded-system-class-admin-syllabus_v01_2025-09-09.pdf
    * data-cocoput-extract-dna-optimize-re(sult_v01_2025-04-19.txt
* 將來或許會有 ME1141 這種學年度使用的代號(token)，將來要回來參考此設計方法，例如學生名，作業名稱等等。

---

## 3) Recommended Folder Templates

### 3.1 Research Project (inside `/research/projects/`)
```
prj-<code>-<shortname>/
  00-admin/
  01-proposal/
  02-literature/   # papers, notes (RO for students if needed)
  03-data/
    raw/
    proc/
    results/
  04-code/
  05-docs/         # manuscript, figures
  06-present/      # slides, posters
  07-notes/
  98-archive/
  99-release/      # public export; cloud-mirrored if needed
```

### 3.2 Teaching (inside `/teaching/courses/`)
```
course-<code>/
  01-syllabus/
  02-lectures/
    L01-intro/
    L02-ros-basics/
  03-labs/
  04-assign/
  05-keys/         # solutions; NAS-only, no cloud sync
  06-submissions/  # drop-box style or Teams/Google Classroom integration
  99-archive/
```

### 3.3 References (inside `/references/`)
```
references/
  papers/
  books/
  manuals/
  tutorials/
  datasets-catalog/   # CSV/markdown catalog pointing to canonical data in /research
  readme.md           # explain what belongs here
```

### 3.4 Archive (inside `/archive/`)
```
archive/
  research-archive/
  teaching-archive/
  personal-archive/
  others-archive/
  _README.txt         # retrieval rules + do-not-modify policy
```

[REVIEW THIS]

---

## 4) Cloud‑Sync Mapping Matrix
> Default stance: **NAS is source of truth**. Use **NAS → Cloud (upload)** unless collaboration requires two‑way.

| NAS share/subpath | Cloud account/space | Sync direction | Purpose | Notes |
|---|---|---|---|---|
| `/research/projects/*/99-release` | **Google‑ME** (My Drive or Shared drive) | **NAS → Cloud** | Share finalized docs/data snippets with coauthors | Keep raw data/code on NAS; publish only curated outputs.
| `/research/collab-inbox` (optional) | Google‑ME/Shared drive | **Two‑way** | External collaborators drop files here | Periodically ingest → normalize → move into project tree.
| `/teaching/courses/*/01–04` | **MS‑NTUST OneDrive** | **NAS → Cloud** | Distribute slides/labs/assignments | Keep `/05-keys` NAS‑only (exclude from task).
| `/references` (subset) | Google‑ME (or MS‑NTUST) | **NAS → Cloud** | Mobile/off‑campus access to key refs | Consider syncing **indices only**; keep large PDFs NAS‑only.
| `/personal` | MS‑Personal / iCloud | **NAS → Cloud** (limited) | Private working set | Exclude sensitive/legal.
| `/archive` | (none) | **No sync** | Preservation vault | Retrieve on demand only.

**Tip:** Prefer *per‑subfolder* tasks (e.g., only `/99-release`) so you never leak raw data or solutions.

[REVIEW THIS]

---

## 5) Archive Triage Priorities
1) **Blockers to movement**
   - Over‑long / illegal names, weird Unicode, trailing spaces/dots.
   - Path depth explosions (>200 chars target).
   - Duplicates (same hash, different paths).

2) **High‑value, time‑sensitive**
   - Active paper/grant materials.
   - Upcoming course materials.
   - Compliance / consent / IRB‑relevant documents.

3) **Bulk consolidation**
   - Legacy “general” folders → relocate into proper project/course/reference buckets.

4) **Cold storage**
   - Old installers, obsolete binaries, vendor dumps → park in archive with README.

[REVIEW THIS]

---

## 6) CLI Preflight & Fix‑up Toolkit (SSH on NAS)
> Run in **archive** first, fix, then move into encrypted destinations.

### 6.1 Find over‑long names (file or folder)
```bash
# names longer than 120 chars (tune N)
find /volume1/archive -regextype posix-extended -regex '.*/[^/]{121,}$' -print
```

### 6.2 Find Windows‑illegal characters
```bash
find /volume1/archive -name '*[<>:"/\\|?*]*' -print
```

### 6.3 Replace spaces with hyphens (files only; dry‑run first)
```bash
# DRY‑RUN
a=()/bin/true # placeholder so code block renders
while IFS= read -r -d '' f; do
  new="${f// /-}"
  printf 'mv -- %q -- %q\n' "$f" "$new"
done < <(find /volume1/archive -type f -name '* *' -print0)

# EXECUTE (after reviewing output)
while IFS= read -r -d '' f; do
  mv -- "$f" "${f// /-}"
done < <(find /volume1/archive -type f -name '* *' -print0)
```

### 6.4 Truncate very long basenames (conservative example)
```bash
# trims basenames > 120 chars by keeping start+end chunks; review carefully
while IFS= read -r -d '' f; do
  dir=$(dirname -- "$f"); base=$(basename -- "$f")
  ext="${base##*.}"; name="${base%.*}"
  if [ ${#name} -gt 120 ]; then
    head=${name:0:90}; tail=${name: -20}
    new="$dir/${head}__${tail}.${ext}"
    printf 'mv -- %q -- %q\n' "$f" "$new"
  fi
done < <(find /volume1/archive -type f -print0)
```

### 6.5 Safe moves (same volume are instant)
```bash
# move curated release artifacts only
mv /volume1/archive/some/path/output_v01.pdf \
   /volume1/research/projects/prj-25a1-lidar/99-release/
```

[REVIEW THIS]

---

## 7) Permission Policy (group‑based)
- **/archive**: Admin **RW** only.
- **/references**: Admin/Assistant **RW**; PhD/MS **RO**.
- **/research**: Admin/Assistant **RW**; students **RW/RO per‑project** (use subfolder ACLs).
- **/teaching**: Admin/Assistant **RW**; students **RO** to materials; `/05-keys` **Admin/Assistant only**.
- **/personal**: Admin only.

[REVIEW THIS]

---

## 8) Migration Playbook (safe & repeatable)
1. **Freeze cloud sync tasks** touching legacy folders.
2. **Unlock** encrypted shares.
3. **Preflight scans** in `/archive` (6.1–6.4). Fix names.
4. **Stage structure**: create project/course/reference skeletons.
5. **Move** (instant on same volume) curated items into place.
6. **Define Cloud Sync tasks** (section 4). Use subfolder scoping.
7. **Verify from Windows/macOS** via SMB (path length sanity check).
8. **Re‑enable sync**, monitor first full pass.
9. **Document**: drop a `README.md` in each top‑level share.

[REVIEW THIS]

---

## 9) Readme Templates (drop these in each share)
**/research/README.md**
- Purpose; structure; what goes where; release policy; per‑project permissions; cloud publish path (99‑release).

**/teaching/README.md**
- Course tree; what’s public; what’s private; submission rules; LMS links.

**/references/README.md**
- Inclusion rules; dedup policy; how to add; large file handling; catalog etiquette.

**/archive/_README.txt**
- Do‑not‑modify; how to request retrieval; triage priorities; where cleaned content moves.

[REVIEW THIS]

