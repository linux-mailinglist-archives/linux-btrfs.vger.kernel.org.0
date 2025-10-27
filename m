Return-Path: <linux-btrfs+bounces-18368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A21C0DF9E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89AA189180B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1129B20D;
	Mon, 27 Oct 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=archworks.co header.i=@archworks.co header.b="GlmCiUX7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from relay.archworks.co (relay.archworks.co [65.21.53.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9E283FF4
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.53.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571233; cv=none; b=iAELGs1YPvMZCgNFUmhQ3b08j2IlnipIMFzDQ+/YGSo+ELMEKySZb1J2R7dXdai5s/KXC9rKwH5HRPClPtvJNg/ovSETcIVX65dXHKHdrG8VfW37mTPYpB80sJKFUWvgkDaz5yhaMEKLV7rJGlNqxvLMZMcULLjsyQJGKati3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571233; c=relaxed/simple;
	bh=PmLjqByT3UKotfbBGM2/Y1SIKB8FOxpDJw8tJHdkYzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW4XeppRIpQltbkjPHc+RTh1KrzG4d3DfvWlhu8xt0eyQ31au42zBcKzTmis1GmzClK//hwrXGaXix9BepeB78i6Wb6L7sRBmF3p8HYHhKaApfOyuHoPz1xXyzp9X9u3c+jWPdZgJq4ERz1Pgk7SbSrdkqSgV7XoHA3m5aY+B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=archworks.co; spf=pass smtp.mailfrom=archworks.co; dkim=pass (1024-bit key) header.d=archworks.co header.i=@archworks.co header.b=GlmCiUX7; arc=none smtp.client-ip=65.21.53.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=archworks.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archworks.co
Received: from [192.168.1.102] (mob-194-230-148-21.cgn.sunrise.net [194.230.148.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: norbert.morawski@archworks.co)
	by relay.archworks.co (Postfix) with ESMTPSA id 1A4793A94B0;
	Mon, 27 Oct 2025 14:20:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=archworks.co; s=k2;
	t=1761571229; bh=PmLjqByT3UKotfbBGM2/Y1SIKB8FOxpDJw8tJHdkYzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GlmCiUX7HVStSGyp/SiHkOScYiM7Pf3ynkLSfrVIbdfz0GaKUF7vLr7H18eRxswXn
	 WSzrYXlVuI/hZ3mvITY4Bqkw423k7fFYglEQ+XzExB8Z3HQWCYgP+X34TkJhxV8Krw
	 mVtmbQ/Djp1O2NduyZoH0FwjJ9xyfLxx8tmBAm2A=
Message-ID: <3e97c25a-d691-48e4-80c4-99b496eee5a3@archworks.co>
Date: Mon, 27 Oct 2025 14:20:27 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] ENOSPC during convert to RAID6/RAID1C4 -> forced RO
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: linux-btrfs@vger.kernel.org
References: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
 <05308285-7660-4d9c-b1d5-0b59cf4f1986@archworks.co>
 <aP7UHKYfgo_ROu_m@hungrycats.org>
From: Sandwich <sandwich@archworks.co>
Content-Language: de-AT, en-US
In-Reply-To: <aP7UHKYfgo_ROu_m@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your reply,
Unfortunately, older kernels including 6.6, 6.8, 6.12 did not help here.
I've used the suggested mount options `nossd,skip_balance,nodiscard,noatime`, and tried to cancel and resume the balance with it.
The result stayed the same as previously.

`btrfs fi usage -T /mnt/Data`:
```
root@anthem ~ # btrfs fi usage -T /mnt/Data
Overall:
     Device size:        118.24TiB
     Device allocated:         53.46TiB
     Device unallocated:         64.78TiB
     Device missing:            0.00B
     Device slack:            0.00B
     Used:             51.29TiB
     Free (estimated):         64.20TiB    (min: 18.26TiB)
     Free (statfs, df):         33.20TiB
     Data ratio:                 1.04
     Metadata ratio:             2.33
     Global reserve:        512.00MiB    (used: 0.00B)
     Multiple profiles:              yes    (data, metadata, system)

             Data     Data    Metadata Metadata System  System
Id Path     single   RAID6   RAID1    RAID1C4  RAID1   RAID1C4  Unallocated Total     Slack
-- -------- -------- ------- -------- -------- ------- --------- ----------- --------- -----
  1 /dev/sdf 15.10TiB 1.09TiB 35.00GiB  8.00GiB 8.00MiB 32.00MiB     1.96TiB  18.19TiB     -
  2 /dev/sdg 15.10TiB 1.09TiB 44.00GiB  2.00GiB 8.00MiB  -     1.96TiB  18.19TiB     -
  3 /dev/sdc 13.43TiB 1.09TiB 29.00GiB        -       -  -     1.83TiB  16.37TiB     -
  4 /dev/sdb  3.14TiB 1.09TiB  4.00GiB 11.00GiB       - 32.00MiB    12.12TiB  16.37TiB     -
  5 /dev/sdd        - 1.09TiB        - 11.00GiB       - 32.00MiB    15.27TiB  16.37TiB     -
  6 /dev/sde        - 1.09TiB        - 11.00GiB       - 32.00MiB    15.27TiB  16.37TiB     -
  7 /dev/sdh        -       -        -  1.00GiB       -  -    16.37TiB  16.37TiB     -
-- -------- -------- ------- -------- -------- ------- --------- ----------- --------- -----
    Total    46.78TiB 4.35TiB 56.00GiB 11.00GiB 8.00MiB 32.00MiB    64.78TiB 118.24TiB 0.00B
    Used     44.72TiB 4.29TiB 50.54GiB  9.96GiB 5.22MiB 352.00KiB
```

What information is needed to trace this bug?
If you're willing to help me on the code side, I would gladly provide you with any information or test patches.

In the meantime, I start to back up the most important data out of the array.

BR
Sandwich

On 10/27/25 3:08 AM, Zygo Blaxell wrote:
> On Sun, Oct 26, 2025 at 10:37:02PM +0100, Sandwich wrote:
>>   hi,
>>
>> i hit an ENOSPC corner case converting a 6-disk btrfs from data=single
>> to data=raid6 and metadata/system=raid1c4. after the failure, canceling
>> the balance forces the fs read-only. there's plenty of unallocated space
>> overall, but metadata reports "full" and delayed refs fail. attempts
>> to add another (empty) device also immediately flip the fs to RO and
>> the add does not proceed.
>>
>> how the filesystem grew:
>> i started with two disks, created btrfs (data=single), and filled
>> it. i added two more disks and filled it again. after adding the
>> final two disks i attempted the conversion to data=raid6 with
>> metadata/system=raid1c4—that conversion is what triggered ENOSPC
>> and the current RO behavior. when the convert began, usage was about
>> 51 TiB used out of ~118 TiB total device size.
>>
>> environment during the incident:
>>
>> ```
>> uname -r: 6.14.11-4-pve
> [...]
>> ```
>>
>> operation that started it:
>>
>> ```
>> btrfs balance start -v -dconvert=raid6 -mconvert=raid1c4 -sconvert=raid1c4 /mnt/Data --force
>> ```
>>
>> current state:
>> i can mount read-write only with `-o skip_balance`. running
>> `btrfs balance cancel` immediately forces RO. mixed profiles remain
>> (data=single+raid6, metadata=raid1+raid1c4, system=raid1+raid1c4). i
>> tried clearing the free-space cache, afterward the free-space tree
>> could not be rebuilt and subsequent operations hit backref errors
>> (details below). adding a new device also forces RO and fails.
>>
>> FS Info:
>>
>> ```
>> # btrfs fi usage -T /mnt/Data
>> Device size:       118.24TiB
>> Device allocated:   53.46TiB
>> Device unallocated: 64.78TiB
>> Used:               51.29TiB
>> Free (estimated):   64.20TiB (min: 18.26TiB)
>> Free (statfs, df):  33.20TiB
>> Data ratio:          1.04
>> Metadata ratio:      2.33
>> Multiple profiles:   yes (data, metadata, system)
>> ```
> You left out the most important part of the `fi usage -T` information:
> the table...
>
>> ```
>> # btrfs filesystem show /mnt/Data
>> Label: 'Data'  uuid: 7aa7fdb3-b3de-421c-bc86-daba55fc46f6
>> Total devices 6  FS bytes used 49.07TiB
>> devid 1 size 18.19TiB used 16.23TiB path /dev/sdf
>> devid 2 size 18.19TiB used 16.23TiB path /dev/sdg
>> devid 3 size 16.37TiB used 14.54TiB path /dev/sdc
>> devid 4 size 16.37TiB used  4.25TiB path /dev/sdb
>> devid 5 size 16.37TiB used  1.10TiB path /dev/sdd
>> devid 6 size 16.37TiB used  1.10TiB path /dev/sde
>> ```
> ...but from here we can guess there's between 2 and 14 TiB on each device,
> which should more than satisfy the requirements for raid1c4.
>
> So this is _not_ the expected problem in this scenario, where the
> filesystem fills up too many of the drives too soon, and legitimately
> can't continue balancing.
>
> It looks like an allocator bug.
>
>> full incident kernel log:
>> https://pastebin.com/KxP7Xa3g
>>
>> i’m looking for a safe recovery path. is there a supported way to
>> unwind or complete the in-flight convert first (for example, freeing
>> metadata space or running a limited balance), or should i avoid that
>> and take a different route? if proceeding is risky, given that there
>> are no `Data,single` chunks on `/dev/sdd` and `/dev/sde`, is it safe
>> to remove those two devices to free room and try again? if that’s
>> reasonable, what exact sequence (device remove/replace vs zeroing;
>> mount options) would you recommend to minimize further damage?
> The safe recovery path is to get a fix for the allocator bug so that you
> can finish the converting balance, either to raid1c4 or any other profile.
>
> This operation (balance) is something you should be able to do with
> current usage.  There's no other way to get out of this situation,
> but a kernel bug is interfering with the balance.
>
> Removing devices definitely won't help, and may trigger other issues
> with raid6.  Don't try that.
>
> You could try an up-to-date 6.6 or 6.12 LTS kernel, in case there's a
> regression in newer kernels.  Don't use a kernel older than 6.6 with
> raid6.
>
> Mount options 'nossd,skip_balance,nodiscard,noatime' should minimize
> the short-term metadata requirements, which might just be enough to
> cancel the balance and start a convert in the other direction.
>
>> thanks,
>> sandwich
> [...]
>

