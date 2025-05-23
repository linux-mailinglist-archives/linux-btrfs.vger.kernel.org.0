Return-Path: <linux-btrfs+bounces-14194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A78AC2AD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38F01BC6818
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BA01F461D;
	Fri, 23 May 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="P8aBuCKa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FBB22338
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032063; cv=none; b=mcg/o7IXcQZMl7J/VUfw5cfFVDKUMJrzCLLmclQgbO+up500LUyB9jLgJkk27YDZybMUcMMgNsTiCEy9ZV1h90tnFiqQyVMJ7O7U3j57+WAORnSVSBpXojDEy4mMgHiUCABzncPZ9P8H9Bm8kHDntGrjrk2/6G4IWEavLqaFkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032063; c=relaxed/simple;
	bh=D36DSwkMADAmfKz8Zg+t9Hn9Eyp7JYp7HeHI0Al0x6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kttsXqXFL7+8sVVk5pgfnHkeo3qvo73W4IyqtY4Fl3nZY+OSr5FGcEJYTG8JUU5wbn82patmsQrp2nYT8vc5lOOT4Ak3iqfrLafDFMvVVrx8TbA02+BjGcQed0bzMApWTDAywM7iD/Khii4V3e8Q5AfM8rBW+q9QENyADV38T4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=P8aBuCKa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748032059; x=1748636859; i=quwenruo.btrfs@gmx.com;
	bh=ATdrtS+hHm6vqR4heMbjh/5o6SwivnS+RELYdz4DgBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P8aBuCKaen+QFSLXEYZTX/m8EUjItsTTRqtLB4hf0T2k8/V/4Jn8rnqWZUGQPgjr
	 ouh7KQPZ8S5QJKMG+R1kr4lIMlSgzKB/zdZNVvZuK3pHfL+2q3buMsa0L7t8GoiS9
	 /CBPuTCYIg9YJ4rfJDfkvKU2LpOhgYWGh77Zao84SLJPA8jKyt7Fgzb1KPXgwyfCb
	 pQYPLNGG9ghNpznH4OSJrh0N9rajg72CF7+7NuONkHUT8jkc+b/3EtpO1aDrg8scr
	 yjudsPDCDTl5MZ5h21xPJHAbybIATUgR4zBDIZhJcAJM/wypBUHDJCsqlHkNgeSdg
	 UCroGr+ge1uaWDqMEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1v6veE2w8G-00rKfE; Fri, 23
 May 2025 22:27:39 +0200
Message-ID: <dfab4a63-d408-4bbd-a8a9-66499f9d49b8@gmx.com>
Date: Sat, 24 May 2025 05:57:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: data chunk_size ceiling and shrinking stripe sizes on large
 RAID1/10 arrays
To: Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <883424e.30d76975.196fe039728@tnonline.net>
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
In-Reply-To: <883424e.30d76975.196fe039728@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBpKf0p6m27GGT5SeuFEmP+0svhAgEYg0yaSl6pL89QXckk85NL
 MGg6KfbsmGxkPoY2XsrKz6pdN3Ofy6yziJWeI35AoZWcnujjjdwR6531qIQuwYl431iik4D
 mYhgVbPVPGt7k36zqLRbeu5NIocvRpfzR/csKLnCbJB9g27NxETvZ4LuOFZTQqRKI1UcKGc
 39zjPfvaUZifdYwb+/O2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9SiW/Uwnlvw=;aoTTwDOyyxdTptol2nfSE12lE0f
 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
 i4oyTJYZckbFAYZcDa/D+iAYZ



=E5=9C=A8 2025/5/24 02:09, Forza =E5=86=99=E9=81=93:
> Hi all,
>=20
> Because the default
>=20
> /sys/fs/btrfs/<fsid>/allocation/data/chunk_size
>=20
> value is capped at 10 GiB (and cannot be raised), the allocator=E2=80=99=
s logic in decide_stripe_size_regular() progressively reduces the per-devi=
ce stripe_size once data_stripes * stripe_size would exceed that 10 GiB ce=
iling.
>=20
> Concrete example:
>=20
> 40-device RAID10  =E2=86=92  data_stripes =3D 20, allocator shrinks stri=
pe_size to =E2=89=88 512 MiB

40 devices, this is already something we do not expect.

Maybe limiting the device number of a RAID0/RAID5/RAID6 chunk to=20
10/11/12 will be better?

>=20
> Functionally, I think everything works, but the result is a much smaller=
 stripe per device than the customary 1 GiB.  With even more drives the st=
ripe continues to decrease.
>=20
> Questions
>=20
> 1. Is this behaviour considered acceptable or just a stop-gap until a be=
tter solution is developed? The limit seems.to have been introduced in htt=
ps://github.com/torvalds/linux/commit/fce466eab7ac6baa9d2dcd88abcf945be3d4=
a089 (btrfs: tree-checker: Verify block_group_item) but with no direct exp=
lanation to why 10GiB was chosen.

The 10GiB is a long existing limits, mostly from the beginning of btrfs,=
=20
thus that tree check patch just keeps it, and that's also a good=20
indicator of obviously wrong chunk size.

>=20
> 2. What are the risks if we increase BTRFS_MAX_DATA_CHUNK_SIZE limit bey=
ond 10GiB?

Further slowing down balance I believe.

Especially the balance itself is single threaded read, won't fully=20
utilize all that many devices in RAID10.

>=20
> 3. Has anyone measured performance impacts once stripe_size drops below =
1 GiB? Are there other issues that may happen on such a filesystem?

No real world benchmark yet, but I guess it should be no big deal, as=20
the stripe size is also limited by 10% of the device size.

Thus for fs < 10 GiB, their stripe size is already smaller than 1GiB.

Thanks,
Qu

>=20
> Thanks!
>=20
> ~ Forza
>=20
>=20


