Return-Path: <linux-btrfs+bounces-20002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5469CDE125
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 21:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D75B3009AA6
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7DD238C3B;
	Thu, 25 Dec 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="slo2x8+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94F155757
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766694348; cv=none; b=sqdDk8U78CDzcLBkfhFElT2Pc5ZMNStJp22bJvuQ01TrEroKoSHeUC1w5JyXahV5mk+sxwI4IYquTXBXDaKIp4gkQ00Rb9mXxxajUqE3bPl+sJKfeB2QLNPiNIUddobF3l8UWQAhqdk4igCY/LB9KhQjeUEEU71WTqYfKxVG1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766694348; c=relaxed/simple;
	bh=gRUhVwVhaNlhZgxFJc6jNVsXxtdoyCcLbA/fjXulLaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HwUiOywAyYfTyKAak+Scz9Fz0Frpyh/T/3xHWzwmLWzjih04nBnp7GmN2ZT3HFLULqP60OyHMxjSEHsQC9fYmTQwfOA5mjklvpxXK6hx8kSmBaUN9LAzIvvcse73mpMIDU9IoK2Ewxu4vWAcnD9CWXhj+nbg+9nqNFrlEVxRxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=slo2x8+q; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766694344; x=1767299144; i=quwenruo.btrfs@gmx.com;
	bh=XcC0SyTy24TkLH4pyXZp1lgTaUIGsOgH5FKhoUCpoGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=slo2x8+qUTV9aq+JaRL1Z56r99Lbm+dxEW4irpvCZGYW7A/1/8XFHU8zW/dO3O7R
	 JN4Qby5b7SYhUBd9kGvEaXqJNU5ThSILGjvB68kTkSVfK70PPQG5t86GsaEJPc1MZ
	 7sX1xxi4z4aVJxOhmJv02vfnvMyORc8QTJAXe+NmLOpNicQoF4YdrVqfjGPX7N/rI
	 H5KCF1yxYv6L9HdAchYH4OPy/UQgiTkZJfqF8ccVlqGZHFENZ1VZjy7Y5KtihU78M
	 te1Qh+t7MyJW9Gh92kP7q3IRse1pGSLu2sETuyoOTjgITJf0DF/JCyO8bmsyFl80l
	 LM9/s9b92lbvR3c1Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHGCu-1vm5KR3Z7A-00AouS; Thu, 25
 Dec 2025 21:25:44 +0100
Message-ID: <5e3796a6-75fc-4de5-9e3d-82155c1dc9b0@gmx.com>
Date: Fri, 26 Dec 2025 06:55:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for assistance: Error on rerun of btrfstune
 convert-to-block-group-tree after accidental Ctrl-C
To: Gavin Westwood <btrfs-issue-2025@gavinwestwood.co.uk>,
 linux-btrfs@vger.kernel.org
References: <bfcf30d4-92df-41e7-b7a7-f3684196b616@gavinwestwood.co.uk>
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
In-Reply-To: <bfcf30d4-92df-41e7-b7a7-f3684196b616@gavinwestwood.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WECZyiWZDvS8KX+KlADsRZ5V+aInGERK6E5ETZq/3arznee2L6
 9zZipeOlDwllcTeYBvPVfwiQf81bT53tvZjmiZLnMZH0cbSo8dUqtWTRDkCSEnARdaIu5I7
 gUHmquKtMMBpf0FQvFdu9zfor1SVJJXThEQLo+awbmbNcc6trZIe9Iun+uv54N3YbUfAj5e
 dEm8gtCeLcj0Myh574uGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8AF99E+md8A=;U/TwlW2k/MYHv6Q1fPuSFOK7p1z
 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
 HAJy1hX2G966259wYVAa



=E5=9C=A8 2025/12/23 00:31, Gavin Westwood =E5=86=99=E9=81=93:
> Hello.
>=20
> Before my main message below,=C2=A0I note that this is similar to the th=
read=20
> https://lore.kernel.org/linux-btrfs/a90b9418-48e8-47bf-8ec0-=20
> dd377a7c1f4e@gmail.com/. Am I correct that the=C2=A0fix discussed there =
was=20
> included in btrfs-progs-6.15 and, based on the information I have=20
> provided below, installing/building then running that version on my=20
> system should resolve my issue of not being able to resume converting=20
> the filesystem to use a block group tree?

Yes, that's the case.

Newer btrfs-progs have quite some enhancements on btrfstune about the=20
bgt conversion.

So it's highly recommended to use newer btrfs-progs instead.

Thanks,
Qu

>=20
> Thanks.
>=20
>=20
> This morning, while running `btrfstune --convert-to-block-group-tree`=20
> (hoping to speed up loading to resolve frequent issues with my 8-=20
> disk=C2=A0~48TB=C2=A0BTRFS filesystem in a=C2=A0RAID-1 configuration=C2=
=A0not being ready in=20
> time to mount on start-up), I accidentally hit Ctrl-C on the wrong=20
> keyboard, killing the process.
>=20
> When I tried to switch back to view the terminal on my monitor there was=
=20
> some sort of video corruption issue (I'm ignoring that as that's beyond=
=20
> the scope of this list) which prevented me from viewing the screen, so I=
=20
> had to SSH in using my user account instead of root.=C2=A0 These are the=
=20
> messages logged when it tried to mount /home on the BTRFS filesystem as=
=20
> I logged in:
>=20
> Dec 22 08:52:46 MyServerName systemd[1]: Starting user@1000.service -=20
> User Manager for UID 1000...
> Dec 22 08:52:46 MyServerName mount[5110]: mount: /home: wrong fs type,=
=20
> bad option, bad superblock on /dev/sdh1, missing codepage or helper=20
> program, >
> Dec 22 08:52:46 MyServerName mount[5110]: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0dmesg(1) may have more=20
> information after failed mount system call.
> Dec 22 08:52:46 MyServerName kernel: BTRFS info (device sdg1): first=20
> mount of filesystem a4e9dbbe-39c3-464b-a3f7-d85c43d02b62
> Dec 22 08:52:46 MyServerName kernel: BTRFS info (device sdg1): using=20
> crc32c (crc32c-intel) checksum algorithm
> Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1):=20
> unrecognized or unsupported super flag 0x4000000000
> Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1):=20
> superblock contains fatal errors
> Dec 22 08:52:46 MyServerName kernel: BTRFS error (device sdg1):=20
> open_ctree failed: -22
> Dec 22 08:52:46 MyServerName systemd[1]: home.mount: Mount process=20
> exited, code=3Dexited, status=3D32/n/a
> Dec 22 08:52:46 MyServerName systemd[1]: home.mount: Failed with result=
=20
> 'exit-code'.
> Dec 22 08:52:46 MyServerName systemd[1]: Failed to mount home.mount - /=
=20
> home.
>=20
>  From what I read=C2=A0(but perhaps misunderstood?)=C2=A0it sounded like=
 I should=20
> be able to resume the conversion to a block-group-tree, however when I=
=20
> tried that, it failed:
>=20
> # btrfstune --convert-to-block-group-tree /dev/sda4
> ERROR: failed to find block group for bytenr 65736247017472
> ERROR: failed to convert the filesystem to block group tree feature
> ERROR: btrfstune failed
> extent buffer leak: start 87456383107072 len 16384
>=20
> This is on a (just upgraded and rebooted) Debian Trixie (13) server with=
=20
> kernel 6.12:
>=20
> Linux MyServerName 6.12.57+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian=20
> 6.12.57-1 (2025-11-05) x86_64 GNU/Linux
>=20
> I had also recently turned on the NO_HOLES feature, but not yet run a=20
> balance to apply it to existing data.
>=20
> Below is some information that I hope may be useful for troubleshooting:
>=20
> # btrfstune --version
> btrfstune, part of btrfs-progs v6.14
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED=20
> CRYPTO=3Dbuiltin
>=20
> # btrfs inspect-internal dump-super /dev/sda4
> superblock: bytenr=3D65536, device=3D/dev/sda4
> ---------------------------------------------------------
> csum_type0 (crc32c)
> csum_size4
> csum0xe6d3472d [match]
> bytenr65536
> flags0x4000000001
> ( WRITTEN |
>  =C2=A0=C2=A0CHANGING_BG_TREE )
> magic_BHRfS_M [match]
> fsida4e9dbbe-39c3-464b-a3f7-d85c43d02b62
> metadata_uuid00000000-0000-0000-0000-000000000000
> label
> generation1017016
> root87456383107072
> sys_array_size161
> chunk_root_generation1015446
> root_level0
> chunk_root94563239936000
> chunk_root_level1
> log_root0
> log_root_transid (deprecated)0
> log_root_level0
> total_bytes53991121108992
> bytes_used23180446068736
> sectorsize4096
> nodesize16384
> leafsize (deprecated)16384
> stripesize4096
> root_dir6
> num_devices8
> compat_flags0x0
> compat_ro_flags0x3
> ( FREE_SPACE_TREE |
>  =C2=A0=C2=A0FREE_SPACE_TREE_VALID )
> incompat_flags0xb61
> ( MIXED_BACKREF |
>  =C2=A0=C2=A0BIG_METADATA |
>  =C2=A0=C2=A0EXTENDED_IREF |
>  =C2=A0=C2=A0SKINNY_METADATA |
>  =C2=A0=C2=A0NO_HOLES |
>  =C2=A0=C2=A0RAID1C34 )
> cache_generation0
> uuid_tree_generation1016405
> dev_item.uuid3ad36dd8-6028-45d7-a6d8-2b0bb1d5a7ab
> dev_item.fsida4e9dbbe-39c3-464b-a3f7-d85c43d02b62 [match]
> dev_item.type0
> dev_item.total_bytes3984677928960
> dev_item.bytes_used3212635537408
> dev_item.io_align4096
> dev_item.io_width4096
> dev_item.sector_size =C2=A0=C2=A0=C2=A04096
> dev_item.devid =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> dev_item.dev_group =C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> dev_item.seek_speed =C2=A0=C2=A0=C2=A0=C2=A00
> dev_item.bandwidth =C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> dev_item.generation =C2=A0=C2=A0=C2=A0=C2=A00
>=20
> Thanks,
>=20
> Gavin
>=20
>=20


