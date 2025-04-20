Return-Path: <linux-btrfs+bounces-13183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1EA949CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 00:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62183B075A
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D201A23A4;
	Sun, 20 Apr 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KwE7Vsgp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04187462
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745186436; cv=none; b=ZOuY3nMsd9s3lrWTgtvJZ/vXR1v16o4zbu/bqak3B24a2Hhi8ZxkXURvK8bt05i6Cswrd2oh/GzWgdWi1owTG13gsE+kM9U1KbxEasjHRas33mQ6Gy0Of9PgOJXuo0bRGh0Yt7SmJVFOIYGslCff+gbvfZWM5k83+A3I13UcwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745186436; c=relaxed/simple;
	bh=eFJw7uPb5wGTA1UFmrwyow46MFDPuFvBxOzTMAd1zRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=snUf1ngWSwvlR5RtVLg4lTy9L+NMdcHB5jsB9HsFaN+pdcZX3aX7sCuEWktAFr4Ym/Jk7E/wFNqi7dcfFgxTWjX2uzwIvL7tori3orDGfNKxx7OAMkiY/GuB3bsAJcrn3GKYWcJG3DMy2E3XgOMnAA/vrHewhsaHBgnVKpHU5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KwE7Vsgp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745186431; x=1745791231; i=quwenruo.btrfs@gmx.com;
	bh=oa+wFoiwQTdXr6495D1cvG06WHku2yHEKPcd67/ZOPk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KwE7Vsgpd7kvbUcovcy7hr+yvfMTA9fkOhSbJ33KbIDd7pybw1FcVjPIJ2ijOfyM
	 SzmYEYeh/id0T74OwBCzicHiHomtJZUDP1IbFOyqIRIHnL5gJ7WY6FjhqCvUAJc7Y
	 XLcNUwZRfEAjPoCyL/3f4y4p1egker69+H/aTcl8o2oz/0xyuGLXLuaIiN13Alwzz
	 qH5VK4YyTOFCnZy2CJw0WDLDD6YIdEjEk43t3n5BUjTZDjSES5hLMs4yoQ2CHMRIk
	 SQi32bJ9lim1isJAzrzTiFdpatCBfe1kR3eQMz35BjIpLyKGLHc9rixoD4xgSJoFB
	 rd0sR9XonvVpEh3fVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1uoASP0Ip4-00nQ7Q; Mon, 21
 Apr 2025 00:00:31 +0200
Message-ID: <c9694b5c-b75c-4d58-8a36-12c46ee816bb@gmx.com>
Date: Mon, 21 Apr 2025 07:30:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
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
In-Reply-To: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Crw3AeRpXTAHQ7es8l3rY7BoZzq6yZCxS7a5XGiqvVT966AcCws
 AnsudOupBVoMSoa2012GD8ZgK7Gtud54UxIghY1T6VNrPn8zj+NAwXhQHNf8qh922MeAmaH
 MlL1yrNuA+Xtk0g4aSKxoxRVFiMpaRoJPSI0qcJIIjf1pBvdMDpDMATIq2mePx8Vc7Beu1S
 v5+8JzCBTHSrKn/zxACXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BBSaLiym3UM=;2rvR0oCWawUKJCnmf6DN6bymdg0
 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
 OYr5g0YQt7hsfFx1feMHu7pn0fLWyFU=



=E5=9C=A8 2025/4/21 07:15, Ferry Toth =E5=86=99=E9=81=93:
> The following is originally done by Yocto's bitbake, but when I try=20
> manually it reproduces.
>=20
> I create a new fs on=C2=A0 a file using -r as ordinary user, then btrfs =
check=20
> the file (before or after mounting makes no difference), also as an=20
> ordinary user.
>=20
> The fs has 1000's of errors, I cut most because it seems the same type=
=20
> of errors. The files system is unrepaired bootable, but can be repaired=
=20
> using --repair, in which 1000's of files are moved to lost+found.
>=20
> The below was mkfs on a non-existing file, but writing to 16GB dduped=20
> file (rootfs is 1.4GB) makes no difference. Neither does dropping --=20
> shrink, -m or -n.
>=20
> Also, writing the file to an actual disk and then check the disk gives=
=20
> the same errors.
>=20
> What could this be?
>=20
> ferry@delfion:~/tmp/edison/edison-scarthgap$ mkfs.btrfs -n 4096 --shrink=
=20
> -M -v -r /home/ferry/tmp/edison-intel/my/edison-morty/out/linux64/build/=
=20
> tmp/work/edison-poky-linux/edison-image/1.0/rootfs edison-image-=20
> edison.rootfs.btrfs
> btrfs-progs v6.6.3
> See https://btrfs.readthedocs.io for more information.
>=20
> ERROR: zoned: unable to stat edison-image-edison.rootfs.btrfs
> NOTE: several default settings have changed in version 5.15, please make=
=20
> sure
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this does not affect your deployments:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - DUP for metadata (-m dup)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled no-holes (-O no-holes)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enabled free-space-tree (-R free-space=
-tree)
>=20
> Rootdir from: /home/ferry/tmp/edison-intel/my/edison-morty/out/linux64/=
=20
> build/tmp/work/edison-poky-linux/edison-image/1.0/rootfs
>  =C2=A0 Shrink:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 yes
> Label:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (null)
> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 c2ecfaca-168a-401b-a12a-e73694d7485a
> Node size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> Sector size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096
> Filesystem size:=C2=A0=C2=A0=C2=A0 1.43GiB
> Block group profiles:
>  =C2=A0 Data+Metadata:=C2=A0=C2=A0=C2=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.42GiB
>  =C2=A0 System:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 single=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4.00MiB
> SSD detected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
> Zoned device:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
> Incompat features:=C2=A0 mixed-bg, extref, skinny-metadata, no-holes, fr=
ee-=20
> space-tree
> Runtime features:=C2=A0=C2=A0 free-space-tree
> Checksum:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cr=
c32c
> Number of devices:=C2=A0 1
> Devices:
>  =C2=A0=C2=A0 ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIZE=C2=A0 PA=
TH
>  =C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0 1.43GiB=C2=A0 edison-image=
-edison.rootfs.btrfs
>=20
> ferry@delfion:~/tmp/edison/edison-scarthgap$ btrfs check edison-image-=
=20
> edison.rootfs.btrfs
> Opening filesystem to check...
> Checking filesystem on edison-image-edison.rootfs.btrfs
> UUID: c2ecfaca-168a-401b-a12a-e73694d7485a
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> root 5 inode 252551099 errors 2000, link count wrong
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 260778488=
 index 2 namelen 11 name=20
> COPYING.MIT filetype 1 errors 0

Looks like exactly the nlink bugs related to --rootdir option.

And that's fixed in v6.10 first, by the commit c6464d3f99ed=20
("btrfs-progs: mkfs: rework how we traverse rootdir"), then further=20
improved in v6.12 with the commit ef1157473372 ("btrfs-progs: mkfs: add=20
hard link support for --rootdir").


So in short, if the directory contains hardlinks out of the directory,=20
then you have to use btrfs-progs newer than v6.12.

Thanks,
Qu

