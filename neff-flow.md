# NEFF Framework Flow Documentation

NEFF (Net7 Frontend Framework) provides structured Angular development with clear separation between data management, event handling, and component composition.

## Core Architecture

### Layout Builder Pattern

Central orchestrator managing widget connections:

```typescript
export class LayoutComponent implements OnInit {
  public lb = new LayoutBuilder("layout-id");
  private widgets = [{ id: "test1" }, { id: "test2" }];

  ngOnInit() {
    this.lb.init({
      widgetsConfig: this.widgets,
      widgetsDataSources: DataSources,
      widgetsEventHandlers: EventHandlers,
      dataSource: new LayoutDS(),
      eventHandler: new LayoutEH(),
    });
  }
}
```

### Data Source Pattern

Transforms external data into component-ready data:

```typescript
export class TestDS extends DataSource {
  protected transform(data) {
    return data.value;
  }
}
```

**Key Features:** `out$` (BehaviorSubject), `run()`, `update()`, `reset()`

### Event Handler Pattern

Manages component interactions:

```typescript
export class TestEH extends EventHandler {
  public listen() {
    this.innerEvents$.subscribe((event) => {
      switch (event.type) {
        case "test.click":
          this.emitOuter("test.click", event.payload);
          break;
      }
    });
  }
}
```

**Event Types:** `emitInner()` (component), `emitOuter()` (layout), `emitGlobal()` (app-wide)

**Event Prefixing:** Events are automatically prefixed by the framework:

- When emitting: Use simple event names (e.g., `"searchresults"`)
- When listening: Include layout/widget prefix (e.g., `"es-search-layout.searchresults"`)

### Widget vs Atomic Component Distinction

**Widgets:** First-level components under layouts. Registered in config with IDs. Single `[data]` input, `(emit)` output. Managed by LayoutBuilder.

**Atomic Components:** Nested within widgets. NOT registered as widgets. Multiple inputs/outputs. Traditional Angular patterns.

Examples: `project-messaging` (widget) → `chat-message` (atomic), `diary-list` (widget) → `diary-element` (atomic)

### Widget Configuration

- `id`: Unique identifier
- `dataSource`: Optional custom data source
- `eventHandler`: Optional custom event handler
- `options`: Configuration options
- `hasStaticData`: Whether to trigger initial data load

### Layout Data Source Management

```typescript
this.one("widget-name").update(data); // Single widget
this.some(["widget1", "widget2"]).update(data); // Multiple widgets
this.all().update(data); // All widgets
this.exclude(["widget3", "widget4"]).update(data); // All except specified
```

### Component Interface Contract

**Widgets:** Single `[data]` input, `(emit)` output

```html
<widget
  [data]="lb.widgets['id'].ds.out$ | async"
  (emit)="lb.widgets['id'].emit($event.type, $event.payload)"
></widget>
```

**Atomic Components:** Multiple inputs/outputs allowed

```html
<atomic
  [input1]="val1"
  [input2]="val2"
  (event1)="handler1($event)"
  (event2)="handler2($event)"
></atomic>
```

### Data Flow Patterns

**Layout → Widget:** Framework methods (see Component Interface Contract above)
**Widget → Atomic:** Traditional Angular binding

```html
<atomic
  [data]="processedData"
  [user]="user"
  (event)="handleEvent($event)"
></atomic>
```

**Flow:** Layout manages widgets → Widgets transform data → Atomic components use Angular patterns

**Event Naming:**

- Inner events auto-prefixed with widget ID: `widget-1.event-name`
- Outer events auto-prefixed with layout ID: `layout-id.event-name`

## Folder Structure

```
src/app/
├── data-sources/
│   ├── TestComponentDS.ts
│   └── index.ts
├── event-handlers/
│   ├── TestComponentEH.ts
│   └── index.ts
└── components/
    └── test-component/
```

### Registration

**Data Sources (`src/app/data-sources/index.ts`):**

```typescript
export * from "./TestComponentDS";
import { TestComponentDS } from "./TestComponentDS";
export const DataSources = { TestComponentDS };
```

**Event Handlers (`src/app/event-handlers/index.ts`):**

```typescript
export * from "./TestComponentEH";
import { TestComponentEH } from "./TestComponentEH";
export const EventHandlers = { TestComponentEH };
```

## Best Practices

1. **Single Responsibility**: Each data source handles one transformation concern
2. **Event-Driven**: Use events for component communication
3. **Reactive Data**: Leverage RxJS streams for data flow
4. **Consistent Naming**: Follow widget naming conventions for automatic class resolution
5. **Type Safety**: Use TypeScript interfaces

## Anti-Patterns to Avoid

### ❌ **Direct Widget Manipulation**

```typescript
// WRONG: Direct method calls
this.dataSource.getWidgetDataSource("search-bar").setInputValue(payload);
this.lb.widgets["search-bar"].component.inputValue = payload;

// CORRECT: Use framework methods
this.one("search-bar").update({ inputValue: payload });
```

### ❌ **Direct Data Source Access**

```typescript
// WRONG: Accessing widget data source directly
const widgetDS = this.dataSource.one("widget").ds;
widgetDS.updateSearchResults(results);

// CORRECT: Use event-driven approach
this.emitOuter("updatesearchresults", results);
```

### ❌ **Bypassing Event System**

```typescript
// WRONG: Direct method calls
this.lb.widgets["search-bar"].eventHandler.handleSearch(query);

// CORRECT: Event-driven communication
this.emitOuter("search", { query });
```

### ❌ **Incorrect Event Prefixing**

```typescript
// WRONG: Adding prefix when emitting
this.emitOuter("es-search-layout.searchresults", results);

// CORRECT: Framework auto-adds prefix
this.emitOuter("searchresults", results);

// WRONG: Missing prefix when listening
case 'searchresults':

// CORRECT: Include prefix when listening
case 'es-search-layout.searchresults':
```

### ❌ **Circular Dependencies**

```typescript
// WRONG: Widgets directly referencing each other
this.layout.widgets["results"].dataSource.update(event.payload);

// CORRECT: Use events
this.emitOuter("results", event.payload);
```

### ❌ **Ignoring Transform Method**

```typescript
// WRONG: Bypassing transform logic
this.out$.next(user); // Skips transform()

// CORRECT: Always use update()
this.update(user); // Calls transform()
```

### ❌ **Nesting Widget Components**

```typescript
// WRONG: Multiple inputs, nested widgets
@Component({
  template: `<es-dropdown-select [emit]="subjectsEmit"></es-dropdown-select>`,
})
export class Component {
  @Input() subjectsEmit: any; // ❌ Multiple inputs
  @Input() measuresEmit: any; // ❌ Violates contract
}

// CORRECT: Place widgets in layout template (see Component Interface Contract)
// OR: Implement atomic component directly
@Component({
  template: `<div (click)="onClick()">Custom dropdown</div>`,
})
export class Component {
  @Input() data: any; // ✅ Single input for widgets
  @Output() emit = new EventEmitter<any>(); // ✅ Single output for widgets
}
```

### ❌ **Treating Atomic Components as Widgets**

```typescript
// WRONG: Registering atomic components as widgets
widgets: [
  { id: "chat-message" }, // ❌ Atomic component shouldn't be widget
  { id: "diary-element" }, // ❌ Atomic component shouldn't be widget
];

// CORRECT: Only first-level components are widgets
widgets: [
  { id: "project-messaging" }, // ✅ Widget contains chat-message
  { id: "diary-list" }, // ✅ Widget contains diary-element
];
```

## Key Principles

1. **Framework methods**: `this.one().update()`, `this.some().update()`
2. **Event-driven**: `emitInner()`, `emitOuter()`, `emitGlobal()`
3. **Data transformation**: Use `transform()` method
4. **Widget encapsulation**: Don't access widget internals
5. **Reactive streams**: Use `out$` BehaviorSubject
6. **Naming conventions**: Auto-resolve classes
7. **Widget vs Atomic**: Only first-level components are widgets
8. **Data hierarchy**: Layout → Widget → Atomic
9. **Event prefixing**: Framework auto-prefixes events (emit simple names, listen with prefixes)
10. **No direct access**: Never access `.ds` or `.component` properties directly

## Widget Class Resolution

**Naming Convention:**

- Widget ID: kebab-case (`test-component`)
- Data Source: PascalCase + `DS` (`TestComponentDS`)
- Event Handler: PascalCase + `EH` (`TestComponentEH`)
- Framework converts kebab-case to PascalCase automatically
