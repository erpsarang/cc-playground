# cc-playground

Windows에서 Claude Code 워크플로를 실험하는 샌드박스.

## 핵심 원칙

**정확성 > 명확성 > 속도** — 챕터 단위로 진행하며, 과제는 `TASKS.md`로 관리한다.

## 사전 요구사항

```powershell
git --version          # Git
pwsh --version         # PowerShell 7 (UTF-8 기본)
claude --version       # Claude Code
```

## 구조

```
CLAUDE.md          ← 규칙 (헌법)
SOUL.md            ← AI 톤·페르소나
USER.md            ← 사용자 선호
TOOLS.md           ← 도구 제약
AGENTS.md          ← AI 역할
KNOWLEDGE.md       ← 결정 기록
TASKS.md           ← 과제 목록
DEBUG.md           ← 디버깅 기록
.claude/
  settings.json         ← 훅 설정
  agents/               ← 서브에이전트 (debugger, reviewer, doc-writer)
  commands/             ← 슬래시 커맨드 정의
  skills/               ← 슬래시 커맨드 스킬 (/prd, /mre, /review)
hooks/
  block-dangerous.ps1   ← PreToolUse: 위험 명령 차단
  quality-gate.ps1      ← Stop: 품질 검증
  post-edit-check.ps1   ← PostToolUse: 편집 후 자동 검사
mre/
  repro.ps1             ← MRE 재현 스크립트
*.ps1                   ← 연습 스크립트
```

## 시작

```powershell
git clone <저장소-URL>
cd cc-playground
```

## Hooks

Claude Code가 도구를 호출할 때 자동 실행되는 안전장치.

| 훅 | 시점 | 역할 |
|---|---|---|
| `block-dangerous.ps1` | PreToolUse (Bash) | `rm -rf`, `curl`, `git push` 등 위험 패턴 차단 |
| `quality-gate.ps1` | Stop | git diff check, 테스트, 컴파일 검증 |
| `post-edit-check.ps1` | PostToolUse (Edit/Write) | 편집 후 diff·whitespace 자동 검사 |

## Slash Commands

| 커맨드 | 설명 | 예시 |
|---|---|---|
| `/prd` | 1페이지 PRD 생성 | `/prd 로그인 기능 추가` |
| `/mre` | 최소 재현 예제 작성 | `/mre 인코딩 에러` |
| `/review` | 최근 변경사항 리뷰 | `/review` |

## 실행 예시

```powershell
# 시스템 정보
pwsh -File .\Get-SystemInfo.ps1

# 훅 테스트: 위험 명령 차단 확인
'{"input":{"command":"rm -rf /"}}' | pwsh -File .\hooks\block-dangerous.ps1
```
