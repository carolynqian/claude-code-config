# Anki Card Style Guide

## Principles

**Scannability**
- Use "s.t." (not "such that") — it's a visual parsing anchor.
- Bullet lists for multi-part conditions, not inline comma-separated.
- Add parenthetical context on Term names (e.g. "active constraint (of an optimization problem)").
- Lead definitions with short intuitive phrasing; put formal notation in the Equation/Formal Definition field.

**Review load**
- Group related blanks under the same cloze number (`{{c1::...}}`) to avoid extra review cards.
- Merge blanks when revealing one gives away the other.
- Prefer fewer dense cards over many atomic ones.

**Cloze design**
- Always use explicit `{{c1::...}}` syntax, never `{}` shorthand.
- Add `::hint` when the blank is ambiguous (e.g. `{{c1::$-t_i \le x_i \le t_i$::constraint}}`).
- For equations, hide the RHS after the `=` sign; keep the LHS visible as context.
- Don't create a blank if surrounding text makes the answer obvious.

**Definitions: trim aggressively**
- Cut filler words. If removing a word doesn't change meaning, remove it.
- Use the Symbol field for standard notation (e.g. `$B \leq A$` for reductions).
- Parenthesize important caveats that aren't part of the core definition (e.g. "(not required to be in $NP$ itself)").

**Information layering**
- Definition field: short, intuitive.
- Equation/Formal Definition field: the formal version of *this concept's* definition. Not related facts or relationships to other concepts — those go in Additional Content.
- Back Extra: can be verbose — shown only after answering, good for deeper explanations. For complex cards (reductions, proofs), include the "full question" walkthrough.
- Additional Content: supplementary context, phrasing notes, relationships to other concepts.

**Cloze context frontloading**
- Cloze cards must set the scene before the blanks. The reader needs to know what they're being asked about.
- Use bold headers (**Context:**, **Problem:**, **Reduction:**, **Solution:**) to structure the card.
- Define any terms inline before testing them (e.g. define Max Independent Set and Max Clique before asking about their reduction).
- For "classify X" clozes, use labeled hints indicating what dimension each blank tests (e.g. `::membership`, `::lower bound`, `::upper bound`).

## Card types

| Type | First field | Key fields |
|------|------------|------------|
| Math Definitions6 | Term | Subject, Definition, Symbol, Equation/Formal Definition, Additional Content |
| Math Theorems | Theorem | Subject, Condition(s), Theorem Statement, Intuition, Additional Content |
| Algorithms | Topic | Algorithm Name, Problem it Solves, Key Idea, Time/Space Complexity, Additional Notes |
| Cloze | Text | Back Extra |

## Reference examples

### Example 1: Definition — intuitive lead, formal separate
```
START
[USE THIS] Math Definitions6
interior point (of a set $\mathcal{X}$)
Subject: optimization / topology
Definition: A point $x \in \mathcal{X}$ not on the boundary of $\mathcal{X}$, i.e. an open ball around $x$ is entirely contained within $\mathcal{X}$ ($B_\varepsilon(x) \subseteq \mathcal{X}$).
Equation/Formal Definition (Optional): $x \in \mathcal{X}$ s.t.:
$\exists\, \varepsilon > 0$ s.t. $\{z : \|z - x\| < \varepsilon\} \subseteq \mathcal{X}$
Tags: math::applied::optimization math::analysis::real
END
```

### Example 2: Definition — concise, with Additional Content for phrasing/context
```
START
[USE THIS] Math Definitions6
finite extension field
Subject: algebra, fields / vector spaces
Definition: Field extension $E \supseteq F$ s.t. $E$ is a finite-dimensional vector space over $F$
Additional Content (Optional): In this case, $\dim_F(E)$ is called the *degree* of the extension, $[E : F]$

Phrasing: "E is a finite extension of F"
Tags: math::algebra::fields
END
```

### Example 3: Theorem — bulleted conditions
```
START
[USE THIS] Math Theorems
Optimum on the Boundary (linear objective over closed set)
Subject: optimization
Condition(s) (Optional):
* Objective is linear ($c^\top x$),
* Feasible set $\mathcal{X}$ is closed, and
* An optimal solution $x^\star$ exists. (Does **not** require convexity of $\mathcal{X}$.)
Theorem Statement: $x^\star$ lies on the boundary of $\mathcal{X}$.
Intuition (Optional): If $x^\star$ were interior, we could step in direction $-c$ by a small amount $\alpha = \varepsilon/(2\|c\|)$ and stay feasible while strictly decreasing $c^\top x$ — contradicting optimality.
Additional Content (Optional): Stronger version for LPs (linear constraints too): optimum lies at a **vertex** of the feasible polytope. This is why the Simplex method works.
Tags: math::applied::optimization
END
```

### Example 4: Cloze — grouped blanks, hint, verbose Back Extra
```
START
Cloze
optimization, problem transformation example:
The Lasso $\min_x \|Ax - b\|_2^2 +$ $\lambda\|x\|_1$ can be rewritten using slack variables as:
$\min_{x,t} \|Ax - b\|_2^2 +$ {{c1::$\lambda \sum_i t_i$}} subject to {{c1::$-t_i \le x_i \le t_i$::constraint}} for all $i$.
Back Extra: Replaces nondifferentiable absolute values with linear constraints. Cost: doubles problem dimension ($n$ extra variables).
More explanation - $|x|_1 = \sum_i |x_i|$ has nondifferentiable kinks (absolute values aren't smooth at zero), which makes standard optimization machinery choke. The rewrite replaces each $|x_i|$ with a fresh variable $t_i$ bounded by linear constraints — so now the objective and constraints are both smooth/linear. The tradeoff is doubling the problem dimension ($n$ extra variables).
Tags: math::applied::optimization
END
```

### Example 5: Algorithm — structured fields, bulleted problem list
```
START
Algorithms
Graph Algorithms
Algorithm Name: Bellman-Ford Algorithm
Problem it Solves:
* Single-source shortest path
* Arbitrary edge weights (handles negatives)
Key Idea: Relax all edges V−1 times.
Rationale: Safe because relaxation never worsens distances, and shortest simple paths use at most V−1 edges. If any distance decreases on iteration V, a negative cycle exists.
Time Complexity: $O(|V| \cdot |E|)$
Space Complexity: $O(|V|)$
Additional Notes (Optional): A key feature: detects negative weight cycles
Tags: compsci::algorithms::graphs::bellman_ford
END
```

### Example 6: Algorithm — concise key idea with comparison
```
START
Algorithms
Graph Algorithms
Algorithm Name: Breadth-First Search (BFS)
Problem it Solves:
* Single-source shortest paths (by edge count)
* Unweighted graphs
Key Idea: Layer-by-layer ("onion") exploration. Processes all vertices at distance d before d+1.
Time Complexity: O(V + E)
Space Complexity: O(V)
Additional Notes (Optional): Queue (FIFO)
Tags: compsci::algorithms::graphs::bfs
END
```

### Example 7: Definition — Symbol field, intuitive def + formal in Equation
```
START
[USE THIS] Math Definitions6
reduction (from problem $B$ to problem $A$)
Subject: complexity theory
Symbol (Optional): $B \leq A$
Definition: Using an algorithm for $A$ to solve $B$ with only poly-time overhead. Witnesses that $A$ is at least as hard as $B$.
Equation/Formal Definition (Optional): A pair of poly-time functions:
* **Reduction map** $R$: instance of $B$ → instance of $A$
* **Answer translation** $G$: answer of $A$ → answer of $B$
s.t. $b^* = G(\text{Solve}_A(R(b)))$ for every instance $b$.
Additional Content (Optional): Reductions compose: if $A$ reduces to $B$ and $B$ reduces to $C$, then $A$ reduces to $C$.
Tags: compsci::complexity::reductions
END
```

### Example 8: Definition — parenthesized caveat
```
START
[USE THIS] Math Definitions6
$NP$-hard
Subject: complexity theory
Definition: A problem $A$ s.t. every $B \in NP$ has a poly-time reduction to $A$ (not required to be in $NP$ itself).
Additional Content (Optional): $NP\text{-complete} = NP \cap NP\text{-hard}$.
$NP$-hard problems can be strictly harder than anything in $NP$ (e.g. the Halting Problem is $NP$-hard but undecidable, so not in $NP$).
Tags: compsci::complexity::definitions
END
```

### Example 9: Cloze — context frontloading with term definitions
```
START
Cloze
complexity theory, reductions:

**Max Independent Set**: largest subset of vertices s.t. no two are adjacent.
**Max Clique**: largest subset of vertices s.t. every pair is adjacent.

**Reduction:** Max Clique reduces to Max Independent Set via {{c1::the complement graph $\bar{G}$::transformation}} — $S$ is an independent set in $G$ iff {{c1::$S$ is a clique in $\bar{G}$}}.

Back Extra: **Why it works:** $S$ independent in $G$ means no pair in $S$ is an edge of $G$. By definition of $\bar{G}$ (same vertices, flipped edges), every pair in $S$ *is* an edge of $\bar{G}$, i.e. $S$ is a clique. The reduction is symmetric.

**Full question:** Given that Max Independent Set has an efficient algorithm, how do you solve Max Clique? Answer: (1) compute $\bar{G}$ by flipping all edges, (2) run Max Independent Set on $\bar{G}$, (3) return the result — it's a clique in $G$.
Tags: compsci::complexity::reductions
END
```

### Example 10: Cloze — "classify X" with labeled hints
```
START
Cloze
complexity theory:

**Context:** Under $P \neq NP$, the landscape of $NP$ has three zones: $P$, $NP$-complete, and an "intermediate" region ($NP \setminus (P \cup NPC)$).

**Factoring** (given integer $n$, find a non-trivial factor) is the canonical conjectured example of an intermediate problem:
* {{c1::In $NP$::membership}} — given a candidate factor, just multiply and check.
* Probably {{c1::not in $P$::lower bound}} — no known poly-time algorithm.
* Probably {{c1::not $NP$-complete::upper bound}} — no known reduction from all of $NP$.

Back Extra: This is the hardness assumption underlying **RSA cryptography**. If factoring were in $P$, RSA breaks. If factoring were $NP$-complete, proving $P \neq NP$ would automatically prove factoring is hard — but no such reduction is known.
Tags: compsci::complexity::definitions
END
```

### Example 11: Cloze — grouped to reduce reviews
```
START
Cloze
optimization, conventions:
If the feasible set of a minimization problem is empty, then $p^\star =$ {{c1::$+\infty$}}.
For a maximization problem with empty feasible set, $p^\star =$ {{c1::$-\infty$}}.
Tags: math::applied::optimization
END
```
