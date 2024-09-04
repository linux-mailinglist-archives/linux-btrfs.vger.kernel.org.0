Return-Path: <linux-btrfs+bounces-7840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55B96C982
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 23:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA36B1F265E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF3155324;
	Wed,  4 Sep 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sjJQav6d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FB1422C5;
	Wed,  4 Sep 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485147; cv=none; b=cuzrKP1Ma3fDWn9yTTUv6YPaSc15UgigDaCXoezC8eImtmKBOwC/V4Ko+7ghSxC4d74/YfVmtmj7ctn88/Fywf5sM80E+hIL5YQZPumP4v2rYC+B+sZKSUN2s5BOZEsT64diSYCHN2rCzmVOGHSJqNLi2zQRVLbinH5r6vgb2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485147; c=relaxed/simple;
	bh=UyQPYfhMxCj75Qe7FGvXwvjhia1oXyw6+//R+DNTr7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0B7Vo15iCOHMZRqTUgEQe78ojjHVA+rPUyjATDWP8FYlPbot5zpyz5ZNqB3/e+x1u/zFUpagJob92j88g2CN7Y89/FIlBhfv0epL9nFv8hpz9o328F7prt9YwOzTeiSZxJUEq8fjI+uUgqBKTutvYpo903BmUp6y7YalDAidD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sjJQav6d; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725485137; x=1726089937; i=quwenruo.btrfs@gmx.com;
	bh=X05O/vHR9o1yY3QK1/iaQa1sVr9mva+yy+0OX69DX3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sjJQav6dCKwCmyLwwPFT3ERE31xL86LDJAwijLnkXo+RKoZCyKZC3XChfXAltLDK
	 1UrTqYfMfcFpy4ooXRr2T+WaQT9EOvO8Ny+vXSntbYT9P6WAHBE9UW3XHuAd3s2KA
	 bvYHVxGRZNwQdN1OEsLRH07GUdNcsni18SmIc0Kt3n7jzS3BzEF2URBFgimgcxjtJ
	 T7/gAAIQMzSJdPCLywrgFduSa4CNFmD4xNEkBq9KiOrub1jw+sIACWqJpTAi+j4me
	 Y+bx0q6v8jl85iijCosHPpB771vf98xwc9rKP3WKAezEuXHBpAoV+KF+tp6CNknTS
	 oXu/u+5QWD76v57GyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1spqCE2zHy-00HAhJ; Wed, 04
 Sep 2024 23:25:37 +0200
Message-ID: <c77e973e-0e45-4fb0-8283-a0307a900b00@gmx.com>
Date: Thu, 5 Sep 2024 06:55:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Added null check to extent_root variable
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
References: <20240904023721.8534-1-ghanshyam1898@gmail.com>
 <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
 <CAG-Bmoc9NVTZgOTGTsngKCw2mCankPvwz8ywExNzFiij+2sGQA@mail.gmail.com>
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
In-Reply-To: <CAG-Bmoc9NVTZgOTGTsngKCw2mCankPvwz8ywExNzFiij+2sGQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rdvbhowp974MkmvwEsUU3j3oqfKMm6cVkPlvgpZdCby1kVzTf/o
 O4lwJnW3PsMttR1vQ29JXWPkIbx68GTw0paHT+HLN/FAoT3Sd2o3mtpXygkuEV0SZWKBnB3
 WFk+WXqa3wXM4y+r/p6h1ELlzHO21Yv0wJQHtFvmk7JQcsCdnru+uwCAdet6zKvlfTq788i
 U6KPjqDeV5vAvT3s3KUuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AHB1cagCmjI=;XX74NKH0EmDR6yAtsl/m93uxZLc
 +HJjzrQy01qURHeGuoXL/lWSa6eKv8S2uzT3E1Cnaa0ke86ThRukYCr0oIgzJNvjkG+p0gwNl
 nd9EEZQkepyCNr2Tq+V9POTKnLNyxo0QiCwrtdRPZ6Dj5zI2+5s0TDl0kPd3EVi2fAEjvx6TW
 rmtjT7sb/1vsX81uwjLSyHoEopfGTjYrxJ0oK96piBFcG59Pw5cBDEdVQfixboTI3vSQVADJc
 WBlZzOv3THws7ljgvFpSlXoPCcqekC+ufNATzB20kTYcfTXYTc+Gd6Gu+qXTFORddHABfC/Gy
 AlYlQEBY5y2fwMfU7cPeDtLdmSwc3/Va3LFMz76Uc9amdvNxcy97ES4oyDBGspW4W8AHn2o5u
 P16Y6CkvQst7cBVm+o4bfsBt22T9keGq3r4FDZG8tg5xtgYPZJQ7ArOpIrZ5TT2/fNnf8D4Id
 0ioRgmjE+/fnTgD3tYayywR5SAjFpD3BywS8sbevr9JZxa6EqMtphxd28n8ENsUec7e8DJf1b
 CegK0rL+ZKfldKkjeHBSv4HozSVTpdL+WvJnpG5eQ8bpTpnU/tOw3wKnuUycHq5HsdlrOQAi5
 q2PHIHN35scVI9ox84oknEmiP7kIQ1qOHklJNyqDmcImY505TgAWN/QUAHkGHA9dhZUVCi41U
 /cQX7culImaQZeovobtM8/JAwhlPBYt5B8DTEu+Pbk5PODFXzuKqy3xJEIpxQdlzw1RCmkAgk
 PjRWU4rBGj7swXtUYAPQA/Fd5a2XW2pzphFaKoHueKlbL1gXla0iJg1c+vjceY1E5vl0W1JXs
 9jrCHlksx7hVBM4CTOczaMpISft9hXnaRnsj97kzzbEhg=



=E5=9C=A8 2024/9/5 01:20, Ghanshyam Agrawal =E5=86=99=E9=81=93:
> On Wed, Sep 4, 2024 at 11:21=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/4 12:07, Ghanshyam Agrawal =E5=86=99=E9=81=93:
>>> Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
>>> Closes:https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e
>>> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
>>> ---
>>>    fs/btrfs/ref-verify.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
>>> index 9522a8b79d22..4e98ddf5e8df 100644
>>> --- a/fs/btrfs/ref-verify.c
>>> +++ b/fs/btrfs/ref-verify.c
>>> @@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *f=
s_info)
>>>                return -ENOMEM;
>>>
>>>        extent_root =3D btrfs_extent_root(fs_info, 0);
>>> +     if (!extent_root)
>>> +             return -EIO;
>>> +
>>
>> Can you reproduce the original bug and are sure it's an NULL extent tre=
e
>> causing the problem?
>
> The original bug can be reproduced using the c program provided by syzka=
ller
> https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e
>
>>
>> At least a quick glance into the console output shows there is no
>> special handling like rescue=3Dibadroots to ignore extent root, nor any
>> obvious corruption in the extent tree.
>
> I don't have a deep knowledge of filesystems and am unable to
> understand this. If you believe I should try to understand this part
> for working on this particular bug, please let me know. I will try to
> understand this.
>>
>> If extent root is really empty, we should error out way earlier.
>
> Upon studying the function call sequence, I found out that the
> variable extent_root is read for the first time at btrfs_root_node
> in fs/btrfs/ctree.c, "eb =3D rcu_dereference(root->node);" where "root"
> is the extent_root. This is where we get a null pointer error.

The problem is, extent_root is very commonly utilized.

For example, inside btrfs_read_block_groups() we call
btrfs_block_group_root(), which calls btrfs_extent_root(fs_info, 0) for
btrfs without block group tree case.

Surprisingly, this time the C reproducer works for me (meanwhile it
never worked before).


In fact, I added extra debugging when mounting the fs, showing that the
loopback device does not have the new block group tree feature, thus
it's still a mystery why we didn't get any earlier crash at
btrfs_read_block_groups().

So I'll keep digging and give you a more comprehensive reason on why
this is triggered (without crashing at an earlier location).

Thanks,
Qu

>>
>> Mind to explain the crash with more details?
> I have answered your questions individually. If any other details are
> needed, please let me know.
>>
>> Thanks,
>> Qu
>>
>>>        eb =3D btrfs_read_lock_root_node(extent_root);
>>>        level =3D btrfs_header_level(eb);
>>>        path->nodes[level] =3D eb;
>
> Thank you very much for reviewing my patch. I look forward to hearing
> back from you.
>
> Thanks & Regards,
> Ghanshyam Agrawal

