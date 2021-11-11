Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E556444D909
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhKKPUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 10:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhKKPUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 10:20:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44774C061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 07:17:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4648848wmz.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NxAmO+EHJzmP8kY3OpjdMUMg/vXj7JUO1vi8bbWQijA=;
        b=V7ASq6DfntZcvd9BvX/th71KKqamxSESvzfFaxbQ35+1KV7yKeu0B+8criICKC+9gX
         dnCSfC+27JAr+t0WhVMKr4ieJgJ11LFjR1wb7RzUFWO2lQD3KElD72xNjnKiiTKUH+n3
         xP6gGt8DpD+AxDQawYwplRqj9PT/8VsxnyRciRGFWtFcBGr9T1pyU+RPKnP1fByfydZQ
         cBSrosP/CfJEHsPk5zgWefP26VhnI2dQdEs/HAg7fwJS/NBuTki9vdAimQKSaMOZdURr
         gYeKE0AmqWWk9wKIfwx0UNPDkJil/Nh//cP+gmlfbt2IXh+6wyzqe/PKn+X6CKEUnSAB
         cOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NxAmO+EHJzmP8kY3OpjdMUMg/vXj7JUO1vi8bbWQijA=;
        b=pgvMaw3uCzbEJnTH6dEztlely9fOu7ulOHIp1Wo7YZ0MmkAtcWVttOm7/ui/JQFUHl
         Dj1INGENNGB3H6Yg8LioGwK8+HHFBEBvPQ2nKSUJCaD0NN7pt+REXA3iP3scjylVTMV7
         L8MP3s92GxUNH0HmGgaWK1qkpBRs4fwifGK/DCvgOKUMXvfQASNs9meBOAOfUxO9O1A4
         2ZRXlvPn6DdJ8w4R2rquXCfK2f620Kmymlag0SYYgh2gcOejx00CKr3SqKoVpklvkv/9
         A3XV2KK8om95rrPFL0O3K6tPyC8WD6qE0NkidVQhnfNJfgTqjBgwrnWfHwD/rcSGCYqg
         xfGg==
X-Gm-Message-State: AOAM532ew+S9Cp6MVxT5OSxeNa5q8qwRGXp1v3iRq8s2j/t0+HQDJWpb
        ufJQjTPiwdFb3phQhfocz+Vj4IawYfPrRKNtEBEEQ4+YBFA=
X-Google-Smtp-Source: ABdhPJyXQeDZm2U64zJsHyxM2q763V0FTq/MDsvcQihMylUm4LqsHt1lmcPXkYypZLPRrQPClfNXhWpAqxsadVOD9Ac=
X-Received: by 2002:a05:600c:364f:: with SMTP id y15mr8568219wmq.7.1636643837358;
 Thu, 11 Nov 2021 07:17:17 -0800 (PST)
MIME-Version: 1.0
From:   Eli V <eliventer@gmail.com>
Date:   Thu, 11 Nov 2021 10:17:06 -0500
Message-ID: <CAJtFHUSN+RfZa2BitX9gH++M54uA7MTmn4Fn6Afx2RL4NPeaVQ@mail.gmail.com>
Subject: 5.10 kernel/fs exhausting reserve running btrfs_delete_unused_bgs,
 going read-only
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ideas requested on how to fix a large btrfs filesystem that goes
read-only shortly after a fresh
mount, with this in dmesg:

BTRFS info (device sdb): left=1507328, need=1572864, flags=1
BTRFS info (device sdb): space_info 2 has 1507328 free, is not full
BTRFS info (device sdb): space_info total=75497472, used=72482816,
pinned=0, reserved=1507328, may_use=0, readonly=0
BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533856256
BTRFS info (device sdb): trans_block_rsv: size 4194304 reserved 4194304
BTRFS info (device sdb): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdb): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdb): delayed_refs_rsv: size 298844160 reserved 110231552
BTRFS info (device sdb): left=1441792, need=1572864, flags=1
BTRFS info (device sdb): space_info 2 has 1441792 free, is not full
BTRFS info (device sdb): space_info total=75497472, used=72482816,
pinned=0, reserved=1572864, may_use=0, readonly=0
...
BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533266432
BTRFS info (device sdb): trans_block_rsv: size 4194304 reserved 4194304
BTRFS info (device sdb): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdb): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdb): delayed_refs_rsv: size 342884352 reserved 155910144
BTRFS info (device sdb): left=1376256, need=1572864, flags=1
BTRFS info (device sdb): space_info 2 has 1376256 free, is not full
BTRFS info (device sdb): space_info total=75497472, used=72482816,
pinned=0, reserved=1638400, may_use=0, readonly=0
BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533266432
BTRFS error (device sdb): allocation failed flags 18, wanted 65536
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 1060882 at fs/btrfs/volumes.c:2989
btrfs_remove_chunk+0x553/0x6b0 [btrfs]
CPU: 1 PID: 1060882 Comm: btrfs-cleaner Tainted: G        W I
5.10.0-9-amd64 #1 Debian 5.10.70-1
RIP: 0010:btrfs_remove_chunk+0x553/0x6b0 [btrfs]
Code: 40 0a 00 00 02 72 28 83 f8 fb 0f 84 91 00 00 00 83 f8 e2 0f 84
88 00 00 00 89 c6 48 c7 c7 40 22 71 c0 89 04 24 e8 80 33 1f e0 <0f> 0b
8b 04 24 89 c1 ba ad 0b 00 00 4c 89 ef 89 04 24 48 c7 c6 d0
RSP: 0018:ffffb82003983d90 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff95a324c2ef00 RCX: ffff959f5fc18a08
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff959f5fc18a00
RBP: ffff959d85f4a000 R08: 0000000000000000 R09: ffffb82003983bb0
R10: ffffb82003983ba8 R11: ffffffffa16ba8f8 R12: ffff959d1acc4150
R13: ffff95a1c807f138 R14: ffff959d85f4a380 R15: ffff95a095e90000
FS:  0000000000000000(0000) GS:ffff959f5fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557323588e70 CR3: 00000002dfa0a005 CR4: 00000000000206e0
Call Trace:
 btrfs_delete_unused_bgs+0x651/0x7a0 [btrfs]
 cleaner_kthread+0xef/0x120 [btrfs]
 ? btree_invalidatepage+0x40/0x40 [btrfs]
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
---[ end trace 6ad4eacda93c19a4 ]---
BTRFS: error (device sdb) in btrfs_remove_chunk:2989: errno=-28 No space left

After it goes read-only usage seems ok:
$ btrfs filesystem usage -T /mirror
Overall:
    Device size:                 382.02TiB
    Device allocated:            381.01TiB
    Device unallocated:            1.01TiB
    Device missing:                  0.00B
    Used:                        337.69TiB
    Free (estimated):             43.86TiB      (min: 43.86TiB)
    Free (statfs, df):            42.97TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

            Data      Metadata  System
Id Path     single    RAID1     RAID1    Unallocated
-- -------- --------- --------- -------- -----------
 1 /dev/sdb  27.22TiB  29.50GiB        -    33.51GiB
 2 /dev/sdc  27.20TiB  39.00GiB        -    43.00GiB
 3 /dev/sdd  36.28TiB  51.00GiB        -    57.00GiB
 4 /dev/sde  36.24TiB  63.00GiB        -    78.00GiB
 5 /dev/sdf  54.36TiB  98.02GiB 32.00MiB   121.05GiB
 6 /dev/sdg  54.26TiB 148.50GiB  4.00MiB   172.50GiB
 7 /dev/sdh  72.26TiB 247.52GiB 36.00MiB   269.55GiB
 8 /dev/sdi  72.29TiB 234.50GiB        -   256.51GiB
-- -------- --------- --------- -------- -----------
   Total    380.12TiB 911.04GiB 72.00MiB     1.01TiB
   Used     337.27TiB 432.68GiB 69.12MiB
