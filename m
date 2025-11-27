Return-Path: <linux-btrfs+bounces-19379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B3C8E9DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F23D13503D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A932BF24;
	Thu, 27 Nov 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkRDH6Pm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139BC1C2334
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251629; cv=none; b=P5+jQcyDC/uI5MjfWAxhalLwUB6OY0NLOUfF7TQdAor1f8y0tt17bGqpkuFdQEylmxSMCSZ5T0jND8oQlu9oKHLj/HfrgMYpXIKBPUcq6Y5IbQXv7qowKKvKICSAXTsWJH/FC1qRf9zlLphivIU6wovIov/6+KcjzC10t0Psbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251629; c=relaxed/simple;
	bh=z0nmAMmI09dUvxaBewLLu5zEAf/KvfkQQQ3OaMhwPwo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qCGJG5iZ5sYZ20nDvMMObJkmOO36jl252/miq/XqRj9uMPoG1nHt/z6SduX+g4zJS2s7GDhA1swLnPpqHaosGdUzt0XABZd5FGsGsZMTZ7LsE6hvpoqLZ816x/ItV2kjYqS+QG6/w+5CO9q7tiliU5TwcXCXZp/ohXkCGa1BK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkRDH6Pm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5958232f806so1098729e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764251625; x=1764856425; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pghnzCbtwsO5lWIjB5A3yALuWYtlG88i/+FXFYl13GM=;
        b=CkRDH6PmKs3sdU8+FGqG4NYeoKVVyzDoS4OttXSC02Adl51VO9adNiJJOKOOfxFeXq
         jpKKMh25wQV1tvJqNCamIDA/zWbxUWwC8gOxwE1Hw6/OfMEHAOJx6GbQ/ZTpduWNAMuB
         V/MdgQRaJXXsVS2EP3kODBlPzkIomNUOhpBGSoEUP+8VoIXrryd4ppDqGjLzXj53lDzT
         cfeD1JM44liYVdyBlBPtcg8VUkaqo48QLXs4Y6fRfSDFEFnH9fFKtdHrlX/F7LTkxVt+
         3k0iiNmw8njiOjaFSI4Ul41UqxUmQai6Bf7U1iyFhg2rpDcYOMk0ZkTvdEqyZHsqpyPe
         i9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251625; x=1764856425;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pghnzCbtwsO5lWIjB5A3yALuWYtlG88i/+FXFYl13GM=;
        b=pgFWsD4omV87nTfzkUrn2GMlOF8H2tmng/U5Xnw8WoeRQqUVaYfzM6DhPmeJhsHe81
         oUg+c7/9nOeVhlzkMe5seVmOSOpvQLoO1TXqqd0ThdX6MFmikk5RdVxIYBMnMsCCkc35
         47I1geACaE9IrrcBCFabLvNa95f8eP755PXPV55jyvdW6B/tZJ0FHuJDqeCOsDXAMuob
         f3CrRzZqcQBowQI1Ur+Az3GqLIaWk6h6caaSEtBrMc1vlYhwXCedA3WO3E40q1M1fNhK
         61Q7mZeYmSq7m2/axIVCOy4jNSQvcTo9RShNnQadBaftNgVF5eHckJVzEwxDoKQYUPg7
         0QkQ==
X-Gm-Message-State: AOJu0YzX4ud6XjxpbxZ+aReX2tyUycqPvz9zwGRLIhfld5nciCj7c0Gu
	MaGSaMXHCYeoDgA/Bx5XuOomOfjQOg7T70ykC55YVqqtdHnjUko5SPSsZH2mDQ==
X-Gm-Gg: ASbGncsAxmhQcUoWg8NbIohP4KlbcENE0oaEAnrBRaAHWQY1cLevo2POmRQWjk8RXE2
	Nwg3tSPXunfdaVxeDuSaZkwt4OyGukotCJLnxDTqzgVKPRASI+OZcXP0MVUM7CcwKrs9IaobHL8
	jqZ9gX9TFXQp+5Mi+wMsFYeIZ7/3z4kWH4lMCoF/JKp585rcnRad4R76X1VSJNVSQT26OmprmHp
	EFfQ7UbA8Y6twfG7GFWLLfp/fRBKn7NeW9WY1f7zVWZYwd+6e//51YanNBQ7Xedweiqg5Br6jPs
	Jj/vhGaWuDs4z/S9S5bA8hcQg6zYUg8KohaNlin8LF9PsZmQsU+6eHRyVFW/HgILA0ygz/Xw2kn
	pehPHPXR+vRB47o/4+dqHnzaTLBnXrunvosTVKpP74nT6bb3dxUZQJifp/Gp7zZdKiFgGLi1Vf0
	ChlpHpGJSvAjjM0yJRfivLrgEkQoQt3qZm
X-Google-Smtp-Source: AGHT+IGkVVW37G1h5+igBszEvuTO7sA0AOJZlHWXxJOQPtxFq6QscbyvlGgFeCXJoeoI9AMGt2OeBA==
X-Received: by 2002:a05:6512:e8c:b0:595:8313:3bce with SMTP id 2adb3069b0e04-596a3e9fbc8mr8785855e87.5.1764251624649;
        Thu, 27 Nov 2025 05:53:44 -0800 (PST)
Received: from [10.128.170.160] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8b068csm434830e87.26.2025.11.27.05.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 05:53:44 -0800 (PST)
Message-ID: <7bbc9419-5c56-450a-b5a0-efeae7457113@gmail.com>
Date: Thu, 27 Nov 2025 16:53:43 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
To: clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: File system corruption after renaming directory and creating a new
 file with same name if system crashes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

File system becomes corrupted after renaming directory, creating and 
syncing a new file with the same name if system crashes.


Detailed description
====================

Hello, we have found another issue with btrfs crash behavior.

In short, two directories are created and synced. Then, first directory 
is renamed as subdirectory of the second directory. A new file is 
created with name that was previously associated with the first 
directory. The file is fsync'ed and moved under the renamed directory 
and fsync'ed again. After a crash, file system cannot be mounted, 
reporting block corruption.

It seems that the directory entry becomes corrupted when the `nlink` 
value is erroneously set to 2, somehow.


System info
===========

Linux version 6.18.0-rc7, also tested on 6.18.0-rc2 and 6.14.11.


How to reproduce
================

Test:

```
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
   int status;
   int file_fd;

   status = mkdir("dir1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   status = mkdir("dir2", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("MKDIR: %d\n", status);

   sync();

   status = rename("dir1", "dir2/dir3");
   printf("RENAME: %d\n", status);

   // create regular file with the name directory had before rename
   status = open("dir1", O_RDWR | O_CREAT);
   printf("OPEN: %d\n", status);
   file_fd = status;

   status = fsync(file_fd);
   printf("FSYNC: %d\n", status);

   status = rename("dir1", "dir2/dir3/not-dir");
   printf("RENAME: %d\n", status);

   status = fsync(file_fd);
   printf("FSYNC: %d\n", status);
}
```

dmesg:

```
[ 17.559361] BTRFS: device fsid 17a75b88-e58e-457d-83db-ea6599920bc7 
devid 1 transid 9 /dev/vdb (253:16) scanned by mount (1095)
[ 17.559676] BTRFS info (device vdb): first mount of filesystem 
17a75b88-e58e-457d-83db-ea6599920bc7
[ 17.559690] BTRFS info (device vdb): using crc32c (crc32c-lib) checksum 
algorithm
[ 17.562785] BTRFS info (device vdb): start tree-log replay
[ 17.563301] page: refcount:2 mapcount:0 mapping:0000000077ae2817 
index:0x1d00 pfn:0x1057ac
[ 17.563305] memcg:ffff89a500340000
[ 17.563307] aops:btree_aops ino:1
[ 17.563311] flags: 
0x17ffffc800402a(uptodate|lru|private|writeback|node=0|zone=2|lastcpupid=0x1fffff)
[ 17.563315] raw: 0017ffffc800402a fffff9aa84135708 fffff9aa84073d88 
ffff89a51cb23a90
[ 17.563318] raw: 0000000000001d00 ffff89a502951b40 00000002ffffffff 
ffff89a500340000
[ 17.563319] page dumped because: eb page dump
[ 17.563320] BTRFS critical (device vdb): corrupt leaf: root=5 
block=30408704 slot=6 ino=257, invalid nlink: has 2 expect no more than 
1 for dir
[ 17.564768] BTRFS info (device vdb): leaf 30408704 gen 10 total ptrs 17 
free space 14869 owner 5
[ 17.564772] item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
[ 17.564775] inode generation 3 transid 9 size 16 nbytes 16384
[ 17.564776] block group 0 mode 40755 links 1 uid 0 gid 0
[ 17.564778] rdev 0 sequence 2 flags 0x0
[ 17.564779] atime 1764249615.0
[ 17.564781] ctime 1764249645.130028300
[ 17.564782] mtime 1764249645.130028300
[ 17.564784] otime 1764249615.0
[ 17.564785] item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
[ 17.564787] index 0 name_len 2
[ 17.564789] item 2 key (256 DIR_ITEM 2363071922) itemoff 16077 itemsize 34
[ 17.564791] location key (257 1 0) type 2
[ 17.564792] transid 9 data_len 0 name_len 4
[ 17.564794] item 3 key (256 DIR_ITEM 2676584006) itemoff 16043 itemsize 34
[ 17.564795] location key (258 1 0) type 2
[ 17.564797] transid 9 data_len 0 name_len 4
[ 17.564798] item 4 key (256 DIR_INDEX 2) itemoff 16009 itemsize 34
[ 17.564800] location key (257 1 0) type 2
[ 17.564801] transid 9 data_len 0 name_len 4
[ 17.564803] item 5 key (256 DIR_INDEX 3) itemoff 15975 itemsize 34
[ 17.564805] location key (258 1 0) type 2
[ 17.564806] transid 9 data_len 0 name_len 4
[ 17.564807] item 6 key (257 INODE_ITEM 0) itemoff 15815 itemsize 160
[ 17.564809] inode generation 9 transid 10 size 14 nbytes 0
[ 17.564811] block group 0 mode 40755 links 2 uid 0 gid 0
[ 17.564812] rdev 0 sequence 1 flags 0x0
[ 17.564813] atime 1764249645.130028300
[ 17.564815] ctime 1764249645.130028300
[ 17.564816] mtime 1764249645.130028300
[ 17.564818] otime 1764249645.130028300
[ 17.564819] item 7 key (257 INODE_REF 256) itemoff 15801 itemsize 14
[ 17.564821] index 2 name_len 4
[ 17.564822] item 8 key (257 INODE_REF 258) itemoff 15787 itemsize 14
[ 17.564824] index 2 name_len 4
[ 17.564825] item 9 key (257 DIR_ITEM 3753155587) itemoff 15750 itemsize 37
[ 17.564827] location key (259 1 0) type 1
[ 17.564828] transid 10 data_len 0 name_len 7
[ 17.564830] item 10 key (257 DIR_INDEX 2) itemoff 15713 itemsize 37
[ 17.564831] location key (259 1 0) type 1
[ 17.564833] transid 10 data_len 0 name_len 7
[ 17.564834] item 11 key (258 INODE_ITEM 0) itemoff 15553 itemsize 160
[ 17.564836] inode generation 9 transid 10 size 8 nbytes 0
[ 17.564837] block group 0 mode 40755 links 1 uid 0 gid 0
[ 17.564839] rdev 0 sequence 1 flags 0x0
[ 17.564840] atime 1764249645.130028300
[ 17.564842] ctime 1764249645.130028300
[ 17.564843] mtime 1764249645.130028300
[ 17.564844] otime 1764249645.130028300
[ 17.564846] item 12 key (258 INODE_REF 256) itemoff 15539 itemsize 14
[ 17.564847] index 3 name_len 4
[ 17.564849] item 13 key (258 DIR_ITEM 1843588421) itemoff 15505 itemsize 34
[ 17.564851] location key (257 1 0) type 2
[ 17.564852] transid 10 data_len 0 name_len 4
[ 17.564853] item 14 key (258 DIR_INDEX 2) itemoff 15471 itemsize 34
[ 17.564855] location key (257 1 0) type 2
[ 17.564856] transid 10 data_len 0 name_len 4
[ 17.564858] item 15 key (259 INODE_ITEM 0) itemoff 15311 itemsize 160
[ 17.564860] inode generation 10 transid 10 size 0 nbytes 0
[ 17.564861] block group 0 mode 100000 links 1 uid 0 gid 0
[ 17.564863] rdev 0 sequence 2 flags 0x0
[ 17.564864] atime 1764249645.139028211
[ 17.564865] ctime 1764249645.140028202
[ 17.564867] mtime 1764249645.139028211
[ 17.564868] otime 1764249645.139028211
[ 17.564869] item 16 key (259 INODE_REF 257) itemoff 15294 itemsize 17
[ 17.564870] index 2 name_len 7
[ 17.564872] BTRFS error (device vdb): block=30408704 write time tree 
block corruption detected
[ 17.566147] BTRFS: error (device vdb) in btrfs_commit_transaction:2535: 
errno=-5 IO failure (Error while writing out transaction)
[ 17.567374] BTRFS warning (device vdb state E): Skipping commit of 
aborted transaction.
[ 17.567377] BTRFS error (device vdb state EA): Transaction aborted 
(error -5)
[ 17.568502] BTRFS: error (device vdb state EA) in 
cleanup_transaction:2020: errno=-5 IO failure
[ 17.569956] BTRFS: error (device vdb state EA) in 
btrfs_replay_log:2093: errno=-5 IO failure (Failed to recover log tree)
[ 17.571778] BTRFS error (device vdb state EA): open_ctree failed: -5
```

Steps:
1. Create and mount new btrfs file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that mount fails.

Notes:

- if path in open() is changed to any other name (instead of `dir1`) the 
bug will not manifest.


