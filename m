Return-Path: <linux-btrfs+bounces-2395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65740855480
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 22:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A82281BAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0013EFE0;
	Wed, 14 Feb 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QM4Zhzjv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F541C71
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944967; cv=none; b=V9RsTE2KXTfPayMf6ew1678IIQFg/aVpa0lJpDP4sQWENgKY9ORrPt5bqwqrB++sGIGQ4YyVckGwBEff/Sxo5oWgliol+BMiqMO+PyMfbpWFCMhverZVPEdwVxwZgUNg0XH/M0Tr+iS++dD7d1io1jKSteQ58UdkVD0TNF24tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944967; c=relaxed/simple;
	bh=GWrRozoaSRoljhoL5MK6L9/BLl6A+A/k1Ofgr4l2CY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXbhFEkcqAESKo//5TrgnvBa06e4QoR7NgfV3tOye6WO2AZFartYSCG5cRpLrXgwsGpTy0l38H3/WG0DQ1clnKrG+lVAjxMNvTLhDmVBmaQcpAp2wCF2nUbBq73tDXLKKKkReqbIhcpj8vS0XaGqlQqCteydtr+Iyn/4N+7FubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QM4Zhzjv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707944959; x=1708549759; i=quwenruo.btrfs@gmx.com;
	bh=GWrRozoaSRoljhoL5MK6L9/BLl6A+A/k1Ofgr4l2CY8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QM4ZhzjveKAJKq+lSvrlP9gEhJD/vKnT69Wnmgz+6I5agxmA4EAkMiYaC3OYtE5E
	 ypUuKmEn7MyhVHkgkScgPYmlJSyT/yL9SdLgfxqv81uftA+Kljor8x+Rv88I+UgaC
	 sd+CWKKYxVryW54pMaKYkGjSPtr0ThX6qp6moLSaE+dNRXZionI897m8dtA1cHwBh
	 tTntrmHr9o6r9TK7HBDDyykjMBJ0by1UPKJwOAAu/xXnCBE9ryBqmmzhxprPF9ECG
	 w0/LsGctb0Ez6geM+9mJWmkKRnZrat0/H2tMS3RZFXf7sWEWqdkPX1I4uMHXkQshA
	 4swCNjEnQRynhqcftA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1rLJO12AkV-00P53o; Wed, 14
 Feb 2024 22:09:19 +0100
Message-ID: <28cd604c-230f-4f80-be5c-f835372d80d0@gmx.com>
Date: Thu, 15 Feb 2024 07:39:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1707883446.git.wqu@suse.com>
 <20240214182117.GA377066@zen.localdomain>
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
In-Reply-To: <20240214182117.GA377066@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HgyFGsDjKO0r2R4cKktkGm0AmDHF+vRP5TayaWkHNInD2MkFT/l
 5LNN+X/GAkZiDe+B+pTBWBG78ihYb1wqaj+7lrlB4paByoo7HJ4742q6sSSlr8K15vsC8wo
 nXXn7zJM83NgjOEe8m3qitGN0b/xHk8WM8LSbj4dP7/wxPZqx7Di5puAvxc1x7G1JYnPtgq
 hh0eguTRwHFkoTwnHYg6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yx92/d4voOk=;PV/O1oP9ItDNIoGdDZNad2mJFrq
 d3sK+lCobkskgTJotZvLDvozokZKDceAb+l/79gRCgVUhGw5fRD9UkpeodGmXkXT9EYwwpYQU
 JbE9pqqhXQRpqXEzgyx5W+WHsxpOdgo7Gsut+ypestlN4lBCP8oO0Ye7w73yoTNzjVmpGnuuU
 LNF2RgK405K/uNseAt/cUyd7j8a+qX1M2/TgqB65gBoTBignhC6uocwTi5NpL6dkj9QiUapYK
 j53YpKhOrsZtd9tk3/wCqxK3FXbATbrOHcjNfi4mcoOdZeH/wo4906yPGtAm3mDdmMLaThy/8
 wdUIrW8soafQCAJ6LWrphvRtnqmEqj1HzhrzynOs3bjTmjGSsODaB9FlyBlWLnNOAc6lNSFxO
 7Z3xgYn/A0S8lmcn6im8ZhUTH8CxvccOL42Z1y3FFMwcoZCC0FG27RV1gD5+agKyYpMG31Wi9
 bzfp2AdcRxUt+fX56fOTm6uWu8inUkZDrswFLEF/RYS8vn6BlQ1gX4FTR9LWqYsP/cXjKU/1H
 Aa+oP/xFOGtFjeqUcHtroI8X8D7g1zPw/UPbCs0Uu6EYfP2DXfEIIQE3Z9C8WGntS+IvGTzk8
 zMtY+aLxdwg+is+2nHtpaQeZFtsIwgRZ1w8B8ywwp+4GqgzvYo1nds1Q/0wm9YMoK865YQi2A
 bGkLoqlFxgL3yuB5+1IPfrYvOOxB7CzhGdXL8v72IWMzWYLctcG2Wwt+7xw/KaOpS4ge/mx/3
 VLySbLN8gezHMEFYj9SoOXdG7n+64lYLl9DO0P/4GbpnbieGkGtBFG43maoGRuW8Xbo4yKzWn
 SMUhb68egMolIHP6Ds0R4mr2Z46vSxIXNsF8lQMnT+tRU=



=E5=9C=A8 2024/2/15 04:51, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Feb 14, 2024 at 02:34:33PM +1030, Qu Wenruo wrote:
>> This can be fetched from github, and the branch would be utilized for
>> all newer subpage delalloc update to support full sector sized
>> compression and zoned:
>> https://github.com/adam900710/linux/tree/subpage_delalloc
>>
>> Currently we just trace subpage reader/writer counter using an atomic.
>>
>> It's fine for the current subpage usage, but for the future, we want to
>> be aware of which subpage sector is locked inside a page, for proper
>> compression (we only support full page compression for now) and zoned s=
upport.
>
> The logic of the patches seems good and self-consistent to me, I don't
> see any issues.
>
> However, I think it would be helpful to at least see the client code to
> motivate the bitmap a bit more for the ignorant :)

Sure, if needed I can include them into the incoming subpage delalloc
patchset.

>
> Also, from a semi-cursory inspection, it looks like this relies on
> extent locking to ensure that multiple threads don't collide on the
> subpage bitmap, is that correct?

The current plan is to make find_lock_delalloc_range() to always lock
all the ranges inside the page, at least beyond the end of the page.

The main work flow would look like this:

find_lock_delalloc_range()
{
	int cur =3D page_offset(page);

	/*
	 * Subpage, already locked, just grab the next locked range
	 * using the locked bitmap.
	 */
	if (btrfs_is_subpage() && write_count > 0)
		return grab_the_next_locked_range();

	while (cur < page_end(page)) {
		/*
		 * The old find and lock code, including
		 * the extent locking
		 */
		cur =3D locked_range_end();
	}
	*start =3D the_first_locked_range_start;
	*end =3D the_first_locked_range_end;
}

So for non-subpage cases, it's the same.
For subpage cases, the page would be kept locked until all its subpage
sectors are written.
(But would need extra cleanup if we hit some error during subpage sector
write)

And the above workflow is still being coded, not yet tested to see if
there is anything fundamentally wrong, thus it may change.

> You should check with Josef that his
> plans with getting rid of the extent locking don't clash with this.

It would still conflict, but the extent locking part would be the same
as usual, so I believe the conflict can be easily resolved.

And I'm pretty happy to help solving the conflicts if needed.

Thanks,
Qu

>
> Thanks,
> Boris
>
>>
>> So here we introduce a new bitmap, called locked bitmap, to trace which
>> sector is locked for read/write.
>>
>> And since reader/writer are both exclusive (to each other and to the sa=
me
>> type of lock), we can safely use the same bitmap for both reader and
>> writer.
>>
>> In theory we can use the bitmap (the weight of the locked bitmap) to
>> indicate how many bytes are under reader/write lock, but it's not
>> possible yet:
>>
>> - No weight support for bitmap range
>>    The bitmap API only provides bitmap_weight(), which always starts at
>>    bit 0.
>>
>> - Need to distinguish read/write lock
>>
>> Thus we still keep the reader/writer atomic counter.
>>
>> Qu Wenruo (3):
>>    btrfs: unexport btrfs_subpage_start_writer() and
>>      btrfs_subpage_end_and_test_writer()
>>    btrfs: subpage: make reader lock to utilize bitmap
>>    btrfs: subpage: make writer lock to utilize bitmap
>>
>>   fs/btrfs/subpage.c | 70 ++++++++++++++++++++++++++++++++++++---------=
-
>>   fs/btrfs/subpage.h | 16 +++++++----
>>   2 files changed, 66 insertions(+), 20 deletions(-)
>>
>> --
>> 2.43.1
>>
>

