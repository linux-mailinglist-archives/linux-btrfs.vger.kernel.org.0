Return-Path: <linux-btrfs+bounces-8990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63B9A2F02
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 22:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8CA280C91
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04DC1DFDAC;
	Thu, 17 Oct 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ucrlAf7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452D143895
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198077; cv=none; b=hzVhCr2ElT3BMCjLl00BVkmB4z3JvAFxF424ATmKmvCs5a3DpLYeqWVEaZAh6IVVKZYTjGZGGWttKM/rlKD27fY8Csyf5lc2TH2U+9zeqLKT/mGTZJHAersXEGyLBfelX1Ds1tF8GuigRAsObV7fXFgG7juc6U1Zih3c6UVu1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198077; c=relaxed/simple;
	bh=XcbavoEu3aZJu82x4UsdimDqIUlCFw6EHPJJewmwUkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gCfysxyyMXDEBOF2UpplX7M5KmaccYwePMlcU9j4pHHCO3mjV7aykg+SfYCC5qzZT+6DZlZVOQnVK8Jd30+9l+Zs0vQzVesqCfHBUYITmudVy8NGEq+piWinvnDEw66k7dxzz0P7ej4z7eQSfGN93+hDYqeKmnVMdeEcry08kkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ucrlAf7L; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729198058; x=1729802858; i=quwenruo.btrfs@gmx.com;
	bh=T/Xv7fnTnNkueBpxrXAcgYq5u0Dt84pmV/S9hvPAmlo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ucrlAf7LJ3FkXYOXBzY2+GVRv5MsLWJrY1CP4T/LHALZQ7LaLrSkB32oxwbRlbdB
	 H05i8k3GdByZ4PWbH2vcdSQ1JWFuA+MDFyYJzbhJsUU8H2/aOqxqksnrtWU03IAob
	 nm4VVR50vmR7AqDzDrdir+ovwe3antu2tx598WDK7SUNxWZiPpjA5vYd4MLZ3s85f
	 KptYM9hTUaVvrdZflqPUClfgiTAsQbwlLAmnUUxnso6PL1jyZaZj08gynXuTpBXIr
	 Qy/+Wg9bWbT20k5lSDbsKvbJ6ojILEw7vMxU2/DPtDZCaWUqEYWwMFlQf14eC1d4U
	 QUw4qklYyQxC4rJhiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUUm-1tiWaj3qGa-00pr9k; Thu, 17
 Oct 2024 22:47:38 +0200
Message-ID: <12c0bb30-7ee5-4aec-9fe8-f40ee01ec9a7@gmx.com>
Date: Fri, 18 Oct 2024 07:17:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
To: Anand Jain <anand.jain@oracle.com>, Boris Burkov <boris@bur.io>,
 linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <694552b3-5f70-48d2-a62f-4c2b8caf10fd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BtHOwHT0oY/9K4yB98f/9wQV3iA1b2hWRv114dZLB/Yj7fQ8VZ7
 ArFCZ+2kq1EW4guVYcQxVxmed+EbP6jeEU0zm/SVm+4780Zpz0hQ24ttCfZ14X5QERqcsjO
 Kw1NHGVz+9lU9ZmwOD8FQcRiLrDeaiW5XVs4NcdFkpYeD9CqA0ClcoT33Xgnmp4xKmyo6kv
 zSgOVZuvrLDlAJseFDE2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xL6bhNMTouI=;tONqYuYNfSzCTI9mo3Ci9VW377Z
 8Jr9mXjcsodIkNLH8Y835rbraUO9jo73ta3fiUbSRacJySDBnBUARooA3jq1Budyy+z4NGrvu
 zu29ZHQwNGeanqMZzdXiHLGVwP0njJQL3bVb1e2Rn5McLT9PZppe4BIWVclm4/SSmFHvBnwSW
 XEL1FYgkEo7uGS9+B7QqniiFY55F5v1uxdacF/OX3PYgo06FByNtxEuH3qoZL488pqdtR9By2
 FH1L79JU4d3ILdu64VfXMR36VlzESO3xJkd+s4xsGsxIBXbL4FaxBdL1R1CGmexzKG0s2mA0N
 dmwSMV5Lbp8TE8EoRnpQD6r/KFxWXSpQ9TDQCeb6IwfuRKdSSvmQC5SQdEr+UXbcJletqOM9H
 NA/YgeQ+xN5WbaTD5biDaNz+DyFMT5sheYF5LfSnyhs3r3CqLML7I+C7H3NP12MH3zjKlz4Ws
 wdBhLj9kWOUL7m3ofR47ymeHma3FPmYrLS1rtVAMn/BA/3rxJjxTVVT71Gh0M9s8rujAKADmn
 89JM4QfxWbWfIdZb/kqUZ3XV+3kxp8ExRgNfel/HPCUGrJJCGrm6ivvxo7uNzVGpVBhM9FyId
 qPSzShSkerijU3CXSB7s8pltzSniFUmXUksobAuQ9MjhKorBCQAr8GdOfO1p1jvyN55uwqUKy
 B6EmgzAbDxZ/utCN7YMOnoB6LFpcbPqkhTRAqkuUrNbk2OKMo66JgiCTLIO8muPBVzdq8e66S
 wlc7u60ngAw0CvwrRQhkm4Y1kFl4Uv05bcWttMQgYQvjpirYgearr7+8fknib4NxScdrHrfNH
 /Bi+GlodGWHLRbol2ikrcvgPA+leGIT5SumbEn1VD2vNM=



=E5=9C=A8 2024/10/17 03:44, Anand Jain =E5=86=99=E9=81=93:
> On 16/10/24 05:38, Boris Burkov wrote:
>> If you follow the seed/sprout wiki, it suggests the following workflow:
>>
>> btrfstune -S 1 seed_dev
>> mount seed_dev mnt
>> btrfs device add sprout_dev
>> mount -o remount,rw mnt
>>
>
>
>
>> The first mount mounts the FS readonly, which results in not setting
>> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
>> somewhat surprisingly clears the readonly bit on the sb (though the
>> mount is still practically readonly, from the users perspective...).
>> Finally, the remount checks the readonly bit on the sb against the flag
>> and sees no change, so it does not run the code intended to run on
>> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>>
>> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN an=
d
>> does no work. This results in leaking deleted snapshots until we run ou=
t
>> of space.
>>
>> I propose fixing it at the first departure from what feels reasonable:
>> when we clear the readonly bit on the sb during device add.
>>
>> A new fstest I have written reproduces the bug and confirms the fix.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>> Note that this is a resend of an old unmerged fix:
>> https://lore.kernel.org/linux-
>> btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur=
.io/T/#u
>> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
>> were also explored but not merged around that time:
>> https://lore.kernel.org/linux-btrfs/
>> cover.1654216941.git.anand.jain@oracle.com/
>>
>> I don't have a strong preference, but I would really like to see this
>> trivial bug fixed. For what it is worth, we have been carrying this
>> patch internally at Meta since I first sent it with no incident.
>> ---
>
>
> I remember fixing this before. I tested on 5.15, and the bug isn't
> there, but it=E2=80=99s back in 6.10, so something broke in between.
> We need to track it down.
>
> The original design (kernel 4.x and below) makes the filesystem switch
> to read-write mode after adding a sprout because:
>
>  =C2=A0=C2=A0 You can=E2=80=99t add a device to a normal read-only files=
ystem
>  =C2=A0so with seed read-only mount is different.
>  =C2=A0=C2=A0 With a seed device, adding a writable device transforms
>  =C2=A0it into a new read-write filesystem with a _new_ FSID and
>  =C2=A0fs_devices. Logically, read-write at this stage makes sense,
>  =C2=A0but I=E2=80=99m okay without it and in fact we had fixed this bef=
ore,
>  =C2=A0but a patch somewhere seems to have broken it again.
>
>
> (Demo below. :<x> is the return code from the 'run' command at
>  =C2=A0https://github.com/asj/run.git)
>
>
> ----- 5.15.0-208.159.3.2.el9uek.x86_64 ----

I also tried it on upstream kernel v5.15.94, the behavior is still the
old changed to RW immediately after device add:

[adam@btrfs-vm ~]$ uname -a
Linux btrfs-vm 5.15.94-1-lts #1 SMP Wed, 15 Feb 2023 07:09:02 +0000
x86_64 GNU/Linux
[adam@btrfs-vm ~]$ sudo mkfs.btrfs  -f /dev/test/scratch1 > /dev/null
[adam@btrfs-vm ~]$ sudo btrfstune -S 1 /dev/test/scratch1
[adam@btrfs-vm ~]$ sudo mount /dev/test/scratch1  /mnt/btrfs/
mount: /mnt/btrfs: WARNING: source write-protected, mounted read-only.
[adam@btrfs-vm ~]$ sudo btrfs device add -f /dev/test/scratch2  /mnt/btrfs=
/
Performing full device TRIM /dev/test/scratch2 (10.00GiB) ...
[adam@btrfs-vm ~]$ sudo touch /mnt/btrfs/file
[adam@btrfs-vm ~]$ mount | grep mnt/btrfs
/dev/mapper/test-scratch2 on /mnt/btrfs type btrfs
(rw,relatime,space_cache=3Dv2,subvolid=3D5,subvol=3D/)

So it looks like it's some extra backports causing the behavior change.

But I still strongly prefer to keep it RO.
Even if it's a different fs under the hood, it still suddenly changes
the RO/RW status of a mount point without letting the user to know.

Thanks,
Qu

> $ mkfs.btrfs -fq /dev/loop0 :0
> $ btrfstune -S1 /dev/loop0 :0
> $ mount /dev/loop0 /btrfs :0
> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>
> $ cat /proc/self/mounts | grep btrfs :0
> /dev/loop0 /btrfs btrfs ro,relatime,space_cache=3Dv2,subvolid=3D5,subvol=
=3D/ 0 0
>
> $ findmnt -o SOURCE,UUID /btrfs :0
> SOURCE=C2=A0=C2=A0=C2=A0=C2=A0 UUID
> /dev/loop0 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
>
> $ btrfs fi show -m :0
> Label: none=C2=A0 uuid: 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 1 FS bytes used 144.00KiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 3.00GiB used 536=
.00MiB path /dev/loop0
>
> $ ls /sys/fs/btrfs :0
> 64f21b87-4e4c-4786-b2cd-c09a5ccd2afa
> features
>
> $ btrfs dev add -f /dev/loop1 /btrfs :0
>
> # After adding the device, the path and UUID are different,
> # so it=E2=80=99s a new filesystem. (But, as I said, I=E2=80=99m fine wi=
th
> # keeping it read-only and needing remount,rw.
>
> $ cat /proc/self/mounts | grep btrfs :0
> /dev/loop1 /btrfs btrfs ro,relatime,space_cache=3Dv2,subvolid=3D5,subvol=
=3D/ 0 0
>
> $ findmnt -o SOURCE,UUID /btrfs :0
> SOURCE=C2=A0=C2=A0=C2=A0=C2=A0 UUID
> /dev/loop1 948cea35-18db-45da-9ec8-3d46cb5f0413
>
> $ btrfs fi show -m :0
> Label: none=C2=A0 uuid: 948cea35-18db-45da-9ec8-3d46cb5f0413
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 144.00KiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 3.00GiB used 520=
.00MiB path /dev/loop0
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 3.00GiB used 576=
.00MiB path /dev/loop1
>
>
> $ ls /sys/fs/btrfs :0
> 948cea35-18db-45da-9ec8-3d46cb5f0413
> features
> ---------
>
>
> Thanks, Anand
>
>> =C2=A0 fs/btrfs/volumes.c | 4 ----
>> =C2=A0 1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index dc9f54849f39..84e861dcb350 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>> *fs_info, const char *device_path
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_blocksize(device->bdev_file, BTRFS_B=
DEV_BLOCKSIZE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seeding_dev) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_clear_sb_rdonly(sb);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* GFP_KERNEL al=
location must not be under device_list_mutex */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seed_devices =3D=
 btrfs_init_sprout(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(seed_=
devices)) {
>> @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>> *fs_info, const char *device_path
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->chunk_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->fs_devices->devic=
e_list_mutex);
>> =C2=A0 error_trans:
>> -=C2=A0=C2=A0=C2=A0 if (seeding_dev)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_sb_rdonly(sb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (trans)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_end_transa=
ction(trans);
>> =C2=A0 error_free_zone:
>
>


