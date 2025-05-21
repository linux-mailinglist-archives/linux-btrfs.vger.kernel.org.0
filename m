Return-Path: <linux-btrfs+bounces-14154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C25ABEB22
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 07:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0E1B63F88
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507E22F389;
	Wed, 21 May 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="n1b+pzhx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F6176ADB
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804116; cv=none; b=bIBZhOnVoR31fvVj1/dcV8LAal59jLe+Uq/bAWYyQfkRU71Q546jOvEaM2abUo5QTCmu5EI05l/VeinqeJjXDBxAaj3lruI2ePTC8sAT13vSs6yuyHrfYYc7UaBXjkmfHFfokVavmiNj7LLhImqhlvWirshGwHPEzrYjqjbf5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804116; c=relaxed/simple;
	bh=lrJs5HavIxZRL1oFh1BiGhLfZjm8zS8ON0JzbIk96r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RJ9le/U1Mq/45ZUooXfAUpTQiJ77c/SwlLjyvb4gXqdBOUc3nN3n1UU0SVXR7K8QSh18BMys0X0556ztu85xTeSGHsWM4WDwSYsY/g47BCNbZEcURr/Fk5ok30rP9fe0kKrzK+uo1fD1hlCG6EWnil/K62TXZaB5KTWdYqDYJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=n1b+pzhx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747804112; x=1748408912; i=quwenruo.btrfs@gmx.com;
	bh=NlincCceWkuswxKdOveQ9Nei3Xts/oVwTdMMGBq+Iko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n1b+pzhxuQy/9vdCXtituJva52DnVro7pR7mb9QIpRkuUQIQBVadwPHWVUB5JFbX
	 vR6VudFrPjYEsGFkf00nETz5m6QyOF7Bss81aqeS8Sg2QeRppIlm4dJQ464ipzpwx
	 BrEnehU5Gh7a0Bbv7ORx/B7L652FG2KoVeVP+Q8wSJHw2A/IouM+bog715uN9ScIi
	 nzow+j4Pv+TuwEDh7+59C5xTIKYmVP6Cyygd8WSw+QT87DCWW6wVGj72HGG0dpFhW
	 oLXmPku/XiG4cOTIjs8G/1jiYhBYxA+BT8xt2hVjJRsgXMEGltR9CT+8XRjxLfBb3
	 +TWl4tuDU6xlgRBnFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPokN-1udn6y1rV5-00KTfI; Wed, 21
 May 2025 07:08:32 +0200
Message-ID: <5836236c-5425-496f-8083-a3e636ce3abb@gmx.com>
Date: Wed, 21 May 2025 14:38:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preserve mount-supplied device path
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
 <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
 <74ee4615-09c7-41c9-9197-c83b171f1c74@oracle.com>
 <1d27523e-76ed-4a92-bd79-49643c5272bb@gmx.com>
 <fbc3c413-c4c9-47c3-9c5f-4fcd7a772e61@oracle.com>
 <bd7d0253-f3b7-4ac9-bcba-be4064246400@gmx.com>
 <6b27ac62-a876-43d4-8d38-c691146e8d0a@oracle.com>
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
In-Reply-To: <6b27ac62-a876-43d4-8d38-c691146e8d0a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmFClU6WBsOThwVHLv3jjAyg1iaYaBP0UmtpmQxYibde3oSexqy
 slSDG0yat4nE80Bsn0feR3UARyd1Dp+e2KwE2EqP0gwSbC08bzscRV0yvFvzSahsxdoyTJ1
 6Dg2UTVi8hpHASD2ARzNT2KeV4wGCpY16/fMWeuRCsBLBX+HqaDeEGmCr8Usro4d+WySndq
 UZUpog1I5SNAMrU1V5dzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8xz20WjQF4k=;fyG99aPvau3X0bxWuTSOX7ZY7Sq
 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
 Sch9x6I3YIDGPMpYbZ09Z167HoJ5VPMSH7



=E5=9C=A8 2025/5/21 14:14, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 21/5/25 12:06, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/21 13:22, Anand Jain =E5=86=99=E9=81=93:
>> [...]
>>>> That's not the how fixes tag should be used.
>>>>
>>>> Let me be clear again, you're working around a bug in libblkid,=20
>>>> which is not the correct way to go.
>>>>
>>>
>>>
>>> No, it=E2=80=99s not. The point is that each individual software compo=
nent has
>>> to do the right thing so that it inter-operates well. Think about why
>>> this problem doesn=E2=80=99t exist in ext4 and XFS =E2=80=94 you=E2=80=
=99ll get the answer.
>>
>> BS, firstly it's libblkid resolving the path to the mapper path, and=20
>> passing it to fsconfig for us to mount.
>  > > But if you do not use libblkid and pass path directly to fsconfig,
>> kernel will still properly mount the fs.
>>
>> You ignored the fact that the device name passed in is already=20
>> modified by libblkid.
>> If you do the same using the mount from busybox, there is no extra=20
>> device path modification, and your workaround makes no sense.
>>
>>
>> Secondly, XFS/EXT4 doesn't bother the device name, because they are=20
>> both single device filesystems, they only care about the block device=
=20
>> major/ minor numbers.
>>
>> The device name used is not handled by them, but VFS (struct=20
>> mount::mnt_devname), and it's again back to the first point, it's=20
>> modified by libbblkid.
>>
>> And btrfs is not a single device fs, it needs to manage all the=20
>> devices, and that's why we implement our own show_devname() call backs.
>>
>> We can choose to show whatever device name (the latest device, or the=
=20
>> olddest device or any live device in the array), just like the user=20
>> space which can pass whatever weird path they want.
>>
>> Wake up from the mindset that there is only one "mount" program in the=
=20
>> world. Then you can see why the workaround doesn't make sense.
>=20
> You're putting words in my mouth. I didn=E2=80=99t say what you're claim=
ing I
> did.
>=20
> Let me be clear: each software unit must behave correctly and
> independently. That=E2=80=99s the only way to avoid interoperability iss=
ues when
> other components change.

We're showing the correct device, no matter if it's mapper path or dm-*=20
path.

The only interoperability problem is:

- Mount is using libblkid to change the device path
   To a mapper path.

- Libblkid can only handle device paths
   It can not properly detect dm-* or other soft links devices.

The only thing btrfs involves is, btrfs maintains its own device path,=20
and we do not care the one passed in for mount/mkfs, just the first one=20
passed for scan.

So btrfs "breaks" the mount hack, by not bothering the path passed in.
But is our path broken? No, it's still a correct path (until the device=20
is gone, and a new rescan is triggered)

But you know what breaks the mount hack? Any "mount" problem that=20
doesn't utilized libbkid to resolve the device path.
Or any other thing that triggered btrfs dev scan before mount.

Btrfs is not the critical link, it's the mount hack and the fact=20
libblkid can not handle any path other than the mapper path.

That's why I call it out loudly, no matter if you choose to ignore.


>=20
> If BusyBox wants to use /dev/xyz at open_ctree(), it must be allowed to
> update the device path. In fact, your commit 2e8b6bc0ab41 (=E2=80=9Cbtrf=
s: avoid
> unnecessary device path update for the same device=E2=80=9D) blocks this=
, and
> that=E2=80=99s a problem.
> Same with mount. If it prefers /dev/mapper/... over /dev/dm-..., it
> should be free to update the path. But your commit forces the path from
> the device register ioctl to be preserved no matter what. That=E2=80=99s=
 not
> just rigid=E2=80=94it=E2=80=99s wrong.

BS again, why it bothers which path btrfs keeps internally?

No matter if it's mapper or dm names, as long as it's accessible at the=20
first rescan (can be mount or udev rules or manually scan), we keep it.

There is no reason to change the device path just because libblkid wants=
=20
certain format.

>=20
> You're calling my method broken, but what's actually broken is the
> assumption that the device path from the pre-mount context must be
> preserved in the post-mount context, which your commit 2e8b6bc0ab41
> wrongly enforces.
And I'll call your workaround broken again and again and again, because=20
there are more ways to "break" libblkid.

E.g. even with your workaround, then we do a dev-replace.
The device name used here is a dm-* one.

Now btrfs reports its device name using the latest and replaced device=20
path, which is dm-* again, breaking libbkid again.

The same applies to dev-add too.

Now say it again, which part is broken?


