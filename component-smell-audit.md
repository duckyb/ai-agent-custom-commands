## Angular Component Review: Architectural Integrity

Analyze the provided Angular Component (TypeScript file and template) to ensure optimal architecture and clean code practices. Focus on diagnosing common "Component Smells."

### Phase 1: The Executive Summary & Score

Your FIRST response must be a concise "Health Check" report consisting of:

1. **Overall Component Quality Score:** (0-100/100)

   - _90-100: Excellent (Clean, focused, performant component)_
   - _70-89: Good (Minor refactoring opportunities)_
   - _50-69: Fair (Significant architectural issues)_
   - _Below 50: Critical (Multiple component smells, high technical debt)_

2. **Score Breakdown (Table):**
   | Dimension | Score (1-10) | Primary Driver for Score |
   | :--- | :--- | :--- |
   | **Single Responsibility** | | (e.g., doing too much, needs service/directive) |
   | **State Management** | | (e.g., poor RxJS usage, manual subscriptions) |
   | **Input/Output Separation** | | (e.g., tight coupling, not reusable) |
   | **Template Optimization** | | (e.g., performance issues, change detection problems) |

3. **Top 3 Critical Violations:** A bulleted list of the most severe issues that impacted the score.

### Phase 2: The "Wait" Prompt

After providing the table and the top 3 issues, STOP. Ask the user:
**"Would you like the full Refactoring Roadmap and detailed technical breakdown for these items?"**

---

## Phase 3: The Full Audit (On-Demand Only)

_Only provide this if the user says "Yes" or "Full Report"._

Specifically, critique the component's adherence to:

1.  **Single Responsibility Principle (SRP):** Is the component doing too much? Should data fetching, complex state logic, or heavy DOM manipulation be delegated to a **Service** or a **Directive**?
2.  **State Management:** Is local state managed efficiently? Are appropriate **RxJS patterns** (e.g., `async` pipe, `BehaviorSubject`, `combineLatest`) utilized for asynchronous data, or is there excessive manual subscription/unsubscription?
3.  **Input/Output Separation:** Are `@Input()` and `@Output()` used correctly for clean parent-child communication, promoting reusability (i.e., is it a "Dumb/Presentational" component)?
4.  **Template Optimization:** Identify potential performance issues in the template (e.g., repeated complex calculations, excessive use of pure pipes where an `async` pipe would suffice, unnecessary bindings). Suggest using **`OnPush` change detection** if appropriate.

Propose refactoring actions to simplify the component and maximize its reusability and efficiency.
