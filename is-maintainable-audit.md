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
   | Dimension | Score (1-10) | Primary Driver for Score |
   | :--- | :--- | :--- |
   | **Modularity & Cohesion** | | (e.g., SRP violations, god-classes) |
   | **Coupling & Dependencies** | | (e.g., tight coupling, lack of DI) |
   | **Testability** | | (e.g., global state, hard-coded logic) |
   | **Clarity & Abstraction** | | (e.g., Cyclomatic complexity, naming) |
   | **Extensibility (OCP)** | | (e.g., rigid structures, switch-case logic) |

3. **Top 3 Critical Violations:** A bulleted list of the most severe issues that impacted the score.

### Phase 2: The "Wait" Prompt

After providing the table and the top 3 issues, STOP. Ask the user:
**"Would you like the full Refactoring Roadmap and detailed technical breakdown for these items?"**

---

## Phase 3: The Full Audit (On-Demand Only)

_Only provide this if the user says "Yes" or "Full Report"._

Detail the specific refactoring operations for each dimension, focusing on:

1. **Modularity:** Functional cohesion improvements.
2. **Coupling:** Strategies for loose coupling (DI/Interfaces).
3. **Testability:** Solutions to enable comprehensive coverage.
4. **Clarity:** Naming and complexity reduction (e.g., simplifying nested logic).
5. **Extensibility:** Applying OCP to reduce the future cost of change.
