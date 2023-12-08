Return-Path: <linux-btrfs+bounces-771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474D780AEDB
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 22:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823E01C20B9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82D58121;
	Fri,  8 Dec 2023 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aOgElYuu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE26B193
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Dec 2023 13:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702071027; x=1702675827; i=quwenruo.btrfs@gmx.com;
	bh=WAe1cEi8aGb/8pqZ1i9nmixayMvFvhHhVODcWYcUgXw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aOgElYuuSDGnE8ZUZ66E8mnUWkonNAig8QfeV/Z8Wl2UxJQQPPjmR47ZSjoIturI
	 R3m4TFCL8w6Vj7e2HAb0HmfR+wuhMLLH3Hy4nYQ/JZAfSDUThRbxa4w56h2oYZalC
	 wVVZsCzIlO5UIzOi1/6uyDd62CzHu/ijB6PeG9NE6eWw2MbOzssBAdskuUsMT7Wgu
	 uf3nvoetHVWTN3JcyxHik30/+dIDCQx1lD1hnZQ11GrENZpaTvRwOCYYsVJ5j+Mjw
	 ydztkLWI5VIPIAJdd8ym1Fe+ZD5UUc97qAC3nfVAqIvKtfIwmrfNLTrCQNpH98U/3
	 4qnL9seF2bJ8QV5avg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([118.102.94.57]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnakX-1rcqAR35JF-00jXbW; Fri, 08
 Dec 2023 22:30:27 +0100
Message-ID: <091034fc-fdc8-4fea-b282-cb2062e0ff52@gmx.com>
Date: Sat, 9 Dec 2023 08:00:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: Use a folio array throughout the defrag
 process
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231208192725.1523194-1-willy@infradead.org>
 <20231208192725.1523194-2-willy@infradead.org>
 <226b0c8d-3d6f-46a1-992c-874ed0c667fb@suse.com>
 <ZXOJjiP7OoEMKYaT@casper.infradead.org>
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
In-Reply-To: <ZXOJjiP7OoEMKYaT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KS1zYHvPyuzR+zrc6bgiaFJ1cfn9tEaNKWe64QkMe9BPwhU0R7U
 f2ka8Aez2q2mCzuVcNKcqKZE8vCL9YP6Llk92cnLoL4N5PseBh/zhA2mW9UFq8nudKXYfu9
 hMhKI0MGyS6CgdGK/tHVR+OZQzzGZQsDCWsFCkLcxqBSKgzljamS5vf+nHVRbTmd9XJfnJJ
 tAZcrKHVyjPzFrYD/o3Ug==
UI-OutboundReport: notjunk:1;M01:P0:LwkMmcX9eAg=;R4tR4qtzQe1u3jAeWQqA1upZ0gk
 Tz4O3Pc0i42KeB3Y9j46J0LTUBItx3jY6Wj2TnScNRsYJ7Jjm3Kksi1IIa2Zny4J8JWfeohba
 MzZDr8rd88iksYOgNWEjJEcyCE4VQETREuC09jblchhqzvNy7RiaaiaSSU5wNy8apDH6Fh8kJ
 HPx6qGovEsDZfIVN7Tn3L3IB4QGNZ7OJRIxy7YgXcEpIB23xbFftr8P8Goo8wChH1Kl+3+vkj
 5SYiYMOSukW+ske8hKkvi+AZ8fNHyOawenHlh6hp5M+MK6ByUlbl2dgEXWagEA6DkxJR4DAJR
 8VC5e7KywGJLacitD4WcCTcRAe3eM2Qt+eO6Wy5YDeWyy5g1bDBlj9WysM7s1kh44dMuz2iFG
 KCLpPH3OjNRsBqqfzqrFif7Fn8/sKyrnXJqS7PJab0R/+uDxUX5TvJNE9RrtzGgJ/Xm455CSB
 V1thT+bg0saUAajw0CXkMuPgiTMNkiyCNx+zi5KhxJSFS4PqxkBOjrrb+5vyowNUED1C4KtVq
 +hpcmfWV/OnwBHZDyKqfTHkGVunaCTms5UwvBexOlSD2Oof2YycimzqDzskyaIhAdeJiuxZe2
 dmzHtgprGjXU60yM4VEF6E4xCDLzdT+v0nQY5y5KWQdyIyTgXudzqL3BYyONbb2Xk9TScv7ZY
 dcy/IZvmtMtYUeXjQJ+AyGcgkMls94yE/IJ5QQsZH5SMKX8v1lFxNhNOTK7RykV9PSz4+ZjfN
 36o9S078wfosKFLelUpExwuSS07fhpe6otvEKV8hnBwp4JcGXPZOeBy2wJYVPlvaV3xF99ULH
 p0A0MvDayrON0qawyIMsIYl41iRvidlm7mSUTb3wyvgIt+15MPABdnIcP2t+luiToy6bxYZGn
 TLtYAeXFhnvg9p1/4Gg1aJntDx1pvKIOrHl6d4J5CJ/zGEKmopE5M3CCCsPsBIyUXTZp81eai
 FtU0YQ==



On 2023/12/9 07:54, Matthew Wilcox wrote:
> On Sat, Dec 09, 2023 at 07:44:34AM +1030, Qu Wenruo wrote:
>>> @@ -875,7 +875,7 @@ static struct page *defrag_prepare_one_page(struct=
 btrfs_inode *inode, pgoff_t i
>>>    	folio =3D __filemap_get_folio(mapping, index,
>>>    			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
>>>    	if (IS_ERR(folio))
>>> -		return &folio->page;
>>
>> What's the proper way to grab the first page of a folio?
>
> It depends why you're doing it.
>
> If you're just doing it temporarily to convert back from folio to page
> so you can make progress on the conversion, use &folio->page.  That
> is a "bad code smell", but acceptable while you're doing the conversion.
> It's a good signal "there is more work here to be done".
>
>> For now, I'm going folio_page() and it's the same wrapper using folio->=
page,
>> but I'm wondering would there be any recommendation for it.
>
> folio_page() is good when you actually need a particular page.  eg you'r=
e
> going to call kmap().  When we get to finally divorcing folio from page,
> folio_page() will still work, and &folio->page won't.
>
>>> @@ -1172,7 +1172,7 @@ static int defrag_one_locked_target(struct btrfs=
_inode *inode,
>>>    	const u64 len =3D target->len;
>>>    	unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
>>>    	unsigned long start_index =3D start >> PAGE_SHIFT;
>>> -	unsigned long first_index =3D page_index(pages[0]);
>>> +	unsigned long first_index =3D folios[0]->index;
>>
>> The same for index, there is a folio_index() wrapper.
>>
>> So should we go the wrapper or would the wrapper be gone in the future?
>
> folio_index() has a specific purpose (just like page_index() did, but it
> seems like a lot of filesystem people never read the kernel-doc on it).

Indeed I should check the code, it says very clearly:

  * If you know
  * the page is definitely in the page cache, you can look at the folio's
  * index directly.


> In short, filesystems never need to call folio_index(), nor page_index()=
.

Yep, as when fs got the page they are mostly already mapped.

> You can always just use folio->index unless you're in the direct-io path
> (and you shouldn't be looking at folio_index() then either!).

And DIO pages are never mapped thus never call that.

>
>>> @@ -1189,8 +1189,8 @@ static int defrag_one_locked_target(struct btrfs=
_inode *inode,
>>>    	/* Update the page status */
>>>    	for (i =3D start_index - first_index; i <=3D last_index - first_in=
dex; i++) {
>>> -		ClearPageChecked(pages[i]);
>>> -		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
>>> +		folio_clear_checked(folios[i]);
>>> +		btrfs_page_clamp_set_dirty(fs_info, &folios[i]->page, start, len);
>>
>> After my patch "2/3 btrfs: migrate subpage code to folio interfaces",
>> btrfs_page_*() helpers accept folio parameter directly, thus this may l=
ead
>> to a conflicts.
>
> I built against linux-next 20231207; I thought all your folio changes
> had landed there?  If you want to adopt these patches and land them
> after yours, I am more than OK with that!

No big deal, David and I can definitely handle the conflicts, no need to
bother you.

Thanks a lot for the lesson on the folio interface best practice!
Qu

>

