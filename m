Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A4644820
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiLFPhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 10:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiLFPhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 10:37:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4D2CE0E
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 07:37:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so14285106plp.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wxy78.net; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zV1rx0G1rn1oji1Ln9JPRo2PS/wTrAiFgOzmBkVn7BY=;
        b=IVJHysr5XpANwjuhcG2o8u2PGJ9qTZ2SQlvT3S6eKjzXF84tK4URSVejdOwWGFUa6G
         wq78s4nJzmRzT8raxpL07HMZ62Ch2ATYHCG7MMLmrR63fDZaBngAKBhSGpcOkzMKgijz
         VaH0scUF2uXGkevDpYBDE3C37aJfDgKOzSW+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zV1rx0G1rn1oji1Ln9JPRo2PS/wTrAiFgOzmBkVn7BY=;
        b=vH2h4Q/bACZebzKZeuKSm85nFCm3i/PRHEhaXHU4p9rws4/JJPogtVGHHAI+XBywKd
         xEDs01J9+XsUAEqnshDVwhObUAVcoqU48DiKL/dAWGV4AJhGFlJNCb01nL06jcLSC9IZ
         0YIDogBlfmXhapkq4XvIqQWx1CkebTU//L5sowwFBMiMeO8gJPRFIbebL29lZVFeHMOS
         YvY+JoRf34XsqWNSOiP4rH1Q0QzZym23ui0ImMa3CmXfsaAoe4DzItCaRkyOZt1/7V6H
         AqsWAH6yXmi7c9+1A/dMK4V9AHPqIGsaTCDkG5RSxfLJGrFpttFccsUKGZrnKH8T0uad
         R/vw==
X-Gm-Message-State: ANoB5pm59UBiNOCkdvHfmFn6gf3HFALTLtgk8fMMfG+/f69xVVRtn/UN
        D689jRieyi0psOqBzVKRQR63FxfI5ILC6jkDm0H+0YFNTG/PoQfC
X-Google-Smtp-Source: AA0mqf5VbclSNP3seBWGA1KC0nd4H5KcfQdqdxTJkOCYUYVo8x1/M39YBQKgHIN0ngZ99dkvxPXTEDq6d6VqBTbv0Cg=
X-Received: by 2002:a17:902:740c:b0:189:d0fa:2314 with SMTP id
 g12-20020a170902740c00b00189d0fa2314mr12126931pll.91.1670341030411; Tue, 06
 Dec 2022 07:37:10 -0800 (PST)
MIME-Version: 1.0
From:   George Joseph <g.devel@wxy78.net>
Date:   Tue, 6 Dec 2022 08:36:54 -0700
Message-ID: <CAHKv19ANoAhh9xywNF1ma8oNL_T7KO4wwb2KiA4PaQepX-GdQA@mail.gmail.com>
Subject: Array stuck with balance in progress holding exclusive lock after
 kernel warning
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This discussion was started on #btrfs on IRC yesterday...

Summary:

I'm stuck where a RAID1C4 array is operational but thinks
there's a balance in progress. Attempts to cancel the balance
result in a transaction aborted kernel warning and the status
remains the same. I can't do any device operations because
the balance holds an exclusive lock.

Environment:
Fedora 37
Kernel 6.0.8
btrfs progs 6.0.2
8 drive RAID1C4 array

History:

I started a balance -dconvert=raid1c3,limit=10 on the array but after about 5
minutes and 10 relocated blocks, I got a kernel warning...

BTRFS info (device sdf): balance: start -dconvert=raid1c3,limit=10
BTRFS info (device sdf): relocating block group 24236929187840 flags
data|raid1c4
BTRFS info (device sdf): found 5 extents, stage: move data extents
BTRFS info (device sdf): found 5 extents, stage: update data pointers
BTRFS info (device sdf): relocating block group 24235855446016 flags
data|raid1c4
 <snip>
BTRFS info (device sdf): balance: ended with status: 0
------------[ cut here ]------------
BTRFS: Transaction aborted (error -22)
WARNING: CPU: 0 PID: 743355 at fs/btrfs/extent-tree.c:4117
find_free_extent+0x14b1/0x1510
<snip>
 <TASK>
 ? preempt_count_add+0x6a/0xa0
 btrfs_reserve_extent+0x13e/0x250
 __btrfs_prealloc_file_range+0x107/0x470
 cache_save_setup.isra.0+0x189/0x370
 btrfs_start_dirty_block_groups+0x1ec/0x5d0
 ? set_extent_buffer_dirty+0x15/0x130
 btrfs_commit_transaction+0x9b1/0xc90
 ? _raw_spin_unlock+0x15/0x30
 ? release_extent_buffer+0x169/0x1b0
 reset_balance_state+0x138/0x190
 btrfs_balance.cold+0x8e/0x318
 btrfs_ioctl+0x2832/0x2ca0
<snip>
BTRFS: error (device sdf: state A) in
find_free_extent_update_loop:4117: errno=-22 unknown
BTRFS info (device sdf: state EA): forced readonly
BTRFS warning (device sdf: state EA): Skipping commit of aborted transaction.

So I unmounted and remounted and even though the balance finished
successfully it auto resumed, probably because the transaction was aborted.

BTRFS info (device sdf): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdf): disk space caching is enabled
BTRFS info (device sdf): bdev /dev/sdf errs: wr 14, rd 3966, flush 0,
corrupt 0, gen 0
BTRFS info (device sdf): checking UUID tree
BTRFS info (device sdf): balance: resume -dconvert=raid1c3,soft,limit=10
BTRFS info (device sdf): relocating block group 24220823060480 flags
data|raid1c4
<snip>

This was the first I'd seen of write/read issues with /dev/sdf.

Then again...

BTRFS info (device sdf): balance: ended with status: 0
------------[ cut here ]------------
BTRFS: Transaction aborted (error -22)
WARNING: CPU: 1 PID: 754413 at fs/btrfs/extent-tree.c:4117
find_free_extent+0x14b1/0x1510
<snip>
? preempt_count_add+0x6a/0xa0
 btrfs_reserve_extent+0x13e/0x250
 __btrfs_prealloc_file_range+0x107/0x470
 cache_save_setup.isra.0+0x189/0x370
 btrfs_start_dirty_block_groups+0x1ec/0x5d0
 ? set_extent_buffer_dirty+0x15/0x130
 btrfs_commit_transaction+0x9b1/0xc90
 ? _raw_spin_unlock+0x15/0x30
 ? release_extent_buffer+0x169/0x1b0
 reset_balance_state+0x138/0x190
 btrfs_balance.cold+0x8e/0x318
 ? _raw_spin_unlock_irqrestore+0x23/0x40
 ? btrfs_balance+0xf50/0xf50
<snip>
BTRFS: error (device sdf: state A) in
find_free_extent_update_loop:4117: errno=-22 unknown
BTRFS info (device sdf: state EA): forced readonly
BTRFS warning (device sdf: state EA): Skipping commit of aborted transaction.

After a few rounds of this plus trying to cancel the balance
immediately after the mount
succeeded (which failed), I finally added 'skip_rebalance" to the mount options
and can get a good mount...

BTRFS info (device sdf): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdf): disk space caching is enabled
BTRFS info (device sdf): bdev /dev/sdf errs: wr 14, rd 3966, flush 0,
corrupt 0, gen 0
BTRFS info (device sdf): balance: resume skipped
BTRFS info (device sdf): checking UUID tree

However, any attempts to cancel the balance result in the same issue.
Any attempts to manipulate the array also fail...
# btrfs device remove /dev/sdf /data1
ERROR: unable to start device remove, another exclusive operation
'balance paused' in progress

I've tried upgrading to kernel 6.0.11 and downgrading to 5.15.81 with
no success.

At this point, I'm stuck. The array seems otherwise completely operational.
I can read and write to it with no errors.
smartctl shows no errors on any of the drives.

Other than copying all trhe data off the array and re-creating it, is there
anything else I can do?

Supporting Data:

First balance attempt and trace:
https://pastebin.com/WCf29wpc

Check output;

Opening filesystem to check...
Checking filesystem on /dev/sdi
UUID: 2290ceee-0ae7-4a89-af9a-1f1dbe00590f
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 4661827932160 bytes used, no error found
total csum bytes: 4520338612
total tree bytes: 31845138432
total fs tree bytes: 25980698624
total extent tree bytes: 739885056
btree space waste bytes: 6323238273
file data blocks allocated: 4630597627904
referenced 4630589636608

Usage:
Overall:
  Device size:  21.83TiB
  Device allocated:  17.26TiB
  Device unallocated:  4.57TiB
  Device missing:   0.00B
  Device slack:   0.00B
  Used:  16.94TiB
  Free (estimated):  1.22TiB (min: 1.22TiB)
  Free (statfs, df): 957.23GiB
  Data ratio:    4.00
  Metadata ratio:    4.00
  Global reserve: 512.00MiB (used: 0.00B)
  Multiple profiles:    yes (data)

      Data   Data  Metadata System
Id Path   RAID1C3 RAID1C4 RAID1C4 RAID1C4 Unallocated Total  Slack
-- -------- -------- ------- -------- -------- ----------- -------- -----
2 /dev/sdf 8.00GiB 2.13TiB 17.00GiB    -  583.52GiB 2.73TiB   -
3 /dev/sdb 6.00GiB 2.14TiB 16.00GiB 32.00MiB  585.49GiB 2.73TiB   -
7 /dev/sdh 8.00GiB 2.14TiB 16.00GiB    -  583.52GiB 2.73TiB   -
8 /dev/sdd 6.00GiB 2.14TiB 16.00GiB 32.00MiB  585.49GiB 2.73TiB   -
9 /dev/sdc 6.00GiB 2.13TiB 17.00GiB 32.00MiB  585.49GiB 2.73TiB   -
10 /dev/sdg 6.00GiB 2.13TiB 17.00GiB 32.00MiB  585.49GiB 2.73TiB   -
11 /dev/sde 7.00GiB 2.14TiB 15.00GiB    -  584.52GiB 2.73TiB   -
12 /dev/sdi 7.00GiB 2.14TiB 14.00GiB    -  584.52GiB 2.73TiB   -
-- -------- -------- ------- -------- -------- ----------- -------- -----
 Total  18.00GiB 4.27TiB 32.00GiB 32.00MiB   4.57TiB 21.83TiB 0.00B
 Used   16.94GiB 4.19TiB 29.66GiB 1.02MiB
