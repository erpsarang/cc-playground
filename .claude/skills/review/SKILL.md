---
name: review
description: "최근 변경사항을 짧고 안전하게 리뷰할 때 사용(긴 diff/로그 금지)."
---

규칙:
- 긴 diff/로그 붙여넣기 금지.
- 출력 <= 12줄.
- 포함 항목:
  1) 핵심 이슈(최대 5 bullets)
  2) 다음 행동(1 bullet)
  3) Risk level: low/med/high
- 가능하면 git diff --name-only, git diff --check 기반으로 판단.
- 명령 제안은 PowerShell 우선.

가능하면 참고: references/commands.md (안전한 리뷰 명령)

