Return-Path: <linux-btrfs+bounces-4042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420F89CFCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 03:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3384F285DDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8F381B1;
	Tue,  9 Apr 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kv8DVEEk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90379FD;
	Tue,  9 Apr 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626149; cv=none; b=VswS4fxMGUOqoTvThzWwEgZv9laI94WgdxcvlFdNtnHDB7g6ZCfgXx+CfKrSmZq/wcWjleNSxO6lI1exrbaw/IM39KTy3XZ7zIF4Gsfk9Mc4He2blSlzqepkd7Y+ZF5mSpe8SQVDPeXtgE1Lj2y7z3J5TL+zDGtLNJEr1C4Z7b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626149; c=relaxed/simple;
	bh=FHfuVPr6QxTurU+/5DsY8pZZNrxzTKe3XevL6KqaeMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2IK9WuOWCFDoae+XnFnslnPTgnCjWpq5KXplDRVQfjB+zvQQBOWKfkZQK23doQ+gZ9RIvrm6IclqbPv8eSFOZgP4nZ0aQbdvs5D5vlEiAEyYg1263gd30cdFcLIsEQAbsOdYV5MiK9CGMjl5ylvgyc89qFNfHGYgFE/xGLqLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kv8DVEEk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712626139; x=1713230939; i=quwenruo.btrfs@gmx.com;
	bh=FHfuVPr6QxTurU+/5DsY8pZZNrxzTKe3XevL6KqaeMU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kv8DVEEkYHuXPcjluRBFqdBpaeUECpEzmI8WrWqjVfDxolpfEN0YNOVBKCg/PpOL
	 w2dC5nnEM69zdKSooNv3A+qhLH+nk8DrrP+gAaTnNweiEkOtSX5LIToS4AwbAkqJE
	 VFUHvJim21SYYRbLTCZdHUcVakT69R0NFaxOkY0CySzmJwPz671GGVlWDT1XBwuqB
	 MeGxvTWmsziXPe5dK48rigN0fDKMjn5qpiYV7vx0ry4gRtvni7RaXMudkHofbaBBk
	 DVQ7rrPF8wgUKvU6xWILLz1CVPN8vClJjnRxuZLXdVz9+y/KT7j2M5Ihwatn39rZ8
	 CTfy8zmeYqwHDEhURQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvLB-1sJgQZ1lJN-00Rrqi; Tue, 09
 Apr 2024 03:28:59 +0200
Message-ID: <9b8ca910-0928-4ce3-a231-62b0d4d28f0c@gmx.com>
Date: Tue, 9 Apr 2024 10:58:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/filter.btrfs: introduce _filter_snapshot
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712306454.git.anand.jain@oracle.com>
 <bedb9edc01e8938544fa5c73f716f823764c3fd9.1712549642.git.anand.jain@oracle.com>
 <8ed760a1-eaa7-4fc6-9599-f642b3b70b76@gmx.com>
 <7e4cec93-32f8-4005-b3c5-02b0325421e3@oracle.com>
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
In-Reply-To: <7e4cec93-32f8-4005-b3c5-02b0325421e3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WvfP34JK8SIXl2WZ3jQ5ONTMZMLiwDcfeBH2PV3DaPFbBtvJLDz
 tl3Uoov3OejAJVMqHCNSSMIrgu2o8HUbEXkLOHjnL0pc+ltwIzfRTF0TyDXrLYmM9N6PSa8
 yxo1hiUU10oW3MKy1fv4cRYCIarjlq3BGMsw7UjaNM3IYrJ+3iXF7JXGFbuJ6GFfHDI0maO
 LGWXr7ju4pQmZ9kKRoysw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HRrbZvZtnuY=;Nghc1YX2D6Hxxxrz/IuP6LE1W1A
 XFDjjAYUbJNpYJc3NNBigixLdux2RQeU0gH+zxoLGwmoZXLqSVypk7EAiMkUq/zE7PfD/vhjc
 RA+n2b9DLABqR+WpwdVlMUnXNM93rEucG4vjV5qB4QTACZxZtyJHivgwjFUYJMk5o5M+STuKx
 xbGLfHS9REwJ8V26x3WOHgc08UdDZyrj4wpw+chw9e1go3vhl7O/3oR41Lx3aCTkLutRLb0uG
 wx+Xlv+bRGXgg5g02foHdzs0yoZFxeK7RiPjpaO3PiSUsRQAPVQyeWNSaa2/652v3p3YtIV35
 pVixRPLhdX3cQJcFuQA1IKw3xD0NHKZ5IGJyyClvogFobSEeyCJBiEHIIUNRUBkxJvcRhtmd0
 kK424BvpEX6ZH+LQNWIb1HyLJAD/DpQEA7Z2g5eNVyOJpUwM6mb2ebKR+59fuLCTLUm5DxS6L
 cI7q7ji3XWboNNFSyGT+6NsoUkBZ1F1R+5/Gz//sfEoTuS/kkwvIdoPbnNjrJzoJddnYxyWT0
 ybBG9Vt6CMUMa0CRMKzhlhRbklpckYbYs88mom0JYakpVMIIVVDhgh1N+P9eK+j8B/VM84LPt
 wqsUahv76AMieV4T2QySEhQNJKT3XNuL56YSSrd2hDmbiWO6q+mYwK8MXuGOj6IqFHgk1v83S
 aTUHzc6ZvFPrc21IsEXm8PKj8JXRjTj5rAYgaKPed95z0vKq/1BQrlCXX/I/5BM2caA9EWCxe
 6QFYO1ung5CS0eEsIjlAyUJyzHvlFenKiDUgzkLGcu+W794bs5qPex3BOmyXRCOZ2e9aJniJi
 EIrxk1dweIXd0t5cm2rYUe1NX1M/T1pr6Vb3CH20OufMw=



=E5=9C=A8 2024/4/9 10:27, Anand Jain =E5=86=99=E9=81=93:
>
>
> On 4/8/24 16:24, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/8 14:02, Anand Jain =E5=86=99=E9=81=93:
>>> Btrfs-progs commit 5f87b467a9e7 ("subvolume: output the prompt line on=
ly
>>> when the ioctl succeeded") changed the output for snapshot command,
>>> updating the golden outputs.
>>>
>>> Create a helper filter to ensure the test cases pass on older
>>> btrfs-progs.
>>>
>>> Another option is to remove the 'btrfs subvolume snapshot' command
>>> output
>>> from the golden output and redirect it to /dev/null, but this strays
>>> from
>>> the bug-fix objective.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v2: The missed testcases included now.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Merged following two patches in v1:
>>> =C2=A0=C2=A0=C2=A0=C2=A0common/filter.btrfs: add a new _filter_snapsho=
t
>>> =C2=A0=C2=A0=C2=A0=C2=A0btrfs: create snapshot fix golden output
>>
>> Still I do not think this is correct way to go.
>>
>> 3 points for my objection:
>>
>> - Most test cases are already doing the redirection for "btrfs
>> =C2=A0=C2=A0 subvolume" command group
>> =C2=A0=C2=A0 Check my patch's commit message, overall the touched ones =
are less
>> =C2=A0=C2=A0 than 25% of all the "btrfs subvolume snapshot" calls.
>>
>
> I observed that. However, as I mentioned in the change log, the
> objective of this patch is to make test cases work with both the
> older and newer versions of btrfs-progs only. So, not a good idea
> to remove the golden output completely.

So you're saying it's a good idea to maintain something that would soon
be utilized by new test case?

>
>> - Missing handling for "btrfs subvolume delete"
>> =C2=A0=C2=A0 Sure you can add new filters, but I do not think it's wort=
hy just a
>> >=C2=A0 =C2=A0 new filter.
>
> Sorry, but test cases using 'btrfs subvolume delete' (without
> redirection) aren't failing.

My bad, my fstest is not uptodate, the latest for-next has another
filter you introduced to filter the "subvolume delete" output change.

But good luck keeping add new filters just for those trival changes.
>
>>
>> - How to enforce the filters for the future test cases?
>> =C2=A0=C2=A0 Good luck if you're really pushing everyone to use the new=
 filter.
>> =C2=A0=C2=A0 On the other hand, it's pretty instintive to just redirect=
 the output.
>
> Unfortunately, that has been the core fundamental design in fstests,
> and I don't intend to change it in a patch meant to fix a bug.
>
> It seems that we need to maintain the golden output fundamentals until
> we find a better alternative or one that is reasonable enough to not
> verify the output on a per-command basis, which I believe is your point
> of view. I understand that. Also, commented, we could use
> '_run_btrfs_util_prog subvolume xxx'. This would mean no golden output.
> But as I mentioned, let's not address that objective within this bug
> fix.

Firstly, the remaining 25% is already the minority. 75% is already doing
the redirection instead.

I see no point arguing whether it's the fstest policy, as majority of
our tests are not following already.

Secondly, unlike xfs_io which can sometimes report short read/writes and
need to be caught, "btrfs subvolume" output (except "subvolume list")
really are informative output, no complexity like "xfs_io".

If you really want to blindly following some policy without thinking if
it really fits the situation, then good luck.

>
> Thanks, -Anand
>
>>> =C2=A0 common/filter.btrfs | 9 +++++++++
>>> =C2=A0 tests/btrfs/001=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>>> =C2=A0 tests/btrfs/001.out | 2 +-
>>> =C2=A0 tests/btrfs/152=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/152.out | 4 ++--
>>> =C2=A0 tests/btrfs/168=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/168.out | 4 ++--
>>> =C2=A0 tests/btrfs/169=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/169.out | 4 ++--
>>> =C2=A0 tests/btrfs/170=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/170.out | 2 +-
>>> =C2=A0 tests/btrfs/187=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/187.out | 4 ++--
>>> =C2=A0 tests/btrfs/188=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++----
>>> =C2=A0 tests/btrfs/188.out | 4 ++--
>>> =C2=A0 tests/btrfs/189=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/189.out | 2 +-
>>> =C2=A0 tests/btrfs/191=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/191.out | 4 ++--
>>> =C2=A0 tests/btrfs/200=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/200.out | 4 ++--
>>> =C2=A0 tests/btrfs/202=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/202.out | 2 +-
>>> =C2=A0 tests/btrfs/203=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0 tests/btrfs/203.out | 4 ++--
>>> =C2=A0 tests/btrfs/226=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/226.out | 2 +-
>>> =C2=A0 tests/btrfs/276=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 tests/btrfs/276.out | 2 +-
>>> =C2=A0 tests/btrfs/280=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/280.out | 2 +-
>>> =C2=A0 tests/btrfs/281=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/281.out | 2 +-
>>> =C2=A0 tests/btrfs/283=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/283.out | 2 +-
>>> =C2=A0 tests/btrfs/287=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/287.out | 4 ++--
>>> =C2=A0 tests/btrfs/293=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/293.out | 4 ++--
>>> =C2=A0 tests/btrfs/300=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 tests/btrfs/300.out | 2 +-
>>> =C2=A0 tests/btrfs/302=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0 tests/btrfs/302.out | 2 +-
>>> =C2=A0 tests/btrfs/314=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 tests/btrfs/314.out | 4 ++--
>>> =C2=A0 45 files changed, 92 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>>> index 9ef9676175c9..7042edf16d2a 100644
>>> --- a/common/filter.btrfs
>>> +++ b/common/filter.btrfs
>>> @@ -156,5 +156,14 @@ _filter_device_add()
>>>
>>> =C2=A0 }
>>>
>>> +_filter_snapshot()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 # btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: s=
ubvolume:
>>> output the
>>> +=C2=A0=C2=A0=C2=A0 # prompt line only when the ioctl succeeded") chan=
ged the output
>>> for
>>> +=C2=A0=C2=A0=C2=A0 # btrfs subvolume snapshot, ensure that the latest=
 fstests
>>> continue to
>>> +=C2=A0=C2=A0=C2=A0 # work on older btrfs-progs without the above comm=
it.
>>> +=C2=A0=C2=A0=C2=A0 _filter_testdir_and_scratch | sed -e "s/Create a/C=
reate/g"
>>> +}
>>> +
>>> =C2=A0 # make sure this script returns success
>>> =C2=A0 /bin/true
>>> diff --git a/tests/btrfs/001 b/tests/btrfs/001
>>> index 6c2639990373..cfcf2ade4590 100755
>>> --- a/tests/btrfs/001
>>> +++ b/tests/btrfs/001
>>> @@ -26,7 +26,8 @@ dd if=3D/dev/zero of=3D$SCRATCH_MNT/foo bs=3D1M coun=
t=3D1
>>> &> /dev/null
>>> =C2=A0 echo "List root dir"
>>> =C2=A0 ls $SCRATCH_MNT
>>> =C2=A0 echo "Creating snapshot of root dir"
>>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | =
\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 _filter_snapshot
>>> =C2=A0 echo "List root dir after snapshot"
>>> =C2=A0 ls $SCRATCH_MNT
>>> =C2=A0 echo "List snapshot dir"
>>> diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
>>> index c782bde96091..c9e32265da6a 100644
>>> --- a/tests/btrfs/001.out
>>> +++ b/tests/btrfs/001.out
>>> @@ -3,7 +3,7 @@ Creating file foo in root dir
>>> =C2=A0 List root dir
>>> =C2=A0 foo
>>> =C2=A0 Creating snapshot of root dir
>>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 List root dir after snapshot
>>> =C2=A0 foo
>>> =C2=A0 snap
>>> diff --git a/tests/btrfs/152 b/tests/btrfs/152
>>> index 75f576c3cfca..b89fe361e84e 100755
>>> --- a/tests/btrfs/152
>>> +++ b/tests/btrfs/152
>>> @@ -11,7 +11,7 @@
>>> =C2=A0 _begin_fstest auto quick metadata qgroup send
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>>>
>>> =C2=A0 # Create base snapshots and send them
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
>>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratc=
h
>>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapsh=
ot
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
>>> -=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratc=
h
>>> +=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapsh=
ot
>>> =C2=A0 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG send $SCRATCH_MNT/subv=
ol1/.snapshots/1 2>
>>> /dev/null | \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PRO=
G receive $SCRATCH_MNT/${recv} |
>>> _filter_scratch
>>> diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
>>> index a95bb5797162..763d38cefe65 100644
>>> --- a/tests/btrfs/152.out
>>> +++ b/tests/btrfs/152.out
>>> @@ -5,8 +5,8 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv1_2'
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv2_1'
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/recv2_2'
>>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in
>>> 'SCRATCH_MNT/subvol1/.snapshots/1'
>>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in
>>> 'SCRATCH_MNT/subvol2/.snapshots/1'
>>> +Create readonly snapshot of 'SCRATCH_MNT/subvol1' in
>>> 'SCRATCH_MNT/subvol1/.snapshots/1'
>>> +Create readonly snapshot of 'SCRATCH_MNT/subvol2' in
>>> 'SCRATCH_MNT/subvol2/.snapshots/1'
>>> =C2=A0 At subvol 1
>>> =C2=A0 At subvol 1
>>> =C2=A0 At subvol 1
>>> diff --git a/tests/btrfs/168 b/tests/btrfs/168
>>> index acc58b51ee39..78bc9b8f81bb 100755
>>> --- a/tests/btrfs/168
>>> +++ b/tests/btrfs/168
>>> @@ -20,7 +20,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro
>>> false
>>> =C2=A0 # Create a snapshot of the subvolume, to be used later as the
>>> parent snapshot
>>> =C2=A0 # for an incremental send operation.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>>> $SCRATCH_MNT/snap1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # First do a full send of this snapshot.
>>> =C2=A0 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/s=
nap1
>>> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K"
>>> $SCRATCH_MNT/sv1/baz >>$seqres.full
>>> =C2=A0 # Create a second snapshot of the subvolume, to be used later a=
s
>>> the send
>>> =C2=A0 # snapshot of an incremental send operation.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1
>>> $SCRATCH_MNT/snap2 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Temporarily turn the second snapshot to read-write mode and t=
hen
>>> open a file
>>> =C2=A0 # descriptor on its foo file.
>>> diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
>>> index 6cfce8cd666c..0eccbc3fc416 100644
>>> --- a/tests/btrfs/168.out
>>> +++ b/tests/btrfs/168.out
>>> @@ -1,9 +1,9 @@
>>> =C2=A0 QA output created by 168
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/sv1'
>>> =C2=A0 At subvol SCRATCH_MNT/sv1
>>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1=
'
>>> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
>>> =C2=A0 At subvol SCRATCH_MNT/snap1
>>> -Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2=
'
>>> +Create readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
>>> =C2=A0 At subvol SCRATCH_MNT/snap2
>>> =C2=A0 At subvol sv1
>>> =C2=A0 OK
>>> diff --git a/tests/btrfs/169 b/tests/btrfs/169
>>> index 009fdaee7c46..e507692fd0c6 100755
>>> --- a/tests/btrfs/169
>>> +++ b/tests/btrfs/169
>>> @@ -20,7 +20,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -44,7 +44,7 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_=
MNT/foobar | _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap1 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/sn=
ap1
>>> 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>>
>>> @@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap
>>> $SCRATCH_MNT/snap1 2>&1 \
>>> =C2=A0 $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap2 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f
>>> $send_files_dir/2.snap \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_=
MNT/snap2 2>&1 | _filter_scratch
>>>
>>> diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
>>> index ba77bf0adbe3..c3467d5162d9 100644
>>> --- a/tests/btrfs/169.out
>>> +++ b/tests/btrfs/169.out
>>> @@ -1,9 +1,9 @@
>>> =C2=A0 QA output created by 169
>>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> =C2=A0 At subvol SCRATCH_MNT/snap1
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> =C2=A0 At subvol SCRATCH_MNT/snap2
>>> =C2=A0 File digest in the original filesystem:
>>> =C2=A0 d31659e82e87798acd4669a1e0a19d4f=C2=A0 SCRATCH_MNT/snap2/foobar
>>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
>>> index ab105d36fb96..50b6fa8654d4 100755
>>> --- a/tests/btrfs/170
>>> +++ b/tests/btrfs/170
>>> @@ -12,7 +12,7 @@
>>> =C2=A0 _begin_fstest auto quick snapshot prealloc
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -46,7 +46,7 @@ md5sum $SCRATCH_MNT/foobar | _filter_scratch
>>>
>>> =C2=A0 # Create a snapshot of the subvolume where our file is.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Cleanly unmount the filesystem.
>>> =C2=A0 _scratch_unmount
>>> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
>>> index 4c5fd87a8b17..ebdf872c7eb2 100644
>>> --- a/tests/btrfs/170.out
>>> +++ b/tests/btrfs/170.out
>>> @@ -3,6 +3,6 @@ wrote 131072/131072 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 File digest after write:
>>> =C2=A0 85054e9e74bc3ae186d693890106b71f=C2=A0 SCRATCH_MNT/foobar
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 File digest after mounting the filesystem again:
>>> =C2=A0 85054e9e74bc3ae186d693890106b71f=C2=A0 SCRATCH_MNT/foobar
>>> diff --git a/tests/btrfs/187 b/tests/btrfs/187
>>> index d3cf05a1bd92..f0935c9e6516 100755
>>> --- a/tests/btrfs/187
>>> +++ b/tests/btrfs/187
>>> @@ -17,7 +17,7 @@ _begin_fstest auto send dedupe clone balance
>>>
>>> =C2=A0 # Import common functions.
>>> =C2=A0 . ./common/attr
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>>
>>> =C2=A0 # real QA test starts here
>>> @@ -152,7 +152,7 @@ done
>>> =C2=A0 wait ${create_pids[@]}
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Add some more files, so that that are substantial differences
>>> between the
>>> =C2=A0 # two test snapshots used for an incremental send later.
>>> @@ -184,7 +184,7 @@ done
>>> =C2=A0 wait ${setxattr_pids[@]}
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap2 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 full_send_loop 5 &
>>> =C2=A0 full_send_pid=3D$!
>>> diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
>>> index ab522cfe7e8c..208cfb212b8f 100644
>>> --- a/tests/btrfs/187.out
>>> +++ b/tests/btrfs/187.out
>>> @@ -1,3 +1,3 @@
>>> =C2=A0 QA output created by 187
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> diff --git a/tests/btrfs/188 b/tests/btrfs/188
>>> index fcaf84b15053..feeb4397c234 100755
>>> --- a/tests/btrfs/188
>>> +++ b/tests/btrfs/188
>>> @@ -21,7 +21,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 # real QA test starts here
>>> =C2=A0 _supported_fs btrfs
>>> @@ -45,16 +45,16 @@ $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K"
>>> $SCRATCH_MNT/foobar | _filter_xfs_io
>>> =C2=A0 $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/base 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/ba=
se
>>> 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Now punch a hole that drops all the extents within the file's=
 size.
>>> =C2=A0 $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/incr 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2=
.snap \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/incr 2>&1 | _filter_scratc=
h
>>> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
>>> index 260988e60084..586543cfde61 100644
>>> --- a/tests/btrfs/188.out
>>> +++ b/tests/btrfs/188.out
>>> @@ -1,9 +1,9 @@
>>> =C2=A0 QA output created by 188
>>> =C2=A0 wrote 512000/512000 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> =C2=A0 At subvol SCRATCH_MNT/base
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> =C2=A0 At subvol SCRATCH_MNT/incr
>>> =C2=A0 File digest in the original filesystem:
>>> =C2=A0 816df6f64deba63b029ca19d880ee10a=C2=A0 SCRATCH_MNT/incr/foobar
>>> diff --git a/tests/btrfs/189 b/tests/btrfs/189
>>> index ec6e56fa0020..244ca84299fa 100755
>>> --- a/tests/btrfs/189
>>> +++ b/tests/btrfs/189
>>> @@ -23,7 +23,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>>
>>> =C2=A0 # real QA test starts here
>>> @@ -46,7 +46,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M"
>>> $SCRATCH_MNT/baz | _filter_xfs_io
>>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo |
>>> _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/base 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/ba=
se
>>> 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
>>> index 79c70b03a1ba..a516167578e4 100644
>>> --- a/tests/btrfs/189.out
>>> +++ b/tests/btrfs/189.out
>>> @@ -7,7 +7,7 @@ wrote 2097152/2097152 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 wrote 2097152/2097152 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> =C2=A0 At subvol SCRATCH_MNT/base
>>> =C2=A0 linked 131072/131072 bytes at offset 655360
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> diff --git a/tests/btrfs/191 b/tests/btrfs/191
>>> index 3c565d0ad209..9c1fd80b7583 100755
>>> --- a/tests/btrfs/191
>>> +++ b/tests/btrfs/191
>>> @@ -19,7 +19,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>>
>>> =C2=A0 # real QA test starts here
>>> @@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K"
>>> $SCRATCH_MNT/foo | _filter_xfs_io
>>>
>>> =C2=A0 # Create the base snapshot and the parent send stream from it.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/mysnap1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap
>>> $SCRATCH_MNT/mysnap1 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> @@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M"
>>> $SCRATCH_MNT/bar | _filter_xfs_io
>>> =C2=A0 # Create the second snapshot, used for the incremental send, be=
fore
>>> doing the
>>> =C2=A0 # file deduplication.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/mysnap2 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Now before creating the incremental send stream:
>>> =C2=A0 #
>>> diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
>>> index 4269803cce1e..ad4d779814f7 100644
>>> --- a/tests/btrfs/191.out
>>> +++ b/tests/btrfs/191.out
>>> @@ -3,11 +3,11 @@ wrote 524288/524288 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 wrote 524288/524288 bytes at offset 524288
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
>>> =C2=A0 At subvol SCRATCH_MNT/mysnap1
>>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
>>> =C2=A0 deduped 524288/524288 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 deduped 524288/524288 bytes at offset 524288
>>> diff --git a/tests/btrfs/200 b/tests/btrfs/200
>>> index 5ce3775f2222..3d18165a630f 100755
>>> --- a/tests/btrfs/200
>>> +++ b/tests/btrfs/200
>>> @@ -19,7 +19,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>> =C2=A0 . ./common/punch
>>>
>>> @@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K"
>>> $SCRATCH_MNT/bar \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/base 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/ba=
se
>>> 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> @@ -64,7 +64,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K
>>> 64K" $SCRATCH_MNT/bar \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/incr 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2=
.snap \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/incr 2>&1 | _filter_scratc=
h
>>> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
>>> index 3eec567e97fe..5c1cd855fa99 100644
>>> --- a/tests/btrfs/200.out
>>> +++ b/tests/btrfs/200.out
>>> @@ -5,11 +5,11 @@ linked 65536/65536 bytes at offset 65536
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 wrote 65536/65536 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> =C2=A0 At subvol SCRATCH_MNT/base
>>> =C2=A0 linked 65536/65536 bytes at offset 65536
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> =C2=A0 At subvol SCRATCH_MNT/incr
>>> =C2=A0 At subvol base
>>> =C2=A0 At snapshot incr
>>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>>> index 5f0429f18bf9..57ecbe47c0bb 100755
>>> --- a/tests/btrfs/202
>>> +++ b/tests/btrfs/202
>>> @@ -8,7 +8,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick subvol snapshot
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 _supported_fs btrfs
>>> =C2=A0 _require_scratch
>>> @@ -28,7 +28,7 @@ _scratch_mount
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scra=
tch
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_sc=
ratch
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT=
/c \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Need the dummy entry created so that we get the invalid remov=
al
>>> when we rmdir
>>> =C2=A0 ls $SCRATCH_MNT/c/b
>>> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
>>> index 7f33d49f889c..6b80810e96ed 100644
>>> --- a/tests/btrfs/202.out
>>> +++ b/tests/btrfs/202.out
>>> @@ -1,4 +1,4 @@
>>> =C2=A0 QA output created by 202
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/a'
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/a/b'
>>> -Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>>> +Create snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>>> diff --git a/tests/btrfs/203 b/tests/btrfs/203
>>> index e506118e2cd2..e62f09edb570 100755
>>> --- a/tests/btrfs/203
>>> +++ b/tests/btrfs/203
>>> @@ -20,7 +20,7 @@ _cleanup()
>>> =C2=A0 }
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>>
>>> =C2=A0 # real QA test starts here
>>> @@ -44,7 +44,7 @@ _scratch_mount
>>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar |
>>> _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/base 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/ba=
se
>>> 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> @@ -70,7 +70,7 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_=
MNT/foobar | _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/incr 2>&1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2=
.snap \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_=
MNT/incr 2>&1 | _filter_scratch
>>> diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
>>> index 58739a98cd1b..59c2564bc61b 100644
>>> --- a/tests/btrfs/203.out
>>> +++ b/tests/btrfs/203.out
>>> @@ -1,7 +1,7 @@
>>> =C2=A0 QA output created by 203
>>> =C2=A0 wrote 65536/65536 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
>>> =C2=A0 At subvol SCRATCH_MNT/base
>>> =C2=A0 wrote 65536/65536 bytes at offset 524288
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> @@ -15,7 +15,7 @@ wrote 65536/65536 bytes at offset 786432
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 linked 196608/196608 bytes at offset 196608
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
>>> =C2=A0 At subvol SCRATCH_MNT/incr
>>> =C2=A0 File foobar digest in the original filesystem:
>>> =C2=A0 2b76b23b62fdbbbcae1ee37eec84fd7d
>>> diff --git a/tests/btrfs/226 b/tests/btrfs/226
>>> index 7034fcc7b2a5..f96a832505a4 100755
>>> --- a/tests/btrfs/226
>>> +++ b/tests/btrfs/226
>>> @@ -11,7 +11,7 @@
>>> =C2=A0 _begin_fstest auto quick rw snapshot clone prealloc punch
>>>
>>> =C2=A0 # Import common functions.
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>>
>>> =C2=A0 # real QA test starts here
>>> @@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_=
MNT/f2 | _filter_xfs_io
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/s=
nap \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 # Write into the range of the first extent so that that range n=
o
>>> longer has a
>>> =C2=A0 # shared extent.
>>> diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
>>> index c63982b0ba4a..1855e5255fce 100644
>>> --- a/tests/btrfs/226.out
>>> +++ b/tests/btrfs/226.out
>>> @@ -13,7 +13,7 @@ wrote 65536/65536 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 wrote 65536/65536 bytes at offset 65536
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 wrote 65536/65536 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 pwrite: Resource temporarily unavailable
>>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
>>> index f15f20824350..30799ebe449e 100755
>>> --- a/tests/btrfs/276
>>> +++ b/tests/btrfs/276
>>> @@ -105,7 +105,7 @@ sync
>>> =C2=A0 echo "Number of non-shared extents in the whole file:
>>> $(count_not_shared_extents)"
>>>
>>> =C2=A0 # Creating a snapshot.
>>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_snapshot
>>>
>>> =C2=A0 # We have a snapshot, so now all extents should be reported as =
shared.
>>> =C2=A0 echo "Number of shared extents in the whole file:
>>> $(count_shared_extents)"
>>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
>>> index 352e06b4d4b2..27ea29bdf87b 100644
>>> --- a/tests/btrfs/276.out
>>> +++ b/tests/btrfs/276.out
>>> @@ -1,6 +1,6 @@
>>> =C2=A0 QA output created by 276
>>> =C2=A0 Number of non-shared extents in the whole file: 2000
>>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 Number of shared extents in the whole file: 2000
>>> =C2=A0 wrote 65536/65536 bytes at offset 524288
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> diff --git a/tests/btrfs/280 b/tests/btrfs/280
>>> index fc049adb0b19..4957825b7e4b 100755
>>> --- a/tests/btrfs/280
>>> +++ b/tests/btrfs/280
>>> @@ -15,7 +15,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick compress snapshot fiemap
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/punch # for _filter_fiemap_flags
>>>
>>> =C2=A0 _supported_fs btrfs
>>> @@ -37,7 +37,7 @@ _scratch_mount -o compress
>>> =C2=A0 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo |
>>> _filter_xfs_io
>>>
>>> =C2=A0 # Create a RW snapshot of the default subvolume.
>>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap |
>>> _filter_snapshot
>>>
>>> =C2=A0 echo
>>> =C2=A0 echo "File foo fiemap before COWing extent:"
>>> diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
>>> index 5371f3b01551..4f0e5d2287b6 100644
>>> --- a/tests/btrfs/280.out
>>> +++ b/tests/btrfs/280.out
>>> @@ -1,7 +1,7 @@
>>> =C2=A0 QA output created by 280
>>> =C2=A0 wrote 134217728/134217728 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>>
>>> =C2=A0 File foo fiemap before COWing extent:
>>>
>>> diff --git a/tests/btrfs/281 b/tests/btrfs/281
>>> index ddc7d9e8b06d..2943998bee20 100755
>>> --- a/tests/btrfs/281
>>> +++ b/tests/btrfs/281
>>> @@ -15,7 +15,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick send compress clone fiemap
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>> =C2=A0 . ./common/punch # for _filter_fiemap_flags
>>>
>>> @@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K"
>>> $SCRATCH_MNT/foo \
>>>
>>> =C2=A0 echo "Creating snapshot and a send stream for it..."
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>> =C2=A0 $BTRFS_UTIL_PROG send --compressed-data -f $send_stream
>>> $SCRATCH_MNT/snap 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>>
>>> diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
>>> index 2585e3e567db..49c23a00baea 100644
>>> --- a/tests/btrfs/281.out
>>> +++ b/tests/btrfs/281.out
>>> @@ -6,7 +6,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX
>>> ops/sec)
>>> =C2=A0 linked 65536/65536 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 Creating snapshot and a send stream for it...
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 At subvol SCRATCH_MNT/snap
>>> =C2=A0 Creating a new filesystem to receive the send stream...
>>> =C2=A0 At subvol snap
>>> diff --git a/tests/btrfs/283 b/tests/btrfs/283
>>> index 118df08b8958..d9b8c1d24b8f 100755
>>> --- a/tests/btrfs/283
>>> +++ b/tests/btrfs/283
>>> @@ -11,7 +11,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick send clone fiemap
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>> =C2=A0 . ./common/reflink
>>> =C2=A0 . ./common/punch # for _filter_fiemap_flags
>>>
>>> @@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K"
>>> $SCRATCH_MNT/foo | _filter_xfs_i
>>>
>>> =C2=A0 echo "Creating snapshot and a send stream for it..."
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 |
>>> _filter_scratch
>>>
>>> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
>>> index 286dae332eff..37f425bf8312 100644
>>> --- a/tests/btrfs/283.out
>>> +++ b/tests/btrfs/283.out
>>> @@ -4,7 +4,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX
>>> ops/sec)
>>> =C2=A0 wrote 65536/65536 bytes at offset 65536
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 Creating snapshot and a send stream for it...
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
>>> =C2=A0 At subvol SCRATCH_MNT/snap
>>> =C2=A0 Creating a new filesystem to receive the send stream...
>>> =C2=A0 At subvol snap
>>> diff --git a/tests/btrfs/287 b/tests/btrfs/287
>>> index 64e6ef35250c..dec812760917 100755
>>> --- a/tests/btrfs/287
>>> +++ b/tests/btrfs/287
>>> @@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
>>>
>>> =C2=A0 # Now create two snapshots and then do some queries.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap1 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap2 \
>>> -=C2=A0=C2=A0=C2=A0 | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0 | _filter_snapshot
>>>
>>> =C2=A0 snap1_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
>>> =C2=A0 snap2_id=3D$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
>>> diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
>>> index 30eac8fa444c..5798ec5d7c55 100644
>>> --- a/tests/btrfs/287.out
>>> +++ b/tests/btrfs/287.out
>>> @@ -41,8 +41,8 @@ resolve first extent +3M offset with ignore offset
>>> option:
>>> =C2=A0 inode 257 offset 16777216 root 5
>>> =C2=A0 inode 257 offset 8388608 root 5
>>> =C2=A0 inode 257 offset 2097152 root 5
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> =C2=A0 resolve first extent:
>>> =C2=A0 inode 257 offset 16777216 snap2
>>> =C2=A0 inode 257 offset 8388608 snap2
>>> diff --git a/tests/btrfs/293 b/tests/btrfs/293
>>> index 06f96dc414b0..fffdcd53441a 100755
>>> --- a/tests/btrfs/293
>>> +++ b/tests/btrfs/293
>>> @@ -32,9 +32,9 @@ swap_file=3D"$SCRATCH_MNT/swapfile"
>>> =C2=A0 _format_swapfile $swap_file $(($(_get_page_size) * 64)) >>
>>> $seqres.full
>>>
>>> =C2=A0 echo "Creating first snapshot..."
>>> -$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap1 | _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT
>>> $SCRATCH_MNT/snap1 | _filter_snapshot
>>> =C2=A0 echo "Creating second snapshot..."
>>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2
>>> | _filter_scratch
>>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2
>>> | _filter_snapshot
>>>
>>> =C2=A0 echo "Activating swap file... (should fail due to snapshots)"
>>> =C2=A0 _swapon_file $swap_file 2>&1 | _filter_scratch
>>> diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
>>> index fd04ac9139b8..7b2947a705e7 100644
>>> --- a/tests/btrfs/293.out
>>> +++ b/tests/btrfs/293.out
>>> @@ -1,8 +1,8 @@
>>> =C2=A0 QA output created by 293
>>> =C2=A0 Creating first snapshot...
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> =C2=A0 Creating second snapshot...
>>> -Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> +Create snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
>>> =C2=A0 Activating swap file... (should fail due to snapshots)
>>> =C2=A0 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
>>> =C2=A0 Deleting first snapshot...
>>> diff --git a/tests/btrfs/300 b/tests/btrfs/300
>>> index 8a0eaecf87f7..00ffcb82eae6 100755
>>> --- a/tests/btrfs/300
>>> +++ b/tests/btrfs/300
>>> @@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
>>> =C2=A0 touch subvol/{1,2,3};
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
>>> =C2=A0 touch subvol/subsubvol/{4,5,6};
>>> -$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
>>> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot | sed -e
>>> 's/Create a/Create/g';
>>> =C2=A0 "
>>>
>>> =C2=A0 find $test_dir/. -printf "%M %u %g ./%P\n"
>>> diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
>>> index 6e94447e87ac..06a75bff5ce1 100644
>>> --- a/tests/btrfs/300.out
>>> +++ b/tests/btrfs/300.out
>>> @@ -1,7 +1,7 @@
>>> =C2=A0 QA output created by 300
>>> =C2=A0 Create subvolume './subvol'
>>> =C2=A0 Create subvolume 'subvol/subsubvol'
>>> -Create a snapshot of 'subvol' in './snapshot'
>>> +Create snapshot of 'subvol' in './snapshot'
>>> =C2=A0 drwxr-xr-x fsgqa fsgqa ./
>>> =C2=A0 drwxr-xr-x fsgqa fsgqa ./subvol
>>> =C2=A0 -rw-r--r-- fsgqa fsgqa ./subvol/1
>>> diff --git a/tests/btrfs/302 b/tests/btrfs/302
>>> index f3e6044b5251..52d712ac50de 100755
>>> --- a/tests/btrfs/302
>>> +++ b/tests/btrfs/302
>>> @@ -15,7 +15,7 @@
>>> =C2=A0 . ./common/preamble
>>> =C2=A0 _begin_fstest auto quick snapshot subvol
>>>
>>> -. ./common/filter
>>> +. ./common/filter.btrfs
>>>
>>> =C2=A0 _supported_fs btrfs
>>> =C2=A0 _require_scratch
>>> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>>> =C2=A0 # Now create a snapshot of the subvolume and make it accessible
>>> from within the
>>> =C2=A0 # subvolume.
>>> =C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/=
snap | _filter_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 $SCRATCH_MNT/subvol/snap | _filter_snapshot
>>>
>>> =C2=A0 # Now unmount and mount again the fs. We want to verify we are =
able
>>> to read all
>>> =C2=A0 # metadata for the snapshot from disk (no IO failures, etc).
>>> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
>>> index 8770aefc99c8..c08f8c135538 100644
>>> --- a/tests/btrfs/302.out
>>> +++ b/tests/btrfs/302.out
>>> @@ -1,4 +1,4 @@
>>> =C2=A0 QA output created by 302
>>> =C2=A0 Create subvolume 'SCRATCH_MNT/subvol'
>>> -Create a readonly snapshot of 'SCRATCH_MNT/subvol' in
>>> 'SCRATCH_MNT/subvol/snap'
>>> +Create readonly snapshot of 'SCRATCH_MNT/subvol' in
>>> 'SCRATCH_MNT/subvol/snap'
>>> =C2=A0 OK
>>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>>> index 887cb69eb79c..598af611d249 100755
>>> --- a/tests/btrfs/314
>>> +++ b/tests/btrfs/314
>>> @@ -43,7 +43,7 @@ send_receive_tempfsid()
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000=
' ${src}/foo |
>>> _filter_xfs_io
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG subvolume snapshot -r =
${src} ${src}/snap1 | \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fil=
ter_testdir_and_scratch
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 _filter_snapshot
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo Send ${src} | _filter_testdir_and_=
scratch
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG send -f ${sendfile} ${=
src}/snap1 2>&1 | \
>>> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
>>> index 21963899c2b2..d29fe51b3ff9 100644
>>> --- a/tests/btrfs/314.out
>>> +++ b/tests/btrfs/314.out
>>> @@ -3,7 +3,7 @@ QA output created by 314
>>> =C2=A0 From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid=
_mnt
>>> =C2=A0 wrote 9000/9000 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> +Create readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
>>> =C2=A0 Send SCRATCH_MNT
>>> =C2=A0 At subvol SCRATCH_MNT/snap1
>>> =C2=A0 Receive TEST_DIR/314/tempfsid_mnt
>>> @@ -14,7 +14,7 @@ Recv:=C2=A0=C2=A0=C2=A0 42d69d1a6d333a7ebdf64792a555=
e392
>>> TEST_DIR/314/tempfsid_mnt/snap1/foo
>>> =C2=A0 From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH=
_MNT
>>> =C2=A0 wrote 9000/9000 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in
>>> 'TEST_DIR/314/tempfsid_mnt/snap1'
>>> +Create readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in
>>> 'TEST_DIR/314/tempfsid_mnt/snap1'
>>> =C2=A0 Send TEST_DIR/314/tempfsid_mnt
>>> =C2=A0 At subvol TEST_DIR/314/tempfsid_mnt/snap1
>>> =C2=A0 Receive SCRATCH_MNT

