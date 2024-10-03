Return-Path: <linux-btrfs+bounces-8489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045498ECB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027681F22A05
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3B149E17;
	Thu,  3 Oct 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XE6XkL8M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C01149C69
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950360; cv=none; b=te2X+4YpeW82lC2n3l0oR9nwNQsaUmGLuZd07ynhHuqTcNzQtSW9RQQ0XPUJSWUs6fqDDu2CLWUTuCwxNF39zBjZo3SFlFi0Wnu7e5Xby3ILKmS40OLY3d+FA6fNvZdzHRlfGgceKe+Lb3HScjCSZGiFwKZVzPjSYxx10XRHSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950360; c=relaxed/simple;
	bh=cZds9bl/ReDPMQtzfo/8qPmXy0i9i1BK4xZLU8MINLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=reKkRs+ZbTT6jJGQEuO43tsUG668aJcMBcv5z9LKN0VHitNjJlRruoPPzm+ZFD0+e88OaDGd/PdSXbIhSsKKQte/apfn16ZsTSpAPw5WL/6beWJYkAigOzYHmHbDOPojxAik3+6T8r3BwWDYxw3xb6zDEtXBD6zU7nIHxzRWL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XE6XkL8M; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac9eaeafcso10039061fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727950356; x=1728555156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ltPELtKAuD4fz2WV0O6ymMfariLuR5bb1hGiaHXwg0=;
        b=XE6XkL8M676rlnfO9g+52sKaBJikFhE4g5818vXHFEaNBEm3xL/Ls5U4/UdLv2hLQE
         QdtZRsN+Sh9BCZTllCEZBc+kHBrwOWztCRCamAL4J/2J1IHlJICSiUuGx8lE1p7qJAMT
         JcFKDMTk4CC69Y/LJx1CNCFjfGzADEwewV5XwLsqln0m+1wfxOaQDYxkMdeKBSSNjPZx
         oo9ePyViAx0h24L9zdj0nGnt5aj7tEyK0jyDJBfygXCkX+HgN7e4gCIfEx80WuVO91zi
         +l+MyvyD/rboslw0G3JyZbuaT1kqLCyBkvLLUjVjA62Yqxn+dwJU36QDo0s0jrJMGwPs
         Hpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727950356; x=1728555156;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ltPELtKAuD4fz2WV0O6ymMfariLuR5bb1hGiaHXwg0=;
        b=AUVI8R7HpHBRtCcF26lFmdLyLl+z6y0OcxgHp3gwupvXpVfeMqpzYjMdNIClc52YGg
         /FfWZbawCi2dR++9kL5OBxBOqZ8rX3uJ6WZm71p5go6TR6UakSQbINqylUh4oMuZOqtK
         ZgnImLahX9SOJfZ5UxZqP+aJKT9vqqOPu03l0XAnAVK60jEGEPnwIeuUkYfA786t5wv2
         Sho2Mgv2Xp469mF1IKxzLteikuvgmMY7H7kmOTKl0s5Ln9Fbnde2sMB4nXXpFDUHtLew
         uYTclRMgAySU/HVZfSXKdvXQKXipZiYsSii+ossPlbE336igMuhkrbBKQGVf71ubEm08
         CShg==
X-Forwarded-Encrypted: i=1; AJvYcCW/d0qD4Rrl8Vq+1gToqWBPJLjUjY2KaKUwP3qUFkh4rmB81uMHS5oqpsSUFT94bfy83ZxuzBZyD8McOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BFzYasSuLwg98BQjOBSi+TORyeLqAmkrP+a+3Zrcl4Qi/45d
	qNqI9AqAODOqM4Pc9FTlwfd/yJWSC0myAnG2xUGgihqLd6NUUf2/XwfmnfHPBG4=
X-Google-Smtp-Source: AGHT+IEJW9ZtrTL7YL/HKnfMQPGTwK7gN4PtqSh20P7go4A4YSGAGF/Zzy/akAss7umuGWZqydDsvw==
X-Received: by 2002:a2e:4a11:0:b0:2fa:bdd8:4c92 with SMTP id 38308e7fff4ca-2fae109988cmr29568991fa.42.1727950355946;
        Thu, 03 Oct 2024 03:12:35 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bff5353esm1159602a91.56.2024.10.03.03.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 03:12:35 -0700 (PDT)
Message-ID: <b0a4945d-92a0-4ea2-a82e-969670526dda@suse.com>
Date: Thu, 3 Oct 2024 19:42:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: "cwalou@gmail.com" <cwalou@gmail.com>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
 <e5612dd9-1c9d-4a77-9dfe-9e06716f718d@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <e5612dd9-1c9d-4a77-9dfe-9e06716f718d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/3 18:50, cwalou@gmail.com 写道:
> Le 03/10/2024 à 10:08, Qu Wenruo a écrit :
>>
>>
>> 在 2024/10/3 17:02, cwalou@gmail.com 写道:
>>> Hello.
>>>
>>> A 4TB drive taken out of a synology NAS. When I try to mount it, it
>>> won't. This is what I did :
>>
>> Synology has out-of-tree features that upstream kernel doesn't support.
>>
>> Please ask the vendor for their support.
>>
>> Thanks,
>> Qu
> 
> Thank you for your answer.
> 
> Just for my general knowledge, can you explain me what "out-of-tree 
> features" means ?

Out-of-tree means it's not merged into the upstream Linux kernel.

Furthermore, they do not even bother to put a special 
compat-ro/incompact flags into the super block.

So upstream kernel will not even know the fs has unsupported features, 
until the tree-checker checks the inode flags.

Thanks,
Qu

> 
> I'll ask synology what's happening. Once I'll find a solution (if one 
> day I find one) I'll let know here.
> 
> Kind regards,
> 
> Walou.
> 
> 
>>>
>>>
>>> root@user-NUC10i7FNH:~# fdisk -l /dev/sda
>>> Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
>>> Disk model: 001-2MA101
>>> Units: sectors of 1 * 512 = 512 bytes
>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>> Disklabel type: gpt
>>> Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2
>>>
>>> Device          Start        End    Sectors   Size Type
>>> /dev/sda1        8192   16785407   16777216     8G Linux RAID
>>> /dev/sda2    16785408   20979711    4194304     2G Linux RAID
>>> /dev/sda5    21257952 1965122911 1943864960 926.9G Linux RAID
>>> /dev/sda6  1965139008 7813827135 5848688128   2.7T Linux RAID
>>>
>>>
>>> root@user-NUC10i7FNH:~# lsblk
>>> NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>>> sda               8:0    0   3.6T  0 disk
>>> |-sda1            8:1    0     8G  0 part
>>> |-sda2            8:2    0     2G  0 part
>>> |-sda5            8:5    0 926.9G  0 part
>>> | `-md2           9:2    0 926.9G  0 raid1
>>> |   `-vg1000-lv 252:0    0   3.6T  0 lvm
>>> `-sda6            8:6    0   2.7T  0 part
>>>    `-md3           9:3    0   2.7T  0 raid1
>>>      `-vg1000-lv 252:0    0   3.6T  0 lvm
>>>
>>>
>>> root@user-NUC10i7FNH:~# cat /proc/mdstat
>>> Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
>>> md3 : active (auto-read-only) raid1 sda6[1]
>>>        2924343040 blocks super 1.2 [2/1] [_U]
>>>
>>> md2 : active raid1 sda5[3]
>>>        971931456 blocks super 1.2 [2/1] [U_]
>>>
>>> unused devices: <none>
>>>
>>>
>>> root@user-NUC10i7FNH:~# lvm pvscan
>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    PV /dev/md2   VG vg1000          lvm2 [926.90 GiB / 0    free]
>>>    PV /dev/md3   VG vg1000          lvm2 [2.72 TiB / 0    free]
>>>    Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG: 0 [0   ]
>>>
>>> root@user-NUC10i7FNH:~# lvm vgscan
>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    Found volume group "vg1000" using metadata type lvm2
>>>
>>> root@user-NUC10i7FNH:~# lvm lvscan
>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>> the VG to update.
>>>    ACTIVE            '/dev/vg1000/lv' [<3.63 TiB] inherit
>>>
>>>
>>> root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=all,ro /dev/vg1000/lv /
>>> mnt/test/
>>> mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.
>>>
>>>
>>> root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
>>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/mapper/vg1000-lv -> ../dm-0
>>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/vg1000/lv -> ../dm-0
>>>
>>>
>>> root@user-NUC10i7FNH:~# tail log/kern.log
>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: device
>>> label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 /dev/mapper/
>>> vg1000-lv scanned by mount (2939)
>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS info
>>> (device dm-0): first mount of filesystem
>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS info
>>> (device dm-0): using crc32c (crc32c-intel) checksum algorithm
>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS info
>>> (device dm-0): disk space caching is enabled
>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critical
>>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error
>>> (device dm-0: state C): read time tree block corruption detected on
>>> logical 2691220668416 mirror 1
>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS critical
>>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS error
>>> (device dm-0: state C): read time tree block corruption detected on
>>> logical 2691220668416 mirror 2
>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS info
>>> (device dm-0: state C): last unmount of filesystem
>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>
>>>
>>> root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
>>> All Devices:
>>>          Device: id = 1, name = /dev/vg1000/lv
>>>
>>> Before Recovering:
>>>          [All good supers]:
>>>                  device name = /dev/vg1000/lv
>>>                  superblock bytenr = 65536
>>>
>>>                  device name = /dev/vg1000/lv
>>>                  superblock bytenr = 67108864
>>>
>>>                  device name = /dev/vg1000/lv
>>>                  superblock bytenr = 274877906944
>>>
>>>          [All bad supers]:
>>>
>>> All supers are valid, no need to recover
>>>
>>>
>>> root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
>>> Clearing log on /dev/vg1000/lv, previous log_root 0, level 0
>>>
>>>
>>> root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/vg1000/lv
>>> UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>> ignoring invalid key
>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>> [...line repeated many times
>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>> ignoring invalid key
>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>> ignoring invalid key
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 2726275964928 bytes used, no error found
>>> total csum bytes: 839025944
>>> total tree bytes: 3015049216
>>> total fs tree bytes: 1991966720
>>> total extent tree bytes: 95895552
>>> btree space waste bytes: 555710555
>>> file data blocks allocated: 3567579688960
>>>   referenced 2977409900544
>>>
>>>
>>> root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
>>> label=2017.12.01-16:57:32 v15217
>>>
>>>
>>> root@user-NUC10i7FNH:~# btrfs version
>>> btrfs-progs v5.16.2
>>>
>>>
>>> The most surprising is that on a Windows 10, "DiskInternals Linux
>>> Reader" (a paid software) shows me the content of this disk (and asks me
>>> to pay for copying the data).
>>>
>>>
>>> Any idea ?
>>>
>>>
>>>
>>
> 
> 


