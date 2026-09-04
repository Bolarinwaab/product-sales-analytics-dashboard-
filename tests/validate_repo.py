from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
required = [
    "README.md",
    "dashboard/executive_dashboard.html",
    "architecture/architecture_diagram.svg",
    "architecture/powerbi_star_schema.md",
    "sql/01_create_schema.sql",
    "sql/02_derived_fields.sql",
    "sql/03_kpis.sql",
    "sql/04_yoy_analysis.sql",
    "sql/05_management_scorecard.sql",
    "tests/sql_validation.sql",
    "powerbi/measures.dax",
    "powerbi/model_spec.md",
    "powerbi/theme.json",
    "pipeline/README.md",
    "management/benchmark_insights.md",
]
missing = [p for p in required if not (ROOT / p).exists()]
assert not missing, f"Missing required project artifacts: {missing}"

html = (ROOT / "dashboard/executive_dashboard.html").read_text(encoding="utf-8")
for marker in ["$2.297M", "12.46%", "37,873", "2014", "2017", "Discount"]:
    assert marker in html, f"Dashboard marker missing: {marker}"

readme = (ROOT / "README.md").read_text(encoding="utf-8")
assert "PORTFOLIO" in readme.upper()
assert "not" in readme.lower() and "confidential" in readme.lower()

print(f"PASS: {len(required)} required artifacts present and dashboard/readme checks passed.")
