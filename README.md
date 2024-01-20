# 뉴스 앱
| ![Simulator Screenshot - iPhone 15 Pro Max - 2024-01-20 at 19 18 23](https://github.com/EJLee1209/CodingTest/assets/101651909/1d29689e-0a2f-4f67-b7da-5cb1fd153fc8) | ![Simulator Screenshot - iPhone 15 Pro Max - 2024-01-20 at 19 20 42](https://github.com/EJLee1209/CodingTest/assets/101651909/22a77785-e95a-4eda-92de-44ea8c81f8d1) |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
## 프로젝트 한 줄 소개

- 한국, 미국, 일본의 헤드라인 뉴스를 한 눈에 확인할 수 있고, 검색할 수 있는 뉴스 앱

## 프로젝트 목적

- `Clean Architecture + MVVM` 를 실제 프로젝트에 적용하고, 기존의 MVVM 패턴과 비교했을 때, 어떠한 장단점이 있는가를 체득하기 위함
- `Coordinator` 패턴을 함께 사용해보면서 ViewController 의 화면 전환 로직을 완전히 분리함으로써 더 클린한 코드를 작성하기 위함
- `Open Api` 를 사용하여 JSON 형태의 데이터를 원하는 형태의 Swift 데이터 모델로 자유자재로 변환할 수 있도록 학습하기 위함

## 아키텍처
![뉴스앱아키텍처 drawio](https://github.com/EJLee1209/NewsApp/assets/101651909/5ad3daeb-dae7-40ff-8e4e-24bcc2779af0)

> 클린 아키텍처

- Domain Layer: 앱의 비즈니스 로직을 포함합니다. (UseCase, Entity, Repository Interface)
- Presentation Layer: 사용자와 직접적으로 상호작용 하는 계층으로, UI와 관련된 작업을 담당합니다. (ViewController, ViewModel)
- Data Layer: 애플리케이션의 데이터에 관련된 모든 작업을 처리하는 계층입니다. 네트워크 통신, 로컬 DB가 이 계층에 포함됩니다. (Repository, DTO)

> 코디네이터 패턴

- 화면 전환 로직을 ViewController 에서 완전히 분리하여 상위 객체인 Coordinator 에게 위임하였습니다.
- ViewController 는 오로지 UI 와 관련된 로직에만 집중할 수 있습니다.

> 의존성 주입

- 앱의 의존성 주입을 모두 AppDIContainer 가 관리합니다.

## 개발 환경

![Generic badge](https://img.shields.io/badge/iOS-15.0+-lightgrey.svg) ![Generic badge](https://img.shields.io/badge/Xcode-15.0.1-blue.svg) ![Generic badge](https://img.shields.io/badge/Swift-5.9.0-purple.svg)

## 사용 라이브러리
- **Combine**: Reactive Programming
- **Snapkit**: AutoLayout
- **SDWebImage**: Image download & caching

