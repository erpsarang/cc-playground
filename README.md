# cc-playground

Claude Code 워크플로를 Windows에서 연습하는 샌드박스 저장소.

## 목적

- **챕터 방식** 진행: 챕터 완료 → 확인 → 다음.
- 각 챕터는 `TASKS.md`의 Task로 관리.
- 우선순위: **정확성 > 명확성 > 속도**.

## 파일 구조

| 파일 | 역할 |
|------|------|
| `CLAUDE.md` | 프로젝트 규칙 (헌법) |
| `SOUL.md` | AI 페르소나 및 톤 |
| `USER.md` | 사용자 선호 설정 |
| `TOOLS.md` | 사용 가능한 도구/제약 |
| `AGENTS.md` | AI 역할 정의 |
| `KNOWLEDGE.md` | 프로젝트 결정 사항 기록 |
| `TASKS.md` | 연습 과제 목록 |
| `*.ps1` | PowerShell 연습 스크립트 |

## 시작하기

설치 여부를 가정하지 않는다. 먼저 확인 후 클론:

```powershell
git --version
pwsh --version          # PowerShell 7 우선 사용 (UTF-8 기본 지원)
git clone <저장소-URL>
cd cc-playground
```

규칙: `CLAUDE.md` / 과제: `TASKS.md` 참고.

## 실행 예시

**PowerShell**: 시스템 정보 수집

```powershell
pwsh -File .\Get-SystemInfo.ps1
pwsh -File .\Get-SystemInfo-KR-v2.ps1
```

**PowerShell**: 파일 구조 및 키워드 검색

```powershell
Get-ChildItem -Path *.md, *.ps1 | Format-Table Name, Length, LastWriteTime
Select-String -Path *.md -Pattern "UTF-8"
```

**Bash**: Git 상태 확인

```bash
git status && git log --oneline -5
```
