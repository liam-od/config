# Writing Rules

Full rules from Prof. Engelbrecht, for use during writing reviews.

## Most commonly broken

- **WR4d** — No present continuous tense. "Optimisation of..." not "Optimising of...".
- **WR14** — No apostrophe possession. "The performance of the algorithm" not "the
  algorithm's performance".
- **WR19f** — No "In this section, X is discussed." Write "This section discusses X" or "X
  is discussed in this section."
- **WR28b** — Chapters and main sections must not open with body text followed by subsections.
  Start with purpose, context, and an outline; then subsections.

---

1. Use LaTeX to typeset the document.

2. Use a spell and grammar checker. AI tools may be used to improve linguistic quality.

3. Write in the third person. Do not use "we", "I", or "one".

4. Tenses:
   - a) Default: present tense.
   - b) Empirical process and discussion of observations: past tense.
   - c) Conclusions: past tense.
   - d) No present continuous tense. "Optimisation of the control parameters..." not
     "Optimising of the control parameters...".
   - e) References to published literature in past tense. E.g. "Engelbrecht showed that...".

5. Avoid pronouns such as "it, its, this, them, they, which" — they introduce ambiguity. Be
   specific.

6. Do not use uncertain terms such as "some" or "certain". Be specific.

7. Avoid "may be" and "can be" — these imply uncertainty.

8. Do not use "etc". Be complete and specific.

9. Avoid footnotes and clarifications in parentheses — they break reading flow. Footnotes only
   for URLs to code or datasets.

10. When text appears in parentheses, the reader must know why. Do not just give a figure/table
    number in parentheses. Prefer: "as indicated in Table 2" over "(Table 2)". If parenthetical,
    write "(refer to Table 2)".

11. Each concept must be defined before it is used.

12. Note: "it's" means "it is". Note the difference between the pronoun "its" and "it is".

13. Do not use contractions: "don't", "we're", etc.

14. Avoid apostrophe possession. "The performance of the algorithm" not "the algorithm's
    performance".

15. Note the difference between "to" and "too".

16. Note the difference between "amount" and "number of". "Number of" refers to countable
    objects; "amount" to non-countable.

17. Be careful with conjunctions such as "since", "because", "as".

18. Single-digit numbers in words; multi-digit numbers in numeric form.

19. Sentences:
    - a) Write in short, flowing sentences. One sentence, one fact. No more than one comma or
      conjunction per sentence.
    - b) Write in full sentences.
    - c) Do not start a sentence with a symbol or a number.
    - d) Each sentence should flow from the previous.
    - e) Do not start a sentence with a citation label.
    - f) Do not start a sentence with "In this section, X is discussed." Write "This section
      discusses X" or "X is discussed in this section."
    - g) Do not start a sentence with "And" or "But".
    - h) Each sentence must have a verb.

20. Paragraphs:
    - a) Each paragraph should flow from the previous.
    - b) One paragraph, one focus. Avoid both overly long and overly short paragraphs.

21. Equations:
    - a) Equations must flow as part of a sentence.
    - b) All symbols in an equation must be defined. Do not redefine symbols already defined.
    - c) Do not make forward references to equations.

22. Acronyms:
    - a) Each acronym must be defined.
    - b) List acronyms in an appendix in alphabetical order.
    - c) Do not use acronyms in headings or captions.
    - d) Once defined, use the acronym consistently. Use the LaTeX `glossaries` package.
    - e) In the conclusions chapter, redefine each acronym when first used.

23. Bibliography and citations:
    - a) Sort references alphabetically by first author surname.
    - b) Every reference in the bibliography must be cited in the text.
    - c) Use only initials and surnames — no full first names.
    - d) Do not cite pre-prints (arXiv, ResearchSquare, etc.). Find the published version.
    - e) Do not cite blogs.
    - f) Website references for code libraries and data archives go in footnotes, not the
      bibliography.
    - g) References must be complete and consistently formatted.
    - h) Conference proceedings source: "Proceedings of the [Full Conference Name]". Write
      names in full — no acronyms.

24. Citation style:
    - a) One author: "Engelbrecht showed that..."
    - b) Two authors: "Erwin and Engelbrecht showed that..."
    - c) Three or more authors: "Harrison *et al.* showed that..."
    - d) Use past tense.
    - e) When using numerical citations, sort citation numbers.

25. Figures:
    - a) Captions below the figure.
    - b) Font and size in figures must match the main text.
    - c) Captions are labels only — no detailed explanations. Explanations go in the main text.
    - d) Symbols in a figure may be defined in the caption.
    - e) Every figure must be referred to, introduced, and discussed in the main text.
    - f) For sub-figures, use the LaTeX `subfigure` environment with sub-captions. No headings
      per sub-figure.
    - g) Place a figure after its first reference in the text.
    - h) Avoid copying figures from literature. Provide original diagrams. If using figures
      from other sources, cite them.

26. Tables:
    - a) Captions above the table.
    - b) Captions are labels only.
    - c) Symbols may be defined in the caption.
    - d) Place a table after its first reference in the text.

27. Algorithms:
    - a) Use the LaTeX `algorithms` package.
    - b) Caption at the top of the algorithm.
    - c) Captions are labels only.
    - d) Symbols may be defined in the caption.
    - e) Place an algorithm after its first reference in the text.
    - f) Use pseudocode in plain English — no programming language syntax.

28. Chapters and sections:
    - a) Headings are labels only — no verbs, no questions.
    - b) Chapters and main sections must not have body text followed by subsections. Start
      with: purpose, context, outline of remainder. Then subsections.
    - c) A chapter or main section must not have only one subsection.
    - d) No forward references to sections/chapters, except in the outline of that section/chapter.
    - e) Do not start a chapter with a figure, table, or algorithm. Start with text.
    - f) End each chapter with a summary.
    - g) Start each chapter with a short paragraph stating context and purpose, followed by
      an outline.

29. Symbols:
    - a) All mathematical symbols must be in math mode (italics).
    - b) Do not overload symbols — one symbol, one meaning.
    - c) List all symbols and definitions in an appendix in alphabetical order.
    - d) Vectors: bold, lower case.
    - e) Matrices: bold, upper case.
    - f) Sets and sequences: upper case, not bold.
    - g) Functions: lower case, not bold.
    - h) Scalars: lower case, not bold.
    - i) Vector notation: (...)
    - j) Numerical ranges: [...]
    - k) Sets: {...}
    - l) Sequences, permutations, tuples: (...)
    - m) Superscripts and subscripts of vectors and matrices are not bold.
    - n) Avoid multi-character symbols for math and indices.
    - o) f(x) is the value of function f at point x. The function itself is f, not f(x).
    - p) Only define symbols not yet defined.

30. Latin words such as *et al* must be in italics.

31. Use either British or American English consistently throughout.

32. Singular vs plural:
    - "criterion" is singular; "criteria" is plural.
    - "optimum/minimum/maximum" are singular; "optima/minima/maxima" are plural.

33. In normal text, do not capitalise each word when defining acronyms. Capitalise only
    proper names.

34. Every statement or claim must be supported by a citation or empirical evidence provided in
    the document.

## LaTeX-specific formatting

- `\subsubsection{}` is the lowest permitted heading level.
- SI units and function names must not be in italics — use `siunitx`.
- Inline commands that produce text must be followed by `{}` or `\ ` to prevent
  space-gobbling — e.g. `\LaTeX{}` not `\LaTeX`, `\textbf{hello}` not `\textbf hello`.
  Standalone structural commands on their own line (`\mainmatter`, `\cleardoublepage`,
  `\phantomsection`, `\normalfont`, `\raggedbottom`, etc.) are exempt — the newline after
  them is a known false positive.
