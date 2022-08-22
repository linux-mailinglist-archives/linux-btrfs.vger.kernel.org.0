Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2159B8F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiHVGHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 02:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiHVGHf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 02:07:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29C20BD6;
        Sun, 21 Aug 2022 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661148453; x=1692684453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hIkwkxIMjj+KmUxWuj4AZ2CfKVevOek9VoyC7GhwxAs=;
  b=CsMViirKBomy3lBoVTNCFdwY9URFNOIQ0UgcogtT3jaII1k8Kxpq9clL
   JlonqGyWghh4TMPowMK74iBITR/QceNgOWAdCVUNEevAIB5BJgZCH5odO
   0hbw3ohJD4gSCCCzRvdjUW8CdD0YpWDpitc9SwYWJmIOq9qppaC9Pg5c3
   Mbyz5JJLtRMXFByiurph3DOuQNJolmXDGcCOl0O8ifCwFiu5gdhMSt93K
   G/Wwo0M8tk2s2QgAYZ2Fb2ykyMAbtIBhJr8p8+jP+zIW/c0ZEXT6rogNo
   J7QR/rvG41T/1P0ETq3WlIeP5Xg4TLzhhDqYiDLbkyFWF+aKzREAMyCuL
   w==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654531200"; 
   d="scan'208";a="321397077"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 14:07:33 +0800
IronPort-SDR: Gf9+nboEtznytUOB3UJjoBXECjCbvNr1L39xJcnI2rJfmiyxxXal9Z0CBvymkcjOqcj3RZhLA0
 PhA86HKdGjXtKcBlbTqT+pd2Lb5OhyD64PFGwwONS9REkSYnroVrHgFzmPsT8yM09fBn8s4Jmx
 ElPrMOYA15x1UV2KoGFr6yvcRgRx2T9GCPGCYd76oOBJTj03crhIJXvDHnDUvnKKc4WsInQgWU
 2RAuL4sqD5REv15f10wJzCtfQYp3AmTnmNf4ra0QW3vCYODD6pAk+Y3D92QN3McklCGQi2XpVi
 SbfN7j9W9fjRQj5iLYVO2S3f
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2022 22:28:15 -0700
IronPort-SDR: k6DZBFDxI09ywmjmclXwWGBDv6xWVqAtQS4GLVx5rwGv9FWEt+P+WoRQsGeFqakAKz+NPFcfP5
 xfwLMrdSNNCLKO1K0n9kZ5ZAqBQU/dukdPGTLva5u/iyJMAg99KKSoPsr54+PbQ5CGNPXBR8ta
 u+vkIJKFxlrrtHTD98irA/S8xcCMtiDcyeoyt2IG7r/2fFy/pHAAI0OpMxhRTlt0D+Mz0eiOLk
 92hAZroG+h/+L4AJBJHNwFXQRiWl9AEFF5Vl6CRV0V5pEPzUzUvCcX0kUEhQNYJjDVxMI9BogU
 WTY=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.50.191])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2022 23:07:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH STABLE 5.15 4/5] btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size
Date:   Mon, 22 Aug 2022 15:07:03 +0900
Message-Id: <20220822060704.1278361-5-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822060704.1278361-1-naohiro.aota@wdc.com>
References: <20220822060704.1278361-1-naohiro.aota@wdc.com>
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

commit f7b12a62f008a3041f42f2426983e59a6a0a3c59 upstream

On zoned filesystem, data write out is limited by max_zone_append_size,
and a large ordered extent is split according the size of a bio. OTOH,
the number of extents to be written is calculated using
BTRFS_MAX_EXTENT_SIZE, and that estimated number is used to reserve the
metadata bytes to update and/or create the metadata items.

The metadata reservation is done at e.g, btrfs_buffered_write() and then
released according to the estimation changes. Thus, if the number of extent
increases massively, the reserved metadata can run out.

The increase of the number of extents easily occurs on zoned filesystem
if BTRFS_MAX_EXTENT_SIZE > max_zone_append_size. And, it causes the
following warning on a small RAM environment with disabling metadata
over-commit (in the following patch).

[75721.498492] ------------[ cut here ]------------
[75721.505624] BTRFS: block rsv 1 returned -28
[75721.512230] WARNING: CPU: 24 PID: 2327559 at fs/btrfs/block-rsv.c:537 btrfs_use_block_rsv+0x560/0x760 [btrfs]
[75721.581854] CPU: 24 PID: 2327559 Comm: kworker/u64:10 Kdump: loaded Tainted: G        W         5.18.0-rc2-BTRFS-ZNS+ #109
[75721.597200] Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.0 02/22/2021
[75721.607310] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[75721.616209] RIP: 0010:btrfs_use_block_rsv+0x560/0x760 [btrfs]
[75721.646649] RSP: 0018:ffffc9000fbdf3e0 EFLAGS: 00010286
[75721.654126] RAX: 0000000000000000 RBX: 0000000000004000 RCX: 0000000000000000
[75721.663524] RDX: 0000000000000004 RSI: 0000000000000008 RDI: fffff52001f7be6e
[75721.672921] RBP: ffffc9000fbdf420 R08: 0000000000000001 R09: ffff889f8d1fc6c7
[75721.682493] R10: ffffed13f1a3f8d8 R11: 0000000000000001 R12: ffff88980a3c0e28
[75721.692284] R13: ffff889b66590000 R14: ffff88980a3c0e40 R15: ffff88980a3c0e8a
[75721.701878] FS:  0000000000000000(0000) GS:ffff889f8d000000(0000) knlGS:0000000000000000
[75721.712601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[75721.720726] CR2: 000055d12e05c018 CR3: 0000800193594000 CR4: 0000000000350ee0
[75721.730499] Call Trace:
[75721.735166]  <TASK>
[75721.739886]  btrfs_alloc_tree_block+0x1e1/0x1100 [btrfs]
[75721.747545]  ? btrfs_alloc_logged_file_extent+0x550/0x550 [btrfs]
[75721.756145]  ? btrfs_get_32+0xea/0x2d0 [btrfs]
[75721.762852]  ? btrfs_get_32+0xea/0x2d0 [btrfs]
[75721.769520]  ? push_leaf_left+0x420/0x620 [btrfs]
[75721.776431]  ? memcpy+0x4e/0x60
[75721.781931]  split_leaf+0x433/0x12d0 [btrfs]
[75721.788392]  ? btrfs_get_token_32+0x580/0x580 [btrfs]
[75721.795636]  ? push_for_double_split.isra.0+0x420/0x420 [btrfs]
[75721.803759]  ? leaf_space_used+0x15d/0x1a0 [btrfs]
[75721.811156]  btrfs_search_slot+0x1bc3/0x2790 [btrfs]
[75721.818300]  ? lock_downgrade+0x7c0/0x7c0
[75721.824411]  ? free_extent_buffer.part.0+0x107/0x200 [btrfs]
[75721.832456]  ? split_leaf+0x12d0/0x12d0 [btrfs]
[75721.839149]  ? free_extent_buffer.part.0+0x14f/0x200 [btrfs]
[75721.846945]  ? free_extent_buffer+0x13/0x20 [btrfs]
[75721.853960]  ? btrfs_release_path+0x4b/0x190 [btrfs]
[75721.861429]  btrfs_csum_file_blocks+0x85c/0x1500 [btrfs]
[75721.869313]  ? rcu_read_lock_sched_held+0x16/0x80
[75721.876085]  ? lock_release+0x552/0xf80
[75721.881957]  ? btrfs_del_csums+0x8c0/0x8c0 [btrfs]
[75721.888886]  ? __kasan_check_write+0x14/0x20
[75721.895152]  ? do_raw_read_unlock+0x44/0x80
[75721.901323]  ? _raw_write_lock_irq+0x60/0x80
[75721.907983]  ? btrfs_global_root+0xb9/0xe0 [btrfs]
[75721.915166]  ? btrfs_csum_root+0x12b/0x180 [btrfs]
[75721.921918]  ? btrfs_get_global_root+0x820/0x820 [btrfs]
[75721.929166]  ? _raw_write_unlock+0x23/0x40
[75721.935116]  ? unpin_extent_cache+0x1e3/0x390 [btrfs]
[75721.942041]  btrfs_finish_ordered_io.isra.0+0xa0c/0x1dc0 [btrfs]
[75721.949906]  ? try_to_wake_up+0x30/0x14a0
[75721.955700]  ? btrfs_unlink_subvol+0xda0/0xda0 [btrfs]
[75721.962661]  ? rcu_read_lock_sched_held+0x16/0x80
[75721.969111]  ? lock_acquire+0x41b/0x4c0
[75721.974982]  finish_ordered_fn+0x15/0x20 [btrfs]
[75721.981639]  btrfs_work_helper+0x1af/0xa80 [btrfs]
[75721.988184]  ? _raw_spin_unlock_irq+0x28/0x50
[75721.994643]  process_one_work+0x815/0x1460
[75722.000444]  ? pwq_dec_nr_in_flight+0x250/0x250
[75722.006643]  ? do_raw_spin_trylock+0xbb/0x190
[75722.013086]  worker_thread+0x59a/0xeb0
[75722.018511]  kthread+0x2ac/0x360
[75722.023428]  ? process_one_work+0x1460/0x1460
[75722.029431]  ? kthread_complete_and_exit+0x30/0x30
[75722.036044]  ret_from_fork+0x22/0x30
[75722.041255]  </TASK>
[75722.045047] irq event stamp: 0
[75722.049703] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[75722.057610] hardirqs last disabled at (0): [<ffffffff8118a94a>] copy_process+0x1c1a/0x66b0
[75722.067533] softirqs last  enabled at (0): [<ffffffff8118a989>] copy_process+0x1c59/0x66b0
[75722.077423] softirqs last disabled at (0): [<0000000000000000>] 0x0
[75722.085335] ---[ end trace 0000000000000000 ]---

To fix the estimation, we need to introduce fs_info->max_extent_size to
replace BTRFS_MAX_EXTENT_SIZE, which allow setting the different size for
regular vs zoned filesystem.

Set fs_info->max_extent_size to BTRFS_MAX_EXTENT_SIZE by default. On zoned
filesystem, it is set to fs_info->max_zone_append_size.

CC: stable@vger.kernel.org # 5.12+
Fixes: d8e3fb106f39 ("btrfs: zoned: use ZONE_APPEND write for zoned mode")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h     | 6 ++++++
 fs/btrfs/disk-io.c   | 2 ++
 fs/btrfs/extent_io.c | 4 +++-
 fs/btrfs/inode.c     | 6 ++++--
 fs/btrfs/zoned.c     | 5 ++++-
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 099c30477cf2..e751eb1b5514 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -999,6 +999,12 @@ struct btrfs_fs_info {
 	u32 csums_per_leaf;
 	u32 stripesize;
 
+	/*
+	 * Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular
+	 * filesystem, on zoned it depends on the device constraints.
+	 */
+	u64 max_extent_size;
+
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e65c3039caf1..247d7f9ced3b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3006,6 +3006,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
+	fs_info->max_extent_size = BTRFS_MAX_EXTENT_SIZE;
+
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a90546b3107c..41862045b3de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1985,8 +1985,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 				    struct page *locked_page, u64 *start,
 				    u64 *end)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	u64 max_bytes = BTRFS_MAX_EXTENT_SIZE;
+	/* The sanity tests may not set a valid fs_info. */
+	u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;
 	u64 delalloc_start;
 	u64 delalloc_end;
 	bool found;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 20d0dea1d0c4..91417cdbf70d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2032,6 +2032,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 size;
 
 	/* not delalloc, ignore it */
@@ -2039,7 +2040,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 		return;
 
 	size = orig->end - orig->start + 1;
-	if (size > BTRFS_MAX_EXTENT_SIZE) {
+	if (size > fs_info->max_extent_size) {
 		u32 num_extents;
 		u64 new_size;
 
@@ -2068,6 +2069,7 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 				 struct extent_state *other)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 new_size, old_size;
 	u32 num_extents;
 
@@ -2081,7 +2083,7 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
 		new_size = other->end - new->start + 1;
 
 	/* we're not bigger than the max, unreserve the space and go */
-	if (new_size <= BTRFS_MAX_EXTENT_SIZE) {
+	if (new_size <= fs_info->max_extent_size) {
 		spin_lock(&BTRFS_I(inode)->lock);
 		btrfs_mod_outstanding_extents(BTRFS_I(inode), -1);
 		spin_unlock(&BTRFS_I(inode)->lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bfbceb94c4e2..7a127d3c521f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -670,8 +670,11 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->max_zone_append_size = ALIGN_DOWN(max_zone_append_size,
+						   fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
+	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
+		fs_info->max_extent_size = fs_info->max_zone_append_size;
 
 	/*
 	 * Check mount options here, because we might change fs_info->zoned
-- 
2.37.2

