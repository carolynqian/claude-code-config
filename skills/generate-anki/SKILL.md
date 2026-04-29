---
name: generate-anki
description: Generate Anki flashcards from lecture notes in the Obsidian vault. Usage - /generate-anki <lecture file or number> [deck=DeckName]
---

Generate Anki flashcards from a lecture note in the Obsidian vault. Do the following:

1. **Read the style guide** at `~/.claude/skills/generate-anki/anki-card-style-guide.md`. Follow its principles and match the tone/format of the reference examples exactly.

2. **Resolve the lecture file.** The user provides a lecture file path, filename, or describes the file. Confirm the resolved path with the user before proceeding.

3. **Read the lecture notes** in full.

4. **Check for existing Anki cards** to avoid duplicates:
   - Check if an `- Anki.md` file already exists for this lecture in the same directory.
   - Query AnkiConnect (`curl -s localhost:8765`) to find cards in the relevant deck tagged with this lecture's topics.
   - If duplicates exist, note them and skip or differentiate.

5. **Generate cards** using these card types (prefix with `[USE THIS]` for definitions and theorems):
   - `[USE THIS] Math Definitions6` — for definitions, concepts, named objects
   - `[USE THIS] Math Theorems` — for theorems, lemmas, propositions, named results
   - `Algorithms` — for named algorithms (problem, key idea, complexity)
   - `Cloze` — for formulas, procedures, conceptual fill-in-the-blank, derivation steps

   Guidelines for card selection:
   - Cover key definitions, theorems, and important formulas/derivations
   - Include conceptual "why" cards (e.g. why a technique works, why a model is chosen)
   - Skip announcements, logistics, and trivial observations
   - Aim for 8–15 cards per lecture — enough to cover the material without excessive review load

6. **Write the output file** as `{lecture filename} - Anki.md` in the same directory as the lecture note. Structure:
   ```
   ---
   up:
     - "[[{folder note name}]]"
   type: anki
   ---

   TARGET DECK: {deck name, default "1. Academic::EECS127" or "1. Academic::CS170"}
   FILE TAGS: {e.g. class::eecs127}

   ### 1. {Card title}

   START
   ...
   END

   ### 2. {Card title}

   START
   ...
   END
   ```
   Use `### N. Title` headings above each card for navigation. The user specified a `deck=` argument, use that; otherwise infer from the class.

7. **Tags**: Use hierarchical tags matching existing conventions:
   - `class::eecs127` or `class::cs170`
   - `math::applied::optimization::convexity`, `math::algebra::linear::SVD`, etc.
   - Match the topic granularity of existing cards in the deck.

8. **Report** what you created: card count, types used, and any existing cards you skipped due to overlap.

Do NOT sync with Anki (don't click the plugin or trigger a sync). The user will review and modify cards first.
