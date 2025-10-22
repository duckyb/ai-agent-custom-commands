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

```html
<test-component
  [data]="lb.widgets['test'].ds.out$ | async"
  (emit)="lb.widgets['test'].emit($event.type, $event.payload)"
>
</test-component>
```

**Required:** Single `[data]` input, single `(emit)` output

### Event Naming Convention

Events auto-prefixed with widget ID: `widget-1.event-name`

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

### ❌ **Bypassing Event System**

```typescript
// WRONG: Direct method calls
this.lb.widgets["search-bar"].eventHandler.handleSearch(query);

// CORRECT: Event-driven communication
this.emitOuter("search", { query });
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
  template: `<es-dropdown-select [emit]="subjectsEmit"></es-dropdown-select>`
})
export class Component {
  @Input() subjectsEmit: any; // ❌ Multiple inputs
  @Input() measuresEmit: any; // ❌ Violates contract
}

// CORRECT: Place widgets in layout template
<es-dropdown-select [emit]="lb.widgets['subject-select'].emit"></es-dropdown-select>

// OR: Implement custom UI directly
@Component({
  template: `<div (click)="onClick()">Custom dropdown</div>`
})
export class Component {
  @Input() data: any; // ✅ Single input
  @Output() emit = new EventEmitter<any>(); // ✅ Single output
}
```

## Key Principles

1. **Use framework methods**: `this.one().update()`, `this.some().update()`, etc.
2. **Event-driven architecture**: Use `emitInner()`, `emitOuter()`, `emitGlobal()`
3. **Respect data transformation**: Let data sources handle processing through `transform()`
4. **Keep widgets encapsulated**: Don't access widget internals directly
5. **Use reactive streams**: Leverage `out$` BehaviorSubject for data flow
6. **Follow naming conventions**: Let framework resolve classes automatically
7. **Keep components simple**: Single `[data]` input and `(emit)` output
8. **Place widgets in layout**: Don't nest widgets inside components

## Widget Class Resolution

**Naming Convention:**

- Widget ID: kebab-case (`test-component`)
- Data Source: PascalCase + `DS` (`TestComponentDS`)
- Event Handler: PascalCase + `EH` (`TestComponentEH`)
- Framework converts kebab-case to PascalCase automatically
