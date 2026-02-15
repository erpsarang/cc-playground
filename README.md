# cc-playground

Claude Code 워크플로를 Windows 환경에서 연습하기 위한 샌드박스 저장소.

## 이 레포로 무엇을 연습하나?

- **챕터 방식**으로 진행: 하나의 연습 단위(챕터)를 완료하고 확인받은 뒤 다음으로 넘어간다.
- 각 챕터는 TASKS.md에 정의된 Task로 관리한다.
- 목표 우선순위: **정확성 > 명확성 > 속도**.

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

### 사전 조건 확인

설치 여부를 가정하지 않는다. 아래 명령으로 먼저 확인한다.

```powershell
git --version
pwsh --version
```

### 저장소 클론

```powershell
git clone <저장소-URL>
cd cc-playground
```

## 실행 예시

**예시 1**: 시스템 정보 수집 스크립트 실행

```powershell
pwsh -File .\Get-SystemInfo.ps1
```

**예시 2**: 한국어 버전 시스템 정보 스크립트 실행

```powershell
pwsh -File .\Get-SystemInfo-KR-v2.ps1
```

## 실행 예시 (Bash)

**예시 1**: Git 상태 및 최근 커밋 확인

```bash
git status && git log --oneline -5
```

```powershell
# PowerShell 동등
git status; git log --oneline -5
```

**예시 2**: 프로젝트 파일 구조 확인

```bash
ls -la *.md *.ps1
```

```powershell
# PowerShell 동등
Get-ChildItem -Path *.md, *.ps1 | Format-Table Name, Length, LastWriteTime
```

**예시 3**: 특정 키워드로 프로젝트 파일 검색

```bash
grep -rn "UTF-8" *.md
```

```powershell
# PowerShell 동등
Select-String -Path *.md -Pattern "UTF-8"
```

## 참고

- PowerShell 7(`pwsh`)을 우선 사용한다. UTF-8 기본 지원으로 한국어 처리에 유리하다.
- 자세한 규칙은 `CLAUDE.md`, 연습 과제는 `TASKS.md`를 참고한다.
