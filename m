Return-Path: <linux-btrfs+bounces-1955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E23E84387D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072D11F2344E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658A5B5B8;
	Wed, 31 Jan 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LLyYCDtP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5F5A0E5
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688455; cv=none; b=AsMPOoMgqX/I3bzgBfUAR/a1ulihxOLSm+K2Z5wE72Ct/2leAq8godzazPY+qHndrBAV3hpNxLhqcy2PprLGdR+cDiEIYqSqtZsw6bxpl9uXidSJUK5kajOOrq6F7WtlItDjqEfmnjm4cuYSJUFoFOdSf7G3ku0mP2Py+A/WlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688455; c=relaxed/simple;
	bh=WWnG0PvyAo4cbDYLuXx0Y/GuxkhaLWrEx7JQslzSGkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRhGiYcV2VIFOH9XjIhVTvJhNDo9Pr7gfnUzMTScMA6ySawekffvKn0Ueb8+y4pP02L1vWJxrMfVw6ENtFWMbHVkRgFGJdSfTw020iv4e2bCl2NDk9MZWl0Qh96+Zay/5IEzUfBKimjdvy/zld+zFgHVSQGEgyYNnqCEamn69Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LLyYCDtP; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706688449; x=1707293249; i=quwenruo.btrfs@gmx.com;
	bh=WWnG0PvyAo4cbDYLuXx0Y/GuxkhaLWrEx7JQslzSGkU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LLyYCDtPGGhB4oavqQ5+Cma1LjX+M7A3rmZSurTon0thGQP1rFixqU8Gz6F5Em2d
	 vrQFkITKWHkC/HPMI1oTzIs9hoEhL5sKDlq2VI1v1H9EICZRs1eVyPEqs4xKZ31/O
	 n2XBRWC5dJ3DJel9PVsd3Pk3+Nlz2h1YCXtya4SbGKob2Caxanu5mkcqcEkm8VQAK
	 zDvvzy/an+KmD3SummLGikHgLicOq8ED/LrUx3PKeiAQ7SpHHHS9Qx5gAKvPajxCP
	 DBI6h+Q6oRvZnIj9yZsve50G6LaQD5vEN2YHABMRK242wqHna6fEpr7a+Y4YYOvRy
	 5JZtoqRlrwYsJGHbqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4b1o-1rWjWZ0Aek-001gEa; Wed, 31
 Jan 2024 09:07:29 +0100
Message-ID: <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
Date: Wed, 31 Jan 2024 18:37:26 +1030
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
In-Reply-To: <20240131071319.GH31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3Qobc/Oh03hmEQmrdwtgIxnN0cGgwmSnTVL2hEr8gAoPqPpLFM
 8L47N+KtbuQ7rryFCvjiROrxY50PnTEBcexhlGnun9WE1VBC+uJjh0havkhwg7ZITu2UJOP
 0CD2k1ej+PHQrs3bXByUh2OQd6Z/JqZsXTGaKbiqQaqokTHvMDuI6jWYRE1Uu2VVnJYSqgt
 YoKW2w9lNIolbDzrW5m0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sScQihzS/bY=;dM8b24BZLk4iBD0pmWrpaVwsR56
 /j7J3Yzii/CsGCUQ4ggsxaya0HBedOegohKFaCAv9BPsFkrbVoYz8mMo9KQ8ba90R4kKGZ2SZ
 qhQxe65p4IhlW9lPzrXrZIPJFPwhP8lS1YMWp+SC83B4/9Cs6frt3kThSsjvCYriJV64n6hXs
 5Ba62BkYE6W6/YZBtmGT8cNiCnWdL9AzI0HZfdgIsDD42NyLWG2JXT4cSJkGenhSRW/SfCz1B
 vN+cxH7xA5Vq4706dfuP7Z4Vx65ogsDSf4z7mDxYdvkxtRTCnt5l2+Hs+HipGSBFpe3nbuqFN
 84VcuzmluNEBrqsc8u4uLFGowFkSll2ycfh+pbvU+w2KEBRugkxnPNtXpNFzaEMs+SPehAk78
 RpOL3TUyBOWj8PuDmy237TsLmvpvwBStSgsbRJzXDFaZ8UDG/Af4iRHbor9s0p0S5XjkGnoWr
 9rILjaM2cCrAvOvC6dSkqIw8hYDRST01HBajEQlnQ8cLeyVao2bWdYmNhKaB++UMoysjVvcU+
 Z1lXpiGow2bzF0nnvqyv5ktU8VHsDu3anFW5tmOjUFrIfgcDdJoJojx9Yhx3d2Y9/SMASSEEi
 X7Zw6e3HX7fg+Spx69iV+Lf36BYPmbUZFQTLYbFZO1mIAB7PYNhzpWZGHwID5PTtrrAeK4cwp
 mxb/LStJQOUOvX7qYyq77IKTtR9jKpXNc8KKuog8AXr5Hc/A2wwBqtNAG6qQSaZ/ViEUrRAGb
 RiUsWoMcW+GFSPCxqSBvx3WSbB9EYEsPym5NlmfkcrOW7NzukvRPxn7GG7p/hGfEMzmqqz8wj
 IimDbQs+SzKevbUrx9DZrzdy1vKFodpNWk9vzGlT5SlRArS/0QZ5YOPJJ4Srkixt8nvhIzih9
 d6TzbquMh2KrJK+SWWo7ZMiyyQ9salMvRCZJS6qJy2C2ovnrSbzMZhIy/W+2FhuLYfCzk0ChX
 /Qdl8WRIvE0WnQmWGULFZYe2CWg=



On 2024/1/31 17:43, David Sterba wrote:
> On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
>> [BUG]
>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
>> descriptors open during whole time"), there is still a bug report about
>> blkid failed to grab the FSID:
>>
>>   device=3D/dev/loop0
>>   fstype=3Dbtrfs
>>
>>   wipefs -a "$device"*
>>
>>   parted -s "$device" \
>>       mklabel gpt \
>>       mkpart '"EFI system partition"' fat32 1MiB 513MiB \
>>       set 1 esp on \
>>       mkpart '"root partition"' "$fstype" 513MiB 100%
>>
>>   udevadm settle
>>   partitions=3D($(lsblk -n -o path "$device"))
>>
>>   mkfs.fat -F 32 ${partitions[1]}
>>   mkfs."$fstype" ${partitions[2]}
>>   udevadm settle
>
> As mentioned in the issue 'udevadm lock <command>' can be used as a
> workaround until mkfs does the locking but we can also use that for
> testing, ie lock a device and then try mkfs.

Indeed, that may be a cleaner way to solve the problem.

Let me check if there is any API provided to do that, but still we will
need the same de-duplication check to prevent locking the same device
twice if we're making fs on all partition from the same disk.

>
>>
>> The above script can sometimes result empty fsid:
>>
>>   loop0
>>   |-loop0p1 BDF3-552B
>>   `-loop0p2
>>
>> [CAUSE]
>> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
>> open during whole time") changed the lifespan of the fds, it doesn't
>> properly inform udev about our change to certain partition.
>>
>> Thus for a multi-partition case, udev can start scanning the whole disk=
,
>> meanwhile our mkfs is still happening halfway.
>>
>> If the scan is done before our new super blocks written, and our close(=
)
>> calls happens later just before the current scan is finished, udev can
>> got the temporary super blocks (which is not a valid one).
>>
>> And since our close() calls happens during the scan, there would be no
>> new scan, thus leading to the bad result.
>>
>> [FIX]
>> The proper way to avoid race with udev is to flock() the whole disk
>> (aka, the parent block device, not the partition disk).
>>
>> Thus this patch would introduce such mechanism by:
>>
>> - btrfs_flock_one_device()
>>    This would resolve the path to a whole disk path.
>>    Then make sure the whole disk is not already locked (this can happen
>>    for cases like "mkfs.btrfs -f /dev/sda[123]").
>>
>>    If the device is not already locked, then flock() the device, and
>>    insert a new entry into the list.
>>
>> - btrfs_unlock_all_devices()
>>    Would go unlock all devices recorded in locked_devices list, and fre=
e
>>    the memory.
>>
>> And mkfs.btrfs would be the first one to utilize the new mechanism, to
>> prevent such race with udev.
>>
>> Issue: #734
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the patch prefix
>>    From "btrfs" to "btrfs-progs"
>> ---
>>   common/device-utils.c | 114 +++++++++++++++++++++++++++++++++++++++++=
+
>>   common/device-utils.h |   3 ++
>>   mkfs/main.c           |  11 ++++
>>   3 files changed, 128 insertions(+)
>>
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index f86120afa00c..88c21c66382d 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -17,11 +17,13 @@
>>   #include <sys/ioctl.h>
>>   #include <sys/stat.h>
>>   #include <sys/types.h>
>> +#include <sys/file.h>
>>   #include <linux/limits.h>
>>   #ifdef BTRFS_ZONED
>>   #include <linux/blkzoned.h>
>>   #endif
>>   #include <linux/fs.h>
>> +#include <linux/kdev_t.h>
>>   #include <limits.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> @@ -48,6 +50,24 @@
>>   #define BLKDISCARD	_IO(0x12,119)
>>   #endif
>>
>> +static LIST_HEAD(locked_devices);
>> +
>> +/*
>> + * This is to record flock()ed devices.
>> + * For flock() to prevent udev races, we must lock the parent block de=
vice,
>> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that ca=
se
>> + * we should only lock "/dev/sda" once.
>> + *
>> + * This structure would be used to record any flocked block device (no=
t
>> + * the partition one), and avoid double locking.
>> + */
>> +struct btrfs_locked_wholedisk {
>
> Please pick a different name, we've been calling it devices, although
> you can find 'disk' references but mainly for historical reasons (eg.
> when it's in a structure). In this case it's a block device.
>

Well, the "wholedisk" name is from the libblk, and I thought it may be
good enough, but it's not the case.

Maybe "parent_block_dev" would be better?

Thanks,
Qu

