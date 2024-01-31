Return-Path: <linux-btrfs+bounces-1956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C8843927
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4CBB219DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E3605DC;
	Wed, 31 Jan 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="H7FRVkmE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C186604C3
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690068; cv=none; b=pnCknhzs0GhNMn1Bwds62IfzrfvtyOHueZ01sUZRZAUi157v036tiHoXDYqA8y12WjA8bPnpJHm/BR5ui52cPUpX9RuFTbPAFJ6AAM9YVG46mYQ+Kqb+A4ACXEAO2iaXQPYp+3BA3x8BzIdoxbtsD2kELgW4VjQxJQQPJBlsuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690068; c=relaxed/simple;
	bh=ePO6h4f3wxtNM8TR+Vv92v/prgQmCbAzU0s4qFRU1Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoLMBapf5gQZ+/dspD2bVgv0M02VKyIEr5ZDXK8UabGDehgMCPUUIGfDTyZaPQdrJl26o3zZh5GbMPyhm1Z+DFz4g0xS6+T3Mk0A15NCFq76A3fuaMT90/bEsbP4OgCRa7U4UyWVkXg92lHgnYjcQj0IinnEBswBbQavE8Z9hcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=H7FRVkmE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706690063; x=1707294863; i=quwenruo.btrfs@gmx.com;
	bh=ePO6h4f3wxtNM8TR+Vv92v/prgQmCbAzU0s4qFRU1Rs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=H7FRVkmEM9AWpYA4DFUqpYtLVPbaFWcBN1y2fpt6sUGZNEPD224HAWUxFxozBZI9
	 S/AluYMSWPLVsYAHqIoWQk1JEH3Kr7v4QOsz4xCA8Bcbm39Pg96Fke3roymTnt1+I
	 g1U4fXQaEfpd5ddjMB6NPxnoUePZpSLRLA9UxdVoStRF8tGmNE0zSueG66+P7FfTS
	 1LiXASdvyb5YjuC4NjWz4uDVjhZIk2wqMKef9HMrFJMw9UBTFt8IByYbFJ5vge4ay
	 Q9njuficsyxPKgYz1XrKgR8ZVPBxCvTVt7uHNmPNogxaz9alXjnwt5JOJDuHNfWNJ
	 YX2fYGRBy5t09yefNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lc9-1rUovt39rX-000pKb; Wed, 31
 Jan 2024 09:34:23 +0100
Message-ID: <0ecad434-8a72-4528-aa1c-579a32044e1e@gmx.com>
Date: Wed, 31 Jan 2024 19:04:19 +1030
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
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131071319.GH31555@twin.jikos.cz>
 <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
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
In-Reply-To: <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2oiifxhVQEAAXYBF3S2MReyUmMEqTFsdOC9gP2/NtJwFf9VDEOr
 svmpoFelOCgy8mRyOMPfOmu5SW7m1ke3YjQMrmYX5YQKjLkPjtt4IhuKZOc3vcsQ71Ep9ce
 P4gxfBbVoXgUTcGuTzgzgANgiMU/Udn0G43j1dpXnfdVwvyMC9hDcHZMCN8GtY1L+g5FKOH
 t77ClQL5nLGmjmuDoWBCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:na7NqGFaK9Q=;kJv/PdGG9Ecmyon7xr0NCJ0JJpb
 2XL07U4uwqHbF13XH8o/WJthsUME1BwJOxi2u/R/O7BtsaLM14pKcVrIvDaxzUNOcHTZI6ps6
 UEu8uXtzZ++UEEVwxik3l5t2JvBpi+NRlsE6WUX2gPUXy+2pTkwszAPXhA2vwODAHfP1G4ljQ
 CeKaOjveKDf9M+wtKvKt6orJhr6ybHMsf8i6P+q/WsnvjfAEDjqFCmnZYQv5cH8JBYhAUtEIV
 pelTkVCYsMqrmb6e0kxWNQzayDhcdsf8KEk4HhCqL+0P4uC5ChYbkVes/TrwpJEuVDZZmH9OS
 P3/K99IS2C3NUIDiiJ55T2Wh8N57VKwr+Thbkn6UsCMwVklaCqWhqDTnDsHi2R6Hhnkw1cxfC
 4p+24ccvDZFsUZrO5EmPwjxjppH/mKkrQjoKhNDb3RLaDac3FQlk1J8QhF6g6fzOKQD+9Jqb0
 SbW7DPppgx4T2Ng8+QbWTTmMgVa0gZ1qTwJ+3UemdmSm++jxJ0hH6XVbk4QDJe/eQprryIWRt
 C10ZQaMl5SY1MX3xThcNJvI/c+S1a/4f4dElCW79JOtN46WiVAKt2jtBbxzByRIO2gAnu3C8E
 uTbQBBL4xdMPshecJ1fTOaKkXV7VogRCgDItPoTQ09AI6AY/64hLO7IYP8LWYmkuhLhTy+ztA
 ZlHO4q0zdtyCzlh3UBPOcHweiY+gAj0cfbiZhs5YKL996HQC4ZtjZZQAI0qPP1QQMjQg52uBr
 WZSiRdj+uZc1wKqRw/0A7DmD/A3b7lv4c8eGg5WGuhLy8Ly0DIGEq1Pk38xycz07rODv9iEMV
 oAm7XwuLGjytgGsOXXw5mbXxiDb2bhoXqWt8Mkz2u7EtssvU0LtnjB63o5O6i9dsTVDv5KQHV
 liuZmzD4xL7wTO0pwuInXIcEQkaOCS9MQk+uzHk6mZfE1vHru68GLY/FPwVEz/jHFDVs15GU6
 NuOjgkvNpNQOI2uUjM39i7dlkpM=



On 2024/1/31 18:37, Qu Wenruo wrote:
>
>
> On 2024/1/31 17:43, David Sterba wrote:
>> On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
>>> [BUG]
>>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
>>> descriptors open during whole time"), there is still a bug report abou=
t
>>> blkid failed to grab the FSID:
>>>
>>> =C2=A0 device=3D/dev/loop0
>>> =C2=A0 fstype=3Dbtrfs
>>>
>>> =C2=A0 wipefs -a "$device"*
>>>
>>> =C2=A0 parted -s "$device" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mklabel gpt \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkpart '"EFI system partition"' fat32 1=
MiB 513MiB \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set 1 esp on \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkpart '"root partition"' "$fstype" 513=
MiB 100%
>>>
>>> =C2=A0 udevadm settle
>>> =C2=A0 partitions=3D($(lsblk -n -o path "$device"))
>>>
>>> =C2=A0 mkfs.fat -F 32 ${partitions[1]}
>>> =C2=A0 mkfs."$fstype" ${partitions[2]}
>>> =C2=A0 udevadm settle
>>
>> As mentioned in the issue 'udevadm lock <command>' can be used as a
>> workaround until mkfs does the locking but we can also use that for
>> testing, ie lock a device and then try mkfs.
>
> Indeed, that may be a cleaner way to solve the problem.
>
> Let me check if there is any API provided to do that, but still we will
> need the same de-duplication check to prevent locking the same device
> twice if we're making fs on all partition from the same disk.

Nope, the "udevadm lock" is just doing flock() on the target device,
thus it's no difference than my implementation.

The call chain looks like this:

udevadm-lock.c:
lock_device()
|- lock_generic(LOCK_BSD, LOCK_EX|LOCK_NB);
    |- flock(fd, operation);

And the fd passed in is also the "wholedisk" fd, not the partition disk fd=
:

lock_main()
|- find_devno()
    |- path_get_whole_disk()

So in short, "udevadm lock" command is just doing:

- Convert the partition path to whole disk path
- Make sure the whole disk is not yet locked
- Then call flock() on it
   There are some extra work like deadline, but it's not really
   something we need to bother AFAIK.

And it also has the same de-duplication ability of my patch.
Although udev is using binary search instead of my simpler but slower
list based search.

Whether to utilize external "udevadm lock" command, or doing the same
thing inside "mkfs.btrfs" is up to you to determine.

But at least, I'm doing the same thing as "udevadm lock".
(Although this version has other problems, like using st_dev not
st_rdev, and not properly making the parameter for
btrfs_flock_one_device() const etc)

Thanks,
Qu
>
>>
>>>
>>> The above script can sometimes result empty fsid:
>>>
>>> =C2=A0 loop0
>>> =C2=A0 |-loop0p1 BDF3-552B
>>> =C2=A0 `-loop0p2
>>>
>>> [CAUSE]
>>> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptor=
s
>>> open during whole time") changed the lifespan of the fds, it doesn't
>>> properly inform udev about our change to certain partition.
>>>
>>> Thus for a multi-partition case, udev can start scanning the whole dis=
k,
>>> meanwhile our mkfs is still happening halfway.
>>>
>>> If the scan is done before our new super blocks written, and our close=
()
>>> calls happens later just before the current scan is finished, udev can
>>> got the temporary super blocks (which is not a valid one).
>>>
>>> And since our close() calls happens during the scan, there would be no
>>> new scan, thus leading to the bad result.
>>>
>>> [FIX]
>>> The proper way to avoid race with udev is to flock() the whole disk
>>> (aka, the parent block device, not the partition disk).
>>>
>>> Thus this patch would introduce such mechanism by:
>>>
>>> - btrfs_flock_one_device()
>>> =C2=A0=C2=A0 This would resolve the path to a whole disk path.
>>> =C2=A0=C2=A0 Then make sure the whole disk is not already locked (this=
 can happen
>>> =C2=A0=C2=A0 for cases like "mkfs.btrfs -f /dev/sda[123]").
>>>
>>> =C2=A0=C2=A0 If the device is not already locked, then flock() the dev=
ice, and
>>> =C2=A0=C2=A0 insert a new entry into the list.
>>>
>>> - btrfs_unlock_all_devices()
>>> =C2=A0=C2=A0 Would go unlock all devices recorded in locked_devices li=
st, and free
>>> =C2=A0=C2=A0 the memory.
>>>
>>> And mkfs.btrfs would be the first one to utilize the new mechanism, to
>>> prevent such race with udev.
>>>
>>> Issue: #734
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Fix the patch prefix
>>> =C2=A0=C2=A0 From "btrfs" to "btrfs-progs"
>>> ---
>>> =C2=A0 common/device-utils.c | 114 +++++++++++++++++++++++++++++++++++=
+++++++
>>> =C2=A0 common/device-utils.h |=C2=A0=C2=A0 3 ++
>>> =C2=A0 mkfs/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 ++++
>>> =C2=A0 3 files changed, 128 insertions(+)
>>>
>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>> index f86120afa00c..88c21c66382d 100644
>>> --- a/common/device-utils.c
>>> +++ b/common/device-utils.c
>>> @@ -17,11 +17,13 @@
>>> =C2=A0 #include <sys/ioctl.h>
>>> =C2=A0 #include <sys/stat.h>
>>> =C2=A0 #include <sys/types.h>
>>> +#include <sys/file.h>
>>> =C2=A0 #include <linux/limits.h>
>>> =C2=A0 #ifdef BTRFS_ZONED
>>> =C2=A0 #include <linux/blkzoned.h>
>>> =C2=A0 #endif
>>> =C2=A0 #include <linux/fs.h>
>>> +#include <linux/kdev_t.h>
>>> =C2=A0 #include <limits.h>
>>> =C2=A0 #include <stdio.h>
>>> =C2=A0 #include <stdlib.h>
>>> @@ -48,6 +50,24 @@
>>> =C2=A0 #define BLKDISCARD=C2=A0=C2=A0=C2=A0 _IO(0x12,119)
>>> =C2=A0 #endif
>>>
>>> +static LIST_HEAD(locked_devices);
>>> +
>>> +/*
>>> + * This is to record flock()ed devices.
>>> + * For flock() to prevent udev races, we must lock the parent block
>>> device,
>>> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that
>>> case
>>> + * we should only lock "/dev/sda" once.
>>> + *
>>> + * This structure would be used to record any flocked block device (n=
ot
>>> + * the partition one), and avoid double locking.
>>> + */
>>> +struct btrfs_locked_wholedisk {
>>
>> Please pick a different name, we've been calling it devices, although
>> you can find 'disk' references but mainly for historical reasons (eg.
>> when it's in a structure). In this case it's a block device.
>>
>
> Well, the "wholedisk" name is from the libblk, and I thought it may be
> good enough, but it's not the case.
>
> Maybe "parent_block_dev" would be better?
>
> Thanks,
> Qu
>

