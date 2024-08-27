Return-Path: <linux-btrfs+bounces-7546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08919605A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B4C1C22C76
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74219CD0F;
	Tue, 27 Aug 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CYVsOtTR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24413BAE4
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751190; cv=none; b=Na5uPqivQ7gsOIVnwzrfUekibSqpwAl+RrwvF76bE2xPZTtzxGVa1kcozNYWMa4sw/TSZBntQy4TYAVvPn3ny7FtudTI5RnviAAzfyQwNyM6MiLieuhoSl58GgjUSmpgWe5jGUs8BBk9Ax/OGPGmcdaYBRN4sV+MKw92FEpIcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751190; c=relaxed/simple;
	bh=seGUFddA6rvBiliDZheztxdk/jiY4lwqceEecivjatQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ETPR1Eyldiw6WdraTAvM3VyZqjz8C2DSx80gSUDXxv2mYy+ClLYaCoxUheoUz6pkP7Fttq0oagNJd/JDP5ubHobiqlsVK4WohwP/49tGQGYclW4TdxtzWqlxOELLVQI6F3Q2kKU/YlaMyO77cExzBoGOHIfBHcV5az/fdRoUOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CYVsOtTR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724751184; x=1725355984; i=quwenruo.btrfs@gmx.com;
	bh=seGUFddA6rvBiliDZheztxdk/jiY4lwqceEecivjatQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CYVsOtTROihjHgK/S3ZwZqLa7puE8vTp0AO0OAGGHOkJrPuH6o01YaehbiJiw/DG
	 BXbb4DVDk5S+5TguaYJixmwSj1/Kd3Ce1UkPqn1e1D6ttE7dyMIuPk4QYbzEYrGZU
	 qyDooMT+6c2pqjU6c690sW9Z2PSkyXDsHHXwgswpYUL23W9ajuK5bgB0pEoJ/Q01T
	 UYclsrT1OXjZcTXo6/GoO8f7eUCAhfHMttcQ6bivO+OvSh/5+98PphvshMfuJdiWJ
	 nVLTizmmmUl1jQisGxNESuZQoslHurn6ht2zBMg/QVQzBeccEZxBwtpBclNYJaQ7s
	 k7uoDVmBFhOs+iTiig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1rydiJ2tTM-0107u2; Tue, 27
 Aug 2024 11:33:04 +0200
Message-ID: <c29529ca-e6b5-4979-a25a-b254a4d800d0@gmx.com>
Date: Tue, 27 Aug 2024 19:03:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6d90baa9-ffc1-4c9d-87b2-4ba89983bef1@gmx.com>
 <AS8P250MB08869C932AF99C5C087F1B408F8B2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <012717c6-4e7e-44e9-9906-5f13e4273c35@gmx.com>
 <AS8P250MB08866EFCC85A9CCCAF99E65E8F942@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <6f7117dd-a9ba-4c0a-be4b-6adae1be98d3@gmx.com>
 <bc8701ab-0054-48c7-88d9-6fd9e856cde7@gmx.com>
Content-Language: en-US
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
In-Reply-To: <bc8701ab-0054-48c7-88d9-6fd9e856cde7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NeDiZR5KSWFPWknfJpLOFLYr+UakHUKvBll07TG68Io6gGC4sKv
 lMmxTDiBbEMTkvoCXlkDnea0Xh9YxKDBwrbZRVwgUmRmbUxaSADx/CUQYKFYdiG6Xiqi/9Z
 Q+FPtWGX6hxcZjioEVfmdRfFQcfr+nhobn8i6PHcc9+2kx6bQYBBhMoGkLwFXn6gtNguETN
 8UDUXkftqljlX5f820QqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JF6T2wsBRTc=;R3ymN72+xB4Ex0TQyZcZGyOA3iB
 QJmmi73CJjQL7buF41fD2ve1h782Iaq+bH2SGPHdn1lAOifVPj/CrXBN7UTrfaiysuItVO/cQ
 51cw87gXCYgg2XvW3rl4xKo3wI27f94Cpw9BcYLFk2UQ25TVtXiH+fvUxlgzKs/aoHbyhQ1B5
 26mtV6jFlrrIo+Rp8m5I6EJ0L9sMdcavXRRMc8T2h8HhzK/tGkXpnPuTGCJqL5hsIghm150xS
 V05x58lJ4FTpUajD1CSuEwFd02SXVXTDIjiztHDiqrnTm18KJKetm/wR/oHB8WmRvBEGQlwdR
 yVCDDaQbm2eMaRctRJ4cRemgzyak+M0hIfFkJ0VOLiigC1kCdKqDEPXCNbdA19SBQWEPYAIRE
 RNixGaKR4lAUr7UVDrn32M01yazKTaucavsMwzQ+2LoZpX5h2/STWjwsFCTp1LCNP5Lahf2g8
 gapS+JTr7XsY8opd2zJexVQPNl32e8zxReUw2bqhcF1YuStALRqC9F1tkIGUJGNysWtuPqFMw
 ZXd/yqdZpXfRe3BwcG7gnuxxMLTdlDqH5+/kpIPJO9M7nmZs9Bj6SYwOzuNilOhiNhyOpCBOL
 XTbW1O1o2pmqjmZdubSQOplTvFTum1rVVNt2Cw3ig8XcN6uRr2/39fcjzrRTlpN98jvEP5yCl
 oUk+pzBrCfC9cRkGr2EpUk7/r5vHGSV45J+N9hDeTDtq3DSc6EfYV0G6cF9fZ+6bhruoYPOjh
 vr+s1RZ4199Oet65Fd3wHIgUi3pazWacSTo7G6NOoYci0tIurCoOTFEzkxhaF2rhUxEQlfZTE
 a9QJ/16z3B0wP7Z4bqc4YFcQ==



=E5=9C=A8 2024/8/27 16:21, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/8/27 14:49, Qu Wenruo =E5=86=99=E9=81=93:
>>
>>
>> =E5=9C=A8 2024/8/27 10:17, Pieter P =E5=86=99=E9=81=93:
>>> On 27/08/2024 01:18, Qu Wenruo wrote:
>>>> After your latest --repair try, the fs should be more or less fine, y=
ou
>>>> can try remove the offending file.
>>>>
>>>> Just a minor problem left with the superblock used bytes, that can be
>>>> fixed by another "btrfs check --repair" run very safely.
>>>
>>> No luck, unfortunately. Removing the file fails (automatically gets
>>> re-mounted read-only, and the file re-appears), and btrfs check --repa=
ir
>>> fails to repair the super bytes_used error (output attached).
>>>
>>>> Another possibility is, the fs is old and you just migrated the
>>>> drive/fs
>>>> to the current platform, but I doubt about the case considering the
>>>> file
>>>> is some browser cache, which shouldn't be that old.
>>>>
>>>> Just in case, mind to try something like memtest86+ (UEFI payload) or
>>>> memtester (inside the OS) to rule out the hardware problem?
>>>
>>> The fs is only around 1.5 years old, it never left the system. The fil=
e
>>> was last modified on July 22. I'll run another memtest.
>>
>> Anyway considering it's not going to be resolved by repair, I can craft
>> a dedicated tool, if you can compile btrfs-progs.
>>
>> That should fix modify that specific file extent (root 257 ino 50058751
>> filepos 0) by changing its on-disk bytenr to the correctly.
>>
>> Will let you know when the tool is done (should be pretty soon)
>
> Here is the hand crafted fix for you:
>
> https://github.com/adam900710/btrfs-progs/tree/dirty_fixes
>
> The usage is:
>
> # ./btrfs-corrupt-block -X <device>
>
> The fs must be unmounted.

And it's better to run "btrfs check --readonly" after a successful run
(the successful should result no output), and paste the output of the
btrfs-check.

If there is something wrong, the program should output something and
please paste it here.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>> Thanks,
>> Qu
>>>
>>> Thank you,
>>> Pieter
>>>
>>
>

