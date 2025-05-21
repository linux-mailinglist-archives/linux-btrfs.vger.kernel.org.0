Return-Path: <linux-btrfs+bounces-14148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14815ABEA76
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B723B569B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B191A5BAF;
	Wed, 21 May 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ixqoTfz9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134228E7
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747798359; cv=none; b=GVG9UiTedn//Jy2uTFeOnK5fn86CY+YLGIUyj+kJxXa8gY1wKBhpAKuTMfbzsFGNQnqU99saDJ02hkVZgDyIEmttTCCOC1xRj9zqbbA+QvfSv3XtfK9SHUHRQGeEPAdsbl5L0L906sTiqsFuU4IVr9S0pIzkCeJHfel8N9MX8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747798359; c=relaxed/simple;
	bh=YUaQeywzmdbATi3iRaB70DVm0V09AKoDmy3VMDi2wno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rbK7oQdY4NQx/T/ZdiXOpO7UhTKAWvTbBcwp0LyPGqKc+GQgObhrNYb7mgFkueR4xgXtfHCKw5XMFuB9z4WGHNNeOpa9+E1x2kHux165u+gigKVdRWKfbx5OrGSnXfNKGpaojD1BQ6PSzKaEXH9/IBrb33pKOBRmMegST8lIVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ixqoTfz9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747798354; x=1748403154; i=quwenruo.btrfs@gmx.com;
	bh=ASkVlKzTiNC5hTP3/mn7tivaX6pHax7/U2aeFHDmOwk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ixqoTfz92OCK2bB7VL9uLFN7sKy2s7dDcpVap1ZQarVUNrnhbAeqZ65YprE85Uku
	 nVd3IU6rYt4J6Hw32xVG/tcE17xZeVrZQHdgQe5hz6iur+jcowByC6J93XNJf1OaS
	 nur1Ktd6hIX4iXeUa72dl79HcV8WgoWmpu4VIwFZl38FzfQMu0SjnBlIxyAw+L/tA
	 5FmVtHc0/E/Oqj4f4i3lk1DjPRF1ES/tqVlSSpdEsipHEkJ8biNUu+v9xxogjCY13
	 NrVKgNPGEAL8rCaWTxgd0MBkm0IyDIgB4tJFdzdybsNaZYX1b7kpIJbl/lWQhZrKr
	 Q9vXGUXQfHQLSLb/Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5UN-1uCPnZ0pIF-00CgEJ; Wed, 21
 May 2025 05:32:34 +0200
Message-ID: <1d27523e-76ed-4a92-bd79-49643c5272bb@gmx.com>
Date: Wed, 21 May 2025 13:02:31 +0930
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
In-Reply-To: <74ee4615-09c7-41c9-9197-c83b171f1c74@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o0KS6zQmvOqiGVR8ftQIlRoDs6PADPUyRuj/N2B9rtuqS2jDJBD
 4nWj07IP533Eor1FzrdUuiC8G4F/E/U1uuYWE9UFljDKYH14vNB0HJ73xwHuh1gCo31fvHe
 ZjwZjpH1Tf/XMjcfpRyypENpHTKVwWFi6RsHbIxWZ2G/HaxiqBsfRt93KUwAtXjF42xN34/
 oe835iwJqQ9xKBHpf7pRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:va/9qcW22PI=;25BA3RzT/jbCw6bF64E/8/XPEvY
 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
 tan296yDJxNJXPeVi0i/s6/4q8hZiWTKux



=E5=9C=A8 2025/5/21 12:44, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 21/5/25 06:25, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/20 20:53, Anand Jain =E5=86=99=E9=81=93:
>>> Commit 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for=
=20
>>> the
>>> same device") addresses the bug in its commit log shown below:
>>>
>>> =C2=A0=C2=A0 BTRFS info: devid 1 device path /dev/mapper/cr_root chang=
ed to /=20
>>> dev/dm-0 scanned by (udev-worker) (14476)
>>> =C2=A0=C2=A0 BTRFS info: devid 1 device path /dev/dm-0 changed to /dev=
/mapper/=20
>>> cr_root scanned by (udev-worker) (14476)
>>> =C2=A0=C2=A0 BTRFS info: devid 1 device path /dev/mapper/cr_root chang=
ed to /=20
>>> proc/self/fd/3 scanned by (true) (14475)
>>>
>>> Here, the device path keeps changing =E2=80=94 from `/dev/mapper/cr_ro=
ot` to
>>> `/dev/dm-0`, back to `/dev/mapper/cr_root`, and finally to `/proc/=20
>>> self/fd/3`.
>>>
>>> While the patch prevents these unnecessary device path changes, it als=
o
>>> blocks the mount thread from passing the correct device path. Normally=
,
>>> when you pass a DM device to `mount`, it resolves to the mapper path
>>> before being sent to the kernel.
>>>
>>> =C2=A0=C2=A0 For example:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mount --verbose -o device=3D/dev/dm-1 /dev/dm=
-0 /mnt/scratch
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mount: /dev/mapper/vg_fstests-lv1 mounted on =
/mnt/scratch.
>>
>> So what is the problem here?
>>
>> No matter if it's dm-1/dm-0, or mapper path, btrfs shouldn't need to=20
>> bother.
>>
>> I guess you're again trying to address the libblkid bug in kernel.
>>
>>>
>>> Although the patch in the mailing list (`btrfs-progs: mkfs: use
>>> path_canonicalize for input device`) fixes the specific mkfs trigger,
>>> we still need a kernel-side fix. As BTRFS_IOC_SCAN_DEV is an KAPI
>>> other unknown tools using it may still update the device path. So the
>>> mount-supplied path should be allowed to update the internal path,
>>> when appropriate.
>> This doesn't look good to me.
>>
>> The path resolve is util-linux specific, and remember there are other=
=20
>> projects implementing "mount", like busybox.
>> Are you going to check every "mount" implementation and handle their=20
>> quirks?
>>
>> =C2=A0From the past path canonicalization we learnt you will never win =
a=20
>> mouse cat game.
>>
>>
>> Again, if it's a bug in libblk, try to fix it.
>>
>=20
> ext4 and xfs don=E2=80=99t hit this because they use the mount thread=E2=
=80=99s device
> path=E2=80=94we don=E2=80=99t.
>=20
> Sure, libblkid could be smarter understanding that /dev/dm-0 vs /dev/
> mapper/test-scratch1 are same, but that=E2=80=99s separate.

Why separate? Without the libblkid bug I bet you won't even bother=20
submitting such a patch.

> Between mount and unmount, we should just stick to the path from mount
> so everything stays in sync. As these tools including mount use
> libblkid.
>=20
> Or please look at this like this-
>=20
> The Btrfs kernel needs a device path to display, which comes from
> either:
>=20
> Threads BTRFS_IOC_SCAN_DEV (only Btrfs specific),
>  =C2=A0 or
> Threads going through open_ctree() (usually mount-related, system
> specific)
>=20
> This patch makes sure the path from the mount thread (open_ctree()),
> are=C2=A0 preserved because that's system wide common to ext4 and xfs,
> BTRFS_IOC_SCAN_DEV is specific to btrfs.

Then btrfs will never update the device path, even if got disappeared.

>=20
> Why now?
>=20
> Commit 2e8b6bc0ab41 blocked the mount thread from updating the device
> path, which it used to do. That=E2=80=99s now leading to incorrect paths=
 being
> shown=E2=80=94often from BTRFS_IOC_SCAN_DEV (mkfs)

Define the "incorrect" part.

There is no incorrect path here, it's all the same block device, just=20
different soft links.

Remember the device can disappear and multi-device btrfs must be able to=
=20
handle that.

But different soft links? No, we should not bother that.

>=20
> What was that commit fixing?
>=20
> It was suppressing noisy path flips caused by Btrfs=E2=80=99s udev rule =
on a=20
> mounted btrfs filesystem.
>=20
> ENV{DM_NAME}=3D=3D"?*", RUN{builtin}+=3D"btrfs ready /dev/mapper/$env{DM=
_NAME}"
>=20
> That rule switches paths like this:
>=20
> /dev/mapper/test-scratch1 =E2=86=92 /dev/dm-4 =E2=86=92 /dev/mapper/test=
-scratch1
>=20
> With this patch we will still block such flips.
>=20
> So this patch restores expected behavior by preferring the mount
> thread=E2=80=99s device path.
>=20
> In fact:
>=20
> Fixes:
> 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the same=
=20
> device")

That's not the how fixes tag should be used.

Let me be clear again, you're working around a bug in libblkid, which is=
=20
not the correct way to go.

>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 fs/btrfs/volumes.c | 7 ++++---
>>> =C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 89835071cfea..37f7e0367977 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device=20
>>> *device, const char *new_path)
>>> =C2=A0=C2=A0 */
>>> =C2=A0 static noinline struct btrfs_device *device_list_add(const char=
 *path,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *disk_super,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bool *new_device_added)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bool *new_device_added, bool mounting)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_devices *fs_devices =3D=
 NULL;
>>> @@ -889,7 +889,7 @@ static noinline struct btrfs_device=20
>>> *device_list_add(const char *path,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJOR(path_devt), MINOR(path_devt),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current->comm, task_pid_nr(current));
>>> -=C2=A0=C2=A0=C2=A0 } else if (!device->name || !is_same_device(device=
, path)) {
>>> +=C2=A0=C2=A0=C2=A0 } else if (!device->name || mounting || !is_same_d=
evice(device,=20
>>> path)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When FS=
 is already mounted.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1. If y=
ou are here and if the device->name is NULL that
>>> @@ -1482,7 +1482,8 @@ struct btrfs_device=20
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_disk_=
super;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 device =3D device_list_add(path, disk_super, &new_=
device_added);
>>> +=C2=A0=C2=A0=C2=A0 device =3D device_list_add(path, disk_super, &new_=
device_added,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount_arg_dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(device) && new_device_added=
)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_stal=
e_devices(device->devt, device);
>>
>=20


