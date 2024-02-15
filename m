Return-Path: <linux-btrfs+bounces-2439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B285A856E44
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 21:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CCD1C2262C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C313A896;
	Thu, 15 Feb 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub8q/FXB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472411384B8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027481; cv=none; b=NNXt6om+PqUHRhGD11ST/wncYYhJhv84lAOq3t/28Vn5DYd1kGfmMTreMvjMAqFG4DtwiJRPEt+q9sP1ZcN7LznMHHfWQExS/j7TN/See2L80nu12wY/QCkh7PX79XSnCFq9rMuKm2c9dqRYDTuOY01ML6Tz/QCELD3DBksah14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027481; c=relaxed/simple;
	bh=2GgUHsxcrCkupzuZEwDPba7ihglwpzedcJTuK7ABEB0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PM9SM5c0ZUyqMxF5oKu8PlsXmkqDaH54GMukI4tCflG2GyVk4HB66eyiDLZPxZybwyyeT8rhjcmjEwmSjNKuxygVJPRU6cQLMu9o/tPiqKU7rr1S1owar/94P70Hu9J8GF6kSfybii9aZioMsRNhwb6beH0LV9/E06ykdlsJOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub8q/FXB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-296df89efd2so1156283a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708027479; x=1708632279; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=58GDLZa64im//2gtlNwjy+4xdvBW5mcPLth20gzX37I=;
        b=Ub8q/FXBJeg6TRCqIjrJEjXl29vJEH15ux1fv86wsNL5LhWvlWChhGbIaRvaEk9xUS
         9EbIp3ydMOup2yQ3j2M0TdW1XIYNW54Ml4fGChN71UMgoqfK3ahX6Gl94y5lXFqM1d5i
         uEjJYAbtnUosjF7XpbDr+sqTh2OuhLp5qFnx8KpHKh9Ov1DfHoAS6fePMga2xyokmhxY
         i9DlmdS+GhJ6VnrVPb5aCuxKCuBzTCn1x4lbJ92i4GepvtalfdIaad8++2VAO+tN67kx
         Dp2KtmtsUrdGPFV2/c1a3+g0QWA9FzgV2vKMOTUo95fe6lPVpd4C3fcQ8b5SWwhQZleU
         ZlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027479; x=1708632279;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58GDLZa64im//2gtlNwjy+4xdvBW5mcPLth20gzX37I=;
        b=li7oY5cQiylV/VFVuN49MWHcJNqNIPF2bi6hrQiQujM6nZ8qqGP5XPmAfUnTLY+mh6
         9S+WjwxLn55hLHyANtvuzTCgzCvrqAw23IPuyIpmD33L6thLg0k4wxpTM6wWu3yhyF27
         qd+2II+jXBec875KIua/jTJ4KEMId0WQUL2YiymaCJXRGzMFHpSLWedjoyxtg0imOfjh
         nSHOwwXmioeSIbqK4D0yT7dZTEjhR8nMBUXfXuG7bKhHrr5hNUGdZ5baR6izYNZo2FGz
         cM07FZv1zfj9QhjA6fFe96gTJxzAn/GFoSt1aRbDXHBERx2vYsXEVDt/MB/CcM9ho5pJ
         2mVg==
X-Gm-Message-State: AOJu0Yzg/jbrckXqaX35AAfCMSeDf1FXbBdHSAWqbadGzCyyP9N5b/DB
	+q+afUvyS6COJJXf5TqeA6GcLJ4irxk4jkMZ7qsIdib2eeAdoYYAqxttAD1vK2Sg6DuXLvip5cV
	9LA5OXjq3tnKw05uVwuJTUh5HvI4jYHUKqz0=
X-Google-Smtp-Source: AGHT+IGNhy3NoFaanFzeQwHJAqG5N+pdXgypjy066xlTNM4G8R1qCAVlDP9Z+WIyxUWZGQl+tBgS9kDEvS2HJC//7lA=
X-Received: by 2002:a17:90b:e8a:b0:293:fc07:22c7 with SMTP id
 fv10-20020a17090b0e8a00b00293fc0722c7mr2362001pjb.47.1708027479170; Thu, 15
 Feb 2024 12:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Smith <mr.kyle.smith@gmail.com>
Date: Thu, 15 Feb 2024 12:04:28 -0800
Message-ID: <CAKb79g0cM38YmV7rqeoC1EpO9vU856Y8LH2Kh7zxT5frDFfZDA@mail.gmail.com>
Subject: mounting causes errors after power loss
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have noticed the occasional btrfs error after a hard power cycle and
wanted to get a better understanding of the issue. These errors only
happen after the btrfs partition is mounted, and running "btrfs check"
before mounting does not find any errors.

I am using btrfs on Linux 5.10.176 on an encrypted LUKS2 partition on
an eMMC device. The LUKS2 partition is configured to allow-discards
and btrfs is mounted with  "-o acl,noatime,nodiratime,compress=lzo".

# uname -a
Linux (none) 5.10.176 #0 SMP PREEMPT Thu Apr 27 20:28:15 2023 aarch64 GNU/Linux

# btrfs --version
btrfs-progs v6.0.1

# btrfs fi show
Label: none  uuid: d90b7698-7ef5-4c1e-8365-b7631a6eafba
    Total devices 1 FS bytes used 92.16MiB
    devid    1 size 2.53GiB used 808.00MiB path /dev/mapper/luks-part

# mount -t btrfs -o acl,noatime,nodiratime,compress=lzo
/dev/mapper/luks-part /mnt/btrfs
[  185.443505] BTRFS: device fsid d90b7698-7ef5-4c1e-8365-b7631a6eafba
devid 1 transid 17201265 /dev/mapper/luks-part scanned by mount (2976)
[  185.455314] BTRFS info (device dm-0): flagging fs with big metadata feature
[  185.461689] BTRFS info (device dm-0): use lzo compression, level 0
[  185.467924] BTRFS info (device dm-0): using free space tree
[  185.473563] BTRFS info (device dm-0): has skinny extents
[  185.486490] BTRFS info (device dm-0): enabling ssd optimizations

# btrfs fi df /mnt/btrfs
Data, single: total=280.00MiB, used=91.46MiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=256.00MiB, used=704.00KiB
GlobalReserve, single: total=3.25MiB, used=0.00B

Here is an example of the errors found by "btrfs check" after
mounting. These errors don't happen often but they are reproducible
and persistent.

# btrfs check --mode=lowmem --readonly -p /dev/mapper/luks-part
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-part
UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
[1/7] checking root items                      (0:00:00 elapsed, 1456
items checked)
[2/7] checking extents                         (0:00:01 elapsed, 42
items checked)
[3/7] checking free space tree                 (0:00:00 elapsed, 5
items checked)
ERROR: root 5 INODE_ITEM[27535265] index 55000957 name .sharedContents
filetype 1 missing
ERROR: root 5 INODE_ITEM[27535266] index 55000959 name .sharedContents
filetype 1 missing
ERROR: root 5 DIR INODE [256] size 668 not equal to 698
[4/7] checking fs roots                        (0:00:00 elapsed, 15
items checked)
ERROR: errors found in fs roots
found 96636928 bytes used, error(s) found
total csum bytes: 93652
total tree bytes: 737280
total fs tree bytes: 376832
total extent tree bytes: 147456
btree space waste bytes: 231395
file data blocks allocated: 95899648
 referenced 92807168
Command exited with non-zero status 1

# btrfs check --readonly -p /dev/mapper/luks-part
Opening filesystem to check...
Checking filesystem on /dev/mapper/luks-part
UUID: d90b7698-7ef5-4c1e-8365-b7631a6eafba
[1/7] checking root items                      (0:00:00 elapsed, 1456
items checked)
[2/7] checking extents                         (0:00:00 elapsed, 54
items checked)
[3/7] checking free space tree                 (0:00:00 elapsed, 5
items checked)
root 5 inode 256 errors 200, dir isize wrong   (0:00:00 elapsed, 1
items checked)
root 5 inode 27535265 errors 1, no inode item
    unresolved ref dir 256 index 55000957 namelen 15 name
.sharedContents filetype 1 errors 5, no dir item, no inode ref
root 5 inode 27535266 errors 1, no inode item
    unresolved ref dir 256 index 55000959 namelen 15 name
.sharedContents filetype 1 errors 5, no dir item, no inode ref
[4/7] checking fs roots                        (0:00:00 elapsed, 22
items checked)
ERROR: errors found in fs roots
found 96636928 bytes used, error(s) found
total csum bytes: 93652
total tree bytes: 737280
total fs tree bytes: 376832
total extent tree bytes: 147456
btree space waste bytes: 231395
file data blocks allocated: 95899648
 referenced 92807168
Command exited with non-zero status 1

Here is the "btrfs ins dump-tree" output of the above inodes.

# btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535265 "
        location key (27535265 INODE_ITEM 0) type FILE
        transid 17119099 data_len 0 name_len 15
        name: .sharedContents
    item 62 key (256 DIR_INDEX 55000959) itemoff 13593 itemsize 45
        location key (27535266 INODE_ITEM 0) type FILE
        transid 17119099 data_len 0 name_len 15
# btrfs ins dump-tree -t 5 /dev/mapper/luks-part | grep -A5 "(27535266 "
        location key (27535266 INODE_ITEM 0) type FILE
        transid 17119099 data_len 0 name_len 15
        name: .sharedContents
    item 63 key (256 DIR_INDEX 55415388) itemoff 13545 itemsize 48
        location key (27743503 INODE_ITEM 0) type FILE
        transid 17188721 data_len 0 name_len 18

Is this a known issue with btrfs and power loss? Running "btrfs check
--repair" can fix this issue but I would like to prevent it in the
first place. This issue looks similar to the one in a previous message
on this list, "Filesystem inconsistency on power cycle" [0].


Thank you,
Kyle

[0]: https://lore.kernel.org/linux-btrfs/CA+XNQ=ixcfB1_CXHf5azsB4gX87vvdmei+fxv5dj4K_4=H1=ag@mail.gmail.com/

