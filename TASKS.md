# TASKS.md

## Prompt Template (Explore → Plan → Execute → Verify)

규칙:
- Explore(탐색): 변경 없이 파일 읽기/질문만. 필요한 @파일/폴더를 먼저 요청.
- Plan(계획): 6줄 이내. 선택지는 최대 2개.
- Execute(실행): 필요한 파일만 변경. 작은 단위로.
- Verify(검증): 테스트/명령 실행 결과 또는 체크리스트로 증거 제시.
- Hypotheses: 불확실할 땐 가설 최대 3개 + 각 가설 검증 명령 1개(PowerShell).

## Task 001 - README 초안 작성

### 1) Goal (한 문장)
이 저장소의Claude Code 연습용)의 목적과 사용 방법을 1분 안에 이해할 수 있는 README를 만든다.

### 2) Non-Goals (하지 않을 것)
- 실제 배포/배포 스크립트 작성은 하지 않는다.
- 도구 설치 가이드는 링크만 두고 상세 설치는 다루지 않는다.

### 3) Deliverables (산출물 목록)
- README.md (신규)

### 4) Acceptance Criteria (통과 조건)
- 한국어로 작성
- 섹션은 6개 이내
- “이 레포로 무엇을 연습하는지(챕터 방식)”가 명확히 드러남
- Windows(PowerShell) 기준으로 실행 예시 2개 포함
- 60초 스캔해도 이해되는 구조(짧은 문장/불릿)

### 5) Constraints (환경/도구/제약)
- Windows + PowerShell 우선
- 설치 여부 가정 금지(버전 확인 명령 선제시)

### 6) Steps (예상 작업 순서)
1) 현재 파일 구조 파악
2) README 목차 제안
3) README 초안 작성
4) 간단한 실행 예시 추가
5) 체크리스트로 자체 검수

### 7) Risks / Open Questions (리스크/질문)
- 사용자가 WSL을 쓰는지 확실치 않음 → PowerShell 우선, WSL은 옵션으로만 표기
