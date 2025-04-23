Return-Path: <linux-btrfs+bounces-13346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72131A99BF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C796169C40
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 23:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB422AE48;
	Wed, 23 Apr 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="e+Q0y24+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F52701A3
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450672; cv=none; b=KbIpTeIkKkmzORdCduItrmx2y5OW5V8Ja73Ps/+ySTYq5G1hhPSq5abL88ig1mmBLFNtRSbg/SqKvGb8D31A3gFlGD1eHRlZJyfiZnnL7nzgaKHtA6WcjV4hCe7F0ftS0fizTUqGuHKM+k2cUUnLZl7NpahAyIOQC1qXRVr4cVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450672; c=relaxed/simple;
	bh=N1/io5Jcz6WIOvTI0JMVPXm0s1vnDJv1Xfs7BnfEVXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OAG9Wop4dAxGmMW+519FINEjthCLZxUW3O43F1RfVOZEh/MoXCS1ISQu5VC6M5ltUQtc/g33hbPBWItzt29C0nVBv6BZKlUZlE4tJH4F8J9qv+eFw4lajmm0rwBXJi4Y0kJgt+gIK1tkLBJioaNaBnfZJ9cgaamk8Xhk1yqRaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=e+Q0y24+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745450666; x=1746055466; i=quwenruo.btrfs@gmx.com;
	bh=tXlMh5fzJo5av8G8Ps9VKp2lmTfPSkDhVeDQe4218ys=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e+Q0y24+AwGoGhNKPjG5PU6zjluW3KRkf3y+lVKf5fCjCMFaPESqk8aQkVG/VeDa
	 GSzDL/bTpvdhVmzAnYOaAK8oh2VZjdOHeshz31Mk8gr3V+T0VD8XBtVBx4tE8hmvH
	 4bZeX2qu6vdZdcKG1NNhoO9rGEJEk0VkhbI2ku0kTx58GOw5wB273CLooQM7RgrqU
	 rbDBxk7aYfhU793GKcUjhODT11B/gZ8KbuEp74OZwLHYUHaZcG4YW91u9AiHvT/9l
	 S9tgF8whu5u0njTS6el5TVRjXxik9TF+He+mpyYWtIdzSOObzWdmLvajvs+9R0HRl
	 qmV8f6CPQh5YjftJ5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1v6XZ70vXD-00zyEN; Thu, 24
 Apr 2025 01:24:26 +0200
Message-ID: <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
Date: Thu, 24 Apr 2025 08:54:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
To: Ferry Toth <fntoth@gmail.com>, linux-btrfs@vger.kernel.org,
 Qu Wenruo <wqu@suse.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <cdf268c1-b031-488e-a2f3-d68cc88f4d16@gmail.com>
 <aee691cc-4536-40a7-8d98-b31040e0b1d6@suse.com>
 <2366963.X513TT2pbd@ferry-quad>
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
In-Reply-To: <2366963.X513TT2pbd@ferry-quad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XRzW8BkHRzS9FsFuy/yt+EnkoeVQ8zUOC7fOwXRIhKNwu4cGti7
 b7r5zHZC/CmiX7FJ8qiPazZmGDpEhkuS9KEQaH4iHKTn1KZoNvup2LUez6qys/n9ICx6gVr
 GxiaFUVkh5Kb7211yIZBeJ7x62/8xtyJjucaPBbJY7L73yR3q3kL3UQbYETh1cJu5SkFUSl
 ds3nmUv6gYZozPtogZFLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qEGhp7HR1kk=;alOCQanyVXwvucZBGWGF+uRbuIu
 bYSbAFnj6xnYsZ9vjT9Hn4oLaEQX+5FLmz9UHF1YIrDGNRLk7/1so0dUvMhi7jBHnE94zca4U
 EOhjTqKZmKYZkhueEA/gY1MCHkJiwD/D150IgDzhjkbhg8j3ebo6FdObMOhwnZe+bMgTfjqSj
 Mu/GFEanLl8rWwcmgRtmSzzc5Y1xYJgxbCVvqw2RUIPo4eoLeAQ3Hpn2FgnWc4R33ZDWyJLbf
 qNuLkX1mnWggdY1gdDBScNLQuorXiM2kF0sU307QJC529BVYjFD9//zZc57cd3tYAljIvg8zh
 YmK2Elb6q9aOXSheSocvVy+U55sMnQTWGJmS4dFs/79tadjRb0NcA9DuSDzgwyNnCUNptQiHW
 cRe6ikaKOX2LLe38JWe5YDgkIpbFaHCidTq/5lG3UqUd8m0w0O0pWKlCdd2f6p9fjafoO0o1/
 Bv8wtNLozq30cimWzt88cpTfOpvFMT1NwVcHQq6jD19cCJO3sta8XG9WI5tEQjpd1SwM0xBOW
 eabzLT9fJ++JDUsNhNlw8XAogwr9NOqp5XPYIa7bJn7oBCkc+qPKzDmRQR4QPi+qjrS6/6KdW
 cavoTJSWUkyQph9JXMzKEMv8vncvQBOPDONFnE3WUnGX7FcssPCBaAsbIqXQVb8aS1bLm2ur+
 lKXLUgq9y/muLaflRIYUIZouRp3gNjTdy62dBllmCj0Nrq2bES6f3jtT1/W6Gf9sDsV0S5ah1
 t3SJcqemnyjDAVjl3ISaLwpTkYYHVW6aaZUk/gSUTyZXgYyeNSKCCRGBJoeNzkabML6Txl82A
 uQBRtu2cQUit0CZws1inMHbXDQiW/aZGB20LwC0MPNVU8250X84o0dN7uCFoxriQ3C1WUuBbY
 tCkEia0N148UR41QOLYZSfRQyXjKPqWuIwf0Gse9m85f0VbljrJa5P5w9CvTTAt/BMhsR3U9g
 /U6stzD5Te3M9GuoiCEI2fENBjzcDXFJdLBTC2XUtKxu171uhV5usiDjo/CJN/jWP/KjnVp8s
 USNL3q3EIyJWtlpSujAce7D9H5ahi1432eLF8gpy0Il/q6y9VRGXFc/67ucwnd+6ga2WVjdSs
 Ltzz28TeqPYSUdcJZwclJhbFzx7ZD7aW6fAz3YOtuZf34BZyy5KBx9+NdO02jmIiIx9ySb/sY
 27DTrtzOumvgzhDcDmkcQHQQ1ANtqDnCejPfynS0TSivlV8fHRa9S2zGBXOMuKz56FGdpdDaf
 fscHucWQn5O1Dvxrys2ecgIJM6GhZuNRBvYY5fGMIZewhXZxSMspWTTMZUocjFRGwz9O58UKl
 qd+ZlgiMXOB0bz8AblK2gwbxrFOQsVU/MILZhvg0yvGgk+N5rUniQxKggy3iPDp+pj6GwO0xH
 4rdjRv9kb9m1IOiV2Z+EzcQ62OnsdVZFHMplPc5rVHuA3tTU9srBYQchALt+s3O6c3UViq3gH
 WHCqPxASRANnYSDkB6IQmT9xXATRckygNUqUBP5eKQzqz+YZPhtH2j22HdqlVKy63/DW0z3hY
 sbSZi924+xC5zAPMa4benwJSmdCKuSRNIZlBU5jnjVPW91Jp+zmeTtHqEmHcwRKcyY6drQvha
 92zGW2Yakx9WCtAdVwnj0DnJObx+q2rOksVci9kFQsp8A5v4C4uu5HgQZ859GEhhhtOEgKWxZ
 CgwPQbl7RL6XNja2NaLQR0hxApZBKDBFCk+2PUfOyzAtlM8LCQmghDVRGAjzEcsrnWZv+vW1z
 qWpXc3Z/GmVtxRV4hiPnzv+ACFO9AtXziZ6gnN74O9Rk/hPDrLHRb/brC3xPAdNw8rksPq/Se
 3cB32r8vG8GlTPchi7yOH9wN5UtB5b0T1JXhwy6DCWUYCNkBUdgWUVlL4Y704Vag/xP3q2Xrb
 Qe54PHVHhYCULY1C27Dac3pnOlbkxfKhFVD9GZ0Qyl9TR/eHbxJuUOPqw+/s6VOL19mys1jEb
 1kZAYawlNaaXnyOHm6QXRDmLqU89Zt34ecEp5AOhP4urWkfW4DL8aXfXpFzhaOcNr+AalRWDo
 x7TUpJtDNC2Lz0EoR9a+gBXNf/a6jT9Dr6Sthezkfytg9cdtFBlbYJzE5pDTFWdBOkih8hrrc
 ObP7ZXH2194I26vp5Diogu7iEBzFNRXEbbN0jaV3WE3uvGa104Au5p1pMBk8b2cNMwxH68O8e
 HdRpWbi6QFFF0MVyhWjJvZ/0HWL52QJdPh8f/IPvoahpY1rCwpvO2wEpIFFRy9NZWAFRfYGBZ
 niFjitT3noOoQWp9zZNYo3odZl2CGl+0FeWh7CXOYd298Iuw2+38GDZhf1W70L3K+9TzHrch5
 57v0B/KTXrlVcyP5FV893dG142bglhddR2uW9Qzj5gMzs4xUaSiWwrOZwRFfqZTeXVBJXMbiW
 hmDZ7TMPL6XSfWco9agfgghzzjSgFGbOmmPuxmaNZy+ENUm0hngD0XA2ae0J6GKUr3/yvIBsn
 x8fnLHEUIDrwq5wflXgbLmrTmeFDB6JL7+5NF7mNslPISEA5P3rW8W5Wm//SWdvHk50NzK/DR
 pusHbPVS/drjMPaNwHn4SLAarDVUssGG01k6y4t6PfJvHa4ytQLw4R8huNuzn8cWDOdjC+zA5
 xa1osZeopPi9UOGeXRx3ln60nwpzMn5BsHE3Ej8xY23Hl2mKNU1iSwzZjF/bbzwuSwbe9Blgo
 CobDAfrviga62eqhgh6RBlIb9/aAMg5HaAiIasuw81MuIlDcwhdGnR+GzscPtJ2NIJCb9BXE6
 Gp6HydCJZh+0CD3lc7XvR0nOemkkJV4rftHVZyDtKFY+GMccVSNtkQHJQgptjT83Bfkvi73PV
 t7j5Ssu/WfgAMbtLMk1kjcPJMFfEFt6s0MVTh+1LOTQ54ccCAo3uunbZROH0AYWaSC/jK4ri1
 fN1hQfWOGvknjQE1Vo7g/KY1JfOTww7G+zPOKpEmLl1FGh/fIRP7rD+ns5iB9VgEKVTsPBct6
 ItmlKVwOIQ==



=E5=9C=A8 2025/4/24 01:36, Ferry Toth =E5=86=99=E9=81=93:
> Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:
>=20
[...]

>=20
>  > > Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may copy the
>=20
>  > > recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from
>=20
>  > > walnascar or 6.14 from master. If they are building additional tool=
s
>=20
>  > > that use headers from this package like btrfs-compsize these may br=
eak.
>=20
>  > >> Thanks,
>=20
>  > >> Qu
>=20
>=20
> While here, am I right that we can not generate the rootfs with=20
> compression on?
>=20
>=20
> Reason I ask is, Yocto of course builds the rootfs and than has=20
> mkfs.btrfs create the image. But it runs as unprivileged user, so can=20
> not do mount.
>=20
> And then can not do defrag.

We have this feature recently thanks to Mark!

In the latest release v6.13, there is a new option "--compress" added to=
=20
mkfs.btrfs, which must be used with "--rootdir".

And the result is exactly what you expected, mkfs.btrfs will try to=20
compress the file extents at runtime.
For uncompressible data, it will detect at the beginning and fallback to=
=20
uncompressed data instead, exactly like the kernel.

But considering how new this feature this, it will be appreciated if=20
Yocto guys can do some extra testing to make sure nothing is broken.
(Normally a btrfs check after the mkfs will be good enough)


Thanks,
Qu


>=20
>=20
>  > >
>=20
>  > >
>=20
>  >
>=20
>  >
>=20
>=20
>=20


