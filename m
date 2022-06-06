Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E353EBEF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbiFFP71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiFFP7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 11:59:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261E532EE
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654531165; x=1686067165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XihMd5DAln1AH2OMI6coYUM6OJw8YjCfaE8H8xsulAk=;
  b=UF+EI4Sd/botiUxrNr6dPD0REn1StC70bJJUwmDvfkYcSWQEHlyBOk5S
   me0aPU9XL7fEqlF7eBbB/JL+d4UQhzFVJAA5J+HnIfLsXaS9LbNb0QXcG
   vM37nspmf9AF+paX9fD7AbLTO6Ky96E6qc5kwi8IFxSD/mAj8BbushQIJ
   WqCM6AymyJrZokjflwgHQxBj9zultUswBg2efU2oBgIdC2D3U4oDdseQQ
   f731XRS/VQbFHdIU+EUzEB/oRBT/tJhUn52wRPLc9s1Xc4499Hjlswe6Z
   sihC/ZmJhSsT17d2aCe7DZYpEHurGh9+mkLU1niEMUJgEaMaxdS0G8oFN
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647273600"; 
   d="scan'208";a="203172774"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2022 23:59:24 +0800
IronPort-SDR: Kylj6QSPX9APVnwG1FwgoH408NM93SdhC7Yayvw6p27JRnagCSemMKUCqlIgPhBLunmh0aX46r
 kk1Rs4jTtMjm6em3Ziava7i05ECAjD5QW8ODCoFDAsqAFQHUpASKdv2ppCW7Is8UTDia8ctT6D
 pQ+dPaNnKWuoYvkQU8tpihnp7lvPA1xNMeQT05rLY1bVpNQz0b4dD+7/1bdztufptKD3R8Wler
 JH81wyoLic4AVllHbCxQ8rR0kxgIvNJ3XdcuR+eupBn/GnxXIKbfCUVzDF1d39W4TuUcvrHlxT
 DHQlgjTacHz2v97Kz35LYbpi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 08:18:21 -0700
IronPort-SDR: PCRli2oENQbwClwUabtI/nTIg/Z6uK1e/bydIUmtNzx5V6QQ3VQe6HxIZP8xSob0DCeqYz8ptb
 nhrRzJndKZIB8jpWHKGxbkOm3ndnh3BKix4IabjnTH69PUWCEP/0Ps5cmh2CR5ei/OCu2PTasF
 0grJxP00+ey3O7PgGxoxsh+y8ftJniKE9tHfRmAZVJygFkvn0coblymPaBAP1/hE72Xc1fDxYN
 4nnqGW50mXW2aPHNj5DmyXflwjcSuiDwUQGSk+DByUmpid8lw/4NOHDMijEtZv+qf8QxZs6AH8
 ysY=
WDCIronportException: Internal
Received: from 5cg2012pz0.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.70])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jun 2022 08:59:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] btrfs: zoned: fixes for data relocation
Date:   Tue,  7 Jun 2022 00:59:19 +0900
Message-Id: <cover.1654529962.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two long-standing potential bugs in the data relocation path of
zoned btrfs. They are recently revealed by commit 5f0addf7b890 ("btrfs:
zoned: use dedicated lock for data relocation"). One is a mixed issue of
WRITE (for relocation extents) and ZONE APPEND (for regular extent) at the
same time, which confuses the write pointer. The other one is a too short
critical section, which can cause an out-of-order issue of the IOs.

Actually, these bugs are easily reproducible with a smaller zone size (e.g,
128 MB) with fstests btrfs/232. For example, IO failures occurs like this:

  [99909.031820][T4038707] WARNING: CPU: 3 PID: 4038707 at fs/btrfs/extent-tree.c:2381 btrfs_cross_ref_exist+0xfc/0x120 [btrfs]
  <snip>
  [99909.268769][T4038707] Call Trace:
  [99909.272105][T4038707]  <TASK>
  [99909.275093][T4038707]  run_delalloc_nocow+0x7f1/0x11a0 [btrfs]
  [99909.280996][T4038707]  ? test_range_bit+0x174/0x320 [btrfs]
  [99909.286622][T4038707]  ? fallback_to_cow+0x980/0x980 [btrfs]
  [99909.292333][T4038707]  ? find_lock_delalloc_range+0x33e/0x3e0 [btrfs]
  [99909.298825][T4038707]  btrfs_run_delalloc_range+0x445/0x1320 [btrfs]
  [99909.305222][T4038707]  ? test_range_bit+0x320/0x320 [btrfs]
  [99909.310844][T4038707]  ? lock_downgrade+0x6a0/0x6a0
  [99909.315732][T4038707]  ? orc_find.part.0+0x1ed/0x300
  [99909.320705][T4038707]  ? __module_address.part.0+0x25/0x300
  [99909.326280][T4038707]  writepage_delalloc+0x159/0x310 [btrfs]
  <snip>
  [99909.883814][    C3] sd 10:0:1:0: [sde] tag#2620 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
  [99909.893855][    C3] sd 10:0:1:0: [sde] tag#2620 Sense Key : Illegal Request [current]
  [99909.901819][    C3] sd 10:0:1:0: [sde] tag#2620 Add. Sense: Unaligned write command
  [99909.909525][    C3] sd 10:0:1:0: [sde] tag#2620 CDB: Write(16) 8a 00 00 00 00 00 02 f3 63 87 00 00 00 2c 00 00
  [99909.919544][    C3] critical target error, dev sde, sector 396041272 op 0x1:(WRITE) flags 0x800 phys_seg 3 prio class 0
  [99909.930329][    C3] BTRFS error (device dm-1): bdev /dev/mapper/dml_102_2 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0

Or, an assertion failure occur like this:

  [   12.527832] assertion failed: start >= found_start && end <= found_end, in fs/btrfs/free-space-tree.c:737
  <snip>
  [   12.533391] Call Trace:
  [   12.533391]  <TASK>
  [   12.533391]  __remove_from_free_space_tree.cold+0x11/0x22 [btrfs]
  [   12.542073]  ? setup_items_for_insert.isra.0+0x2bf/0x3f0 [btrfs]
  [   12.542073]  remove_from_free_space_tree+0x80/0x110 [btrfs]
  [   12.542073]  alloc_reserved_file_extent+0x1b4/0x240 [btrfs]
  [   12.542073]  __btrfs_run_delayed_refs+0x692/0xf30 [btrfs]
  [   12.542073]  ? btrfs_btree_balance_dirty+0x2f/0x50 [btrfs]
  [   12.542073]  btrfs_run_delayed_refs+0x81/0x1e0 [btrfs]
  [   12.542073]  btrfs_commit_transaction+0x54/0xaf0 [btrfs]
  [   12.542073]  ? start_transaction+0xc2/0x5b0 [btrfs]
  [   12.542073]  ? _raw_read_lock_irqsave+0x20/0x40
  [   12.542073]  relocate_block_group+0x320/0x550 [btrfs]
  [   12.542073]  btrfs_relocate_block_group+0x1f9/0x3a0 [btrfs]
  [   12.542073]  btrfs_relocate_chunk+0x36/0xf0 [btrfs]
  [   12.542073]  btrfs_reclaim_bgs_work.cold+0x4f/0x74 [btrfs]
  [   12.542073]  process_one_work+0x1b0/0x310
  [   12.542073]  worker_thread+0x48/0x3d0
  [   12.542073]  ? rescuer_thread+0x3a0/0x3a0
  [   12.542073]  kthread+0xed/0x120
  [   12.550506]  ? kthread_complete_and_exit+0x20/0x20
  [   12.550506]  ret_from_fork+0x22/0x30
  [   12.550506]  </TASK>

This series fixes the two issues. The first one is fixed by introducing a
new btrfs_block_group bit to disallow extent allocation but still allow
nocow writes to start.

The second one is simply fixed by extending the critical section.

Naohiro Aota (2):
  btrfs: zoned: prevent allocation from previous data relocation BG
  btrfs: zoned: fix critical section of relocation inode writeback

 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/extent_io.c   |  3 ++-
 fs/btrfs/inode.c       |  2 ++
 fs/btrfs/zoned.c       | 27 +++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  5 +++++
 6 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.35.1

