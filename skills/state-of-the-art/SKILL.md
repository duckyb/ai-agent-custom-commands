---
name: state-of-the-art
description: "Judge whether code, a proposal or a plan is the state-of-the-art approach for its stack today (idiomatic and standard, but also current, efficient and not deprecated), answer what the state-of-the-art approach for something is, or audit a whole project area by area (stack, dependencies, end-of-life runtimes). Gives a verdict first, then what is already current and a ranked list of gaps with the modern alternative, plus promising bleeding-edge options kept apart for evaluation. Use whenever the user says \"state of the art\", \"state-of-the-art\", \"SOTA\", \"bleeding edge\", \"modern best practice\", \"the current/best way to do X in <year>\", asks if an approach or a whole project/codebase is outdated or modern, or asks if code is \"industry standard\" or idiomatic, even when they only ask a short question about the current branch, a proposal, CI/CD, UX, or a library choice."
---

# State of the art

"State of the art" means the approach a strong senior engineer who keeps up
with the ecosystem would choose **today**, for **this stack at the version in
use**. It has three layers, and every one must hold:

1. **Standard.** Idiomatic and widely adopted. Nothing weird or homegrown
   that would surprise someone who knows the stack. Prefer the first-party or
   officially supported solution over a community alternative when the
   framework, platform or vendor offers one.
2. **Current.** Not deprecated, archived, superseded or in maintenance mode.
   It is what the official docs recommend now, or what the ecosystem has
   clearly converged on, not what most tutorials from a few years ago show.
3. **Excellent.** Efficient and lean: it uses built-in platform and framework
   features instead of extra code or dependencies, performs well, and is
   the simplest thing that fully solves the problem.

The recommendation is **not** the bleeding edge. Experimental flags,
release candidates, hype libraries with little adoption, and patterns only a
few big companies can justify are not state of the art yet, because the user
would carry the risk of churn and thin documentation.

Still, the user does want to hear about the bleeding edge when it is worth
their attention. When something new is genuinely relevant to the question
and plausibly on track to become the standard (an official experimental API,
a fast-growing tool backed by the framework team, a new platform feature
landing in browsers), propose it in its own **On the horizon** section,
separate from the recommendation. Give what the user needs to evaluate it:
its status (experimental, beta, stable since when), who backs it, how widely
it is adopted, what it would gain over the current standard, and what could
go wrong (API churn, migration back, missing support). Link the primary
source (official docs, release announcement or repository) so the user can
check it directly. Leave the section out when nothing qualifies; don't pad
it. If the user asks for the bleeding edge directly, it becomes the main
subject and the same evaluation applies.

## Three ways the user asks

- **Review:** "Is this the state of the art approach for X?" The target is
  the current changes, the branch, a proposal or plan in the conversation, or
  the files the user points to. If it is unclear, use the most recent proposal
  in the conversation, else the uncommitted diff, else the branch diff against
  the default branch.
- **Discovery:** "What is the state of the art approach for X?" There may be
  no code yet. Answer for the user's stack and constraints, not in general.
- **Project audit:** "Is this project / codebase / repo state of the art?",
  "How modern is this app?", "Audit the stack". The target is the whole
  project, not the diff, even when there are uncommitted changes. If the user
  names one part ("the frontend", "the infra"), audit only that part.

## How to judge

1. **Pin the context.** Read the real versions from the manifests and
   lockfiles (`package.json`, `composer.lock`, `pyproject.toml`, Dockerfiles,
   CI files and so on), and note the runtime, hosting, CI runner and any
   constraint the user stated (an admin who must approve changes, a team that
   prefers simplicity, an existing architecture). The state of the art for
   Next.js 16 is not the one for Next.js 12, and the right answer for a
   GitLab shared runner is not the one for a self-managed cluster.

2. **Verify freshness, don't trust memory.** Your training data lags the
   ecosystem, and this skill exists precisely to catch what has moved on.
   Before calling something current or outdated, check the sources that are
   cheapest and most authoritative:
   - docs shipped inside installed packages (for example
     `node_modules/<pkg>/docs` or the package's README and CHANGELOG);
   - the official docs, release notes and deprecation notices, through web
     search when the verdict depends on what changed recently (a tool being
     archived, a new default, an API marked legacy).
   In the answer, say briefly what you verified and against which source.
   If you could not verify a claim, say it comes from memory.

   Hold claims about the user's own code to the same standard. Before
   saying the current implementation has a flaw that the modern approach
   fixes, open the code and confirm it does what you say. It is tempting to
   overstate the old approach's weaknesses to make the new one look better;
   one such claim that turns out false makes the user doubt the whole
   answer. If the existing code already handles something well, say so, and
   argue for the modern option on its real merits.

3. **Weigh it.** For each relevant part of the approach, ask:
   - Would an expert in this stack find it idiomatic, or would it surprise
     them?
   - Is there a first-party or built-in way that now replaces it?
   - Is any tool, library or API in it deprecated, archived or legacy?
   - Is it efficient: no wasted work, no unneeded dependency, no hand-rolled
     version of something the platform already does?
   - Does it handle the concerns the current approach is expected to handle
     (for example accessibility for UI, caching and reproducibility for CI,
     perceived responsiveness for async work)?

4. **Separate "state of the art" from "worth doing now".** Sometimes the
   modern answer means a large migration (a new router, a new build system, a
   new architecture). Say so honestly, then also give the best option
   **within the current architecture**, so the user can choose. Respect the
   constraints they gave you: if the state of the art needs a privileged
   runner the admin won't grant, the realistic recommendation is the best
   option that works without it. Never push complexity for its own sake; the
   modern answer is often the simpler one.

## Auditing a whole project

A project audit applies the same judgement area by area. The risk is
covering only what happens to catch your eye, so work through the project
systematically:

1. **Inventory.** List the stack with exact versions: runtime, framework,
   language, database, key libraries, build tool, test tools, CI/CD, hosting
   and deploy method. Read manifests, lockfiles, Dockerfiles, CI config and
   any architecture docs (`ARCHITECTURE.md`, `README`, ADRs). Note what the
   docs say was decided on purpose, so you don't flag a deliberate choice as
   an oversight without addressing the reason given.

   Some of what matters runs outside the repo: the production database
   server, the reverse proxy, the hosting platform. Infer its version and
   setup from what the repo shows (CI services, compose files, deploy
   scripts, docs), label that as an inference in the answer, and say what
   the user would need to check on the server to confirm it.

2. **Check dependencies and runtimes.** This is often where a project falls
   furthest behind, and it is cheap to verify:
   - known security advisories in the locked versions (`composer audit
     --locked`, `npm audit --omit=dev` for runtime dependencies,
     `pip-audit`, `cargo audit`). For each advisory that affects a runtime
     dependency, check whether the project's own configuration or usage
     actually triggers it before ranking it;
   - outdated packages, especially ones a major version or more behind, with
     the ecosystem's read-only command (`yarn outdated`, `npm outdated`,
     `pnpm outdated`, `composer outdated --direct`, `pip list --outdated`);
   - deprecated or archived packages (`npm view <pkg> deprecated`, the
     repository's archive status, the package's README);
   - runtime, database and OS image versions against their official
     end-of-life dates (the project's own release pages or endoflife.date).
   Don't install, upgrade or change lockfiles; this is an assessment.

3. **Go through the areas.** Use the ones that apply and skip the rest:
   - framework and rendering model (router, data fetching, caching);
   - API layer and data validation;
   - data layer (ORM, migrations, schema design, indexing);
   - realtime and background work (queues, jobs, push);
   - auth and security (sessions, headers, secrets handling);
   - frontend platform (styling, accessibility, performance and Core Web
     Vitals, use of modern web platform features);
   - build, tooling and code quality (bundler, TypeScript config, linting,
     formatting);
   - testing (unit, integration, end-to-end, how tests run in CI);
   - CI/CD, containers and deployment;
   - observability (logging, error tracking, metrics).
   For each one, apply the four steps in "How to judge" above. Verify the
   claims that drive the verdict instead of skimming everything; one
   checked source for each important finding beats many unchecked ones.

4. **Rank the gaps by impact against effort.** Put security exposure,
   end-of-life runtimes and deprecated dependencies first, because they get
   worse with time. Then cheap wins with clear benefit, then larger
   migrations. Between items of similar seriousness, put the cheaper fix
   first: the user gets the most risk removed for the least work. For a
   large migration, follow step 4 of "How to judge": say
   what it would gain and give the best option without it.

If you can delegate work, the area checks run well in parallel. Give each
helper the inventory and the rules in this file, and verify their key claims
yourself before reporting them.

## How to answer

Lead with the verdict, then the details. Keep it tight and in plain
language; the user reads this to decide, not to learn the whole topic.

**Review mode:**

1. **Verdict in the first sentence:** *Yes*, *Mostly*, *Partly* or *No*,
   plus the single biggest reason. For example: "Partly: the structure is
   standard for Laravel on GitLab, but Kaniko has been archived."
2. **What is already current:** short bullets, each naming the practice and
   why it counts as current. Skip this section if there is nothing.
3. **Where it falls short, most important first:** a numbered list (the user
   often replies by number, like "do 3 then 1"). For each item: what is
   outdated or missing, the modern alternative, the concrete benefit, and the
   rough cost of switching.
4. **On the horizon** (only when something qualifies, see above).
5. **Verified against:** one line naming the sources you checked, with
   links for anything on the web.

**Discovery mode:**

1. **The recommendation in the first sentence**, for this stack and these
   constraints.
2. **Why it is the current standard**, in a few bullets.
3. **Alternatives, ranked.** Each one needs both sides compared with the
   recommendation, or the user can't weigh it: its **pros** (what it does
   better), its **cons** (what it costs or loses: complexity, extra
   services, vendor lock-in, performance, migration effort), and when it
   would be the better choice.
4. **What to avoid:** approaches that are still common in older tutorials or
   answers but have been superseded, and what replaced them.
5. **On the horizon** (only when something qualifies, see above).
6. **Verified against:** one line, as above.

**Project audit mode:**

1. **Overall verdict in the first sentence:** *Current*, *Mostly current*,
   *Behind* or *Outdated*, plus the single biggest reason.
2. **Stack:** one line with the main versions, so the user can see what was
   audited.
3. **Area table:** one row per area you audited, with a status (*Current*,
   *Behind* or *Outdated*) and one line explaining why. Don't use a numeric
   score; a status with a reason tells the user what to do, a number doesn't.
   When the project has separate apps (a frontend and a backend, several
   services), give each app its own status column, with a dash where an
   area doesn't apply, so one app's gap doesn't hide behind the other's
   strength.
4. **Gaps, ranked:** a numbered list, most important first, each with what
   is outdated or missing, the modern alternative, its pros and cons, and the
   rough effort. Mark quick wins.
5. **Already strong:** a few bullets on what is genuinely current, so the
   user knows what to leave alone.
6. **On the horizon** (only when something qualifies, see above).
7. **Verified against:** as above, including the dependency commands you ran.

A project audit is longer than the other modes, but keep each row and item
to the point. If the list of gaps is long, give the top items in full and
the rest as one-line entries.

Do not change code as part of this skill. End by offering to apply the
items the user picks; they decide which and in what order.
