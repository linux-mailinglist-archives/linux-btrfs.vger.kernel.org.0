Return-Path: <linux-btrfs+bounces-15808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8AB18D3D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F3518945AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73118230BD5;
	Sat,  2 Aug 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TKAKu2rv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28A218AA0
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127135; cv=none; b=EVe5WcLf5qdLiG78X1fx9GT9QHfqx1AQ3/Gze+P6m9fYenaQnAhdZxnEMTXtIHQ42m2Pxy7clmr+sx8FaYngo6fSyC9LkOgok9KPGBcFnO24kkQf8+5mm7dNJwhWiVa9YnXSqOscOoprLlLM5q0GMEiye1vzDtrNfr2YCnOkg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127135; c=relaxed/simple;
	bh=SfBJi9vVED2XV8JW0uzJ2tqWPGhwWHn2x51pkETdmsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmiFDBu7yM0FcMh9b/f9EMHOiuaJKC/E2w2Hqtp5gFIBFO8IKYddkhMVmYD37lKS8UIPxAMA2PpYWwaQax8CgL1sm5Zh/Gol6Z8iTL85B/MjZqOeaqFwsxEWngZ0GG75eF5sLDyBy8Z+WA9DJBG7Pqpx0Snhlz2MCeouWdrj5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TKAKu2rv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754127130; x=1754731930; i=quwenruo.btrfs@gmx.com;
	bh=AweJ6//x07NKH2EuQWv3evSLlr0Gn5zlnw2J6RS7gps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TKAKu2rvv7OLiur6mzPcaRo2gKx6uotYyTAWjEDlPm7WNV/ZAnWR74JXnAz5Ypsl
	 xeHsq5/+jJDGiwDHMPmhycTLystRdWzbg3zNexLlh5FU0BFeBRJ+mFoIUsSw5PmkC
	 IswD+nJ08XQRwgll1RZr5sI+pUkB6dnRD7wBLAsLHkIXlEuR8OIwGeAszpVc8V3sG
	 PTWUE72FpuSQxv9hPrpp123B+itKHJGvNjlQ3m6Xs9of+4Tj7L1xP06GmpiZxib0t
	 NIuBKKm0pp8aFeD+Bu8soRnqxkUES8Ub8VDPaSK8kUgquOzFCWHQ8HnKuRSnht5n/
	 yCUBsSAYzKDK8u9HXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1uRPaX1aM0-00uTl2; Sat, 02
 Aug 2025 11:32:09 +0200
Message-ID: <ccfba80a-d238-43d1-86b1-9d1ac1ec5c56@gmx.com>
Date: Sat, 2 Aug 2025 19:02:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to
 handle loopback and device mapper devices
To: Racz Zoli <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250801110318.37249-1-racz.zoli@gmail.com>
 <3a8f23bf-e1cf-4803-a290-8d77b0d5dadd@gmx.com>
 <CANoGd8=_frhw+8iF=n0dFe-+vzwg4SRpM41XXRkB6Zt-2ANPpg@mail.gmail.com>
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
In-Reply-To: <CANoGd8=_frhw+8iF=n0dFe-+vzwg4SRpM41XXRkB6Zt-2ANPpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8FgVsjaoH/YJRhVOliEFy5Xu+jlPjBJrJh3Gw2Pxs09RJO7eA5x
 S2v5/eyKGCLoHbxNmZRlQq19BgY4j0BsRClzKEQsoTXKD8ZQOm/hv5CdTcvx04AmqwzhePE
 q3VMTxA740Wp9I8UvdBMMSu5Bcwz2DsKU0N/S1M//NfhUrzaY+GvhNoc1NFMNes2+F32Bif
 Cu4ahzMas5mxSaDLwWMnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mqRZ1ic/sp4=;DqiWhc086JaE59jY1wwynY7Hpg9
 ++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
 v2MHiy6gCbo4QM=



=E5=9C=A8 2025/8/2 18:59, Racz Zoli =E5=86=99=E9=81=93:
> I reproduced the bug on three separate distros, Arch, Ubuntu 25.04 and
> Fedora 42 and open() fails on all three of them
> when device usage was checked as a normal user. For testing I used the
> most basic commands I could to be sure it`s
> not only a particular usecase it fails.
>=20
> For real storage device:
>=20
> sudo mkfs.btrfs /dev/sda1
> sudo mount /dev/sda1 /mnt
> btrfs device usage /mnt -> run as normal user, and open() fails.

Have you checked if you're in the "disk" group?

>=20
> For loopback device:
>=20
> fallocate -l 5G test_bug.img
> sudo losetup --find --show test_bug.img
> sudo mkfs.btrfs /dev/loop0
> sudo mount /dev/loop0 /mnt/
> btrfs device usage /mnt/ -> also fails
>=20
> Thank you,
> Zoltan
>=20
> On Sat, Aug 2, 2025 at 7:19=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/8/1 20:33, Zoltan Racz =E5=86=99=E9=81=93:
>>> Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs =
device usage"
>>> which returns the sector size of a partition (or its parent). After mo=
re testing
>>> it turned out it couldn`t handle loopback or mapper devices. This patc=
h adds a fix
>>> for them.
>>
>> I can fold this change into the original patch if needed.
>>
>> Although during my test, even unprivileged users can still do regular
>> ioctl based size detection, as long as the user have read permission to
>> that device.
>>
>> And if the user can not even read the device, I'd say the environment i=
s
>> set up to intentionally prevent user accesses to that block device.
>>
>> So I'm not convinced about all the fallback method, especially we're
>> doing a lot of special handling (partition vs raw devices).
>>
>> Mind to also provide the test setup you're using and the involved block
>> device mode?
>>
>>>
>>> Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
>>> ---
>>>    common/device-utils.c | 48 +++++++++++++++++++++++++++++-----------=
=2D--
>>>    1 file changed, 33 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>> index dd781bc5..a75194bf 100644
>>> --- a/common/device-utils.c
>>> +++ b/common/device-utils.c
>>> @@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(c=
onst char *name)
>>>        char sysfs[PATH_MAX] =3D {};
>>>        char sizebuf[128];
>>>
>>> -     snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
>>> +     /*
>>> +      * First we look for hw_sector_size directly directly under
>>> +      * /sys/class/block/[partition_name]/queue. In case of loopback =
and
>>> +      * device mapper devices there is no parent device (like /dev/sd=
a1 -> /dev/sda),
>>> +      * and the partition`s sysfs folder itself contains informations=
 regarding
>>> +      * the sector size
>>> +      */
>>> +     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_s=
ize", name);
>>> +     sysfd =3D open(sysfs, O_RDONLY);
>>>
>>> -     if (!realpath(link_path, real_path)) {
>>> -             error("Failed to resolve realpath of %s: %s\n", link_pat=
h, strerror(errno));
>>> -             return -1;
>>> -     }
>>> +     if (sysfd < 0) {
>>
>> Just a small nitpic, it's better to check the errno against ENOENT.
>>
>> But my question still stands, does it really make sense to use sysfs as
>> a fallback?
>>
>> Thanks,
>> Qu
>>
>>> +             /*
>>> +              * If we couldn`t find it, it means our partition is cre=
ated on a real
>>> +              * device and we need to find its parent
>>> +              */
>>> +             snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", =
name);
>>>
>>> -     dev_name =3D basename(real_path);
>>> +             if (!realpath(link_path, real_path)) {
>>> +                     error("Failed to resolve realpath of %s: %s\n", =
link_path, strerror(errno));
>>> +                     return -1;
>>> +             }
>>>
>>> -     if (!dev_name) {
>>> -             error("Failed to determine basename for path %s\n", real=
_path);
>>> -             return -1;
>>> -     }
>>> +             dev_name =3D basename(real_path);
>>>
>>> -     snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_s=
ize", dev_name);
>>> +             if (!dev_name) {
>>> +                     error("Failed to determine basename for path %s\=
n", real_path);
>>> +                     return -1;
>>> +             }
>>>
>>> -     sysfd =3D open(sysfs, O_RDONLY);
>>> -     if (sysfd < 0) {
>>> -             error("Error opening %s to determine dev sector size: %s=
\n", real_path, strerror(errno));
>>> -             return -1;
>>> +             memset(sysfs, 0, PATH_MAX);
>>> +             snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_=
sector_size", dev_name);
>>> +
>>> +             sysfd =3D open(sysfs, O_RDONLY);
>>> +
>>> +             if (sysfd < 0) {
>>> +                     error("Error opening %s to determine dev sector =
size: %s\n", real_path, strerror(errno));
>>> +                     return -1;
>>> +             }
>>>        }
>>>
>>>        ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>>


