Return-Path: <linux-btrfs+bounces-2045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C8846284
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B1F28D37E
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4ED3CF60;
	Thu,  1 Feb 2024 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="R3T0um2+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C723CF4B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822138; cv=none; b=gjPCjpVNsaGi7CvScwHZqgb8HTuEnI5RCFfHSYrgy6I3b7mb+tLCklDi3A5chTIMNgpl9cUDq8CnOUZBNkq9OODLKaTJ/IQDtX43Ofygj5+uTvcw1E+F221fLh9YIpD1mXHavTDLGE05Zrfnm6WBK434wfy8SQDEo1zDkkmuPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822138; c=relaxed/simple;
	bh=6bjNMV0J0VCsrIPzq+amNUlAkU/WfwcpmZo+Oo5XfVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ht320K9foVupWw6xd0gaoKY906LUuPLBEFHD4gYsdDuulnjFVCF3gNcIdnzmV7NZJdKS24PD1B4oRtXNGO9ZMW8rD+tow7jOkCErXY+6stddAnkntuSBQmhYGOk0ilDjBT1UBb3L2pbhGTMlscvIkXlk57Q60/gmx3YQ6S/Lbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=R3T0um2+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706822129; x=1707426929; i=quwenruo.btrfs@gmx.com;
	bh=6bjNMV0J0VCsrIPzq+amNUlAkU/WfwcpmZo+Oo5XfVs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=R3T0um2+1coYzsysvGGHqAP93P9Oo0cp3YbH/qyViwBBwJyd1HhrRvB9HhS6TTI+
	 i8rL09tBxC1zQlokaI9rVO4YAIFJrg2YOm/HYWb2d+kLxqKrfASZ4LlNOfNkTn9eG
	 RGE+H0Y5K6HbjRD8m3H9XUC1r5IakDx178bNHERM23Z1TVKJmuQG7x0bFbScdMV+f
	 q/mUWx1Gxu51F24/RF/FoeoqJYOWVWAgjgx0pm7UxBABoU4Vs8lZNsSN/pEKKqt+b
	 IQVAYkrFIdCLMNJWYfYbUXReYo2jkvN/rMFt7OfZiK7gOox1Xs0QIA1k+7BneNoUO
	 9xXxsiza5Pici7s3Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvrB-1qpB2z2U4z-00hLxc; Thu, 01
 Feb 2024 22:15:29 +0100
Message-ID: <f2533b10-417f-4f70-bb68-5f408fa75424@gmx.com>
Date: Fri, 2 Feb 2024 07:45:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <b5b191e2-27a8-4d9f-92ec-434e7b88d1f9@oracle.com>
 <0f6bbeb1-0d05-4f4c-837d-11ca8297fcef@suse.com>
 <868c62e2-9bf9-49ed-97e5-ddfdf1e138ed@oracle.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <868c62e2-9bf9-49ed-97e5-ddfdf1e138ed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SemDGKi00zPi6UcD6JWBwox96dVOGfLqzGoxKBQvKfj0HngxjGg
 S1NjPWJ0BBPpV933yOH5sAZfTOKZZssuV+AwWMMUQawbTBKG9qhCvPj65zTnBOVS17hwD5o
 t6+xIz26xbkb0+583vmjl+lm9mRPNPSW0Q3gKkiWlMyBYQnJCbDHb+hKm/FGalcwrlScLE/
 fHBJkeXyYBqrQ23v+MQaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PIaFMXNKaXc=;HkgE1h2IqrMgqQANaz4i1V78g/q
 JF8UQpLlwLcVQZUs7V/XPn2pzFxvhfZJmwL2uBsnsGdNv4d54qso2Int98fzLYpzG6tS8074y
 tgO7m9f1f65/VZ5k4HUUhJ6CxDUNqbwVZKLqBzb8oRLLxIL9sh11RcGgy2Qd4zLa/LXxPjqpz
 J3MB0S1/NdvJOSUj1lCtHT2wtSYZm+OIWuTyPo/Jo0iC2fKct4lSeU0bpdQp1L8xrN5Oo6nSJ
 cPXd9MpxlgGXAMrs4pmg4UbENKOBjMmISRef811MDOAXYXmp1W1PbiYAlIXS/IUrRWBRyxfO+
 0o0iYUOMYEQ+Fx8IwOrC9MXmi8SgwbNOC/jlplBkwn7QgFIOjDqUuAawv6ilR7io2osw07TH3
 cneDhTFFr9y38YdUa/mtgVT1sebWwz38nVFZ7y3JbGNL6itx9OAeaMCm1oQ9pgRqe+xfCRIjd
 4Qr4ahsDRuGY97wXwM801SUTd6hjSMKH/AiFBn0zalbaowkVL8SqY0EQPb92gI8DAUtqKjK2m
 ppfowqYa+ryVoeTPONNryXemCBBVMwnWWCTcDsFuEsYz1+dqyxEu5Ucx8CZS2ShGmezWsWtPh
 9anoOo17Ov2MXQ/dHcAz6IxiEdvB5QcJzoX07BPB8uKkanE+rCJjZKrrxl2b3Pic73WCZ1Tq4
 p5OHI8fJP4Moux1toc2/JIYSR9rUyoBAS4uHN8pwMjbObhKoSYtvvd7npAwxyl/5ZUujzDBiI
 Em7EQ3ea6RvU6AV6Lgytk/uzDbFiNNPhR4nNmjl7gduXs44sNU1ny1iIf8unAs9ctJecVWJVu
 uZFJe1OmqNN9kybg6Oo8p3c0FXgREUuyxG96s/lxU8Rlg=



On 2024/2/1 21:02, Anand Jain wrote:
>
>
> On 2/1/24 04:06, Qu Wenruo wrote:
>>
>>
>> On 2024/2/1 02:23, Anand Jain wrote:
>>> On 1/30/24 11:31, Qu Wenruo wrote:
>>>> [BUG]
>>>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
>>>> descriptors open during whole time"), there is still a bug report abo=
ut
>>>> blkid failed to grab the FSID:
>>>>
>>>> =C2=A0 device=3D/dev/loop0
>>>> =C2=A0 fstype=3Dbtrfs
>>>>
>>>> =C2=A0 wipefs -a "$device"*
>>>>
>>>> =C2=A0 parted -s "$device" \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mklabel gpt \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkpart '"EFI system partition"' fat32 =
1MiB 513MiB \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set 1 esp on \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkpart '"root partition"' "$fstype" 51=
3MiB 100%
>>>>
>>>> =C2=A0 udevadm settle
>>>> =C2=A0 partitions=3D($(lsblk -n -o path "$device"))
>>>>
>>>> =C2=A0 mkfs.fat -F 32 ${partitions[1]}
>>>> =C2=A0 mkfs."$fstype" ${partitions[2]}
>>>> =C2=A0 udevadm settle
>>>>
>>>> The above script can sometimes result empty fsid:
>>>>
>>>> =C2=A0 loop0
>>>> =C2=A0 |-loop0p1 BDF3-552B
>>>> =C2=A0 `-loop0p2
>>>>
>>>
>>>
>>>
>>>> [CAUSE]
>>>> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descripto=
rs
>>>> open during whole time") changed the lifespan of the fds, it doesn't
>>>> properly inform udev about our change to certain partition.
>>>>
>
>
>>>> Thus for a multi-partition case, udev can start scanning the whole
>>>> disk,
>>>> meanwhile our mkfs is still happening halfway.
>>>>
>>>> If the scan is done before our new super blocks written, and our
>>>> close()
>>>> calls happens later just before the current scan is finished, udev ca=
n
>>>> got the temporary super blocks (which is not a valid one).
>>>>
>>>> And since our close() calls happens during the scan, there would be n=
o
>>>> new scan, thus leading to the bad result.
>>>>
>>>
>>>
>>>
>>> I am able to reproduce the missing udev events without the device
>>> partitions on the entire device also, so its not about the flock.
>>> Also, per the udevadm monitor I see no new fsid being reported for
>>> the btrfs. Please find the test case in the RFC patch below.
>>
>> Please go check the issue of btrfs-progs.
>>
>> Firstly, it is about flock().
>> In fact the problem would be gone if using "udevadm lock" command for
>> the mkfs.btrfs.
>>
>> And as I already explained, "udevadm lock" is just flock() for the
>> parent block device, with some extra fancy work like deadline and
>> deduplication.
>>
>
> I am able to reproduce the issue on the entire device, which conflicts
> with the cause you have mentioned. Ref to the test case in the RFC.
>
>>> The problem appears to be a convoluted nested file descriptor of the
>>> primary device (which obtains the temp-super-block).
>>
>> Nope.
>
> I don't see how your fix will work when two filesystems' mkfs use
> flock() simultaneously on different partitions of the same device.
> IMO, this approach is incorrect.

Why not?

The first would lock the parent block device, does it work, and unlock.
The other one who loses the race would just wait until the first one
finishes its work.

And I'd say you're incorrect, or argue with udev guys:

https://systemd.io/BLOCK_DEVICE_LOCKING/

>
> Were you able reproduce the issue with mkfs.xfs? I couldn't; xfs
> doesn't use flock() either, as I glanced.

Yes, mkfs.xfs is not doing the flock, but have you tried it with an
external log device on the same disk?
I'm pretty sure it would cause the same problem.

Any fs with multi-device support (no matter if it's external log or true
multi-device support) would have the same problem.

For pure single device usecase, changing the fd lifespan may be fine,
but see the next section, as I don't think the existing nested behavior
is the cause.

>
> Cleaning up the mkfs.btrfs file descriptors has been pending for a
> long time, which my RFC patch did as a first step. It makes it
> similar to what other filesystem mkfs do, with no nesting of open
> and close per device. The udev monitors CLOSE-WRITE event, and it
> works well with this RFC.

Then explain why the original nested workflow doesn't work in the first
place.

Let me be clear, we keep the first writeable fd open (for the
preparation part), then we open the devices for fs_info open.

At the time of close of the fs_info devices, the fs is already properly
written.
Later closes of the preparation fds would only:

- Trigger a new scan (and found nothing changed)
- Do nothing if there is already a running scan

Either way, as long as the scan is triggered by the close of writeable
fds, the scan should got a correct btrfs super already.

Thus the fd lifespan change makes no difference.

I would even suggest there may be some stray writeable fd we didn't notice=
.
But even that's the case, the proper flock() documented by the udev guys
can handle it correctly no matter what the lifespan of writeable fds is.

Thanks,
Qu
>
> Thanks, Anand
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> The RFC patch below optimizes the file descriptors and I find it to
>>> fix the issue. Now, both yours and my test cases pass.
>>>
>>> [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
>>> =C2=A0=C2=A0mkfs.btrfs
>>>
>>> Thanks, Anand
>>>
>>>
>>>
>>>
>>>> [FIX]
>>>> The proper way to avoid race with udev is to flock() the whole disk
>>>> (aka, the parent block device, not the partition disk).
>>>>
>>>> Thus this patch would introduce such mechanism by:
>>>>
>>>> - btrfs_flock_one_device()
>>>> =C2=A0=C2=A0 This would resolve the path to a whole disk path.
>>>> =C2=A0=C2=A0 Then make sure the whole disk is not already locked (thi=
s can happen
>>>> =C2=A0=C2=A0 for cases like "mkfs.btrfs -f /dev/sda[123]").
>>>>
>>>> =C2=A0=C2=A0 If the device is not already locked, then flock() the de=
vice, and
>>>> =C2=A0=C2=A0 insert a new entry into the list.
>>>>
>>>> - btrfs_unlock_all_devices()
>>>> =C2=A0=C2=A0 Would go unlock all devices recorded in locked_devices l=
ist, and
>>>> free
>>>> =C2=A0=C2=A0 the memory.
>>>>
>>>> And mkfs.btrfs would be the first one to utilize the new mechanism, t=
o
>>>> prevent such race with udev.
>>>>
>>>> Issue: #734
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Fix the patch prefix
>>>> =C2=A0=C2=A0 From "btrfs" to "btrfs-progs"
>>>> ---
>>>> =C2=A0 common/device-utils.c | 114
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 common/device-utils.h |=C2=A0=C2=A0 3 ++
>>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 ++++
>>>> =C2=A0 3 files changed, 128 insertions(+)
>>>>
>>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>>> index f86120afa00c..88c21c66382d 100644
>>>> --- a/common/device-utils.c
>>>> +++ b/common/device-utils.c
>>>> @@ -17,11 +17,13 @@
>>>> =C2=A0 #include <sys/ioctl.h>
>>>> =C2=A0 #include <sys/stat.h>
>>>> =C2=A0 #include <sys/types.h>
>>>> +#include <sys/file.h>
>>>> =C2=A0 #include <linux/limits.h>
>>>> =C2=A0 #ifdef BTRFS_ZONED
>>>> =C2=A0 #include <linux/blkzoned.h>
>>>> =C2=A0 #endif
>>>> =C2=A0 #include <linux/fs.h>
>>>> +#include <linux/kdev_t.h>
>>>> =C2=A0 #include <limits.h>
>>>> =C2=A0 #include <stdio.h>
>>>> =C2=A0 #include <stdlib.h>
>>>> @@ -48,6 +50,24 @@
>>>> =C2=A0 #define BLKDISCARD=C2=A0=C2=A0=C2=A0 _IO(0x12,119)
>>>> =C2=A0 #endif
>>>>
>>>> +static LIST_HEAD(locked_devices);
>>>> +
>>>> +/*
>>>> + * This is to record flock()ed devices.
>>>> + * For flock() to prevent udev races, we must lock the parent block
>>>> device,
>>>> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that
>>>> case
>>>> + * we should only lock "/dev/sda" once.
>>>> + *
>>>> + * This structure would be used to record any flocked block device
>>>> (not
>>>> + * the partition one), and avoid double locking.
>>>> + */
>>>> +struct btrfs_locked_wholedisk {
>>>> +=C2=A0=C2=A0=C2=A0 char *full_path;
>>>> +=C2=A0=C2=A0=C2=A0 dev_t devno;
>>>> +=C2=A0=C2=A0=C2=A0 int fd;
>>>> +=C2=A0=C2=A0=C2=A0 struct list_head list;
>>>> +};
>>>> +
>>>> =C2=A0 /*
>>>> =C2=A0=C2=A0 * Discard the given range in one go
>>>> =C2=A0=C2=A0 */
>>>> @@ -633,3 +653,97 @@ ssize_t btrfs_direct_pwrite(int fd, const void
>>>> *buf, size_t count, off_t offset)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(bounce_buf);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>> +
>>>> +int btrfs_flock_one_device(char *path)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_locked_wholedisk *entry;
>>>> +=C2=A0=C2=A0=C2=A0 struct stat st =3D { 0 };
>>>> +=C2=A0=C2=A0=C2=A0 char *wholedisk_path;
>>>> +=C2=A0=C2=A0=C2=A0 dev_t wholedisk_devno;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D stat(path, &st);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to stat %s:=
 %m", path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 /* Non-block device, skipping the locking. */
>>>> +=C2=A0=C2=A0=C2=A0 if (!S_ISBLK(st.st_mode))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D blkid_devno_to_wholedisk(st.st_dev, path,=
 strlen(path),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &wholed=
isk_devno);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to get the =
whole disk devno for %s: %m", path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 wholedisk_path =3D blkid_devno_to_devname(wholedi=
sk_devno);
>>>> +=C2=A0=C2=A0=C2=A0 if (!wholedisk_path) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to get the =
devname of dev %ld:%ld",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M=
AJOR(wholedisk_devno), MINOR(wholedisk_devno));
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Check if we already have the whole disk in the=
 list. */
>>>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry(entry, &locked_devices, list)=
 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The wholedisk is alrea=
dy locked, need to do nothing. */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry->devno =3D=3D w=
holedisk_devno ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
ntry->full_path =3D=3D wholedisk_path) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ree(wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn 0;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Allocate new entry. */
>>>> +=C2=A0=C2=A0=C2=A0 entry =3D malloc(sizeof(*entry));
>>>> +=C2=A0=C2=A0=C2=A0 if (!entry) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("unable to allocate=
 new memory for %s: %m",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 entry->devno =3D wholedisk_devno;
>>>> +=C2=A0=C2=A0=C2=A0 entry->full_path =3D wholedisk_path;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Lock the whole disk. */
>>>> +=C2=A0=C2=A0=C2=A0 entry->fd =3D open(wholedisk_path, O_RDONLY);
>>>> +=C2=A0=C2=A0=C2=A0 if (entry->fd < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to open dev=
ice %s: %m",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(entry);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D flock(entry->fd, LOCK_EX);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed to hold an =
exclusive lock on %s: %m",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(wholedisk_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(entry);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Insert it into the list. */
>>>> +=C2=A0=C2=A0=C2=A0 list_add_tail(&entry->list, &locked_devices);
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +void btrfs_unlock_all_devicecs(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 while (!list_empty(&locked_devices)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_locked_whole=
disk *entry;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D list_entry(lock=
ed_devices.next,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_locked_wholedisk, =
list);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&entry->lis=
t);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D flock(entry->fd, =
LOCK_UN);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
arning("failed to unlock %s (fd %d dev %ld:%ld),
>>>> skipping it",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 entry->full_path, entry->fd, MAJOR(entry->devno),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 MINOR(entry->devno));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(entry->full_path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(entry);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +}
>>>> diff --git a/common/device-utils.h b/common/device-utils.h
>>>> index 853d17b5ab98..3a04348a0867 100644
>>>> --- a/common/device-utils.h
>>>> +++ b/common/device-utils.h
>>>> @@ -57,6 +57,9 @@ int btrfs_prepare_device(int fd, const char *file,
>>>> u64 *block_count_ret,
>>>> =C2=A0 ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, of=
f_t
>>>> offset);
>>>> =C2=A0 ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t co=
unt,
>>>> off_t offset);
>>>>
>>>> +int btrfs_flock_one_device(char *path);
>>>> +void btrfs_unlock_all_devicecs(void);
>>>> +
>>>> =C2=A0 #ifdef BTRFS_ZONED
>>>> =C2=A0 static inline ssize_t btrfs_pwrite(int fd, const void *buf, si=
ze_t
>>>> count,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off_t offset, bool dir=
ect)
>>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>>> index b9882208dbd5..6e6cb81a4165 100644
>>>> --- a/mkfs/main.c
>>>> +++ b/mkfs/main.c
>>>> @@ -1723,6 +1723,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 /* Lock all devices to prevent race with udev pro=
bing. */
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < device_count; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *path =3D argv[optin=
d + i - 1];
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_flock_one_d=
evice(path);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
arning("failed to flock %s, skipping it", path);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Start threads */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < device_count; i++) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_ctx[i]=
.file =3D argv[optind + i - 1];
>>>> @@ -2079,6 +2088,7 @@ out:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(label);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(source_dir);
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 btrfs_unlock_all_devicecs();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!ret;
>>>>
>>>> =C2=A0 error:
>>>> @@ -2090,6 +2100,7 @@ error:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(prepare_ctx);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(label);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(source_dir);
>>>> +=C2=A0=C2=A0=C2=A0 btrfs_unlock_all_devicecs();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>>> =C2=A0 success:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0);
>>>> --
>>>> 2.43.0
>>>>
>>>
>

