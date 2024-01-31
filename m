Return-Path: <linux-btrfs+bounces-1982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331C3844D55
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 00:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568631C23191
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D83A8E3;
	Wed, 31 Jan 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RQDjI6IR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB53A8C6
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744927; cv=none; b=F3ZC10QqfmKjG6Fb+F+FQcDqF8hwxZ6JwPdcFTmSCH7khrPOk6KGqvVHZM6xI1BmS4hkR+laNea6Zd8doAkMowCqnHi1HHovhQZrgRqEXxVk+rbKGb15kyWs+EeZeNQpjA9yWUZd2qPfnDsIvrNMWKqbOjCT28h/90W4pNGr4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744927; c=relaxed/simple;
	bh=aDXwu2d80cHvfQj8RqZ5/1t4Ae2GYVw00RFQbQcxQac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlVI9Q16otHIcqklvEaqUkwreBhW9QnyhiQwmqjVAa7z0mdCacYcS56s0fiIrDUDIvwfHwoFEz3yRem7x34ivjuukaKcQ5Q+6CpWsXAlFoVEU6ICjqC5T3kDWkmze7d4wiS6HvmyYdpTjeEDjrFpF57pwBzoAk4eoAIIGSgsOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RQDjI6IR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706744921; x=1707349721; i=quwenruo.btrfs@gmx.com;
	bh=aDXwu2d80cHvfQj8RqZ5/1t4Ae2GYVw00RFQbQcxQac=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RQDjI6IRqonzzqOoYTm+ZLQMI+6op9fwKNhvckNs/pi6399X5Sqraa2s0x1Lm3Sm
	 sR8UZR8NGf0U4MPvScK/McH41r7idR7JyXrsvTj8MRmZrYe3wa8DfrqE7DhOs/KXp
	 NYxE2WWgHWjAhcvngY+9HuFP78xC1EbQ0QTMmpbKtH2QPE1NqqTnxNQPlnnTLjR+D
	 x7Sc4Q9sa239HnICT3D5ezMMuxE40H2QNPDeZglINN2LV6bH29t4R/UszN1nlY/BI
	 6Wm/uK4OWQB6QCsucGhQfWHlImoAO/WQwBTEWtVJmCpXmcTiYsMNkD4jA7crVBrHY
	 HgxWYDO5j8FXvTLVlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDIu-1qnE8v13ZY-00i9tx; Thu, 01
 Feb 2024 00:48:41 +0100
Message-ID: <dda90424-0961-4dfe-9196-114dba854e51@gmx.com>
Date: Thu, 1 Feb 2024 10:18:38 +1030
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
 <20240131182409.GO31555@twin.jikos.cz>
 <6b1001cb-7df0-4ffc-ab15-cd25223da9d6@suse.com>
 <20240131230413.GT31555@twin.jikos.cz>
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
In-Reply-To: <20240131230413.GT31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38V1sC/qu2FOstaChb/QUnX5zaE/FP3EqQwUloLgCaSljC9oXQl
 WypF/6d4077hlSMfc/n4Hl89BMvLiXiFLAXFoUB2bej0YSiOUC2zF2ZShPRDfpZSz9meV0M
 v/JW6epbjgLbQ0IiD40QJ/n6VSPhhvgQqllI2vqvErBO88ZEHNzCutcN8eogu4J0zJv4JHk
 31VRwRuPWKJQD3aO5jGWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fCoppH8j60Q=;tC3MzMlzj6ayYmzYHML38CBmoTk
 EBhPb60kp6cYvuth0emdFhATKz6tLLGXmRiepCWqtnagngUV3CM5z7KWyCsR5eqYLQP5JuJwq
 nTbuANHCBX46ZJ1O004fjer+3tyPpMP21OAowLsFaIhqeor2p+6TDZdFvAeaI+wqviFEcFJXo
 ZNqo5AZMnPMD6fcV7D8PushSTuFvcfy5mJSQ0Z5kbE4TePIdrUsRphDfye5zsDXIBuxieNhoM
 n4n5WPjqz6NWGZz9+b5jkypUedDg/9FY2RHlClHB+JCCzviPyYSnPRV1q21wqKfXyYq198fKk
 xoOcxFgReRgTrb5AQ09p2xl05yTgK/spU/oFvtjU0KXofp4ou/O5V7h6uR5O/X/1nZ9OEFv8+
 b/8jph94c7L8wYIDZZk++R15blCiIa7ETg5B1c672sfMtXwS+5tLsCQmHfXFZbM8rOamXIV9g
 xn+HP8Lp1poJA94s2KIXWsLhkCHUTx0ljT6wPdU2frtNbvh8CodRSLCRUESxdUan8IllezkE0
 yQo0I8UgPttUhZ9MwHwuqJ2tlshwwlqgLC/KWPebi/NZXDgfCGbqLpBo//CuIeXkuSlnrEdYi
 Tuqet0E45RYpNClNVmVmPy8sbduITxQe+X16+Kc58WDYTfh0f4E/XyPNbAvn+tQXlHaxFEPp4
 r4Q1zxVcc1X2OlnGE9F2mJPTNCewOzSLVgLGNvDKet0sCP1bUTsX1+LUP6CZARQq1h7UK2SqA
 S3npjBSU7O30Hd0zAEI5rHKcpyidFHmTUJQIAUWu5dsUBJDIqIYI/xTev9xBZa7Dv/fTJfD57
 0V4LvMsmlJxh/tERaDx5J2kFn7LyVme38fP/fs8IKVmGw=



On 2024/2/1 09:34, David Sterba wrote:
> On Thu, Feb 01, 2024 at 09:08:31AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/2/1 04:54, David Sterba wrote:
>>> On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
>>>> descriptors open during whole time"), there is still a bug report abo=
ut
>>>> blkid failed to grab the FSID:
>>>>
>>>>    device=3D/dev/loop0
>>>>    fstype=3Dbtrfs
>>>>
>>>>    wipefs -a "$device"*
>>>>
>>>>    parted -s "$device" \
>>>>        mklabel gpt \
>>>>        mkpart '"EFI system partition"' fat32 1MiB 513MiB \
>>>>        set 1 esp on \
>>>>        mkpart '"root partition"' "$fstype" 513MiB 100%
>>>>
>>>>    udevadm settle
>>>>    partitions=3D($(lsblk -n -o path "$device"))
>>>>
>>>>    mkfs.fat -F 32 ${partitions[1]}
>>>>    mkfs."$fstype" ${partitions[2]}
>>>>    udevadm settle
>>>>
>>>> The above script can sometimes result empty fsid:
>>>>
>>>>    loop0
>>>>    |-loop0p1 BDF3-552B
>>>>    `-loop0p2
>>>>
>>>> [CAUSE]
>>>> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descripto=
rs
>>>> open during whole time") changed the lifespan of the fds, it doesn't
>>>> properly inform udev about our change to certain partition.
>>>>
>>>> Thus for a multi-partition case, udev can start scanning the whole di=
sk,
>>>> meanwhile our mkfs is still happening halfway.
>>>>
>>>> If the scan is done before our new super blocks written, and our clos=
e()
>>>> calls happens later just before the current scan is finished, udev ca=
n
>>>> got the temporary super blocks (which is not a valid one).
>>>>
>>>> And since our close() calls happens during the scan, there would be n=
o
>>>> new scan, thus leading to the bad result.
>>>>
>>>> [FIX]
>>>> The proper way to avoid race with udev is to flock() the whole disk
>>>> (aka, the parent block device, not the partition disk).
>>>>
>>>> Thus this patch would introduce such mechanism by:
>>>>
>>>> - btrfs_flock_one_device()
>>>>     This would resolve the path to a whole disk path.
>>>>     Then make sure the whole disk is not already locked (this can hap=
pen
>>>>     for cases like "mkfs.btrfs -f /dev/sda[123]").
>>>>
>>>>     If the device is not already locked, then flock() the device, and
>>>>     insert a new entry into the list.
>>>>
>>>> - btrfs_unlock_all_devices()
>>>>     Would go unlock all devices recorded in locked_devices list, and =
free
>>>>     the memory.
>>>>
>>>> And mkfs.btrfs would be the first one to utilize the new mechanism, t=
o
>>>> prevent such race with udev.
>>>
>>> The other possible user could be btrfs-convert as it also writes data
>>> and changes the UUID.
>>>
>>>> Issue: #734
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Added to devel, thanks for fixing it.
>>
>> Sorry, this v2 is still incorrect, as it doesn't use the correct device
>> number, the proper fix is in my flock branch.
>>
>> But I'll send out a v3 just in case.
>
> I noticed the update after I replied, the commit in devel is from your
> repository. There were added hunks in btrfs_flock_one_device() adding
> path_dump, and some typos fixed.
>
As long as you're using the commit from my repo, it's totally fine.

Thanks,
Qu

