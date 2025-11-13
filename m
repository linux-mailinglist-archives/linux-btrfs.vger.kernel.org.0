Return-Path: <linux-btrfs+bounces-18968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6335C5A675
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 23:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B3CA351C8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 22:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E738326957;
	Thu, 13 Nov 2025 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X/FK3aJR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCF2E4274
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074504; cv=none; b=DAvEICGVv1q8471Q4Ayn6PBgXJqF4SACQvLUuZuj0UeLYZjGudDKHzCsi83eYHY+jVzQkygrDZPtqe7m7bUKvWkR3Ukvy80lde2OXiXtdioJWI7/5/cGiY0DkymXVh3fwwiHdjuJ/tRXvbzLsVZ0WiTakk3ZQdu3hMF157zYy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074504; c=relaxed/simple;
	bh=b8fEmefVjgn+3goEwniQd8UZestWYjKkr8Th2IXtwpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KQF/2g5Gt1BGzTLvfS8CEoHbIMjq5jelEF8BR6JovJfpcvxTGyjTpOPndXmT+L/bG4pDF9qXlFVlChZm83+jZ3qPrAezEnMvAxgkXvs4KSYpzmG+SK3zppTo7g/y8H7zF18siq7NOT1dXUXcyVpMA0D99bPwT0EfWS70d1okEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X/FK3aJR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763074500; x=1763679300; i=quwenruo.btrfs@gmx.com;
	bh=b8fEmefVjgn+3goEwniQd8UZestWYjKkr8Th2IXtwpY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X/FK3aJRXF0kFsGbJR/XtKenS8+utAMgCXyxODeFHjl5MagcHtuyeyBP5PzpNgKo
	 Tj9c19Hy+NKJGeI/U30vMW+MKkLvn8840B84/qlhZZzGkOOj+mz1m8B3rVT3gk31N
	 KoPYTzAxUwSEhSxNrOid6N3EigXWJxAwxSkzZuFGDPGALxnuts26+bbuwqmFsWSMw
	 enZmFP9rS6p9VX+4jSp19drB07po1ObEtFUOOQlDRsJpcWgJFAnMFkyWHP4+QUrPS
	 ADlO13z77T3BKBUym+M6njG7bxLEk0CFQ/ju/Qt8AxjnBk0Dc1YUFzDFPp8lo4IeS
	 tBGmxxm6qZ+GsNpQLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1wJ2HI2JNL-017bcF; Thu, 13
 Nov 2025 23:55:00 +0100
Message-ID: <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
Date: Fri, 14 Nov 2025 09:24:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Paul Graff <pj.world@gmx.com>, linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
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
In-Reply-To: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XlIqL05CvYZSNnxoOyyRUjQttuYkNZTnIXUHLI4rHGd7GpuE20Y
 rZ534QAU7TjgdsGeYpjnhziqA4mpLJTiM/eHv2TSbmnwma76I4JcbhcCXOUugNr0DIYz3vZ
 eStqoSTq6W7rnzoHGRmHDokJtzOwAzpSaHiAuO8sRvG41CETjcHy9RyNT3mYR0VfY6Kk9GE
 ng28XZMl27lL90Oi/TFcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:igNXoID3cis=;OXeqC7+EaLESjIgIHRcWcKlA28e
 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



=E5=9C=A8 2025/11/14 09:10, Paul Graff =E5=86=99=E9=81=93:
> Hi, currently there is a dropped subvolume error when running a full=20
> balance on a single SSD.
>=20
> |:~> sudo btrfs balance start / WARNING: Full balance without filters=20
> requested. This operation is very intense and takes potentially very=20
> long. It is recommended to use the balance filters to narrow down the=20
> scope of balance. Use 'btrfs balance start --full-balance' option to=20
> skip this warning. The operation will start in 10 seconds. Use Ctrl-C to=
=20
> stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any filters.=20
> ERROR: error during balancing '/': Structure needs cleaning There may be=
=20
> more info in syslog - try dmesg | tail hightower-i5-6600k:~> dmesg |=20
> tail [38576.407681] [ T29728] BTRFS info (device dm-2): found 37170=20
> extents, stage: update data pointers [38584.873805] [ T29728] BTRFS info=
=20
> (device dm-2): relocating block group 64891125760 flags data=20
> [38607.693519] [ T29728] BTRFS info (device dm-2): found 33194 extents,=
=20
> stage: move data extents [38641.574032] [ T29728] BTRFS info (device=20
> dm-2): found 33194 extents, stage: update data pointers [38649.812477]=
=20
> [ T29728] BTRFS info (device dm-2): relocating block group 62710087680=
=20
> flags data [38662.710999] [ T29728] BTRFS info (device dm-2): found=20
> 43884 extents, stage: move data extents [38696.292982] [ T29728] BTRFS=
=20
> info (device dm-2): found 43884 extents, stage: update data pointers=20
> [38708.587669] [ T29728] BTRFS info (device dm-2): relocating block=20
> group 60294168576 flags metadata|dup [38714.889735] [ T29728] BTRFS=20
> error (device dm-2): cannot relocate partially dropped subvolume 490,=20
> drop progress key (853588 108 0) [38723.736887] [ T29728] BTRFS info=20
> (device dm-2): balance: ended with status: -117 hightower-i5-6600k:~>|

The format is a mess.
Please provide a proper formatted dmesg instead.

Along with the kernel version.

The relocation is rejected because there is a half-dropped subvolume,=20
which is not that common.
It maybe a problem with the fs that there are some ghost subvolumes that=
=20
are never dropped.

There used to be kernel bug that can lead to such ghost subvolumes, IIRC=
=20
the latest btrfs check can detect it.

So please also provide the output of "btrfs check --readonly" of the=20
unmounted fs.

Thanks,
Qu

>=20
> After passing,
>=20
> |:~> sudo btrfs subvolume sync / [sudo] password for root: hightower-=20
> i5-6600k:~> |
>=20
> the command returned to prompt very, very quickly.
>=20
> A second balance attempt results with the following output:
>=20
> |:~> sudo btrfs balance start / WARNING: Full balance without filters=20
> requested. This operation is very intense and takes potentially very=20
> long. It is recommended to use the balance filters to narrow down the=20
> scope of balance. Use 'btrfs balance start --full-balance' option to=20
> skip this warning. The operation will start in 10 seconds. Use Ctrl-C to=
=20
> stop it. 10 9 8 7 6 5 4 3 2 1 Starting balance without any filters.=20
> ERROR: error during balancing '/': Structure needs cleaning There may be=
=20
> more info in syslog - try dmesg | tail hightower-i5-6600k:~> |
>=20
> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device dm-2):=20
> found 16 extents, stage: update data pointers [93690.667290] [ T69656]=
=20
> BTRFS info (device dm-2): relocating block group 1495819878400 flags=20
> data [93703.323923] [ T69656] BTRFS info (device dm-2): found 33=20
> extents, stage: move data extents [93705.575991] [ T69656] BTRFS info=20
> (device dm-2): found 33 extents, stage: update data pointers=20
> [93706.769453] [ T69656] BTRFS info (device dm-2): relocating block=20
> group 1494746136576 flags data [93725.570642] [ T69656] BTRFS info=20
> (device dm-2): found 39 extents, stage: move data extents [93727.449779]=
=20
> [ T69656] BTRFS info (device dm-2): found 39 extents, stage: update data=
=20
> pointers [93728.465650] [ T69656] BTRFS info (device dm-2): relocating=
=20
> block group 60294168576 flags metadata|dup [93736.722689] [ T69656]=20
> BTRFS error (device dm-2): cannot relocate partially dropped subvolume=
=20
> 490, drop progress key (853588 108 0) [93750.594559] [ T69656] BTRFS=20
> info (device dm-2): balance: ended with status: -117 hightower-=20
> i5-6600k:~> |
>=20
> Please see the following referenced, prior posting for stuck subvolume=
=20
> removal similarity. https://lore.kernel.org/linux-btrfs/9f936d59-=20
> d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>=20
> Is there a patch for btrfsprogs? If so can the patch be merged?|
> |
>=20
> What are your thoughts on this?
>=20
>=20
>=20
>=20
>=20


