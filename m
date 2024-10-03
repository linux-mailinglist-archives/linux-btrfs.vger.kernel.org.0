Return-Path: <linux-btrfs+bounces-8490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D598ED14
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7C31F230FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7E150981;
	Thu,  3 Oct 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMjD9L1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858B14F104
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951536; cv=none; b=P7XyEVYMkrHYK98sysmj2ylPOdfUEP7gqedwIWwjT2iIExCOJXpC4JzK4rLu/Avnia2YdGz7BZpfuZTGvMjHcI5HGMucmqeBnALwSKPlsHhAjZcO1KBj9LypxrZENSlHBTlTrE/K7fB2UHhS+A+AalOE2+D7vVJbyLeO950buRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951536; c=relaxed/simple;
	bh=fkYEj2rR4h3QuB07ziCWAPDmAJtKOqfVCvLjy8pr3e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RCB2qI0WJmqEb6LsrsXiqcyQvIVHRe3bfovHcAKeccq/43q4SY1l/09KAr1zCJvpdYusEQmzkDbF74vBxkhf0vEIvaEOjjpIGQH3kNFTTHmM/hgJJHTmI1SYMLmq8/SYr/5TQdI6UFg+Xd9/Y5OuPKg4UnNRIfQuQHZEw70LcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMjD9L1m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso715170f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727951532; x=1728556332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eC7Qy3HZ6wxLIIC7DLLV+l1xyeQk04c+Z72vIJmc04Y=;
        b=gMjD9L1mrVc0lDeML9JuCELJv7wXbIuorOEjQdAokONjKMmUqpuV9rb+229qOV4LgO
         J0Sir98DfiCOjm2evcWo0UGcCLtgHn46NdWkJu4efa9lD50DsqyP7gVuzg4jlbHT01dW
         +6xfJ0PWEBXC6hILkEtQAMmzmTanzh5QSovIsd3exx/4mYAQ7Fkt0J0TbGdGLzyrjLcB
         GWcBveTFvW3pK3ZN4NfHuxQlkkDN0x6Y2KRgCAO4HbjR1QYs2rGVYt5B400Upw20/ElS
         4icc638EFTfZCOpbyYIwelI/LA3KlpxBtSab3kHDqltHtwIArf97mGbynRMjEe3/2fPQ
         J8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727951533; x=1728556333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC7Qy3HZ6wxLIIC7DLLV+l1xyeQk04c+Z72vIJmc04Y=;
        b=MwhH8eZ40Nb9lB3FMF/5wJJXGxRIQNoEcZMEx9llH3sLIhsnEBsVQNB2LNmurHE2f8
         Wtx1yO/ldQp0Wr7+BFYA9HAKINgSDN2Jtw2QsWPPQHn5qqql479RgKoAU3GRisIepPkc
         z3GjkC+Xn7ZTXnGyeS5IzIBuOwBucwfxZXhhucqXwZYeZJD0LP0pnsYtF+xHkiiJiEov
         kIutfgI4s8lkIP7k25OPF0E3dc12UWWHFdTiPQ6h6VqfBgYblDBRcgEMwKx9QVoDTgjd
         SQO1uJixYIZbKUv1g/ukSIUyistg1d82raLi1XSuYW5sINCa+X/xFJZK2o2sfv8EJjQ+
         Htrw==
X-Forwarded-Encrypted: i=1; AJvYcCXcuHpNbQA8DyH2RPDvdbc0bIKwWemQApqt4aiL/o3563VFY8KvhXvoWPb1sSRg9lcGxw3ReVfPuezgFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ24UPIgzi6c+Hgy7yhLTGN5zQLk+8xW8CG6XhpDVfCJrKYUhx
	7mWfUkZANLhNl+k7cyeZMCEX+Dw1erHPll0PrpzwHJfubwWiqGEs
X-Google-Smtp-Source: AGHT+IHRcFWNAHFxs9fw5AlIeWsmO4z7d0BImZp/Egu0WoaBjZAfVz69o4zkLss1EgvT2PfhBvAA4g==
X-Received: by 2002:a05:6000:2a3:b0:371:8e3c:5c with SMTP id ffacd0b85a97d-37cfb8b5585mr6450031f8f.7.1727951532219;
        Thu, 03 Oct 2024 03:32:12 -0700 (PDT)
Received: from [192.168.230.172] ([194.167.18.244])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d082d22ffsm975236f8f.99.2024.10.03.03.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 03:32:11 -0700 (PDT)
Message-ID: <43b709da-339d-4ed5-af7a-59d8916366be@gmail.com>
Date: Thu, 3 Oct 2024 12:32:10 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
 <e5612dd9-1c9d-4a77-9dfe-9e06716f718d@gmail.com>
 <b0a4945d-92a0-4ea2-a82e-969670526dda@suse.com>
Content-Language: fr
From: "cwalou@gmail.com" <cwalou@gmail.com>
In-Reply-To: <b0a4945d-92a0-4ea2-a82e-969670526dda@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/10/2024 à 12:12, Qu Wenruo a écrit :
> 
> 
> 在 2024/10/3 18:50, cwalou@gmail.com 写道:
>> Le 03/10/2024 à 10:08, Qu Wenruo a écrit :
>>>
>>>
>>> 在 2024/10/3 17:02, cwalou@gmail.com 写道:
>>>> Hello.
>>>>
>>>> A 4TB drive taken out of a synology NAS. When I try to mount it, it
>>>> won't. This is what I did :
>>>
>>> Synology has out-of-tree features that upstream kernel doesn't support.
>>>
>>> Please ask the vendor for their support.
>>>
>>> Thanks,
>>> Qu
>>
>> Thank you for your answer.
>>
>> Just for my general knowledge, can you explain me what "out-of-tree 
>> features" means ?
> 
> Out-of-tree means it's not merged into the upstream Linux kernel.
> 
> Furthermore, they do not even bother to put a special 
> compat-ro/incompact flags into the super block.
> 
> So upstream kernel will not even know the fs has unsupported features, 
> until the tree-checker checks the inode flags.
> 
> Thanks,
> Qu
> 

Before I start a quest at Synology.
Is there any way to get around the "can't read superblock on 
/dev/mapper/vg1000-lv." problem?

I mean, is there an option I can pass to 'mount' to skip superblock 
check? Or is there a way to tell him a superblock is available at 
"65536" ("67108864" or "274877906944" which "btrfs rescue super-recover 
-v" tells me are good, see below) ?

My apologies if my questions seem naive. But file systems and storage 
media are not really my specialty. I'm just trying to help an 
acquaintance who has been diligently backing up his data but is now 
stuck restoring his data.

I think if we solve this problem on this public list, it may help more 
people. That's why even I need to ask synology for help, I'll give 
feedback here.

Nevertheless, thank you for the answers you already gave me, for taking 
the time to answer me.

>>
>> I'll ask synology what's happening. Once I'll find a solution (if one 
>> day I find one) I'll let know here.
>>
>> Kind regards,
>>
>> Walou.
>>
>>
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# fdisk -l /dev/sda
>>>> Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
>>>> Disk model: 001-2MA101
>>>> Units: sectors of 1 * 512 = 512 bytes
>>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>>> Disklabel type: gpt
>>>> Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2
>>>>
>>>> Device          Start        End    Sectors   Size Type
>>>> /dev/sda1        8192   16785407   16777216     8G Linux RAID
>>>> /dev/sda2    16785408   20979711    4194304     2G Linux RAID
>>>> /dev/sda5    21257952 1965122911 1943864960 926.9G Linux RAID
>>>> /dev/sda6  1965139008 7813827135 5848688128   2.7T Linux RAID
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# lsblk
>>>> NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>>>> sda               8:0    0   3.6T  0 disk
>>>> |-sda1            8:1    0     8G  0 part
>>>> |-sda2            8:2    0     2G  0 part
>>>> |-sda5            8:5    0 926.9G  0 part
>>>> | `-md2           9:2    0 926.9G  0 raid1
>>>> |   `-vg1000-lv 252:0    0   3.6T  0 lvm
>>>> `-sda6            8:6    0   2.7T  0 part
>>>>    `-md3           9:3    0   2.7T  0 raid1
>>>>      `-vg1000-lv 252:0    0   3.6T  0 lvm
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# cat /proc/mdstat
>>>> Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
>>>> md3 : active (auto-read-only) raid1 sda6[1]
>>>>        2924343040 blocks super 1.2 [2/1] [_U]
>>>>
>>>> md2 : active raid1 sda5[3]
>>>>        971931456 blocks super 1.2 [2/1] [U_]
>>>>
>>>> unused devices: <none>
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# lvm pvscan
>>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    PV /dev/md2   VG vg1000          lvm2 [926.90 GiB / 0    free]
>>>>    PV /dev/md3   VG vg1000          lvm2 [2.72 TiB / 0    free]
>>>>    Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG: 0 [0   ]
>>>>
>>>> root@user-NUC10i7FNH:~# lvm vgscan
>>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    Found volume group "vg1000" using metadata type lvm2
>>>>
>>>> root@user-NUC10i7FNH:~# lvm lvscan
>>>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>>>> the VG to update.
>>>>    ACTIVE            '/dev/vg1000/lv' [<3.63 TiB] inherit
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=all,ro 
>>>> /dev/vg1000/lv /
>>>> mnt/test/
>>>> mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
>>>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/mapper/vg1000-lv -> 
>>>> ../dm-0
>>>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/vg1000/lv -> ../dm-0
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# tail log/kern.log
>>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: device
>>>> label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 /dev/mapper/
>>>> vg1000-lv scanned by mount (2939)
>>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS info
>>>> (device dm-0): first mount of filesystem
>>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS info
>>>> (device dm-0): using crc32c (crc32c-intel) checksum algorithm
>>>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS info
>>>> (device dm-0): disk space caching is enabled
>>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critical
>>>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>>>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error
>>>> (device dm-0: state C): read time tree block corruption detected on
>>>> logical 2691220668416 mirror 1
>>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS critical
>>>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>>>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS error
>>>> (device dm-0: state C): read time tree block corruption detected on
>>>> logical 2691220668416 mirror 2
>>>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS info
>>>> (device dm-0: state C): last unmount of filesystem
>>>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
>>>> All Devices:
>>>>          Device: id = 1, name = /dev/vg1000/lv
>>>>
>>>> Before Recovering:
>>>>          [All good supers]:
>>>>                  device name = /dev/vg1000/lv
>>>>                  superblock bytenr = 65536
>>>>
>>>>                  device name = /dev/vg1000/lv
>>>>                  superblock bytenr = 67108864
>>>>
>>>>                  device name = /dev/vg1000/lv
>>>>                  superblock bytenr = 274877906944
>>>>
>>>>          [All bad supers]:
>>>>
>>>> All supers are valid, no need to recover
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
>>>> Clearing log on /dev/vg1000/lv, previous log_root 0, level 0
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/vg1000/lv
>>>> UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>> ignoring invalid key
>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>> [...line repeated many times
>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>> ignoring invalid key
>>>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>>>> ignoring invalid key
>>>> [3/7] checking free space cache
>>>> [4/7] checking fs roots
>>>> [5/7] checking only csums items (without verifying data)
>>>> [6/7] checking root refs
>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>> found 2726275964928 bytes used, no error found
>>>> total csum bytes: 839025944
>>>> total tree bytes: 3015049216
>>>> total fs tree bytes: 1991966720
>>>> total extent tree bytes: 95895552
>>>> btree space waste bytes: 555710555
>>>> file data blocks allocated: 3567579688960
>>>>   referenced 2977409900544
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
>>>> label=2017.12.01-16:57:32 v15217
>>>>
>>>>
>>>> root@user-NUC10i7FNH:~# btrfs version
>>>> btrfs-progs v5.16.2
>>>>
>>>>
>>>> The most surprising is that on a Windows 10, "DiskInternals Linux
>>>> Reader" (a paid software) shows me the content of this disk (and 
>>>> asks me
>>>> to pay for copying the data).
>>>>
>>>>
>>>> Any idea ?
>>>>
>>>>
>>>>
>>>
>>
>>
> 


