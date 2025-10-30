Return-Path: <linux-btrfs+bounces-18421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71778C21BA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 19:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267D73AC5AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970C2EC092;
	Thu, 30 Oct 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="ZtruVonT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C325B31C
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848372; cv=none; b=nHMILdrDFruXwEYdN78Brd0WOGudrCHTzt17c6QsioArkY0EEuTzxHCJtAdSlfPZVEWekbpGfymdmta81nk2nmoJszGHBOEFgXSJv7SFncVom6OEwvwwoHplO9U2A8KZKSuq3vpTOo5KQY45ftsyCWw3IM2bKBPQX9Q6R7Jjxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848372; c=relaxed/simple;
	bh=QjjvOvLMVyrDcCMozLQdAgpporgJg+thq/LFIOG0BGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpFzWoi2PheduXyF2AHG30zjNOL/x6CXSHc1mT+UNxbWMc9yzVy9EyDlu7Vf5hj25V/sKGJS85VG/WA1mhD3L4BnDckSs14HFrBT5ngg2Coeb9IdmTU22mi3g1I6i9fBWl/+NeVfdwZaexG0xdUIKtlea7Uk0E39r+pH8KPXa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=ZtruVonT; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id EXCbvP75s32S3EXCbvuuiv; Thu, 30 Oct 2025 19:16:49 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1761848209; bh=B3Pte5oKcvpxVTfEi75pCwVkF9XNhiuwT5ClMYU9PVM=;
	h=From;
	b=ZtruVonTGn+yXCB3DsqG7anxeHr2QafUJrtjJ/odlqGOvjJrYEGo6dQAnLVL6aSYY
	 77s2iwjg3ZXUcxsESKJWR7wTNQhF+TPA0Q/V3kSTadq//836sQxJdd6oiYyWXlnsEo
	 z7A7QPYFp4AKk+qtml++FYitb5cz34qYi0D2tWqWkqyqg+d1pZDk2v0k9eoGjHoxSA
	 a/aPgbTUDtSog8ASEso03FLsunqhqRIkWf3DLif8DlyB+hWSBC06yIioNa+l6Nyi1A
	 EHBZztXvUhV9Nb0YJ0Dm1Tk+rvCSnakkcMHC9w8UqJ9/LkEn4Ve8j+l9ydEUJ7y4+Y
	 o8LuGntWNRg/A==
X-CNFS-Analysis: v=2.4 cv=Tu3mhCXh c=1 sm=1 tr=0 ts=6903ab91 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=fGO4tVQLAAAA:8 a=bAib0CrAcnEWAPO9nWgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
Message-ID: <d03213de-d2ab-44e7-85a7-02f7efc9c539@libero.it>
Date: Thu, 30 Oct 2025 19:16:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [btrfs] ENOSPC during convert to RAID6/RAID1C4 -> forced RO
To: Sandwich <sandwich@archworks.co>,
 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
References: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
 <05308285-7660-4d9c-b1d5-0b59cf4f1986@archworks.co>
 <aP7UHKYfgo_ROu_m@hungrycats.org>
 <3e97c25a-d691-48e4-80c4-99b496eee5a3@archworks.co>
 <dc306b46-443e-4229-bacc-46ec9f50f00a@archworks.co>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <dc306b46-443e-4229-bacc-46ec9f50f00a@archworks.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKZEPKAt230EJPk3+aqFYuyCz3yj/4Um5zrzeooeJ9uKTE+XIQAmzQOH54l0jf/w68+WMJBw6JSnPrRB4fOjxOSh4DcC6wkSX6mUogBigs4MbQQ/qD4v
 3gMKGgz9Bkfio4FnPdX4QGWdy+OQyXWlqeWSnwcatq4L1T74hNqPgRKQVLWjPMC76VrGOuAtsuDhjKBj/CrNnhIPksAgXpaAV9wM48LQ0yYA0S9oXSLmBqyZ
 g34J/yUZ4WMYNe4jQ1SiPJUBrUs9BTXYwnOojsNz+CI=

On 29/10/2025 23.06, Sandwich wrote:
> Hi, I will in 1-2 days migrate my storage and format this array, so this story will end for me.
> In case, someone needs to replicate this.
> 
> Make 2 disks in a single array:
> `mkfs.btrfs -L NewData -d single -m raid1 /dev/sda /dev/sdb`
> 
> Fill them up till their full:
> Add 2 extra drives `btrfs device add /dev/sdx /some/path`

During a conversion to raid6/raid1c4 with 4 disks, the filesystem needs to allocate a portion of the BG in all the disks. But if two are already filled, it fails (but this is expected).

> Fill the whole array till about 50% total usage.
> Start the conversion with `btrfs balance start -v -dconvert=raid6  -mconvert=raid1c4 -sconvert=raid1c4  /mnt/Data --force`

In fact, when I tried to reproduce (single disk size=10GB), I got the error

       ERROR: error during balancing 't/.': No space left on device

$ uname -a
Linux venice.bhome 6.16.12+deb14+1-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.16.12-2 (2025-10-16) x86_64 GNU/Linux

> 
> In the after sign, using the limiters and converting the chunks bit by bit might have helped here.
> Like this `btrfs balance start -mconvert=raid1c4,soft,limit=1 -sconvert=raid1c4,soft,limit=1 /mnt/Data`
> 
> Best
> Sandwich
> 
> On 10/27/25 2:20 PM, Sandwich wrote:
>> Thank you for your reply,
>> Unfortunately, older kernels including 6.6, 6.8, 6.12 did not help here.
>> I've used the suggested mount options `nossd,skip_balance,nodiscard,noatime`, and tried to cancel and resume the balance with it.
>> The result stayed the same as previously.
>>
>> `btrfs fi usage -T /mnt/Data`:
>> ```
>> root@anthem ~ # btrfs fi usage -T /mnt/Data
>> Overall:
>>     Device size:        118.24TiB
>>     Device allocated:         53.46TiB
>>     Device unallocated:         64.78TiB
>>     Device missing:            0.00B
>>     Device slack:            0.00B
>>     Used:             51.29TiB
>>     Free (estimated):         64.20TiB    (min: 18.26TiB)
>>     Free (statfs, df):         33.20TiB
>>     Data ratio:                 1.04
>>     Metadata ratio:             2.33
>>     Global reserve:        512.00MiB    (used: 0.00B)
>>     Multiple profiles:              yes    (data, metadata, system)
>>
>>             Data     Data    Metadata Metadata System  System
>> Id Path     single   RAID6   RAID1    RAID1C4  RAID1   RAID1C4  Unallocated Total     Slack
>> -- -------- -------- ------- -------- -------- ------- --------- ----------- --------- -----
>>  1 /dev/sdf 15.10TiB 1.09TiB 35.00GiB  8.00GiB 8.00MiB 32.00MiB  1.96TiB  18.19TiB     -
>>  2 /dev/sdg 15.10TiB 1.09TiB 44.00GiB  2.00GiB 8.00MiB  -  1.96TiB  18.19TiB     -
>>  3 /dev/sdc 13.43TiB 1.09TiB 29.00GiB        -       -  -  1.83TiB  16.37TiB     -
>>  4 /dev/sdb  3.14TiB 1.09TiB  4.00GiB 11.00GiB       - 32.00MiB 12.12TiB  16.37TiB     -
>>  5 /dev/sdd        - 1.09TiB        - 11.00GiB       - 32.00MiB 15.27TiB  16.37TiB     -
>>  6 /dev/sde        - 1.09TiB        - 11.00GiB       - 32.00MiB 15.27TiB  16.37TiB     -
>>  7 /dev/sdh        -       -        -  1.00GiB       -  - 16.37TiB  16.37TiB     -
>> -- -------- -------- ------- -------- -------- ------- --------- ----------- --------- -----
>>    Total    46.78TiB 4.35TiB 56.00GiB 11.00GiB 8.00MiB 32.00MiB 64.78TiB 118.24TiB 0.00B
>>    Used     44.72TiB 4.29TiB 50.54GiB  9.96GiB 5.22MiB 352.00KiB
>> ```
>>
>> What information is needed to trace this bug?
>> If you're willing to help me on the code side, I would gladly provide you with any information or test patches.
>>
>> In the meantime, I start to back up the most important data out of the array.
>>
>> BR
>> Sandwich
>>
>> On 10/27/25 3:08 AM, Zygo Blaxell wrote:
>>> On Sun, Oct 26, 2025 at 10:37:02PM +0100, Sandwich wrote:
>>>>   hi,
>>>>
>>>> i hit an ENOSPC corner case converting a 6-disk btrfs from data=single
>>>> to data=raid6 and metadata/system=raid1c4. after the failure, canceling
>>>> the balance forces the fs read-only. there's plenty of unallocated space
>>>> overall, but metadata reports "full" and delayed refs fail. attempts
>>>> to add another (empty) device also immediately flip the fs to RO and
>>>> the add does not proceed.
>>>>
>>>> how the filesystem grew:
>>>> i started with two disks, created btrfs (data=single), and filled
>>>> it. i added two more disks and filled it again. after adding the
>>>> final two disks i attempted the conversion to data=raid6 with
>>>> metadata/system=raid1c4—that conversion is what triggered ENOSPC
>>>> and the current RO behavior. when the convert began, usage was about
>>>> 51 TiB used out of ~118 TiB total device size.
>>>>
>>>> environment during the incident:
>>>>
>>>> ```
>>>> uname -r: 6.14.11-4-pve
>>> [...]
>>>> ```
>>>>
>>>> operation that started it:
>>>>
>>>> ```
>>>> btrfs balance start -v -dconvert=raid6 -mconvert=raid1c4 -sconvert=raid1c4 /mnt/Data --force
>>>> ```
>>>>
>>>> current state:
>>>> i can mount read-write only with `-o skip_balance`. running
>>>> `btrfs balance cancel` immediately forces RO. mixed profiles remain
>>>> (data=single+raid6, metadata=raid1+raid1c4, system=raid1+raid1c4). i
>>>> tried clearing the free-space cache, afterward the free-space tree
>>>> could not be rebuilt and subsequent operations hit backref errors
>>>> (details below). adding a new device also forces RO and fails.
>>>>
>>>> FS Info:
>>>>
>>>> ```
>>>> # btrfs fi usage -T /mnt/Data
>>>> Device size:       118.24TiB
>>>> Device allocated:   53.46TiB
>>>> Device unallocated: 64.78TiB
>>>> Used:               51.29TiB
>>>> Free (estimated):   64.20TiB (min: 18.26TiB)
>>>> Free (statfs, df):  33.20TiB
>>>> Data ratio:          1.04
>>>> Metadata ratio:      2.33
>>>> Multiple profiles:   yes (data, metadata, system)
>>>> ```
>>> You left out the most important part of the `fi usage -T` information:
>>> the table...
>>>
>>>> ```
>>>> # btrfs filesystem show /mnt/Data
>>>> Label: 'Data'  uuid: 7aa7fdb3-b3de-421c-bc86-daba55fc46f6
>>>> Total devices 6  FS bytes used 49.07TiB
>>>> devid 1 size 18.19TiB used 16.23TiB path /dev/sdf
>>>> devid 2 size 18.19TiB used 16.23TiB path /dev/sdg
>>>> devid 3 size 16.37TiB used 14.54TiB path /dev/sdc
>>>> devid 4 size 16.37TiB used  4.25TiB path /dev/sdb
>>>> devid 5 size 16.37TiB used  1.10TiB path /dev/sdd
>>>> devid 6 size 16.37TiB used  1.10TiB path /dev/sde
>>>> ```
>>> ...but from here we can guess there's between 2 and 14 TiB on each device,
>>> which should more than satisfy the requirements for raid1c4.
>>>
>>> So this is _not_ the expected problem in this scenario, where the
>>> filesystem fills up too many of the drives too soon, and legitimately
>>> can't continue balancing.
>>>
>>> It looks like an allocator bug.
>>>
>>>> full incident kernel log:
>>>> https://pastebin.com/KxP7Xa3g
>>>>
>>>> i’m looking for a safe recovery path. is there a supported way to
>>>> unwind or complete the in-flight convert first (for example, freeing
>>>> metadata space or running a limited balance), or should i avoid that
>>>> and take a different route? if proceeding is risky, given that there
>>>> are no `Data,single` chunks on `/dev/sdd` and `/dev/sde`, is it safe
>>>> to remove those two devices to free room and try again? if that’s
>>>> reasonable, what exact sequence (device remove/replace vs zeroing;
>>>> mount options) would you recommend to minimize further damage?
>>> The safe recovery path is to get a fix for the allocator bug so that you
>>> can finish the converting balance, either to raid1c4 or any other profile.
>>>
>>> This operation (balance) is something you should be able to do with
>>> current usage.  There's no other way to get out of this situation,
>>> but a kernel bug is interfering with the balance.
>>>
>>> Removing devices definitely won't help, and may trigger other issues
>>> with raid6.  Don't try that.
>>>
>>> You could try an up-to-date 6.6 or 6.12 LTS kernel, in case there's a
>>> regression in newer kernels.  Don't use a kernel older than 6.6 with
>>> raid6.
>>>
>>> Mount options 'nossd,skip_balance,nodiscard,noatime' should minimize
>>> the short-term metadata requirements, which might just be enough to
>>> cancel the balance and start a convert in the other direction.
>>>
>>>> thanks,
>>>> sandwich
>>> [...]
>>>
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

