Return-Path: <linux-btrfs+bounces-7055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F6894C6FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571521C222BE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107015ECE6;
	Thu,  8 Aug 2024 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KSpynI01"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9B15F3E6
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156092; cv=none; b=T9V8N10JiL2Jxg8OepIJSz9mwMSosRpysj7TAPkoSSEBO304/S0ESJK8XRg/14EtGcr29x+ZAgzCGGRSk2O8WxAJL8sCvdaNHJJgbqKY2i70gLh0a9jsKKxWaQCpA3iBAD13dTpnAhXhQsPXD4btXlVW3+wsyHUMFxOO1U547po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156092; c=relaxed/simple;
	bh=feyT6Tavm7hFAqMaEyVXmVdn+pCsb1g3BvOroBE4KCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OsjIq92ksjSpR9NChUJC9sn0NvkaJXDnwCz5PO0ivHsNhO3e9dxW+jdC7Dw4nAEbwcEZ/AnzvfzAe+UGk3BbSqVtifvNH3iJTOSHoEsoT7bALJqgDYYrU6EgO101W1wz9kfrJEf+4SKU2xYTYRVJvoKo60YxovKh+BD89El1rRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KSpynI01; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723156087; x=1723760887; i=quwenruo.btrfs@gmx.com;
	bh=feyT6Tavm7hFAqMaEyVXmVdn+pCsb1g3BvOroBE4KCw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KSpynI018jZUqP3EepVHd5AgFaObx6UxkUzP0zUdfGrDUX8tg7qXgDYXOfSUWuCi
	 YBPnPymdZ2LicMaxtoYddT2Afl90fXFqAixORuNgkQvYJ8imt7a7xj3EMLeHC3Bgk
	 zRDdI+N9YqATZQurk3UbRBmCuuH3t9qCFfH+Imf7/xTEDYRyw+4d8/IGxZLOWO5ma
	 eowdbfgDuAIP0biZFdUq4wWA5mX9Lc+abbwixXFh5q4l6i2XI9/aC34AEnQd35I3d
	 VLcZhFCNiM3ObzPCi81KrQA9KPm2Qa08CvS3F452Vt+OptYv06gWtIP7w/ddv4ZOw
	 FK1Q1yno780OpymVTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1skg2Z1kJN-00T9XF; Fri, 09
 Aug 2024 00:28:06 +0200
Message-ID: <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
Date: Fri, 9 Aug 2024 07:58:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: =?UTF-8?Q?Andr=C3=A9_KALOUGUINE?= <andre.kalouguine@ensta-paris.fr>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
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
In-Reply-To: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3wekxcnTdTM9UGK5nYccpE+iav19tm5GdLY/7bfGMJYhb+XeXl
 0a9/FIf8PczORsZkKrkMrXp85kbO41UcG1rEZC43ECAv32KL8PEKHh5DcoObJYJJ/t/8QHU
 golGcm5Zv/QpGd4SDo0SetWx4q7F3g7OSiGyRkNan/mfw5pbj+LSTPZZoEO+cO+U3CdGGaS
 IZtrjJYW4flkxIHM558UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hDQX8pT/dis=;OOcmF8NJNuP64VLxxXxpCJ7atse
 SLQfp2Iuf3PirnoDWqLoJzOp0WFr46AYitG0ZB1ERqTTqY693oO5A1RSUOQEKUxiuwGuNdo1P
 awnFEyDXw7bliDh7CLWLpSVWxqGg3YguK3uvrE4aQDYIR8KmGIPSIsCrDK+uEaqu3gJ1vJsy5
 /xdoiXB1nFogTm2cqiaFt0dsHAgqsyB2m9SCbxylWKfGYWrp/eM3Bltydwo0DWkuqLMMOAUrB
 cfxMuhkJDfrJjMbb/13UFleVAwII+9m6trqTjLeCmwj5xfiD5FawrAz3LMpIITFKVRGoxQv9K
 3GTAYpmh+FZ3ss9RUr/UmGyN+pvjOrYchpq+zPoSfdL2D2IWERbN/jdJvB6rBNnvb78BXyycW
 fyDfLW6mDRu7X0ivicUMAX9fPzQT/GWGjuAIz7qH13VZ3/BVScNE4nhkIdieCt3tCzB+mXo0h
 SRqRSpIcy/KgzZTarTbJFDuX854V6FcLlcWuYjjAEDdbs6iWwkSQaAtFM0ViDsW0J4S5NwpBy
 buzZXz8vUruooXYTtw6g26EnxGULDMsK224Hf1hC7UNEZvmCdDLqc/cO3ZBKvy2L1w7/aBs7K
 7XEgFSrorG8NBjs95LjqAa0An0hZaSSd95nk+PgkWJDCX7t4SkecilmsSK1W17hm/kCrietxb
 M6Jz8M452gET60PE7kBGRaxAufEUDHgjO0Wsyvc8dqbWjHhEtt6S2UpZIIBC11lbBDU98oq3f
 7JzXNlsc8qBtVDKRWm+XT2FOz9f6E375d5aKVMlTuNQJ81NaZwbP2De8i50K7KycvztI+tW2v
 VN4pJy702aF0mj+0K+crsCixVZiLgM1hzLnUeK/4Wa9Wo=



=E5=9C=A8 2024/8/9 05:48, Andr=C3=A9 KALOUGUINE =E5=86=99=E9=81=93:
> Hi,
> I have a system running Arch Linux, kernel 6.10, with the system install=
ed on a btrfs partition (with a @home subvolume). I had a kernel panic tod=
ay and after hard rebooting, the disk can't be mounted. Under a live USB, =
mounting gives:
>
> BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want 2116=
58031104 have 0
> BTRFS error (device nvme1n1p3): bad tree block start, mirror 2=C2=A0want=
 211658031104 have 0

This means some tree blocks are just wiped out from the disk.

Either it's the async discard (which is now enabled by default as long
as the device supports, and I doubt it's the case) or the hardware is
not properly doing flush.

Mind to share the model of the NVME device?
And I guess you didn't do anything dangerous like "nobarrier" mount
option for the fs?

Furthermore, the error message doesn't show which tree is causing the
problem, which I hope it's not some critical trees.

So you can always try "-o rescue=3Dall,ro" mount first to see if btrfs can
still access the critical subvolume trees.
If that works, you still have a good chance salvaging most of your data.

Thanks,
Qu

> BTRFS error (device nvme1n1p3): open_ctree failed
>
> I am planning on doing a dd copy of the partition once I find a big enou=
gh disk, so I'll be able to try risky commands if necessary.
> In the meantime, is there anything I can try? I only need to recover a f=
older with some text files.
>
> A small request: please don't rub salt on a wound! I'm well aware of how=
 moronic =C2=A0it is working on code without making backups, pushing commi=
ts upstream etc... Especially on an unfamiliar file system. Catastrophic m=
istakes happen and I would really appreciate people trusting that I learne=
d the lesson and being kind enough to avoid comments about the need for ba=
ckups.
>
> Lastly, I do apologise if at any point I seem ungrateful or anything. I =
greatly appreciate any help even if doesn't lead anywhere. I'm just having=
 a really really bad day, losing nearly 2 months worth of work because I f=
orgot to back up.
> A PhD already doesn't last nearly long enough to do all that needs to be=
 done and wasting more than a month of work (though I could now write it f=
aster) is really disheartening.
>
> Thanks in advance for any piece of advice.
> Best regards,
>
> Andre
>

