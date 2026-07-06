# Design Tokens & Design System Consolidation

Audit a codebase for hardcoded style values, extract them into SCSS design tokens, consolidate near-duplicates, and refactor the codebase to use the tokens — promoting visual consistency and maintainability.

Use this skill whenever the user wants to:
- Create or expand a design token/variable system
- Audit SCSS/CSS for hardcoded values
- Refactor styles to use `$variables` instead of magic numbers
- Improve UI consistency by consolidating color palettes, spacing, typography
- Clean up a messy or inconsistent design system

## Phase 1: Discover the Existing Setup

Before touching anything, understand what already exists.

**Find token/variable files:**
- Look for `_variables.scss`, `_tokens.scss`, `_color-scheme.scss`, `_settings.scss` or similar
- Check `src/styles/`, `styles/`, `assets/styles/`, `src/assets/`, `src/theme/`
- In Angular: also check `angular.json` for global style paths
- In Next.js/React: check `styles/`, `app/globals.css`, or any `theme.ts`/`tokens.ts` file

**Understand the structure:**
- Is ITCSS already in use? (Generic → Global → Components → Layouts → Utilities)
- Is there already a `$space` base unit or spacing scale?
- Are there partial files (`_*.scss`) already organized by category?
- Are tokens imported globally or per-component?

**Summarize what you found** before proceeding — tell the user:
- What token files exist and what they already define
- What structure is already in place
- What's missing or inconsistent

## Phase 2: Audit — Find Hardcoded Values

Systematically scan all `.scss` files (and `.css` if applicable) for hardcoded values that should be tokens.

### What to scan for

| Category | Examples |
|---|---|
| Colors | `#3B82F6`, `rgb(0,0,0)`, `rgba(255,255,255,0.5)`, named colors |
| Typography | `font-size: 14px`, `font-weight: 700`, `font-family: 'Inter'`, `line-height: 1.5`, `letter-spacing` |
| Spacing | Pixel values in `margin`, `padding`, `gap`, `top/right/bottom/left` |
| Shadows | `box-shadow: 0 2px 4px rgba(0,0,0,0.1)` |
| Borders | `border-radius: 4px`, `border-width: 1px`, `border-color: #ccc` |
| Z-index | `z-index: 100`, `z-index: 9999` |
| Transitions | `transition: all 0.3s ease`, durations and easing functions |
| Breakpoints | Values in `@media (min-width: 768px)` |

### Group findings by category and frequency

For each category, list:
- The hardcoded value
- How many times it appears
- Which files use it
- Whether an existing token already covers it (or nearly covers it)

**Example output:**
```
Colors (hardcoded):
  #333333 — 12 occurrences — button.scss, nav.scss, card.scss
  #334155 — 3 occurrences — header.scss
  → both could consolidate into existing $color-text-dark

  #3B82F6 — 8 occurrences — (no existing match)
  → new token: $color-primary
```

### Cluster near-duplicates

Values that are visually nearly identical should be unified. Use judgment:
- `#333` and `#333333` → same color
- `#f5f5f5` and `#f4f4f4` → likely the same surface color
- `14px` and `15px` for font-size → likely intentional if different components, but flag it
- `0.3s` and `300ms` → same duration, different syntax

Don't silently merge things that might be intentionally different — flag ambiguous cases for user review.

## Phase 3: Propose the Token Map

Before making any changes, present a clear consolidation plan to the user.

Structure the proposal by category:

```
## Proposed Token Changes

### Colors
NEW $color-primary: #3B82F6
  → replaces hardcoded #3B82F6 in: button.scss, form.scss, link.scss

UPDATE $color-text-dark: #333333 (was #2d2d2d)
  → unifies #333333 (12x), #2d2d2d (3x), #334155 (3x — near match, flag)

EXISTING $color-surface already covers #f5f5f5 ✓

### Spacing
NEW $space-xs: 4px
NEW $space-sm: 8px   (or confirm this is $space × 1 if $space = 8px)
NEW $space-md: 16px  (or $space × 2)
...

### Typography
NEW $font-size-sm: 12px
NEW $font-size-base: 14px
...
```

Ask the user to confirm before applying:
> "Here's the proposed token map. Does this look right? Anything to rename, split, or skip before I start refactoring?"

## Phase 4: Update Token Files

Once the user confirms, update (or create) the token file(s).

**Adapt to the existing setup:**
- If `_variables.scss` exists: add new tokens there, in the right section
- If categories are split across files (`_colors.scss`, `_spacing.scss`): respect that
- If nothing exists: create `_variables.scss` in the Generic layer, organized by category

**Token file organization:**
```scss
// _variables.scss

/* #COLORS */
$color-primary:     #3B82F6;
$color-primary-dark: #2563EB;
$color-text:        #1a1a1a;
$color-text-muted:  #6b7280;
$color-surface:     #f5f5f5;
$color-border:      #e5e7eb;

/* #TYPOGRAPHY */
$font-family-base:  'Inter', sans-serif;
$font-size-sm:      12px;
$font-size-base:    14px;
$font-size-md:      16px;
$font-size-lg:      20px;
$font-weight-normal: 400;
$font-weight-bold:   700;
$line-height-base:   1.5;

/* #SPACING */
$space:    8px;   // base unit
$space-xs: 4px;   // $space * 0.5
$space-sm: 8px;   // $space * 1
$space-md: 16px;  // $space * 2
$space-lg: 24px;  // $space * 3
$space-xl: 32px;  // $space * 4

/* #BORDERS */
$border-radius-sm:  4px;
$border-radius-md:  8px;
$border-radius-lg:  16px;
$border-radius-pill: 9999px;
$border-width:      1px;
$border-color:      $color-border;

/* #SHADOWS */
$shadow-sm:  0 1px 2px rgba(0, 0, 0, 0.05);
$shadow-md:  0 2px 8px rgba(0, 0, 0, 0.1);
$shadow-lg:  0 8px 24px rgba(0, 0, 0, 0.15);

/* #Z-INDEX */
$z-dropdown:  100;
$z-sticky:    200;
$z-overlay:   300;
$z-modal:     400;
$z-toast:     500;

/* #TRANSITIONS */
$transition-fast:   0.15s ease;
$transition-base:   0.3s ease;
$transition-slow:   0.5s ease;

/* #BREAKPOINTS */
$bp-sm:   576px;
$bp-md:   768px;
$bp-lg:   1024px;
$bp-xl:   1280px;
```

Use comment-based sections (`/* #SECTION */`) and align values for readability.

## Phase 5: Refactor — Replace Hardcoded Values

Go through each affected file and replace hardcoded values with token references.

**Rules:**
- Replace exact matches and confirmed near-duplicates
- Preserve visual output exactly — this is a pure token refactor, not a redesign
- Don't change anything beyond the value being replaced
- For ambiguous near-duplicates you flagged earlier: only replace if user confirmed

**Work file by file.** After finishing each file, briefly confirm what changed:
```
button.scss — replaced 4 hardcoded values
  #3B82F6 → $color-primary (3x)
  700 → $font-weight-bold (1x)
```

**Spacing shorthand handling:** Be careful with shorthand properties:
```scss
// Before
margin: 16px 8px;

// After
margin: $space-md $space-sm;
```

**Calc expressions:** When existing calc uses `$space`, extend the pattern:
```scss
// Good — consistent with existing pattern
padding: calc(#{$space} * 1.5);
// Or prefer explicit token if one fits
padding: $space-sm;
```

## Phase 6: Verify and Summarize

After all refactoring is complete:

1. **Spot-check** a few files to confirm the replacements look right
2. **Check for missed values** — do a final scan for any remaining hardcoded values that should be tokens
3. **Confirm import chain** — make sure `_variables.scss` (or equivalent) is imported before any file that uses it

**Summary report:**
```
Design Token Refactor — Complete
──────────────────────────────────────
Token file:  src/styles/generic/_variables.scss
New tokens:  18 added, 3 updated

Files refactored: 24
Values replaced:  143
  Colors:        52
  Typography:    31
  Spacing:       38
  Other:         22

Flagged for review:
  - #334155 in header.scss — kept as-is (possible intentional variant of $color-text-dark)
  - z-index: 9999 in modal.scss — kept as-is (needs semantic token name)
──────────────────────────────────────
```

## Key Principles

- **Adapt, don't impose** — work within the existing file structure and naming style
- **Semantic names** — `$color-primary`, not `$color-1`; `$space-md`, not `$space-16`
- **Frequency wins** — if a value appears once, a token might not be worth it; if it appears 3+, it's a candidate
- **Cluster intelligently** — explain merges, flag ambiguous ones, never silently change perceived design intent
- **One concern at a time** — token refactor first; visual redesign (if any) is a separate conversation
- **Complement existing guidelines** — if `css-guidelines.md` or similar exists in the project, align with its naming and file conventions

## Common Patterns to Watch

**Angular projects:**
- Check `angular.json` → `architect.build.options.styles` for global imports
- Component styles are often scoped — hardcoded values there still benefit from tokens if the token is imported in the component's `styleUrls`
- Consider using `:root` variables or SCSS `@use`/`@forward` if the project uses newer SCSS module syntax

**Next.js/React projects:**
- Global styles in `app/globals.css` or `styles/globals.scss`
- Component-level `.module.scss` files — tokens must be imported or available via `@use`
- Check for CSS-in-JS (styled-components, emotion) — if present, note it and ask the user if they want to align the token system with those too

**Theming:**
- If dark/light mode exists, note it and propose a two-layer token approach:
  - Primitive tokens: `$color-blue-500: #3B82F6`
  - Semantic tokens: `$color-primary: $color-blue-500` (overridden per theme)
