Return-Path: <linux-btrfs+bounces-13437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5FA9D788
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 06:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A49F4C6BE3
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 04:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8A1E8348;
	Sat, 26 Apr 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu7QV1p+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CE42AA5
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Apr 2025 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745641715; cv=none; b=clgFsYomLiIZjCLouVwgvZ2wzPR/cZrHfhzKnqO6O1POCRPvsD9Ku1S51pqfU1/wTl04JYCaCgDWU2sCVWKnQSqMgzA5ZGrHnCzG0iAqdWkJpO6NF3xphaEzkSVpLGzaa7FK/Bb5ZSCrzVrgGxpPeLPZD56Yf/47m46G7GDfXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745641715; c=relaxed/simple;
	bh=0A3vmoA4P6x7TFQMvem8SPNw2i48+x0d/3sQnH04BeQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WjmFKlAKgHDoSj0kHUgfSxoR6g0HE5kwI2AN/z015N867MASF3Tn6pYv9ftCTfAyc6qQhHbWZl4L3MQaHIzmapdeIzeGiR3kq31KF6sqvzzHmOMsvqtMcdNzYri8DjZiEmZ693RKy+nZzkdIbzskkMvu75tmgaTm7XxAxU91hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu7QV1p+; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso1790736fac.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745641712; x=1746246512; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1n5cm8g15WGsD/3sLG364lxVGptQnH8EDRUFipebCs=;
        b=Fu7QV1p+9xugQhVocYGFz92wFIWnLlfliBoHl5Cnr1aeE23NGrziI5ND9vT/L/XR83
         WKozFzdKFtxR/UpQ81RSGkaQwmyebGvuc1PCPuk05NpXq5uBzUwJf8KVuzz2vKLw/F+z
         hp1AnXGaSJpq2eGGQzpR7emOv+whbJFatuWpB1Zkbgay15+L+AnPenGacJsb78GzUWNx
         H76xwHS0jWiCaH63xUg8geLDBZpzjGQmaRbZ8pn1epI3FgGxgukul7Y+WnVf8gpiqkzG
         RGc8oJhxn1yBeOoG4H6FRlZZjpqSEOWRE5xL44viThF+DwzJbvrOpBpj24KCk/N7XFWi
         RNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745641712; x=1746246512;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1n5cm8g15WGsD/3sLG364lxVGptQnH8EDRUFipebCs=;
        b=EqfHyXG3UaCpxcN2crbmYrS2v9lqCmNfRoH6OIRpdQSK60HQ0RJZ3h6ZIQErOrk0p0
         q4R8DfwvdPYYrf1LsuR8+9f/Lf9cqeWKlGzXOzKyI8DbVdCAt1VXAZD4xH4o9iC/PX62
         pCMYklxMa4BYEZxXAdgj44Mvxcde2hoJSF30aeJaymdT/xMEDooiCjXz4XfZaiwkteyO
         B1rdBCrHhCqmHD/UnjxDIvfVGoijri6lGtN39gWc08w+FQEsxPCDqMxlDImwSWFhY3dP
         qEEUi/835GxbdTJCprxtbyC7WDo+1Zz4H84jQ6dYKWbtVL0Ifk1u1N7P1/inumsfRioh
         XYig==
X-Gm-Message-State: AOJu0YzBzTzZa2lvkhT5GIZKJTBAqRkwXF5WBAcVxJoVvPortzs3wAn7
	KqZ/sDUuXBRxjRkZbHs0Sr7TqEGbPOp5aqMQ3GxhK9brK1kM33rsxkv84RDiS0Ga3yCliXqw1/a
	LYuEutF3Q0jm2y/g/z7uR2POX6eQV5qqp2D6LKhaa
X-Gm-Gg: ASbGnct37/p54gP4DfqsYCJKtCdztaAfI+3oyinMnStG0nQbbF0SFS3RXwuFIQbU2YY
	3eq3qhaJbLcw/TXbai9/7ww7h3BuRyu03uBwqWah27TQolP5cwnKgcxdqCFFzePd6Pmj4UpQ5VN
	l40TFP47SseO5WKhrb97ZHCyY=
X-Google-Smtp-Source: AGHT+IEXLxlJI6JuMUcrXcHksuzZ4oZcg2fUMolsDCdR0lLrMdV+eT/rBqXdGbrNhvPKGDipeZ8eORHUfmw1X8HAK78=
X-Received: by 2002:a05:6870:a78c:b0:296:a67c:d239 with SMTP id
 586e51a60fabf-2d99d7e680emr2577198fac.12.1745641712069; Fri, 25 Apr 2025
 21:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5byg6bmP6aOe?= <jstxzpf@gmail.com>
Date: Sat, 26 Apr 2025 12:28:19 +0800
X-Gm-Features: ATxdqUEIQXoqx5DdjNSAZwGUeDXXju7HnlZd4GzNzfmzPd_3fJFvusuH4UQPBao
Message-ID: <CAHefssCK98jCf6c4FRxHz9bSFgi=xA5sKgTTp4zteVxL8yWG3g@mail.gmail.com>
Subject: Assistance Needed: Btrfs RAID1 Filesystem Unmountable Due to Chunk
 Tree and FSID Mismatch Issues
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Btrfs Community,

I am seeking assistance with a critical issue on a Btrfs RAID1
filesystem that has become unmountable after an interrupted `btrfstune
-u` operation. Despite extensive troubleshooting, I have been unable
to repair or mount the filesystem, and I am hoping for guidance from
developers or experienced users.

System Details
- Operating System: OpenEuler (based on Linux)
- Kernel Version: 6.6.0-85.0.0.79.oe2403.x86_64
- Btrfs Tools: btrfs-progs v6.6.3
- Filesystem: Btrfs RAID1 on two devices (/dev/sdb1 and /dev/sdc1)
  - Total size: 16 TiB (8 TiB per device)
  - Used space: 5.52 TiB
  - FSID: f7d5ddae-5499-42e7-854f-7b4c658e3930
  - Metadata profile: RAID1
  - Data profile: RAID1

Problem Background
The issue began when I attempted to change the filesystem UUID using
`btrfstune -u`. The operation was interrupted (likely due to a system
crash or manual termination), after which the filesystem became
unmountable. The primary errors are:
- FSID mismatch: Metadata blocks reference an old UUID
(fae46898-a972-4118-a2e2-5d35e8219ae0) instead of the expected UUID
(f7d5ddae-5499-42e7-854f-7b4c658e3930).
- Chunk tree corruption: Repeated errors indicating `Couldn't read chunk tree`.
- Tree root corruption: Issues with the tree root at block
17953108230144 and bad tree block at 17936955146240.

Symptoms
- Mounting attempts (`mount -o degraded,ro`, `mount -o
degraded,ro,recovery`, `mount -o degraded,ro,usebackuproot`) fail
with:
  mount: /mnt: can't read superblock on /dev/sdc1.
- `dmesg` reports:
  BTRFS error (device sdb1): bad fsid on logical 17936954720256 mirror 1
  BTRFS error (device sdb1): failed to read chunk tree: -5
  BTRFS error (device sdb1): open_ctree failed: -5
- `btrfs check --readonly` on both devices reports:
  bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
  Couldn't read chunk tree
  ERROR: cannot open file system

Steps Attempted
I have tried the following repair and recovery steps, all of which have failed:

1. Superblock Recovery:
   - `sudo btrfs rescue super-recover /dev/sdb1`:
     All supers are valid, no need to recover
   - Confirmed superblocks are intact via `btrfs inspect-internal
dump-super -f /dev/sdb1` and `/dev/sdc1`.

2. Chunk Tree Recovery:
   - `sudo btrfs rescue chunk-recover /dev/sdc1`:
     Scanning: DONE in dev0, DONE in dev1
     corrupt node: root=1 block=17953108230144, nritems too large,
have 2 expect range [1,0]
     Couldn't read tree root
     open with broken chunk error

3. Mount Attempts:
   - Tried various mount options (`degraded,ro`,
`degraded,ro,recovery`, `degraded,ro,usebackuproot`) on both devices.
   - Attempted to use backup roots listed in `btrfs inspect-internal
dump-super` (e.g., 18288112435200, 18288112664576, 18288112697344),
but the kernel does not support `usetreeroot` or `usesuper` options:
     BTRFS error (device sdb1): unrecognized mount option
'usetreeroot=18288112697344'

4. Filesystem Check and Repair:
   - `sudo btrfs check --repair /dev/sdc1` and `/dev/sdb1`:
     bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
     Couldn't read chunk tree
     ERROR: cannot open file system
   - `sudo btrfs check --init-csum-tree /dev/sdc1` and `/dev/sdb1`:
     bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
     Couldn't read chunk tree
     ERROR: cannot open file system
   - `sudo btrfs check --init-extent-tree /dev/sdc1` and `/dev/sdb1`:
     bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
     Couldn't read chunk tree
     ERROR: cannot open file system

5. Data Recovery Attempts:
   - `sudo btrfs restore /dev/sdc1 /mnt/restore` and `sudo btrfs
restore --ignore-errors /dev/sdc1 /mnt/restore`:
     bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
     Couldn't read chunk tree
     Could not open root, trying backup super
     warning, device 1 is missing
     bad tree block 17936955146240, bytenr mismatch, want=17936955146240, have=0
   - Tried specifying backup roots (`-r 18288112435200`, `-r
18288112664576`, `-r 18288112697344`) with `--ignore-errors`:
     bad tree block 17936955146240, fsid mismatch,
want=f7d5ddae-5499-42e7-854f-7b4c658e3930,
have=fae46898-a972-4118-a2e2-5d35e8219ae0
     Couldn't read chunk tree
     Could not open root, trying backup super
     warning, device 1 is missing
     bad tree block 17936955146240, bytenr mismatch, want=17936955146240, have=0

Current Status
- All repair attempts (`btrfs rescue`, `btrfs check --repair`,
`--init-csum-tree`, `--init-extent-tree`) have failed to restore the
chunk tree or tree root.
- All recovery attempts (`btrfs restore`, including `--ignore-errors`
and specifying backup roots) have failed due to `fsid mismatch` and
chunk tree issues.
- The filesystem remains unmountable, and no data has been recovered.
- I plan to try `btrfs restore` on /dev/sdb1 with backup roots, but
given the identical errors on both devices, I expect similar results.

Questions and Requests
1. Are there any advanced tools, patches, or experimental options in
`btrfs-progs` that could help repair the chunk tree or address the
`fsid mismatch`?
2. Could the `fsid mismatch` be resolved by manually editing metadata
blocks or forcing the filesystem to accept the expected UUID
(f7d5ddae-5499-42e7-854f-7b4c658e3930)?
3. Are there specific kernel configurations or newer versions of
`btrfs-progs` that might offer additional recovery options?
4. For `btrfs restore`, are there other options or techniques (e.g.,
`btrfs-find-root`) to maximize data recovery? Should I try
`btrfs-zero-log` to clear potential log tree issues?
5. Given the RAID1 setup, is there a way to leverage both devices
(/dev/sdb1 and /dev/sdc1) simultaneously for recovery?
6. Any other suggestions for recovering the filesystem or extracting data?

Attached Information
- Superblock Dump (from `btrfs inspect-internal dump-super -f /dev/sdc1`):
  superblock: bytenr=65536, device=/dev/sdc1
  ---------------------------------------------------------
  csum_type               0 (crc32c)
  csum_size               4
  csum                    0xd0eb00de [match]
  bytenr                  65536
  flags                   0x1
                          ( WRITTEN )
  magic                   _BHRfS_M [match]
  fsid                    f7d5ddae-5499-42e7-854f-7b4c658e3930
  metadata_uuid           00000000-0000-0000-0000-000000000000
  label
  generation              707761
  root                    17953108230144
  sys_array_size          258
  chunk_root_generation   707001
  root_level              1
  chunk_root              18289175560192
  chunk_root_level        1
  log_root                0
  log_root_transid (deprecated)   0
  log_root_level          0
  total_bytes             16003123642368
  bytes_used              6073712148480
  sectorsize              4096
  nodesize                16384
  leafsize (deprecated)   16384
  stripesize              4096
  root_dir                6
  num_devices             2
  compat_flags            0x0
  compat_ro_flags         0x3
                          ( FREE_SPACE_TREE |
                            FREE_SPACE_TREE_VALID )
  incompat_flags          0x371
                          ( MIXED_BACKREF |
                            COMPRESS_ZSTD |
                            BIG_METADATA |
                            EXTENDED_IREF |
                            SKINNY_METADATA |
                            NO_HOLES )
  cache_generation        0
  uuid_tree_generation    707761
  dev_item.uuid           e17aa5ea-c6d6-4c5d-a154-8977b8c7a921
  dev_item.fsid           f7d5ddae-5499-42e7-854f-7b4c658e3930 [match]
  dev_item.type           0
  dev_item.total_bytes    8001561821184
  dev_item.bytes_used     6087109509120
  dev_item.io_align       4096
  dev_item.io_width       4096
  dev_item.sector_size    4096
  dev_item.devid          2
  dev_item.dev_group      0
  dev_item.seek_speed     0
  dev_item.bandwidth      0
  dev_item.generation     0
  sys_chunk_array[2048]:
          item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 17936954687488)
                  length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                  io_align 65536 io_width 65536 sector_size 4096
                  num_stripes 2 sub_stripes 1
                          stripe 0 devid 1 offset 4384126664704
                          dev_uuid 6a1c0f64-698d-43b7-b072-95a1d586d9d9
                          stripe 1 devid 1 offset 4384160219136
                          dev_uuid 6a1c0f64-698d-43b7-b072-95a1d586d9d9
          item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 18289175560192)
                  length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                  io_align 65536 io_width 65536 sector_size 4096
                  num_stripes 2 sub_stripes 1
                          stripe 0 devid 2 offset 6087043448832
                          dev_uuid e17aa5ea-c6d6-4c5d-a154-8977b8c7a921
                          stripe 1 devid 2 offset 6087077003264
                          dev_uuid e17aa5ea-c6d6-4c5d-a154-8977b8c7a921
  backup_roots[4]:
          backup 0:
                  backup_tree_root:       17953108230144  gen: 707761
   level: 1
                  backup_chunk_root:      18289175560192  gen: 707001
   level: 1
                  backup_extent_root:     17953755693056  gen: 707761
   level: 2
                  backup_fs_root:         18288112533504  gen: 707759
   level: 2
                  backup_dev_root:        17953317421056  gen: 707761
   level: 1
                  csum_root:      18288110616576  gen: 707758     level: 3
                  backup_total_bytes:     16003123642368
                  backup_bytes_used:      6073712148480
                  backup_num_devices:     2
          backup 1:
                  backup_tree_root:       18288112435200  gen: 707758
   level: 1
                  backup_chunk_root:      18289175560192  gen: 707001
   level: 1
                  backup_extent_root:     18288111075328  gen: 707758
   level: 2
                  backup_fs_root:         18288110305280  gen: 707758
   level: 2
                  backup_dev_root:        18288386441216  gen: 707001
   level: 1
                  csum_root:      18288110616576  gen: 707758     level: 3
                  backup_total_bytes:     16003123642368
                  backup_bytes_used:      6073712148480
                  backup_num_devices:     2
          backup 2:
                  backup_tree_root:       18288112664576  gen: 707759
   level: 1
                  backup_chunk_root:      18289175560192  gen: 707001
   level: 1
                  backup_extent_root:     18288112582656  gen: 707759
   level: 2
                  backup_fs_root:         18288112533504  gen: 707759
   level: 2
                  backup_dev_root:        18288386441216  gen: 707001
   level: 1
                  csum_root:      18288110616576  gen: 707758     level: 3
                  backup_total_bytes:     16003123642368
                  backup_bytes_used:      6073712148480
                  backup_num_devices:     2
          backup 3:
                  backup_tree_root:       18288112697344  gen: 707760
   level: 1
                  backup_chunk_root:      18289175560192  gen: 707001
   level: 1
                  backup_extent_root:     18288112713728  gen: 707760
   level: 2
                  backup_fs_root:         18288112533504  gen: 707759
   level: 2
                  backup_dev_root:        18288386441216  gen: 707001
   level: 1
                  csum_root:      18288110616576  gen: 707758     level: 3
                  backup_total_bytes:     16003123642368
                  backup_bytes_used:      6073712148480
                  backup_num_devices:     2

Additional Notes
- The filesystem contains critical data (5.52 TiB), and I have backups
of some portions but would prefer to recover as much as possible.
- I plan to try `btrfs restore` on /dev/sdb1 with backup roots, but
given the identical errors, I expect similar results.
- I am prepared to create disk images (`dd`) if needed, but this would
require significant storage (8 TiB per device).
- I have avoided further write operations to prevent worsening the damage.

I would greatly appreciate any advice, tools, or steps to either
repair the filesystem or maximize data recovery. Please let me know if
additional logs or outputs (e.g., `btrfs-find-root` or
`btrfs-zero-log`) would be helpful.

Thank you for your time and expertise.

Best regards,
Zhang Pengfei
jstxzpf@gmail.com

