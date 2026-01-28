## Code Quality Audit: Contextual Industry Standard & Idiomatic Patterns

Perform a rigorous analysis of the provided code context against industry-standard patterns and idiomatic conventions.

### Phase 1: The Executive Summary & Score

Your FIRST response must be a concise "Health Check" report consisting of:

1. **Technology Stack Identification:** Clearly state the primary technology stack, framework, and language of the codebase (e.g., Angular/TypeScript, React/JavaScript, Spring Boot/Java, Django/Python).

2. **Overall Standards Adherence Score:** (0-100/100)

   - _90-100: Excellent (Follows community best practices, idiomatic patterns)_
   - _70-89: Good (Minor deviations from standards)_
   - _50-69: Fair (Significant refactoring needed to align with conventions)_
   - _Below 50: Critical (Anti-patterns, non-standard approaches, high risk)_

3. **Score Breakdown (Table):**
   | Dimension | Score (1-10) | Primary Driver for Score |
   | :--- | :--- | :--- |
   | **Framework Idioms & Conventions** | | (e.g., incorrect lifecycle usage, non-standard patterns) |
   | **Structural Adherence** | | (e.g., wrong architecture, poor pattern implementation) |
   | **Dependency Management** | | (e.g., non-standard tools, tight coupling to libraries) |
   | **Community Best Practices** | | (e.g., anti-patterns, bad practices) |

4. **Top 3 Critical Violations:** A bulleted list of the most severe issues that impacted the score.

### Phase 2: The "Wait" Prompt

After providing the table and the top 3 issues, STOP. Ask the user:
**"Would you like the full Refactoring Roadmap and detailed technical breakdown for these items?"**

---

## Phase 3: The Full Audit (On-Demand Only)

_Only provide this if the user says "Yes" or "Full Report"._

Based *only* on the identified stack in Phase 1, evaluate the code's adherence to the **specific, accepted architectural patterns and idiomatic conventions** of that community. Ignore generic principles only when they conflict with a strong, prevailing community standard (e.g., following framework-specific state management practices).

Evaluate and critique the following dimensions:

1.  **Framework Idioms & Conventions:**
    * Are framework-specific features (e.g., lifecycle hooks, component composition, routing conventions) used **correctly and efficiently** according to the official documentation and senior developer consensus for this stack?
    * Identify non-standard patterns that are likely to confuse developers familiar with the technology.
2.  **Structural Adherence & Pattern Implementation:**
    * Is the codebase organized using the **preferred architecture** for this stack (e.g., feature modules in Angular, component-based routing in React, domain-driven structure in a backend)?
    * Identify instances where local **design patterns** (e.g., service layers, repositories, factories) are implemented poorly or inconsistently with community norms.
3.  **Dependency Management & Isolation:**
    * Are the project dependencies managed using the **standard tool** (e.g., `package.json`, `pom.xml`, `requirements.txt`)?
    * Is there adequate abstraction to **isolate core business logic** from direct, tight coupling with third-party library APIs (the "clean architecture" boundary)?
4.  **Best Practices (Community Consensus):**
    * Highlight any areas (e.g., testing structure, configuration handling, data fetching) where the implementation is technically functional but is widely regarded as a **bad practice or anti-pattern** within the community of the identified stack.

Propose concrete, actionable refactoring steps to align the code with the **established community standards and idiomatic best practices**, ensuring it maximizes clarity and maintainability for any developer familiar with this technology.
