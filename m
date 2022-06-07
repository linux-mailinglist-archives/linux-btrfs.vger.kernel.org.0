Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB36953F6DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiFGHIh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiFGHIf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 03:08:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEBD1E3F7
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654585715; x=1686121715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aALyWNcELypwYUCugnysYWwOoafyek5NydTzhXF+5O8=;
  b=cV/iN5nUeTOnGoS21PlAzc94+32wPl8luFH4EIh3r2osMheja2XRt8Oo
   cEWA/K5ddt3NoHzhUM5osTutjL8xfVKQxw2CRMQ21qtKoKUkrCOE02lO/
   M4NGzeULjQu23N+iuOz/BYa3W6m0riV6vvVqZ5VVWGdgu4MndeQp2h6BO
   g4U+RLffsi/fnSHTF8fu9ceq4Cf6t2h39iWp4uPFWVY1Jl+gG47BCkV+9
   sEjRJ0Jw6s0rIwnptr3yK0ku9JOM/4T4KNBtVC3NPqbfuJKaK/dr3pfID
   oRorH6TuOn+S4KO+98ZyQ5K97eYDBrk6nrK/122iohiehGELsWG74inLe
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="203238281"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 15:08:34 +0800
IronPort-SDR: zyez8wmk9Hqpor5Uy6PtwzXEabrxGFGCHiaiHIGIeAyk1EUDebExWTMv4/ZfsjAD9wdHAfWh8a
 ZGZmpmCex1Po6aCo4sdp/huPLLuMSJQJIpWgHwbyVcsjg7ZIr1yqTRs7/6iuh4d6WQE8fP66bG
 l1qd4I3bNeiNLr85CP5UO7WD16gXZOfKMKaBp1xP2v2xItELQ1aFNJxxiaA5mc4ryB+EWQKywk
 uab14NQh0FWXPgGX1IY4Pj+xeWIFmd9VhL4gaRCTvZqtwih5ighf2yk1B4YyQudsxlLFRvOQ+k
 X7UYxdkS2HFux5uyyM7tAEFk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 23:31:49 -0700
IronPort-SDR: ca3iMKfWXYSSjjXtnJx6WmaZu0xuFOdt+En2VY61SzzrAAo6F3F3Wa/Q7PDfpQs5jVB1vTPPPY
 UIBN9v5fFByQQEkBgVyKrKWvmidfSku04TqsAsjuQbbidaERM5M91DYJ9IPFiq2HG2u6uFYtn7
 CsgQPYfbcLUI/WT2ZsC1TZvOHlML98TvPHPMB36nisdFYBUhuDiIM7elC/MoGHZy7zKmL5gOiG
 yt8x25VZqEHA03LPqfOeJ/Uut1mq/bE+5P5bbmttS9It0C2TfQIlPP6/qs56baogJZGpumrskB
 hG0=
WDCIronportException: Internal
Received: from hr204m2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2022 00:08:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: fixes for data relocation
Date:   Tue,  7 Jun 2022 16:08:28 +0900
Message-Id: <cover.1654585425.git.naohiro.aota@wdc.com>
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

Changes:
  - v2:
    - fix block_group->zoned_data_reloc_ongoing to be a bit.

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

