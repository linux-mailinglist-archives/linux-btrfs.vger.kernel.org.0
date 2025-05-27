Return-Path: <linux-btrfs+bounces-14248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8DAC477A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 07:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42C6177550
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 05:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202222AF10;
	Tue, 27 May 2025 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gPPeEecO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83956382
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748323022; cv=none; b=CDI7jR/nkzjPMarHoRrH0XE0LD6L9qMKnX5JqTn+kbrbicnvjlnyKIeDOhFI8REbGKqfdNP7xKaec9cArY/8gX0Y8qV12PceQ/+3CWyjw6D5T2X1zddxEtm2sZdmU+J1h1ihu5jg8uteCStnfxDNH5UCI1XfUvK+/pTAUeYIZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748323022; c=relaxed/simple;
	bh=esG+fnS5boJy7urLllQaxWok2F/sRJonanHmOVwwzpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fgGrpIHPE0lSDj9LDJ2Q9wsHjFVJCHsOlZz/2e7A2yegSbvccsElc1525hPRoaf4ejCFvQ1W5PUJ8d81DM9XeqofSyR/+69++/d6A1bx80rODrMgn5YYorvQXfmtodn7ITnniwyCXSf234gQrDy5D7umnutJMlcR/YE5vhs+k1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gPPeEecO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748323017; x=1748927817; i=quwenruo.btrfs@gmx.com;
	bh=zlz0qDMSxde1cZHLvFKWAcYOBzN9qE+Juz+7oeEPAus=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gPPeEecO25mSnWHYXs7t2yoM4ytZL/vOcCkhiJTITMu02yd4fLeSmEDTaUwyPwNh
	 MyDbpGPaQ4bRs9PzMKAWx0quHPZEZTzxXUo6Ww8zDHY9rp2PYqhYv9pN9Uj66eeDg
	 QpI2FnZ6PUFVTVHLcDvtct5lTSz764DKzZ95Xi3bK22/3U6YmC+5pmJH4OQGgsc9F
	 QSrX5JBXKfeWi/iJqtIkUtpxThNWVTODy3wfUjfJKtCkhnKYiJtNQWDpu+HtP3wGr
	 2FM6QWaalqn46xXMoH+Ww0S4QYS36c9MIHsOb8jhqsyubyHv6Q66WHxI10U/JzyWb
	 r8NOqWD7f5IbzhVQJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1uRjA73GgJ-00Yjyx; Tue, 27
 May 2025 07:16:57 +0200
Message-ID: <3d1c4611-d385-4d31-96de-3a617e02c94c@gmx.com>
Date: Tue, 27 May 2025 14:46:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Portable HDD Keeps Going Read Only
To: Matthew Jurgens <btrfs@edcint.co.nz>, linux-btrfs@vger.kernel.org
References: <7e8abcd3-c84c-4cd3-8cec-3a51fcf98670@edcint.co.nz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <7e8abcd3-c84c-4cd3-8cec-3a51fcf98670@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uqIYJMaK0JV9ephfXpambj2EKgza2vpsxQ6X/J5sLrhVid5u2U8
 dDQFmp0ZyNCmvVIThgkMc0cUt/oDUEfcsBSPX1sof6ej4r+XrJ9oeP3OmfttwxCXLcAFX/y
 fH5cjsrKa5v+0tjcsB2WXhXbyLblOKaW40BzeKO7+IMdnoUsqlISreNFSYnL0fIea+vFJ4Z
 NL4mT0VRDsGOfncED5Riw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PsxGoyfMiQg=;OtRTThWzl/Obz0VmTZzfmIG68+x
 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



=E5=9C=A8 2025/5/27 13:28, Matthew Jurgens =E5=86=99=E9=81=93:
> I have a portable HDD that I just use for backups (so I can lose the=20
> data on this drive if I need to).
>=20
> It keeps going read only. Sometimes at mount time and other times after=
=20
> a small amount of usage.
>=20
> The dmesg and btrfs check output is large so I have attached it.
>=20
> Steps:
>=20
> 1. connect drive via USB. The system tries to automatically mount it.=20
> The drive mounts as read only. The result of this is in dmesg1.txt
>=20
> 2. umount the drive. Run a btrfs check. This results of this check are=
=20
> in btrfs_check1.txt
>=20
> 3. mount drive manually. Drive appears to mount ok. Run a find over the=
=20
> drive. It starts listing lots of file. Cancel the find. Start a scrub.=
=20
> The scrub aborts within a few seconds. The result of this a in dmesg2.tx=
t
>=20
> This is now the 2nd portable drive that I have that has had a problem=20
> with data on the BTRFS file system in about a month. I just recreated=20
> the file system on the other drive. But this time, I'd like to see if=20
> anyone can help with finding out what is going wrong.

The fsck result shows the fs has extent tree corruption on the free=20
space cache tree.

There are free space tree blocks but without its proper backref items.

On the other hand, there are a lot of tree backrefs without a proper=20
tree block.

Just judging from the bytenr, I can't find an obvious clue, the=20
differences are pretty large, definitely not simple bitflip.

But as usual, mind to run a memtest just in case?

Thanks,
Qu

>=20
> uname -a
> Linux host 6.14.6-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May 9=20
> 20:11:19 UTC 2025 x86_64 GNU/Linux
>=20
> btrfs --version
> btrfs-progs v6.14
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED=20
> CRYPTO=3Dlibgcrypt
>=20
> btrfs fi show
> Label: 'PHDD_WD5TB'=C2=A0 uuid: 83f64b18-a2e8-443b-bfa8-78ff90dc86de
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes use=
d 3.67TiB
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 4.55TiB used 3.69TiB path /dev/sdb
>

