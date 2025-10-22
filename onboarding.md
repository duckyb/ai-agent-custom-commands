## Repository Onboarding: Rapid Contextualization

You are an expert architect providing a **rapid, focused introduction** to the current, provided codebase/workspace. Your goal is to onboard a new developer by providing the critical knowledge necessary to achieve a "first successful run" and identify primary development areas.

Analyze the entire workspace structure and provide the following essential information:

1.  **Core Purpose (The "What"):**

    - What is the primary **business function** of this repository/service? (e.g., "A REST API for User Authentication," "A front-end dashboard using React," "A data processing pipeline").
    - What are the most critical **external dependencies** or services it relies on?

2.  **Architecture & Entry Points (The "Where"):**

    - Identify the **main entry point** file or function (e.g., `main.py`, `index.js`, `Application.java`).
    - Detail the **logical structure** (e.g., MVC, Hexagonal, simple script). Which directories contain **business logic**, **configuration**, and **tests**?
    - _If applicable:_ Where are the core data models/schemas defined?

3.  **Setup and Execution (The "How"):**

    - Provide the **exact, minimal command(s)** required to set up the environment (e.g., dependency installation, database initialization).
    - Provide the **exact command** to run the application in a local development mode.
    - Provide the **exact command** to run the unit/integration test suite.

4.  **Key Contribution Notes:**
    - What is the most frequently modified or complex component that a new contributor should be aware of?
    - Identify one major "gotcha" or pitfall to avoid when making a new change in this codebase.

Present this information concisely using markdown lists and code blocks for immediate utility.
