Return-Path: <linux-btrfs+bounces-3938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B2898FE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C3288C13
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2413B295;
	Thu,  4 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i0dTC9EL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F046133426
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264893; cv=none; b=IkbYbcRrhgJFghb94MxIQTtxFTbxSyxGC71qP6sma0p1s9ZVJiWIJkaHnV0gKoOUL/sWrvOQMQ9qfJuDcAQOrGvCcbE/skXqvN+Wh5r/Aa9oZKqTbZEXcv2DyCC3uAOqeS5lhma7h5wEKBWcZtJKI+dAxfFFlzoDgHXf6JI4r4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264893; c=relaxed/simple;
	bh=IY5NSsLcVP5Z0C2zR+LoHh9/AJUtYFgaNpjHMNq6F3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNkzE13U4QiZlOZ3u3WT8rynndE7a6SDzActyzG+MOkXMhLtDz0iKGN36CSyiGv2cq29tpTdlPXy2msNn4YkZyU41B2iT9kWuYE5yNP/KD7ko246fbUp0yXCwnS7fBhzuvk7XRhG5F8Jzi1wlmatv2jEeMyC+FKtnbJNj5iBfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i0dTC9EL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712264886; x=1712869686; i=quwenruo.btrfs@gmx.com;
	bh=OsO7m3YW6NxkpJqjq6z6bauGIxiusXwW4py/zJTwqxk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=i0dTC9ELfgy7T/OpNu1FjnSTJCN+if5l32dJICkLKWV8cVTIrbuzqR5F2LYj8t0n
	 FtSJkoWi1y9KKPvFgBdzL1cV70eU3hQ4h7Evqvc/hVH/zaDcJ0TFwvYRo3rJfAuvO
	 sxXpg1FcLOqeEyTHzDtoiQEEZBbo6RxY1U0+BlRGyEyJEYNpvjPadjuL3iEWQEWw4
	 n21APi5O54l4cfkXr++Y5WJdQIE32n50VfFK8JcYXKW58/mPmItB4DzgV9q/n39P1
	 jzrW6dTE8x40tPbZDkGI9fO1W2wSr5LpNq4kHeGa8eiYuKydd/hWZCFcHnyJ++E+C
	 ByhniMx9TpZN3XgAHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79u8-1stPYY09Bk-017Sic; Thu, 04
 Apr 2024 23:08:06 +0200
Message-ID: <82f0c229-c478-49ff-ac08-5e9b788ab51e@gmx.com>
Date: Fri, 5 Apr 2024 07:38:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 Julian Taylor <julian.taylor@1und1.de>, Filipe Manana <fdmanana@suse.com>
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
 <20240328155746.GY14596@twin.jikos.cz>
 <ec65443a-b7ba-4c60-9cbd-23ffd45c8994@gmx.com>
 <20240404195710.GL14596@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20240404195710.GL14596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3fg/g7gsJVJYYkZw6KpXQktvdruerRf2gN2y3u77hLWpgRU2saa
 EZ/pIYph4EUwg03x6x9KJWAB06zK1351zxuoSibuep7hbN8OdTedW0IMgz2OGqAht6htLII
 DF8lm5FibzCKZ5Z7kMhuBaUWdVkgVNXUOL4Vc4yaYI6oG8B3ycWS3BrL931VRdHgWpLFiTR
 HuPKmq+3129IulaKC5/lA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FHhEG+gYqFk=;GtIediA+miPB2AGC8afWILDHtio
 k3iHc29tOKnZKN02Xf5ab1SpXPA3XmcXQIwrk38ju1oJiGFHTNLFxQnCacQelySVRELrJrV9V
 RQjPE7N0szv9ZkJD0kDcqEvYsqE+d6fdvkTtd7jLt/cFUWxdAfc9zFpu31XssI6l1uhtX01Ky
 Yr0zGhL7hogaXfTJKCbtfjgzMKjtnbvEbtMOjP0SnS+0fS5jIIyVVEyBPTAxzbpa+82T0/xsH
 xy3GJz5hmoMEPjADMKHEq68iXkGZF073MMfcg9NecPezN9vIhQz4UKQc7gT0NVZBg7B2mNK2F
 R5wJzbYuLFLXNuqazHHfP4kdl6T+esfcaf2vM0N9e9sFhk/j+QKWbN52v+fOEElJNPmDdC5L5
 eMDf0ellF4tZ1ZRfYUichd/zfo2ruH7O+AFHHXNO/kT5ESl8H6O6EMQAJhEV3pzwb3m7fvs20
 llA+MK2aUupGP3Wi6V8thcUdOs3wgGJPnErg7hBSeLDU7kSJcwp/K6f8PwYBos5ELFgoYyXYg
 hDZuz8kmxGS0qgxdCjXJ9ojukvD1rtVEcVP4bC1+f278ae8lP5MV20C3yqu0tpHI/UpVC/my4
 Oqxmd0lG8uR0SHKwkXhWIXTC3tvg27WuD3cmcg8q/KIAjt1iJTdfYDa7098Vgkwbp1lwWUUYQ
 ge6L8YJzJeCRJYIirZm/B//iDufK4B/ZioG5z5KljYHJKcP5GNON3Ow6bYwlsnyM6Y8UyU2WF
 7fkkrBcqXm83ci3kR6QvJumc/tIa4lXb8GQUD+jLSgTNHMX9wEZmtFKMHDmVdOmBtk6CaBZT/
 P/RZCE73aQzUDUV5ExI+nQ4DUSko2a4fB5Nemjpwzli5w=



=E5=9C=A8 2024/4/5 06:27, David Sterba =E5=86=99=E9=81=93:
> On Fri, Mar 29, 2024 at 06:59:57AM +1030, Qu Wenruo wrote:
>>>> This patch would only call memalloc_retry_wait() if failed to allocat=
e
>>>> any page for tree block allocation (which goes with __GFP_NOFAIL and =
may
>>>> not need the special handling anyway), and reduce the latency for
>>>> btrfs_alloc_page_array().
>>>
>>> Is this saying that it can fail with GFP_NOFAIL?
>>
>> I'd say no, but never say no to memory allocation failure.
>
> It's contradicting and looks confusing in the code, either it fails or
> not.
>
>>>> Reported-by: Julian Taylor <julian.taylor@1und1.de>
>>>> Tested-by: Julian Taylor <julian.taylor@1und1.de>
>>>> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c=
3@1und1.de/
>>>> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory all=
ocations")
>>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Still use bulk allocation function
>>>>     Since alloc_pages_bulk_array() would fall back to single page
>>>>     allocation by itself, there is no need to go alloc_page() manuall=
y.
>>>>
>>>> - Update the commit message to indicate other fses do not call
>>>>     memalloc_retry_wait() unconditionally
>>>>     In fact, they only call it when they need to retry hard and can n=
ot
>>>>     really fail.
>>>> ---
>>>>    fs/btrfs/extent_io.c | 22 +++++++++-------------
>>>>    1 file changed, 9 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 7441245b1ceb..c96089b6f388 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio=
 *bbio)
>>>>    int btrfs_alloc_page_array(unsigned int nr_pages, struct page **pa=
ge_array,
>>>>    			   gfp_t extra_gfp)
>>>>    {
>>>> +	const gfp_t gfp =3D GFP_NOFS | extra_gfp;
>>>>    	unsigned int allocated;
>>>>
>>>>    	for (allocated =3D 0; allocated < nr_pages;) {
>>>>    		unsigned int last =3D allocated;
>>>>
>>>> -		allocated =3D alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
>>>> -						   nr_pages, page_array);
>>>> +		allocated =3D alloc_pages_bulk_array(gfp, nr_pages, page_array);
>>>> +		if (unlikely(allocated =3D=3D last)) {
>>>> +			/* Can not fail, wait and retry. */
>>>> +			if (extra_gfp & __GFP_NOFAIL) {
>>>> +				memalloc_retry_wait(GFP_NOFS);
>>>
>>> Can this happen? alloc_pages_bulk_array() should not fail when
>>> GFP_NOFAIL is passed, there are two allocation phases in
>>> __alloc_pages_bulk() and if it falls back to __alloc_pages() + NOFAIL =
it
>>> will not fail ... so what's the point of the retry?
>>
>> Yeah, that's also one of my concern.
>>
>> Unlike other fses, btrfs utilizes NOFAIL for metadata memory allocation=
,
>> meanwhile others do not.
>> E.g. XFS always do the retry wait even the allocation does not got a
>> page allocated. (aka, another kind of NOFAIL).
>>
>> If needed, I can drop the retry part completely.
>
> The retry logic could make sense for the normal allocations (ie. without
> NOFAIL), but as it is now it's confusing. If memory management and
> allocator says something does not fail then we should take it as such,
> same what we do with bioset allocations of bios and do not expect them
> to fail.

Got it, would remove the retry part completely.

Thanks,
Qu

