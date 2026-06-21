# Ousterhout Philosophy of Software Design

A set of design principles from John Ousterhout's *A Philosophy of Software Design* that guide how this project manages complexity.

## Core Principles

### Deep Modules

The most important idea. A **deep module** provides powerful functionality through a **simple interface**. The interface cost (what users must learn) should be much smaller than the implementation complexity. Shallow modules (where interface is as complex as implementation) should be avoided.

### Information Hiding

Implementation details should be hidden behind module interfaces. Hidden information may include data representations, algorithms, hardware details, and design decisions likely to change. What cannot be hidden (the interface) should be as simple as possible.

### Strategic vs. Tactical Programming

- **Tactical**: Focus on getting today's feature working quickly. Accumulates complexity.
- **Strategic**: Invest time in good design, even if it slows short-term velocity. Pays off over the project lifetime.

This project expects **strategic** thinking.

### Complexity is Incremental

Each small compromise adds a little complexity. Individually they seem harmless, but they accumulate into an unmanageable system. Every patch should leave the system slightly better — or at minimum, no worse.

### Define Errors Out of Existence

The best way to handle errors is to design APIs and abstractions so that the error condition cannot arise. Exceptions should be exceptional — not part of normal control flow.

### Pull Complexity Downward

When some complexity is unavoidable, handle it inside the module rather than pushing it to the module's users. A slightly more complex implementation is acceptable if it keeps the interface simple.

### Different Layers, Different Abstractions

Each software layer should provide a different abstraction. Adjacent layers should not expose similar abstractions — that indicates the layers are not pulling their weight and should be merged.

### Design It Twice

Before settling on a design, explore at least two alternative approaches. The first approach is rarely the best, and the comparison reveals insights that lead to a stronger final design.

### Comments Describe What Isn't Obvious

Good code comments explain things that aren't obvious from the code itself: design rationale, non-obvious side effects, abstraction intent, and why a particular approach was chosen over alternatives. Comments are not a substitute for clean code, but they are essential for conveying design intent.

## Project Convention

This project follows Ousterhout's philosophy as its primary design principle. All design decisions should favor deep modules, simplicity of interface, and strategic investment in good abstractions.

Related: [[conventional-commits]]
