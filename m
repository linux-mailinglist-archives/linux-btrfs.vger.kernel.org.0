Return-Path: <linux-btrfs+bounces-8481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D698EA61
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9C51F24AAC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796584E11;
	Thu,  3 Oct 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfFwvxLY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CA3FBA7
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940780; cv=none; b=al55IGtcT93PWgJz9qaL33HDBnf59pvD3lfVYsXAWU6P7jhbV8SBMh+GQKhjevTo2qAngl8RZpUxmwBgnb6kOwZJzJ/9Hb7AnBBC/FSgCBXrlDvRIUKCremLFRw+nEldJKFNjimaxHslHnfaQhwEZV6Fxrya2gv3LUWK+iH7cVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940780; c=relaxed/simple;
	bh=KRzWyG0Sxr3P3XAAmbZCa8uRa1Agea/fjX89azMFEHo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Gss6vx0svrZFsWZjHwvWXvijGSzmCoPKXHh1FyhkqI4bgh6dlI5RCT8r1w+3kYYrOeRKQYkHg1MZjgjQTABQDrOksb6ffxGAKbaxazM2BEiwsY/Xbl+pZz6Jd3ESUok+9PkqRJTdA60tt9xdf71DR/UPpsinAl2Y47KXyG5wy3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfFwvxLY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so8202525e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727940777; x=1728545577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGykMD4uYgys87335uWh3jNps4yRRy8h6pK0JKTGcjU=;
        b=RfFwvxLYmcqPUOJ3QP18u8vW4tBmv5R5ZZn9dtuXqvDn2IQXAwcem3uPbOlmfxRdNF
         ChQ5TUxjzR3hjKtTcaCCp9lcYFoIMBB8LoRmMYrOB+n1Tlq82v3v+mP2NBi8CesAgx9C
         7ZrBBh9NDbFLK5moRm4ugE1kiD4aANDImMm3mJIZ9Uh3V4sR4OtZXiHElhUl/eGT/hXD
         68epN4CAuPGGipzPMm7yGe/XSqrABMXh2abcGPm/TXngL9IY0wC3OTUgEGVmv8fCNabv
         rfImoYIJXAmDO7kW9ife7jg5KHXEm8cw6HdK6HJpuqFip2UJdJWs8SdVWWSmtcFFSoTX
         t6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940777; x=1728545577;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGykMD4uYgys87335uWh3jNps4yRRy8h6pK0JKTGcjU=;
        b=XIf+DHub4xubMIpvDfZ+BFyoNmRxAij5ikKjfnwpRUiJSvCiiXG5mIwjiopBMeegv/
         BYRUjfDsD/AOok+k4xpXeKM+OlaD4gmFGlUuMfQvx2F9cRPi7rglDwjejl5lVLFmfjov
         X1p7zszWDWo3EexA38tFd7RZuUns29jCr7dsuaFUSj6aUYfBWP1aTtU9KPoK6Q9jSYTS
         An3emPQhB9rE0x2mRSS4M4hWW3+wlaXrgHwlClZxq7qXzc0/Ef7QouvO9GPqI14UxlYb
         PuGzGgKGjr2GVGcZPvC0YA1m9GI28wUL9AOZZPeBvdiFQnyxAdonjBTVSMXaDlijB44Q
         b4sA==
X-Gm-Message-State: AOJu0Ywq8yZ2LYTJxDcZglMD5g4qKDTL0dQ5rv3LMVDK2YL+aO26bMuf
	Zf5DV6vz3W843LLoWWP3OxqhwjLFBgs2R67558lG4+iFxYUxJrGDFQfdLg==
X-Google-Smtp-Source: AGHT+IHUA9TH/e/1jRhg8n+bKw89TueLl3W+9BDhy+uoGDnKggX3mF/OAwU6ridUico+ngJTIL8LCA==
X-Received: by 2002:a5d:5d81:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-37cfbf8110amr4010998f8f.59.1727940776579;
        Thu, 03 Oct 2024 00:32:56 -0700 (PDT)
Received: from [192.168.230.172] ([194.167.18.244])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d082425f5sm628624f8f.50.2024.10.03.00.32.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:32:56 -0700 (PDT)
Message-ID: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
Date: Thu, 3 Oct 2024 09:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "cwalou@gmail.com" <cwalou@gmail.com>
Subject: mount: can't read superblock on - corrupt leaf - read time tree block
 corruption detected
To: linux-btrfs@vger.kernel.org
Content-Language: fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

A 4TB drive taken out of a synology NAS. When I try to mount it, it 
won't. This is what I did :


root@user-NUC10i7FNH:~# fdisk -l /dev/sda
Disk /dev/sda: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
Disk model: 001-2MA101
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: B7B80A4B-0294-44FD-A368-74B0455D6AF2

Device          Start        End    Sectors   Size Type
/dev/sda1        8192   16785407   16777216     8G Linux RAID
/dev/sda2    16785408   20979711    4194304     2G Linux RAID
/dev/sda5    21257952 1965122911 1943864960 926.9G Linux RAID
/dev/sda6  1965139008 7813827135 5848688128   2.7T Linux RAID


root@user-NUC10i7FNH:~# lsblk
NAME            MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda               8:0    0   3.6T  0 disk
|-sda1            8:1    0     8G  0 part
|-sda2            8:2    0     2G  0 part
|-sda5            8:5    0 926.9G  0 part
| `-md2           9:2    0 926.9G  0 raid1
|   `-vg1000-lv 252:0    0   3.6T  0 lvm
`-sda6            8:6    0   2.7T  0 part
   `-md3           9:3    0   2.7T  0 raid1
     `-vg1000-lv 252:0    0   3.6T  0 lvm


root@user-NUC10i7FNH:~# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md3 : active (auto-read-only) raid1 sda6[1]
       2924343040 blocks super 1.2 [2/1] [_U]

md2 : active raid1 sda5[3]
       971931456 blocks super 1.2 [2/1] [U_]

unused devices: <none>


root@user-NUC10i7FNH:~# lvm pvscan
   WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify 
the VG to update.
   WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify 
the VG to update.
   PV /dev/md2   VG vg1000          lvm2 [926.90 GiB / 0    free]
   PV /dev/md3   VG vg1000          lvm2 [2.72 TiB / 0    free]
   Total: 2 [<3.63 TiB] / in use: 2 [<3.63 TiB] / in no VG: 0 [0   ]

root@user-NUC10i7FNH:~# lvm vgscan
   WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify 
the VG to update.
   WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify 
the VG to update.
   Found volume group "vg1000" using metadata type lvm2

root@user-NUC10i7FNH:~# lvm lvscan
   WARNING: PV /dev/md2 in VG vg1000 is using an old PV header, modify 
the VG to update.
   WARNING: PV /dev/md3 in VG vg1000 is using an old PV header, modify 
the VG to update.
   ACTIVE            '/dev/vg1000/lv' [<3.63 TiB] inherit


root@user-NUC10i7FNH:~# mount -t btrfs -o rescue=all,ro /dev/vg1000/lv 
/mnt/test/
mount: /mnt/test: can't read superblock on /dev/mapper/vg1000-lv.


root@user-NUC10i7FNH:~# ll /dev/vg1000/lv /dev/mapper/vg1000-lv
lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/mapper/vg1000-lv -> ../dm-0
lrwxrwxrwx 1 root root 7 oct.   2 17:34 /dev/vg1000/lv -> ../dm-0


root@user-NUC10i7FNH:~# tail log/kern.log
Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.255079] BTRFS: device 
label 2017.12.01-16:57:32 v15217 devid 1 transid 15800483 
/dev/mapper/vg1000-lv scanned by mount (2939)
Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257012] BTRFS info 
(device dm-0): first mount of filesystem 
320f5288-777d-43eb-84e3-4ac70573ec6b
Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257061] BTRFS info 
(device dm-0): using crc32c (crc32c-intel) checksum algorithm
Oct  2 17:30:57 user-NUC10i7FNH kernel: [ 1697.257079] BTRFS info 
(device dm-0): disk space caching is enabled
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650935] BTRFS critical 
(device dm-0: state C): corrupt leaf: root=257 block=2691220668416 
slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.650969] BTRFS error 
(device dm-0: state C): read time tree block corruption detected on 
logical 2691220668416 mirror 1
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654160] BTRFS critical 
(device dm-0: state C): corrupt leaf: root=257 block=2691220668416 
slot=0 ino=6039235, unknown incompat flags detected: 0x40000000
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654189] BTRFS error 
(device dm-0: state C): read time tree block corruption detected on 
logical 2691220668416 mirror 2
Oct  2 17:31:01 user-NUC10i7FNH kernel: [ 1701.654337] BTRFS info 
(device dm-0: state C): last unmount of filesystem 
320f5288-777d-43eb-84e3-4ac70573ec6b


root@user-NUC10i7FNH:~# btrfs rescue super-recover -v /dev/vg1000/lv
All Devices:
         Device: id = 1, name = /dev/vg1000/lv

Before Recovering:
         [All good supers]:
                 device name = /dev/vg1000/lv
                 superblock bytenr = 65536

                 device name = /dev/vg1000/lv
                 superblock bytenr = 67108864

                 device name = /dev/vg1000/lv
                 superblock bytenr = 274877906944

         [All bad supers]:

All supers are valid, no need to recover


root@user-NUC10i7FNH:~# btrfs rescue zero-log /dev/vg1000/lv
Clearing log on /dev/vg1000/lv, previous log_root 0, level 0


root@user-NUC10i7FNH:~# btrfs check /dev/vg1000/lv
Opening filesystem to check...
Checking filesystem on /dev/vg1000/lv
UUID: 320f5288-777d-43eb-84e3-4ac70573ec6b
[1/7] checking root items
[2/7] checking extents
Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
ignoring invalid key
Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
[...line repeated many times
Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
ignoring invalid key
Invalid key type(BLOCK_GROUP_ITEM) found in root(202)
ignoring invalid key
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 2726275964928 bytes used, no error found
total csum bytes: 839025944
total tree bytes: 3015049216
total fs tree bytes: 1991966720
total extent tree bytes: 95895552
btree space waste bytes: 555710555
file data blocks allocated: 3567579688960
  referenced 2977409900544


root@user-NUC10i7FNH:~# btrfs property get /dev/mapper/vg1000-lv
label=2017.12.01-16:57:32 v15217


root@user-NUC10i7FNH:~# btrfs version
btrfs-progs v5.16.2


The most surprising is that on a Windows 10, "DiskInternals Linux 
Reader" (a paid software) shows me the content of this disk (and asks me 
to pay for copying the data).


Any idea ?



