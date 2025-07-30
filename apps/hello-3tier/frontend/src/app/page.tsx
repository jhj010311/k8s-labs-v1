'use client';

import {useEffect, useState} from "react";

export default function Home() {

    // useState -> select id="lang" value="(en/ko/jp 중에서 변화)"

    // api 주소 : NEXT_PUBLIC_API_URL + ?lang=(option)
    // 최종형태 예시 : http://localhost:8080/greeting?lang=ko

    const [lang, setLang] = useState('en'); // 선택된 언어
    const [message, setMessage] = useState(''); // API 응답 메시지

    const API_URL = process.env.NEXT_PUBLIC_API_URL;

    useEffect(() => {
        if (!API_URL) return;

        const fetchGreeting = async () => {
            try {
                const res = await fetch(`/api/greeting?lang=${lang}`);
                if (!res.ok) throw new Error('API 호출 실패');
                const data = await res.text();
                setMessage(data);
            } catch (error) {
                setMessage('에러 발생: ' + (error as Error).message);
            }
        };

        fetchGreeting();
    }, [lang]);

  return (
    <div>
        <div>hello-world by Next.js</div>
        <div>
            <select value={lang} onChange={(e) => setLang(e.target.value)}>
                <option value="en">en</option>
                <option value="kr">kr</option>
                <option value="jp">jp</option>
            </select>
        </div>
        <div style={{ marginTop: '1rem' }}>
            {message ? (
                <p>메시지: {message}</p>
            ) : (
                <em>로딩 중...</em>
            )}
        </div>
    </div>
  );
}
