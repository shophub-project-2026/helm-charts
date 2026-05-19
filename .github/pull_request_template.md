## Opis promene
Molimo detaljno opišite koje izmene donosi ovaj PR (koji chart-ovi su menjani, koji values, koji CRD-jevi).

## Vrsta promene
Označite vrstu izmene:
- [ ] `feat`: Nov chart ili nova funkcionalnost u postojećem chart-u
- [ ] `fix`: Ispravka greške u chart template-u, values-u ili CRD-u
- [ ] `chore`: Bump verzije charta, ažuriranje zavisnosti
- [ ] `docs`: Dokumentacija (README, NOTES, komentari)
- [ ] `refactor`: Restrukturiranje template-a bez funkcionalne promene

## Chart verzionisanje
- [ ] `Chart.yaml -> version` je inkrementovan po SemVer (ako su menjani template-i ili values).
- [ ] `Chart.yaml -> appVersion` je inkrementovan ako je nova verzija aplikacije.

## Checklist
- [ ] `helm lint charts/<chart>` lokalno prolazi.
- [ ] `helm template charts/<chart>` renderuje bez grešaka.
- [ ] Novi CRD-jevi su u `crds/`, ne u `templates/`.
- [ ] Commit poruke prate Conventional Commits format.
- [ ] README chart-a je ažuriran ako su menjani values.

## Povezani tiketi/issues
(Npr. Resolves #123)
