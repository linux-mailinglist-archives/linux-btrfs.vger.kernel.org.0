Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86554ED7D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiCaKgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiCaKgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 06:36:03 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF9C60040;
        Thu, 31 Mar 2022 03:34:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 6A9131E80D79;
        Thu, 31 Mar 2022 18:33:43 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x1R5h9nOxo0c; Thu, 31 Mar 2022 18:33:40 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id E8F911E80D77;
        Thu, 31 Mar 2022 18:33:39 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] btrfs: remove unnecessary type castings
Date:   Thu, 31 Mar 2022 03:34:08 -0700
Message-Id: <20220331103408.31867-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/btrfs/check-integrity.c | 2 +-
 fs/btrfs/disk-io.c         | 4 ++--
 fs/btrfs/inode.c           | 2 +-
 fs/btrfs/ioctl.c           | 4 ++--
 fs/btrfs/relocation.c      | 2 +-
 fs/btrfs/scrub.c           | 2 +-
 fs/btrfs/space-info.c      | 2 +-
 fs/btrfs/subpage.c         | 2 +-
 fs/btrfs/volumes.c         | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index abac86a75840..62eb149aac98 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2033,7 +2033,7 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 
 static void btrfsic_bio_end_io(struct bio *bp)
 {
-	struct btrfsic_block *block = (struct btrfsic_block *)bp->bi_private;
+	struct btrfsic_block *block = bp->bi_private;
 	int iodone_w_error;
 
 	/* mutex is not held! This is not save if IO is not yet completed
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b30309f187cf..51f7ad6cadce 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1963,7 +1963,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
 
 static int cleaner_kthread(void *arg)
 {
-	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)arg;
+	struct btrfs_fs_info *fs_info = arg;
 	int again;
 
 	while (1) {
@@ -3293,7 +3293,7 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 
 static int btrfs_uuid_rescan_kthread(void *data)
 {
-	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)data;
+	struct btrfs_fs_info *fs_info = data;
 	int ret;
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa0a60ee26cb..6eafb46eadae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8951,7 +8951,7 @@ int btrfs_drop_inode(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct btrfs_inode *ei = (struct btrfs_inode *) foo;
+	struct btrfs_inode *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 238cee5b5254..c05a2afb74a7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2593,7 +2593,7 @@ static noinline int btrfs_ioctl_tree_search(struct inode *inode,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	uargs = (struct btrfs_ioctl_search_args __user *)argp;
+	uargs = argp;
 
 	if (copy_from_user(&sk, &uargs->key, sizeof(sk)))
 		return -EFAULT;
@@ -2627,7 +2627,7 @@ static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
 		return -EPERM;
 
 	/* copy search header and buffer size */
-	uarg = (struct btrfs_ioctl_search_args_v2 __user *)argp;
+	uarg = argp;
 	if (copy_from_user(&args, uarg, sizeof(args)))
 		return -EFAULT;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fdc2c4b411f0..13befafab3b4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -362,7 +362,7 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 	rb_node = rb_simple_search(&rc->reloc_root_tree.rb_root, bytenr);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct mapping_node, rb_node);
-		root = (struct btrfs_root *)node->data;
+		root = node->data;
 	}
 	spin_unlock(&rc->reloc_root_tree.lock);
 	return btrfs_grab_root(root);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 11089568b287..e338e3f9a0b5 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2798,7 +2798,7 @@ static void scrub_parity_bio_endio_worker(struct btrfs_work *work)
 
 static void scrub_parity_bio_endio(struct bio *bio)
 {
-	struct scrub_parity *sparity = (struct scrub_parity *)bio->bi_private;
+	struct scrub_parity *sparity = bio->bi_private;
 	struct btrfs_fs_info *fs_info = sparity->sctx->fs_info;
 
 	if (bio->bi_status)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b87931a458eb..4de2c82051b1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -519,7 +519,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 		items = calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
 	}
 
-	trans = (struct btrfs_trans_handle *)current->journal_info;
+	trans = current->journal_info;
 
 	/*
 	 * If we are doing more ordered than delalloc we need to just wait on
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ef7ae20d2b77..45fbc9e20715 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -127,7 +127,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 	if (fs_info->sectorsize == PAGE_SIZE || !PagePrivate(page))
 		return;
 
-	subpage = (struct btrfs_subpage *)detach_page_private(page);
+	subpage = detach_page_private(page);
 	ASSERT(subpage);
 	btrfs_free_subpage(subpage);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1be7cb2f955f..c7a6d290e67b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8295,7 +8295,7 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 
 static int relocating_repair_kthread(void *data)
 {
-	struct btrfs_block_group *cache = (struct btrfs_block_group *)data;
+	struct btrfs_block_group *cache = data;
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	u64 target;
 	int ret = 0;
-- 
2.25.1

