Return-Path: <linux-btrfs+bounces-16807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC5B56C92
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 23:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2843A6634
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 21:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653F2E6CA9;
	Sun, 14 Sep 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QBp2OU56"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F715E5DC
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885330; cv=none; b=VuFzK+mDyR3eVbjNKLX4s6+uJg+Hztdofno6ihugMWR0lrck20PjL3LwSUn5XPh6iYmcZgskTgFmxbv5rhi5c+Y4ivNw9VADk1PmtDJp16LcjGFXzF5/h1xruPSS6uZ4IHE2gKSCiDdt7KBvPhaHXN+FX8QgmX8JYdTd0ReZlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885330; c=relaxed/simple;
	bh=ak1PVsf/nn4+NZsmCpE62ByI9wHAmtHC2W3mGIr/6RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cf7xMpXxPvcJV9QA33fEu+FCdmR4lg3yPV1ntJjxd55JQlL2tQTYE1w+5hZxayQwM0s6ZBkbb7vT3GA25YvNJsdKQSWAEfunnKSS6uhd6wAs2xXLEN8hPWdDDIGyckYmKLVtE5B9MU1zeCy2U29n5VE+faOBSxC7+6AagWlVd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QBp2OU56; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757885324; x=1758490124; i=quwenruo.btrfs@gmx.com;
	bh=ak1PVsf/nn4+NZsmCpE62ByI9wHAmtHC2W3mGIr/6RQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QBp2OU569erZiUSnSAhlg42yCqewyBvXwx+gK2ozTk+GaQq8g/2o4ihsIs9Pknem
	 7AVYkcgKEJvnP+V3DOAEhcyuKTlLvfXMnSRCCF7RFPtBhBM2qgtncuOk7Q3ER3fMh
	 u5uYPhzm+IMoAfDc1CIwpf6avSgyWoM+UwiwgzFs5TdC9MnjodBf1fN4bq+2f9QQi
	 xOZGN/yxN+B7aZWdvWH/p2sA0FRM9oWzGXAlxTO/Xj1b3WiuBP2SPhLiIgYjpNs3f
	 1NsupqxWNbLGoUxJYbl0Zh/oVXZdWJymKT1EecANKypAAqh1HLmDwWhO1Kmp70rNk
	 WFUj9sf6IWy1qKuJJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1u5wbu48BR-00xFM6; Sun, 14
 Sep 2025 23:28:44 +0200
Message-ID: <44330134-4c22-4fea-9a14-84c78daecdb5@gmx.com>
Date: Mon, 15 Sep 2025 06:58:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD overheating during scrub in laptop
To: Martin Steigerwald <martin@lichtvoll.de>,
 BTRFS <linux-btrfs@vger.kernel.org>
References: <1938311.tdWV9SEqCh@lichtvoll.de>
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
In-Reply-To: <1938311.tdWV9SEqCh@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qjUzg+kRcP9tBw5RgxU9V0HB0M802nuNeVfS7aVolrp40YsP4q3
 Uzs98Gc0C6zE3oDuvAilsz+tLuCjJj40fBQ+LJsYnunAxYuJ7IHk9ksyEU7rrHpmNuBI8hX
 aKZDJCdoP/m9uFlcEhGP54ZBZtiAY6mLs1Z4biec0wCc7FPO+S2ioiGa7jCHtC91ucWBtXJ
 vnOxYRO++csUD19SVvawQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tm+KUw9SdK4=;YfzuHoU7AdplHGvJxffgrupZGVY
 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



=E5=9C=A8 2025/9/14 21:27, Martin Steigerwald =E5=86=99=E9=81=93:
> Hi!
>=20
> Just to share an experience and ask whether others have experienced this=
.
>=20
> Already during summer it happened, that the Samsung 990 Pro 4 TB SSD in
> this ThinkPad T14 AMD Gen 5 said goodbye during scrubbing a 2 TB BTRFS
> filesystem with almost 2 TB of data in big files running at about 3,5 to
> 4,2 GiB/s. I concluded this being due to excessive heat.
>=20
> However it still succeeded with the 500 GiB /home with about 300-350 GiB
> of data in it back then. I worked around it, by scrubbing two minutes,
> then canceling, waiting to cool down, resuming for two minutes until the
> 7-9 minutes of scrubbing were complete. I tried to work around with
> lowered speed, but even then the temperature slowly rose till the SSD sa=
id
> goodbye. I think I went down to 1 GiB/s of speed maximum, maybe even bel=
ow
> that. But then the scrubbing takes longer so more time for SSD to heat u=
p.
> However=E2=80=A6 I would have thought it would not heat that much with a=
 slower
> speed. Maybe it would have worked with 50 or 100 MiB/s. But this takes
> long.
>=20
> Now I had these SSD goodbyes during regular use in times of heavy I/O an=
d
> in the end it could not even scrub that /home partition anymore in one g=
o.
> Linux hung and only way to recover was to forcefully power off the lapto=
p.

Can you setup netconsole and catch the dying message?

I doubt if it's really the drive dying.


>=20
> I opened the laptop and removed dust with high pressure air can while
> holding the fan still so it would not generate current. And with disable=
d
> laptop battery.
>=20
> This fixed the SSDs goodbye issue and I could even scrub that 2 TiB
> filesystem again. However, according to sensors command it still had abo=
ut
> 80,8 =C2=B0C composite temperature and even 100,8 =C2=B0C for sensor 2 f=
or the NVME
> SSD at "nvme-pci-0300" shortly before the end of the scrub, with critica=
l
> for composite at 84,8 =C2=B0C, but no critical set for sensor 2. That is=
 still
> quite high. Granted, it took about 7-8 minutes of scrubbing at 3,5 to 4,=
2
> GiB/s in one go for it to heat up like this. But on the other hand it is
> not summer anymore and room is not as hot as in summer.

I have hit similar situation, but the symptom is very different, the=20
death come silently at boot, the drive is no longer recognized by the=20
BIOS thus no longer bootable, and Linux kernel from liveUSB will not=20
recognize it either.

That's why I'm asking if it's really dying caused by the heat.


>=20
> Anyone had similar experiences?
>=20
> My solution to this will be to remove the dust inside laptop about every
> half year. However=E2=80=A6 I was a bit surprised that the NVME SSD woul=
d not
> throttle itself before saying goodbye. Or maybe it tried and it was not
> enough or to late? The laptop is a bit less than 15 months old. So I
> conclude that it takes less than a year for the cooling system to become
> quite a bit less effective due to dust. Good old ThinkPad T520 took way
> longer for that. But it is way larger on the other hand with more space =
to
> distribute heat.

You can refer to man page of btrfs-scrub, it provides the way to limit=20
the bandwidth of scrub using cgroup or even the btrfs sysfs interface.

Thanks,
Qu

>=20
> I bet it is out of scope for btrfs scrub command to monitor NVME SSD
> temperature and pause when to high. And I conclude the NVME layer of the
> kernel is not throttling to hot NVME flash either.
>=20
> I checked my data filesystems, two BTRFS and one BCacheFS by scrubbing a=
nd
> fsck'ing without changing anything. They are okay.
>=20
> Best,


