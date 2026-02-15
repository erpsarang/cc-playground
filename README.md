# cc-playground

Windows에서 Claude Code 워크플로를 실험하는 샌드박스.

## 핵심 원칙

**정확성 > 명확성 > 속도** — 챕터 단위로 진행하며, 과제는 `TASKS.md`로 관리한다.

## 구조

```
CLAUDE.md        ← 규칙 (헌법)
SOUL.md          ← AI 톤·페르소나
USER.md          ← 사용자 선호
TOOLS.md         ← 도구 제약
AGENTS.md        ← AI 역할
KNOWLEDGE.md     ← 결정 기록
TASKS.md         ← 과제 목록
hooks/
  block-dangerous.ps1   ← PreToolUse 훅: 위험 명령 차단
  quality-gate.ps1      ← Stop 훅: 품질 검증
*.ps1            ← 연습 스크립트
```

## 시작

```powershell
git --version
pwsh --version          # PowerShell 7 권장 (UTF-8 기본)
git clone <저장소-URL>
cd cc-playground
```

## Hooks

Claude Code가 도구를 호출할 때 자동 실행되는 안전장치.

| 훅 | 시점 | 역할 |
|---|---|---|
| `block-dangerous.ps1` | PreToolUse (Bash) | `rm -rf`, `curl`, `git push` 등 위험 패턴 차단 |
| `quality-gate.ps1` | Stop | git diff check, 테스트, 컴파일 검증 |

## 실행 예시

```powershell
# 시스템 정보
pwsh -File .\Get-SystemInfo.ps1

# 파일 구조 확인
Get-ChildItem *.md, *.ps1 | Format-Table Name, Length, LastWriteTime

# Git 상태
git status && git log --oneline -5
```
