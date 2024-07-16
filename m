Return-Path: <linux-btrfs+bounces-6502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612C9325F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD531F22571
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516B199E8A;
	Tue, 16 Jul 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dAB9BBLk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC117C64
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130870; cv=none; b=aL8dP//Tg8vM9z7MGaoXzmfQ27mHyRkMD5khhCagsjipjJKmtQpSFLXZxCS3RFp2Aj/Uj4ONVmhSTW74/STlWThFFzCZcEOTkM16dMV35E4JtH2Eq2H8Iy77Ej8MlFh8pbKM0RPaCh4H8NKbRQREwqbRG31viUyIWF82qiCP//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130870; c=relaxed/simple;
	bh=Sz0uihPhAWpIaxVFuTDcWXKOTjzj2Iv28pGg+Yp3Uuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr1RUVTg+guoc7Mp7OkwRfcBqLPbBZj0iaS1/DgP7htbUQbJrXSG16mtojayGT6W9EW96S1pJQEMldF33oIFvf+UkUYqn5fzis5Mp2MhI+5ATLDlT+I7VzfjBRItQeYkaOxuSlUX0jVGRrjwKCOX6yqjL1GDeqOL528CTeRS40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dAB9BBLk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721130862; x=1721735662; i=quwenruo.btrfs@gmx.com;
	bh=n1tsdz2FOh4BJXP/bNJnB2QDdyi9VFyO6QcQNw8kAVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dAB9BBLkX1fHnEwKUS7FhU+TH4ykrKOc4uKpd0Gcvsnm1u9nNuYY9FUyH0V/azYW
	 Fz7oBxLeuLcBZ6UgNsq85+YBpgWFjx0XbRp3C7FC8y+hoXKJbviFVLQRrPt39ewIX
	 fEz7QD0CWa66YGR2dQt4ywwgnenONU+2jLieWmXvjko6p/hdIpiSC3v/91J8ecO0t
	 m9RfrwYzJGwrUi5My5AFSvokNynxN0V4kNCxOJkNCplbVZGWM+CbQ/oYjQ0qjXDmP
	 VouqZsTCMXauyusvVtsxR9eGZAae4shv2R+XXWhMzCZ4/H3Y55W2dyFrEVLP2WuT7
	 ZOQxsSVfURH/fDZziw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1ruLoE3CUd-00h7q8; Tue, 16
 Jul 2024 13:54:22 +0200
Message-ID: <070d9165-b9aa-4693-a066-737529a6e005@gmx.com>
Date: Tue, 16 Jul 2024 21:24:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed
 extent map
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
 <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com>
 <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
 <35ff514b-25c1-448a-a9cd-7b7b0b3709a1@gmx.com>
 <CAL3q7H6cpVcy6D=HYGGjzqgfvSq1ri_OV6rpuU5R-XddejbJ-Q@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6cpVcy6D=HYGGjzqgfvSq1ri_OV6rpuU5R-XddejbJ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ax/DUdy7Ho6Br/KHPhLsIsB7JhtnFFKjqeowj/lWYTZVoYmQG1A
 3ziUQY5Jwn9PZYTLVWIzZQ2l02Ozs/+gBah7q7983f5wnjU35Bmi+zGk96bh4XPfiFe87MN
 DpVOPhZGToFborl/BDqwyv8lEf/NF1tvKrUNF9ZndG8lD4NlvsjiC5RgCLPRYL41ssMJApR
 kbPOHj5Rh+vnV/At+Wfnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YXfaro6kluw=;rwifR3QZjFMSOstDFE96Jc1x+L7
 PmvPrrMwB65k/U7JsQQGgDO2qavMICg/ocWDj58u/zLzR3aSFaNwpI8YLBFndgTU0MPYzOCxT
 /Z/3i9kf2gG3j87gHMz27mFM56jpP1aJ2dVZzyCcKAgaeWGbDlHM281X7S+iY9jK1oj/h/Grw
 b1BihsNM46jUfB4BB28I/nBYMohdIc5pRPZENutK0ANdkKKoptgKYi+RdU72C7rZfojMj22cF
 NUZwckvK2N6bZGmXZPKqTtUzq2Qqt9gEsIuI2ylhJaqoSxNRqUi5cpdsu/thisulfUPvr9/5m
 0sVgGbUA1i098hSHLCY4pbfTDqoKV8jVaUy7IC/SeH714voVlETWUaX+b4D4qxF5gL/Q3icAd
 w+urmXafS+3gC4y+91SICENcnKTii0ZqZtnU4R0End45eaeAODBhUJKgyei4wK0ra6IcjJecL
 r5/8o/ZR54f419lWYxTB+lt/+Sy+6QxYs/YElPN1nWQEpO6FOT669kg3BXCqNknRwZt/Unne4
 errSsGv+6K5zUl2CR2Kh/jwCd70yHeirK/1QsKmAvGSCPoXpf1KYpWjHa/ZSKiSbfLPkXTG8k
 su6VWoof7n0Lb0ePOwu5hundGm/v/NAyzmwDNfwe8bdV4BIUzvilzfvw3Vjq38B+1eipJCddB
 UOZVibitgSaYmNaaUMQ5co0Tsvv7A/iaglO/Ka6EiCwDPDohUgyNY0TZSEE0jPBPB+7/CWH9c
 8e/6tYapEyEF2KEnTru+HiSgxzVqY5aShz5VFi1IG+ArPHDKpunNuE7PneToIGPekVZ4usy+P
 ortHWEqyHmff+5XrvMiI37qZbpPea6FWtiAPek4LCjZqo=



=E5=9C=A8 2024/7/16 21:06, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Jul 16, 2024 at 12:30=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/7/16 20:37, Filipe Manana =E5=86=99=E9=81=93:
>> [...]
>>>> However I'm not sure if the fixes tag is correct.
>>>>
>>>> The fix is changing the condition so that even for compressed extents=
 we
>>>> can properly update the offset
>>>>
>>>> However the condition line is not from that commit.
>>>
>>> No?
>>>
>>> That's the only commit that adds:
>>>
>>> em->offset +=3D start_diff;
>>>
>>> to add_extent_mapping(). How can it not be?
>>> em->offset only exists after that patch.
>>
>> Before the introduction of em->offset, the old code is:
>>
>>          if (em->block_start < LAST_BYTE && !is_compressed) {
>>                  em->block_start +=3D start_diff;
>>                  em->block_len =3D em->len;
>>          }
>>
>> @block_start is the disk_bytenr + offset for uncompressed extents, or
>> just disk_bytenr for compressed extents.
>
> But that's a different thing.
> em->disk_bytenr should never be updated for a compressed extent, that
> was correct.
>
>>
>> @block_len is the num_bytes for uncompressed extents, or just
>> disk_num_bytes for compressed extents.
>>
>> So for the old kernel without em member update, compressed extents won'=
t
>> get any update at all, thus should still lead to the same problem.
>
> And they shouldn't get any updates.
> Because it's disk_bytenr - we have to read the whole compressed
> extent, and then extract what we need from the decompressed data.

OK, I got the answer.

For compressed extent we have other things to calculate the offset,
using em->orig_start.

This means before the em change, we handle offset differently:

- For compressed extents, it's em->start - em->orig_start.

- For uncompressed extents, it's already calculated into
   em->block_start.

So for the old code, even if we didn't update anything, as long as the
em->orig_start is still correct, we can always get a correct result from
btrfs_submit_compressed_read().

But after the em update, all the calculation is unified, and we no
longer have orig_start to do the hidden calculation for compressed read.

>
>>
>> Or did I miss something?
>
> It seems so. Did you really authored the patchset? :)
>
> If you still don't believe that commit is buggy (despite adding the
> em->offset increment logic), then do the following:

No, I think the fix is correct, or I won't give it a reviewed-by.

I just didn't see why the old code is also working.

Now I see the reason and I believe the reason is worthy to be mentioned
in your commit message then, especially considering the old code is not
that obvious why it works in the first place.

Thanks,
Qu


>
> 1) Run for-next against the test case for fstests - it fails;
>
> 2) Checkout for-next into a commit before the patchset that changes
> extent maps and run the test case for fstests - it will always pass.
>

