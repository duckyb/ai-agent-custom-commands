## Code Quality Health Check: Maintainability & Architectural Integrity

Perform a rigorous analysis of the provided source code against 5 core dimensions.

### Phase 1: The Executive Summary & Score

Your FIRST response must be a concise "Health Check" report consisting of:

1. **Overall Maintainability Score:** (0-100/100)

   - _90-100: Excellent (Clean, modular, testable)_
   - _70-89: Good (Minor technical debt)_
   - _50-69: Fair (Significant refactoring recommended)_
   - _Below 50: Critical (Architectural erosion, high risk)_

2. **Score Breakdown (Table):**
   | Dimension | Score (1-10) | Primary Driver for Score | Action |
   | :--- | :--- | :--- | :--- |
   | **Modularity & Cohesion** | | (e.g., SRP violations, god-classes) | `Refactor` / `Monitor` / `Accept` |
   | **Coupling & Dependencies** | | (e.g., tight coupling, lack of DI) | `Refactor` / `Monitor` / `Accept` |
   | **Testability** | | (e.g., global state, hard-coded logic) | `Refactor` / `Monitor` / `Accept` |
   | **Clarity & Abstraction** | | (e.g., Cyclomatic complexity, naming) | `Refactor` / `Monitor` / `Accept` |
   | **Extensibility (OCP)** | | (e.g., rigid structures, switch-case logic) | `Refactor` / `Monitor` / `Accept` |

   _Action guide: **Refactor** = benefit clearly justifies the cost. **Monitor** = valid issue but not urgent; revisit if the area grows. **Accept** = real limitation, but effort to fix outweighs the gain._

3. **Top 3 Critical Violations:** For each issue, briefly state the effort to address it and whether it's likely worth pursuing:
   - Issue description — **Effort:** Low/Medium/High · **Impact if fixed:** Low/Medium/High

### Phase 2: The "Wait" Prompt

After providing the table and the top 3 issues, STOP. Ask the user:
**"Would you like the full breakdown with effort/impact analysis for each recommendation?"**

---

## Phase 3: The Full Audit (On-Demand Only)

_Only provide this if the user says "Yes" or "Full Report"._

For each dimension scored below 8, detail the specific issues and recommendations. Structure each item as:

- **What:** The specific issue.
- **Why it matters:** The concrete risk or cost this creates in practice.
- **How to fix:** The specific change or refactoring operation.
- **Effort:** Low / Medium / High
- **Impact:** Low / Medium / High
- **Verdict:** `Worth it` / `Optional` / `Defer` — be honest when the fix is valid but not worth the disruption right now.

Group all recommendations into two sections:

### High ROI — Recommended
Changes where impact clearly outweighs effort. Make the case for why these are worth prioritising.

### Lower Priority — Optional or Defer
Valid improvements that don't justify the cost right now. Note the conditions under which they'd become worth revisiting (e.g., "worth addressing if this module is expected to grow" or "consider when you next touch this area").
