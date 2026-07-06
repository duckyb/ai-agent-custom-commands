# CSS Guidelines for AI Agents

## Purpose

This document serves as both implementation guidelines and audit criteria for SCSS code. Use it to ensure code quality, consistency, and maintainability.

## Core Rules

### Preprocessor & Setup

- Use **SASS/SCSS** syntax only
- Use **spaces** for indentation (4 spaces, no tabs)
- Never write inline styles in HTML
- Use `$space: 8px` variable for all margins/paddings
- Limit line width to 80 characters

### Variable Usage & Global References

- **Always check for existing global variables** before creating new ones
- Reference global variables from `_variables.scss` or `_color-scheme.scss` when available
- Use semantic variable names: `$color-primary`, `$font-size-base`, `$border-radius-sm`
- Create local variables only when global equivalents don't exist

### File Organization (ITCSS Structure)

```
style.scss
├── Generic/ (variables, mixins, color-scheme)
├── Global/ (HTML tags only, no classes)
├── Components/ (reusable modules)
├── Layouts/ (page structures)
└── Utilities/ (helper classes)
```

### Naming Conventions

- **Components**: `component-name` (hyphen-delimited)
- **Child elements**: `component-name__child-element` (double underscore)
- **States**: `is-active`, `has-loaded`, `is-disabled` (prefix with is-/has-)
- **Variables**: `$color-text-link`, `$footer-margin-bottom` (hierarchical, hyphen-delimited)
- **No camelCase** for classes

### Component Structure

```scss
.component-name {
  // Box model properties
  display: block;
  width: 100px;
  margin: $space * 2;

  // Positioning
  position: relative;
  z-index: 1;

  // Visual
  background-color: #f5f5f5;
  border: 1px solid #e5e5e5;

  // Typography
  font-size: 14px;
  color: #333;

  // Child elements
  &__child-element {
    // styles
  }
}
```

### Color & Sizing

- Use hex colors: `#f0f0f0` (lowercase)
- Font-size in pixels
- Unit-less line-height
- Limited color palette (<15 colors total)

### Specificity & Best Practices

- Keep nesting to 2 levels maximum
- Never use `!important`
- Never use ID selectors
- Avoid undoing/overriding styles
- Each HTML element must have a class
- Don't rely on HTML tags as selectors

### Comments

- Document-level: `/** DOCUMENT TITLE */`
- Section-level: `/* #SECTION-TITLE */`
- Use `//` for non-compiled comments
- Use `/* */` for compiled comments

### Media Queries

- Write media queries within each component file
- Don't create separate media query files

### Grid System

- Custom grid classes: `prefix-grid-columns`
- Prefer CSS Grid Layout
- Fallback to Flexbox/Float for older browsers

### External Frameworks

- Avoid frameworks for long-term projects
- If used, import via package manager
- Don't modify original framework files
- Import only needed SASS files

## SCSS Audit Checklist

### File Structure & Organization

- [ ] Files follow ITCSS structure (Generic → Global → Components → Layouts → Utilities)
- [ ] Each component has its own SCSS file
- [ ] File names match component class names
- [ ] Proper import order in main `style.scss`

### Variable Usage

- [ ] Global variables referenced when available
- [ ] No hardcoded values that could use variables
- [ ] Consistent use of `$space` variable for spacing
- [ ] Color variables used instead of hex values
- [ ] Semantic variable naming conventions followed

### Naming Conventions

- [ ] BEM-like naming: `component-name__child-element`
- [ ] State classes use `is-` or `has-` prefixes
- [ ] No camelCase in class names
- [ ] No ID selectors used
- [ ] Each HTML element has appropriate class

### Code Quality

- [ ] No `!important` declarations
- [ ] Nesting limited to 2 levels maximum
- [ ] Proper declaration order (Box → Position → Visual → Typography → Misc)
- [ ] Consistent formatting (4-space indentation, proper spacing)
- [ ] No inline styles in HTML

### Comments & Documentation

- [ ] Document-level comments present
- [ ] Section-level comments for major blocks
- [ ] Complex code has inline comments
- [ ] Proper comment syntax (`//` vs `/* */`)

### Responsive Design

- [ ] Media queries within component files
- [ ] Mobile-first approach where applicable
- [ ] Consistent breakpoint usage

### Performance & Maintainability

- [ ] No redundant or conflicting styles
- [ ] Efficient selectors (avoid deep nesting)
- [ ] Proper use of mixins for repeated patterns
- [ ] Clean, readable code structure
