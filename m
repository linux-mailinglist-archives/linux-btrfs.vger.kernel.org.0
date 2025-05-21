Return-Path: <linux-btrfs+bounces-14150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092EFABEA8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 06:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FA13AFF37
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 04:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDA22D9EB;
	Wed, 21 May 2025 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KJRnS4Bp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A233993
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800405; cv=none; b=DDvC5eDgs6ImRNX2bUs0u06b7MV6t30/ZZmXGbKGufU+hgaz//6fpYtYLnws6uy0b/QSCmbFJrVpuuLLAo/eT4HXpmNKaIu8m2Zxo+LLjOouU0WHrDNch19oc/Lli5X1e2Drvk7LPLiY/P616T0pkVzhWcTKj6asQXIgPYhOr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800405; c=relaxed/simple;
	bh=zMXKKz2RSM8ang3VzYOYpF0f02GYNSJQ+Rsy7v4Xo9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjOhQkj2EFKWHgoEA7JSWtLp0AK0GSlEvg9eoVUJcncFbPOSDwp5vmsqMRj5JEPKyz9VsymuH7gcDKe/Kd8i4hwnLzctZxfIEmOM5keWIVlgivV4V+rRyFVUWwZZz7no1uPdA/Cq0lWz8qEbSAqqfCRW3Q7njBs4qymzmgPplSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KJRnS4Bp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747800369; x=1748405169; i=quwenruo.btrfs@gmx.com;
	bh=zMXKKz2RSM8ang3VzYOYpF0f02GYNSJQ+Rsy7v4Xo9U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KJRnS4BpUfRQtnx2mAaHwQodwYvqON5LURcs3F/njwgWtXCm5n7DKxrQA1CyDkeQ
	 vYBqQEMoVlgbyWtBjUyRxg9AA75zhDaggw9SRh0n3WwUz66yFffqHPcRIogy9MFkN
	 MEe/UuG46bBqOpaEJR4ZWzn6S1TVrqeNUGePeQWjZYNVFbObrTFdMeAWqkRG1gIed
	 tKuqc74wP6TnadgkzWYcArzOo1QjAk5L9ms0L8f6/DkkMgCkvrI9L/Qcp60kUM7N2
	 q/n+ZhrHwoy4zG1OudoUOMOOEA+me4IA9/igQ3D71LDammLyvGnOqd6H9wT2o3w5B
	 wocAapWcxSERQxatig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1uZwPl42A9-00WLzg; Wed, 21
 May 2025 06:06:09 +0200
Message-ID: <bd7d0253-f3b7-4ac9-bcba-be4064246400@gmx.com>
Date: Wed, 21 May 2025 13:36:06 +0930
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
In-Reply-To: <fbc3c413-c4c9-47c3-9c5f-4fcd7a772e61@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T8szC2Fk5S+uNfhoJWSkWNGt7Hc0jXbai+hpMUsmr5JqPfyUceK
 BIvVPYaPXAW1eN2cJEcQPM53Hm9mJFn+o3sZXEo7fKHfQ/fN1gchRCFLsypqapz0S/q62+m
 NsZtT27o/xXlXkaZ8VgKViKuPT5dh4f5JENqKTYpCigR7DP/KKa7FXKo/c+BO+kjyVi2Mrq
 yzRXt6IUfkuNNheuGBFdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MrwLzxIablI=;pBw1MLeK/rACmgozoSD70jEwuos
 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
 wObuWZ/MaoHkI2MQqAFmVxx8N7X3esgItm



=E5=9C=A8 2025/5/21 13:22, Anand Jain =E5=86=99=E9=81=93:
[...]
>> That's not the how fixes tag should be used.
>>
>> Let me be clear again, you're working around a bug in libblkid, which=
=20
>> is not the correct way to go.
>>
>=20
>=20
> No, it=E2=80=99s not. The point is that each individual software compone=
nt has
> to do the right thing so that it inter-operates well. Think about why
> this problem doesn=E2=80=99t exist in ext4 and XFS =E2=80=94 you=E2=80=
=99ll get the answer.

BS, firstly it's libblkid resolving the path to the mapper path, and=20
passing it to fsconfig for us to mount.

But if you do not use libblkid and pass path directly to fsconfig,=20
kernel will still properly mount the fs.

You ignored the fact that the device name passed in is already modified=20
by libblkid.
If you do the same using the mount from busybox, there is no extra=20
device path modification, and your workaround makes no sense.


Secondly, XFS/EXT4 doesn't bother the device name, because they are both=
=20
single device filesystems, they only care about the block device=20
major/minor numbers.

The device name used is not handled by them, but VFS (struct=20
mount::mnt_devname), and it's again back to the first point, it's=20
modified by libbblkid.

And btrfs is not a single device fs, it needs to manage all the devices,=
=20
and that's why we implement our own show_devname() call backs.

We can choose to show whatever device name (the latest device, or the=20
olddest device or any live device in the array), just like the user=20
space which can pass whatever weird path they want.

Wake up from the mindset that there is only one "mount" program in the=20
world. Then you can see why the workaround doesn't make sense.

Thanks,
Qu

>=20
>=20
> -Anand
>=20
>=20
>=20
>>>
>>> Thanks, Anand
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>> =C2=A0 fs/btrfs/volumes.c | 7 ++++---
>>>>> =C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index 89835071cfea..37f7e0367977 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device=
=20
>>>>> *device, const char *new_path)
>>>>> =C2=A0=C2=A0 */
>>>>> =C2=A0 static noinline struct btrfs_device *device_list_add(const ch=
ar=20
>>>>> *path,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_super_block *disk_super,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *new_device_added)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool *new_device_added, bool mounting)
>>>>> =C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_devices *fs_devices =
=3D NULL;
>>>>> @@ -889,7 +889,7 @@ static noinline struct btrfs_device=20
>>>>> *device_list_add(const char *path,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJOR(path_devt), MINOR(path_devt),
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current->comm, task_pid_nr(current));
>>>>> -=C2=A0=C2=A0=C2=A0 } else if (!device->name || !is_same_device(devi=
ce, path)) {
>>>>> +=C2=A0=C2=A0=C2=A0 } else if (!device->name || mounting || !=20
>>>>> is_same_device(device, path)) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * When =
FS is already mounted.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1. If=
 you are here and if the device->name is NULL that
>>>>> @@ -1482,7 +1482,8 @@ struct btrfs_device=20
>>>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto free_dis=
k_super;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 device =3D device_list_add(path, disk_super, &ne=
w_device_added);
>>>>> +=C2=A0=C2=A0=C2=A0 device =3D device_list_add(path, disk_super, &ne=
w_device_added,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mount_arg_dev);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(device) && new_device_add=
ed)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free_st=
ale_devices(device->devt, device);
>>>>
>>>
>>
>=20


