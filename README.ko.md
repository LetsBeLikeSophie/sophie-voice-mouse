# Sophie Voice Mouse

**마우스 가운데 버튼을 누른 채 말하고 떼면, 커서가 있는 곳에 글이 입력돼요.**

Sophie Voice Mouse는 지금 쓰는 마우스를 윈도우용 음성 입력 장치로 바꿔줘요. AI와 대화할 때를 위해 만들었어요. 프롬프트는 말로 하고, 에러 메시지나 문단은 톡 눌러 담아서 키보드 없이 같이 보낼 수 있어요.

[English README](README.md)

## 사용법

| 이렇게 하면 | 이렇게 돼요 |
|---|---|
| 가운데 버튼 **누른 채 말하고 떼기** | 말한 문장이 커서 위치에 입력 |
| 글을 드래그하고 **짧게 톡** | 그 글을 담아둠 (여러 번 담기 가능) |
| 담아둔 상태에서 **누른 채 말하기** | 말한 문장 + 담아둔 글이 같이 입력되고, 담은 건 비워짐 |
| 글을 드래그한 채 바로 **길게 누르기** | 말한 문장 + 선택한 글이 같이 입력 |
| 아무것도 선택 안 하고 **짧게 톡** | 원래 가운데 클릭 (새 탭 열기 등) |

예) 웹페이지에서 에러 메시지를 긁고 **톡** → AI 채팅 입력창 클릭 → 누른 채 "이거 왜 나는지 알려줘" → 떼면:

```
이거 왜 나는지 알려줘.

TypeError: cannot read property 'map' of undefined
```

커서 옆에 작은 표시가 떠서 듣는 중인지, 글이 몇 개 붙는지, 처리 중인지, 끝났는지 보여줘요.

## 특징

- **어떤 프로그램에서든** 돼요. 채팅창, 편집기, 메일, 문서 다요.
- **어떤 언어든** 말하는 언어를 자동으로 알아들어요.
- **문장부호를 알아서** 넣어요. API 키가 있으면 AI가 `? ! , .`를 넣고 "음, 어"를 빼요. 말한 내용은 바꾸지 않아요.
- **내 키로 써요.** Claude, OpenAI, Gemini 중 아무거나요. 키만 보고 회사를 자동으로 알아내요.
- **기본이 프라이버시 우선이에요.** 음성 인식은 내 PC에서 돌아서 녹음이 밖으로 나가지 않아요.

## 다운로드와 실행

### 방법 A: 완성된 앱 (파이썬 필요 없음)

1. [Releases](../../releases)에서 `SophieVoiceMouse-windows.zip`을 받아 압축을 풀어요.
2. `SophieVoiceMouse.exe`를 더블클릭해요.
3. 아직 코드 서명이 없어서 "Windows의 PC 보호" 창이 뜰 수 있어요. **추가 정보 → 실행**을 누르면 돼요.

### 방법 B: 소스로 실행

1. [Python 3.10 이상](https://www.python.org/downloads/)을 설치해요. 설치 화면에서 **"Add python.exe to PATH"를 꼭 체크**하세요.
2. 이 저장소를 내려받고 `run.bat`을 더블클릭해요. 첫 실행 때 필요한 걸 알아서 설치해요.

첫 실행 때 음성 인식 모델(약 500MB)을 내려받느라 몇 분 걸려요. 그다음부터는 몇 초면 켜져요.

## API 키 (선택)

처음 실행하면 API 키를 물어봐요. 아래 중 아무 키나 붙여넣으면 돼요.

| 회사 | 키 시작 | 발급 | 기본 모델 |
|---|---|---|---|
| Claude | `sk-ant-` | [console.anthropic.com](https://console.anthropic.com/settings/keys) | `claude-haiku-4-5-20251001` |
| OpenAI | `sk-` | [platform.openai.com](https://platform.openai.com/api-keys) | `gpt-5.4-nano` |
| Gemini | `AIza` | [aistudio.google.com](https://aistudio.google.com/apikey) | `gemini-3.5-flash-lite` |

- 키는 **Windows 자격 증명 관리자**에 저장돼요. 파일로 남지 않아요.
- 사용료는 키 주인 계정으로 청구돼요. 이 소형 모델들로 문장 하나 정리하는 비용은 아주 적어요.
- **건너뛰어도** 동작해요. 인식된 그대로 입력돼요.
- 키 바꾸기: `Change API key.bat`(앱) 또는 `run.bat --set-key`(소스). 키 지우기: `--clear-key`.

## 프라이버시

- **음성**은 [faster-whisper](https://github.com/SYSTRAN/faster-whisper)로 내 PC에서 받아써요. 업로드되지 않아요.
- **받아쓴 문장**은 키를 넣은 경우에만, 문장부호 정리를 위해 내가 고른 AI 회사로 보내져요.
- **선택하거나 담은 글**은 내 PC에서 붙여넣기만 하고, AI로 **보내지 않아요.**
- 선택한 글을 가져올 때 클립보드를 잠깐 쓰고, 원래 있던 글로 되돌려놔요.

## 설정

`sophie_voice_mouse.py` 위쪽 `Settings` 부분에서 바꿀 수 있어요.

| 설정 | 하는 일 |
|---|---|
| `MODE` | `"clean"`(말한 그대로 + 문장부호 정리, 기본) / `"dictate"`(AI 안 씀) / `"prompt"`(프롬프트로 다듬기) |
| `LANGUAGE` | `None` = 자동 감지, 또는 `"ko"`, `"en"`처럼 고정 |
| `UI_LANG` | `None` = 윈도우 언어 따라감, 또는 `"ko"` / `"en"` |
| `SELECTION_POSITION` | 붙는 글을 말한 문장 `"after"`(뒤) / `"before"`(앞)에 |
| `MODELS` | 회사별로 쓸 모델 |
| `WHISPER_MODEL` | `"base"` = 빠름, `"medium"` = 더 정확 |
| `WHISPER_DEVICE` | NVIDIA 그래픽카드가 있으면 `"cuda"` (훨씬 빠름) |

## 알아두면 좋은 점

- **터미널**(명령 프롬프트, PowerShell, Windows Terminal)에서는 Ctrl+C가 "실행 중지"라서 자동 복사를 하지 않아요. 직접 복사해 주세요.
- 길게 누르기를 녹음에 쓰기 때문에 브라우저의 **가운데 버튼 자동 스크롤**은 안 돼요.
- 페이지에 글이 선택된 채로 링크를 가운데 클릭하면 새 탭 대신 그 글이 담겨요. 선택을 풀고 누르세요.
- **관리자 권한 창**에는 윈도우가 입력을 막아요. 필요하면 Sophie Voice Mouse도 관리자 권한으로 실행하세요.
- 마우스·키보드를 감지하는 프로그램이라 일부 백신이 경계할 수 있어요. 전체 코드가 공개돼 있으니 직접 확인할 수 있어요.

## 문제 해결

- **버튼을 눌러도 반응이 없어요** → 누를 때마다 검은 창에 `▶ 가운데 버튼 감지`가 찍혀야 해요. 안 찍히면 로지텍 같은 마우스 프로그램에서 가운데 버튼을 다른 기능에 지정했는지 확인하세요.
- **녹음이 안 돼요** → 설정 → 개인 정보 및 보안 → 마이크 → "데스크톱 앱이 마이크에 액세스하도록 허용" 켜기.
- **느려요** → `WHISPER_MODEL = "base"`로 바꾸거나, NVIDIA 그래픽카드가 있으면 `"cuda"`를 쓰세요.

## 직접 빌드하기

`v0.1.0` 같은 태그를 올리면 GitHub Actions가 `SophieVoiceMouse-windows.zip`을 만들어 릴리스에 붙여줘요. [.github/workflows/build.yml](.github/workflows/build.yml)을 보세요.

## 라이선스

[MIT](LICENSE)
