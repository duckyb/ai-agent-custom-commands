## Code Quality Audit: Contextual Industry Standard & Idiomatic Patterns

Perform a rigorous, two-phase audit of the provided code context:

### Phase 1: Contextual Identification 🔍

First, **identify the primary technology stack, framework, and language** of the codebase (e.g., Angular/TypeScript, React/JavaScript, Spring Boot/Java, Django/Python). State the identified stack clearly.

### Phase 2: Architectural & Idiomatic Adherence Audit 📐

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
