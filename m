Return-Path: <linux-btrfs+bounces-8487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8251098EC35
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67EA1C225CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F914658C;
	Thu,  3 Oct 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIXwdoQA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B113CFB8
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947264; cv=none; b=OY8pWBzlDFGNsFoqvdtgoQmKeHwmVSD5wllrv3ru8tmoRJdQyLO5iUCGpMD42urGyh0hG+ROUVOQtN70rnL24EksnJ9rImGJnTyiV7RFNEfnlbW/K5OAdpUlSLLRbxJ7Z6a+Yk1PbDoHUbR3hZUIBt/+ewHB3rqhG08oPkw+nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947264; c=relaxed/simple;
	bh=bn6Y57EoZ4WbTmMaoKRO3VEQmDYen8qrLkLwqQLEdEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XTCECK4ZYeYIIi5e5nYPpal+dgX23lzuAYtDWq5viH6wvOid+N1LUYmmRPlV1Qvm0cMjplLE4CKESS8ZKm0Qtq3A76FgcdpXgB3mut4v2nNgBnzUvbREdvX3RLHolPGobX97a+koXUkp9/a8ww0XuM1qG7d3qfpBIs81xufFkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIXwdoQA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso5750325e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727947261; x=1728552061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcoFXNLWCqxPQnGRFGhp1tsVwGhJa5667Mjp+Fk5ZvM=;
        b=hIXwdoQAboUucn9msT3ux5lr/WPsR8KsnKJBzdgtehz7gKJa6Tv3aLk4/XHpzcfWIE
         orbf0NSdofjcC9Vb5xLcau3H2T6fRaWyRJ5Jj/LZ00Q4WIszIHUbrKkWCvvkGC+KDi/T
         /2g9NaUDkFj8EU8RzHQ2rnHz2Q9bAtpW6cRIcGgOZC/wT8/SPbbaoSA+Atz1XES6k30k
         WAW6UxXElWggOCtOGCJbU76PRSOc6+4UHXwfKi5dlrnIL5FKcA8PTPeXhD8GkTf54W0T
         zd8ON7k+BmYPzLPdqBJURF1DbEMl521RLHV7SakhauLxlpZTpyKNR27/IFQ1IoBQQVbP
         dgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727947261; x=1728552061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcoFXNLWCqxPQnGRFGhp1tsVwGhJa5667Mjp+Fk5ZvM=;
        b=nN7kBeM7f/avcOWhmV1zfan8YIlaLCjB5lviO+Jf2Yp6UqkVdxqOFIJjAOnjklghpt
         +eKYKvPFddv2EiY01eeA/Sk9B9Un4lZ0CojStcxHvD05qwWB+1OagZhik1UYD/uMYCZn
         n6eBDrUX4Hs6JJUi7lCEd39VKDLiUDJ+Gs7LYyFVPWFHA0ABtl/k7id//bubB6BJclxG
         PQOqjkzCdTyYRw3mKNYXpbxYaQ78xWBZGARiGT7x1oeGZNzp4bn/L6FNCuGnYIzfukhu
         /T7eAlFuiTdZd6Kf2UncuNbleahG1szfFKuN3IUt9I7aMe9Mp8dRwiRb7GKYIYvndwrB
         Iw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB/NqUkuVzMKD3eRkrFE2VxrrFhLDyeD0fcIVzXyD5Cz2o1+fIvdDmQZx+je/4E9HgQZnhPrzrZqlhsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyouxINUuVIMYAXX8TnPtwsh69A0+ozgxPViSqhaJjUNLm9JkY
	wd5tl0jX8aS+BGwM7q4MydA6G27SzlAOGh+wk3Lh/8bhexlDFxEX
X-Google-Smtp-Source: AGHT+IHxa4+RHjptPrn/ETZvF8fG9fhQPAN9IyLaqPAmV91TvpUZXDOio26/XCmX2tnA7okEdht1kA==
X-Received: by 2002:a05:600c:350b:b0:42c:bcc8:5877 with SMTP id 5b1f17b1804b1-42f777b8a2bmr40490235e9.13.1727947260721;
        Thu, 03 Oct 2024 02:21:00 -0700 (PDT)
Received: from [192.168.230.172] ([194.167.18.244])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d081f7103sm843250f8f.1.2024.10.03.02.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:21:00 -0700 (PDT)
Message-ID: <e5612dd9-1c9d-4a77-9dfe-9e06716f718d@gmail.com>
Date: Thu, 3 Oct 2024 11:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
Content-Language: fr
From: "cwalou@gmail.com" <cwalou@gmail.com>
In-Reply-To: <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/10/2024 à 10:08, Qu Wenruo a écrit :
> 
> 
> 在 2024/10/3 17:02, cwalou@gmail.com 写道:
>> Hello.
>>
>> A 4TB drive taken out of a synology NAS. When I try to mount it, it
>> won't. This is what I did :
> 
> Synology has out-of-tree features that upstream kernel doesn't support.
> 
> Please ask the vendor for their support.
> 
> Thanks,
> Qu

Thank you for your answer.

Just for my general knowledge, can you explain me what "out-of-tree 
features" means ?

I'll ask synology what's happening. Once I'll find a solution (if one 
day I find one) I'll let know here.

Kind regards,

Walou.


>>
>>
>> root@user-NUC10i7FNH:~# fdisk -l /dev/sda
>> Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
>> Disk model: 001-2MA101
>> Units: sectors of 1 * 512 = 512 bytes
>> Sector size (logical/physical): 512 bytes / 512 bytes
>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>> Disklabel type: gpt
>> Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2
>>
>> Device          Start        End    Sectors   Size Type
>> /dev/sda1        8192   16785407   16777216     8G Linux RAID
>> /dev/sda2    16785408   20979711    4194304     2G Linux RAID
>> /dev/sda5    21257952 1965122911 1943864960 926.9G Linux RAID
>> /dev/sda6  1965139008 7813827135 5848688128   2.7T Linux RAID
>>
>>
>> root@user-NUC10i7FNH:~# lsblk
>> NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>> sda               8:0    0   3.6T  0 disk
>> |-sda1            8:1    0     8G  0 part
>> |-sda2            8:2    0     2G  0 part
>> |-sda5            8:5    0 926.9G  0 part
>> | `-md2           9:2    0 926.9G  0 raid1
>> |   `-vg1000-lv 252:0    0   3.6T  0 lvm
>> `-sda6            8:6    0   2.7T  0 part
>>    `-md3           9:3    0   2.7T  0 raid1
>>      `-vg1000-lv 252:0    0   3.6T  0 lvm
>>
>>
>> root@user-NUC10i7FNH:~# cat /proc/mdstat
>> Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
>> md3 : active (auto-read-only) raid1 sda6[1]
>>        2924343040 blocks super 1.2 [2/1] [_U]
>>
>> md2 : active raid1 sda5[3]
>>        971931456 blocks super 1.2 [2/1] [U_]
>>
>> unused devices: <none>
>>
>>
>> root@user-NUC10i7FNH:~# lvm pvscan
>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    PV /dev/md2   VG vg1000          lvm2 [926.90 GiB / 0    free]
>>    PV /dev/md3   VG vg1000          lvm2 [2.72 TiB / 0    free]
>>    Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG: 0 [0   ]
>>
>> root@user-NUC10i7FNH:~# lvm vgscan
>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    Found volume group "vg1000" using metadata type lvm2
>>
>> root@user-NUC10i7FNH:~# lvm lvscan
>>    WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify
>> the VG to update.
>>    ACTIVE            '/dev/vg1000/lv' [<3.63 TiB] inherit
>>
>>
>> root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=all,ro /dev/vg1000/lv /
>> mnt/test/
>> mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.
>>
>>
>> root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/mapper/vg1000-lv -> ../dm-0
>> lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/vg1000/lv -> ../dm-0
>>
>>
>> root@user-NUC10i7FNH:~# tail log/kern.log
>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: device
>> label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 /dev/mapper/
>> vg1000-lv scanned by mount (2939)
>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS info
>> (device dm-0): first mount of filesystem
>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS info
>> (device dm-0): using crc32c (crc32c-intel) checksum algorithm
>> Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS info
>> (device dm-0): disk space caching is enabled
>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critical
>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error
>> (device dm-0: state C): read time tree block corruption detected on
>> logical 2691220668416 mirror 1
>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS critical
>> (device dm-0: state C): corrupt leaf: root=257 block=2691220668416
>> slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS error
>> (device dm-0: state C): read time tree block corruption detected on
>> logical 2691220668416 mirror 2
>> Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS info
>> (device dm-0: state C): last unmount of filesystem
>> 320f5288-777d-43eb-84e3-4ac70573ec6b
>>
>>
>> root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
>> All Devices:
>>          Device: id = 1, name = /dev/vg1000/lv
>>
>> Before Recovering:
>>          [All good supers]:
>>                  device name = /dev/vg1000/lv
>>                  superblock bytenr = 65536
>>
>>                  device name = /dev/vg1000/lv
>>                  superblock bytenr = 67108864
>>
>>                  device name = /dev/vg1000/lv
>>                  superblock bytenr = 274877906944
>>
>>          [All bad supers]:
>>
>> All supers are valid, no need to recover
>>
>>
>> root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
>> Clearing log on /dev/vg1000/lv, previous log_root 0, level 0
>>
>>
>> root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
>> Opening filesystem to check...
>> Checking filesystem on /dev/vg1000/lv
>> UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
>> [1/7] checking root items
>> [2/7] checking extents
>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>> ignoring invalid key
>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>> [...line repeated many times
>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>> ignoring invalid key
>> Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
>> ignoring invalid key
>> [3/7] checking free space cache
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 2726275964928 bytes used, no error found
>> total csum bytes: 839025944
>> total tree bytes: 3015049216
>> total fs tree bytes: 1991966720
>> total extent tree bytes: 95895552
>> btree space waste bytes: 555710555
>> file data blocks allocated: 3567579688960
>>   referenced 2977409900544
>>
>>
>> root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
>> label=2017.12.01-16:57:32 v15217
>>
>>
>> root@user-NUC10i7FNH:~# btrfs version
>> btrfs-progs v5.16.2
>>
>>
>> The most surprising is that on a Windows 10, "DiskInternals Linux
>> Reader" (a paid software) shows me the content of this disk (and asks me
>> to pay for copying the data).
>>
>>
>> Any idea ?
>>
>>
>>
> 


