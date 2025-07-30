import { NextRequest, NextResponse } from 'next/server';

const API_URL = process.env.NEXT_PUBLIC_API_URL;

export async function GET(req: NextRequest) {
    const lang = req.nextUrl.searchParams.get('lang') || 'en';
    const url = `${API_URL}?lang=${lang}`;

    try {
        const res = await fetch(url);
        const text = await res.text();
        return new NextResponse(text, { status: res.status });
    } catch (err) {
        return new NextResponse('Spring Boot 호출 실패', { status: 500 });
    }
}