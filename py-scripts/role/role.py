import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Firebase 프로젝트에서 생성한 서비스 계정 키를 지정하여 인증
cred = credentials.Certificate('../../pocketgpt-7a3f1-firebase-adminsdk-te2ee-e7d013a06c.json')
firebase_admin.initialize_app(cred)

# Firestore DB 연결
db = firestore.client()

# 콜렉션 이름
collection_name = "role_chats"

roles = []
# role.json 파일 열기
def create_or_update():
    with open("role.json", "r") as file:
        data = json.load(file)

    # 필수 필드 목록
    required_fields = ["category", "role", "title", "description", "system_message"]

    # role_chats 컬렉션에 데이터 추가 또는 업데이트
    for item in data:
        roles.append(item["role"])
        # 모든 필수 필드가 데이터에 있는지 확인
        if all(field in item for field in required_fields):
            # role을 문서 ID로 사용
            doc_id = item["role"]

            # 기존 문서 참조
            doc_ref = db.collection(collection_name).document(doc_id)

            # 데이터 저장 또는 업데이트
            doc_ref.set(item, merge=True)
            print(f"Document '{doc_id}' created or updated.")
        else:
            print(f"Missing required fields in item {item}. Skipping.")

    print(roles)


if __name__ == "__main__": 
    create_or_update()

    print('||완료||')





