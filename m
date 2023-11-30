Return-Path: <linux-btrfs+bounces-449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357687FE968
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 07:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673E51C20A33
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 06:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770618E01;
	Thu, 30 Nov 2023 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i5MbYcBH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34E10DE
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 22:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701327375; x=1701932175; i=quwenruo.btrfs@gmx.com;
	bh=vli8Yy/etDa/dc6xFy+my+cjtsgObQgpDzYX5eEnSA8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=i5MbYcBH5GyRHn33hLGHMM5W64isWKd6zg8k5zxPxsx/NRblvDv5FyMmkRINcoIK
	 3L4bV/EQ30zwH9zqgF7L3vENCxDxddcrVhw/SvapNjZ0/FH+yDdmU5Q7ki6dlJZXV
	 EPKHxXCudNgF3G40qAn2RWL2/nC8FvkevcwmhbdDJBv1SGajj+wvttn647+Ndf0/X
	 xqelmmxP/5dtOuM3SjX/5fuudWqydspMK9nCjRFamvZBOs87DqSxrXKZadHoezLs8
	 mtSkEItBqALJEGdnjoRQWYa47GdAkS0XGlxX11U7KPODzxo8skf0SGrB0jQ+SGIRE
	 D6p9XKf7M7mUbGTK3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1rfPMP3Mtb-00oaWl; Thu, 30
 Nov 2023 07:56:15 +0100
Message-ID: <9e8ba9d7-34b2-4918-a4e9-2aaa3464d9ee@gmx.com>
Date: Thu, 30 Nov 2023 17:26:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Content-Language: en-US
To: dsterba@suse.cz
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
 <20231127163236.GF2366036@perftesting>
 <84df53e7-7034-4aba-a35a-143960d626a3@gmx.com>
 <20231129160217.GT18929@twin.jikos.cz>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231129160217.GT18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5Oqf6L0O8/Uq0fH/4WbPj1zCXuwQBCC6bCehmeTio9i3J9S5/gf
 fXOcwbmZGreAGjfNrVo3QjJ+55asMpr3ZGhURANysARKYwlcb3bXQbcDAunfDMdsnhPS1qo
 NUf7J7cGN+8tvOyBoLDiQ1Rosxkn1kE2eS0AB1KAY4jweMbdVF2yY9t64qZCHsQ895t2/+Y
 pY9Ahu8z8ceRvTQC3lBCA==
UI-OutboundReport: notjunk:1;M01:P0:gDiOcPnHwC0=;iwfOetKO7dvC/l2mxG9n7OxWTkz
 3rmhDguabF/dxyPondnbXwc54pNo3WUUyq8zS89r+wIlcmM5NXLXJODeYPHdt7VvCo7O9fJNs
 9wKiXfbVNSnZs6P/ZS6k/5ATlZkDbaCZJ+/HopkEubCAu6vrcE1G9mwkpciL1MlwhYnQ1RQch
 LngXrYfbeWw1XLgWSiyyryPK0guFidaUTO+mceM/wsZukZuea5TQpqLmlHXejKT4HjDBxNvb3
 XuI6aSQkBY8YAtMw8hhcBVyLdQZoR7FzoRSMu8p5ABj0et1/Wh51HIBVqu33zQ9j6UYJdVTJL
 hCvQjWEgrD8mDMoRi5Kk+KoPDzkLtxkHC49DTLyRyFWtIGvUsnqT4duPAhgV1rFjfXhDYoLBn
 nbp2X1TwSDl/hrvrkx5pJGe562V9TFr+M6Kzqce8s9vZhaWHsIGrUtK21fvHTjwCexGKYzpGa
 CxDI/38kts8YM+Lg598/ADGZVm5w2uC9vJqykL8VPRkX8BkDCy9qwtLQ/S0C7K8qxdwiKUVjH
 pjdoix/VjS6dfAA17rsGcHOlVx8ZjzZfectQGfK1wFEgpU9owrXNQaJVtMazn5QKcG54og/Gj
 Y8AjvYQrqWbIb4jxE5heLutds0v5qwhDTp9IEDh6nuTIW4bQSA7TRwSiYULGKgGTzZB72dYEv
 18M49xIBYbj+v0r4JXRnnfpRXa49HbP4fj26yFnNU+4YdmKsMOqNIvRRnhFGpwxMMo94XjN22
 WaYQ/WVwkKcuUwOtEP0jOwp1rTPH6t4rjkgW8gAMEubp5Ahbx8vjYTPjcNJXqXrAWnb4NM7Zn
 25mHI0dKnxyPUFR0GMKTXw0kxe/y3hMjVpsqvtt6XBBApnV/HMrQzwurNi7AjEgcQQAsZRIFU
 CMflzZ802pQ9kczujXt5j799/pX7xItcOQ6PeMKVn9lB55eEmpvvaVncd220nIQS1UbrCg1cz
 5z9PY3qwDkvi14kRSMM7EJ2IHK4=



On 2023/11/30 02:32, David Sterba wrote:
> On Tue, Nov 28, 2023 at 08:47:33AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/11/28 03:02, Josef Bacik wrote:
>>> On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
>>>> For now extent_buffer::pages[] are still only accept single page
>>>> pointer, thus we can migrate to folios pretty easily.
>>>>
>>>> As for single page, page and folio are 1:1 mapped.
>>>>
>>>> This patch would just do the conversion from struct page to struct
>>>> folio, providing the first step to higher order folio in the future.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> This doesn't apply to misc-next cleanly, so I can't do my normal revie=
w, but
>>> just swapping us over to the folio stuff in name everywhere is a valua=
ble first
>>> start.  I'd like to see this run through our testing infrastructure to=
 make sure
>>> nothing got missed.  Once you can get it to apply cleanly somewhere an=
d validate
>>> nothing weird got broken you can add
>>>
>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>
>> Thanks, the failed apply is due to the fact that this relies on another
>> patch: "btrfs: refactor alloc_extent_buffer() to allocate-then-attach
>> method".
>
> V3 of the patch has a comment from Josef, please send an update so I can
> apply both patches and we can start testing the folio conversion.
>

For the folio conversion, I'd like to add more cleanups, mostly related
to bio_add_page() -> bio_add_folio() and page flags conversion.

Those are pretty safe as long as we're only using order 0 pages.

But the more conversion I have done in this patch, the less I need to do
in the final patch introducing the higher order folios.

Thanks,
Qu

