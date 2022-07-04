Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6D564CD8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiGDE7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiGDE65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:57 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15D6322
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910736; x=1688446736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZ8iZ6Ds6o4LNdZzKxneBuHgIAcCSIPTK4CUbY/sFxM=;
  b=dsS2PRlPRYAFgdGQHRnQWcH3YXTRa/65/Qz2UGu2yi7o2nwJ7S1etkhB
   7MrgsendeHxz0nMj9vjNZgcHlDTYytgBcY+Dep2zVARJAArQEUCN7BD8p
   RvrfYmY1zc7sttLLnKQum9QR5uN4rlfuKJFyJgQQ5ZRQkg4q+HLaTGhbB
   v1giJ84VBiIyLi+RxiATpnZNFmhNMz1Eg/wZmnGEtHZ4KISYfS83mWtIe
   vmtCHgoczLlsjNdPjCsKqtiEQVH/C6KcqbthhaCHz2HYeMdJtvkoZ7WXx
   nTrOoepuNEit7J+z6lPNZVbBPup1aRV7KWiLfz9Nf2gU94Cw/+LzOWksC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:56 +0800
IronPort-SDR: xqNMhiWCjnVmImnJnCIDbcnljfvforuRYMij+ZBi+uP/+xi5KOSU8as5xrQn4OXUAPk+OyEHW4
 3tTJuDzi2f4wGFUvC4SWCGj/40v03BqqWm15z9+6m/dJPw6oSudz1vWKeQBJrZyba0J2+2yrbN
 j75w7f91LzujLaKvSeEh+2x6Fz2zTqjop4NNJqB5CyGioFvATs8AIIG9bHXDB+2g1MhxXri1+c
 8C0rc5lNiW3l5YsaR/PkCXZgNkhoqa3REUMaXp57JGoCi9X7tds1JAAQNnBabZF5Tjp9Sfl92A
 0psm/NCbKtNEHiMWPAMg+hH3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:49 -0700
IronPort-SDR: ELbWEm+XjGUS8LA/LaCaT7kooud1b/mgCiqzNY0mW7zutZbQCmNRKFTkAT10TGdj2ig/UYdguT
 0uoozp21uizKHcoCklnP+whMzW+NRb9SdwuMSTzZpleVNw8PWYNgfojNLlRlGY5quVxwXussec
 Q8ol+DPu/jWYAtvcrUshul1TRp7tF0uc/80yM6f6peynf3npjN03P9+mD8su0dUF+dU+9m+R83
 oeEzVpxprdc+3dTXfu8IT0LC/xj9UKLbcym//1h+Laq6nCvkHVkxmJSU9ca6h2bOG1xzl2WdBT
 kN0=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/13] btrfs: zoned: wait until zone is finished when allocation didn't progress
Date:   Mon,  4 Jul 2022 13:58:17 +0900
Message-Id: <756120a8d4216aff3426a670385182f40421bdc0.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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

When the allocated position doesn't progress, we cannot submit IOs to
finish a block group, but there should be ongoing IOs that will finish a
block group. So, in that case, we wait for a zone to be finished and retry
the allocation after that.

Introduce a new flag BTRFS_FS_NEED_ZONE_FINISH for fs_info->flags to
indicate we need a zone finish to have proceeded. The flag is set when the
allocator detected it cannot activate a new block group. And, it is cleared
once a zone is finished.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h   | 4 ++++
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/inode.c   | 9 +++++++--
 fs/btrfs/zoned.c   | 6 ++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4aac7df5a17d..bace2f2eb9d5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -638,6 +638,9 @@ enum {
 	/* Indicate we have half completed snapshot deletions pending. */
 	BTRFS_FS_UNFINISHED_DROPS,
 
+	/* Indicate we have to finish a zone to do next allocation. */
+	BTRFS_FS_NEED_ZONE_FINISH,
+
 #if BITS_PER_LONG == 32
 	/* Indicate if we have error/warn message printed on 32bit systems */
 	BTRFS_FS_32BIT_ERROR,
@@ -1084,6 +1087,7 @@ struct btrfs_fs_info {
 
 	spinlock_t zone_active_bgs_lock;
 	struct list_head zone_active_bgs;
+	wait_queue_head_t zone_finish_wait;
 
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ef9d28147b9e..b76b7ef6d85d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3131,6 +3131,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	init_waitqueue_head(&fs_info->transaction_blocked_wait);
 	init_waitqueue_head(&fs_info->async_submit_wait);
 	init_waitqueue_head(&fs_info->delayed_iputs_wait);
+	init_waitqueue_head(&fs_info->zone_finish_wait);
 
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 163f3d995f00..d5f27cd1eef2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1643,8 +1643,13 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 		if (ret == 0)
 			done_offset = end;
 
-		if (done_offset == start)
-			return -ENOSPC;
+		if (done_offset == start) {
+			struct btrfs_fs_info *info = inode->root->fs_info;
+
+			wait_var_event(&info->zone_finish_wait,
+				       !test_bit(BTRFS_FS_NEED_ZONE_FINISH, &info->flags));
+			continue;
+		}
 
 		if (!locked_page_done) {
 			__set_page_dirty_nobuffers(locked_page);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6441a311e658..3503dd29eab0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2015,6 +2015,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	/* For active_bg_list */
 	btrfs_put_block_group(block_group);
 
+	clear_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
+	wake_up_all(&fs_info->zone_finish_wait);
+
 	return 0;
 }
 
@@ -2051,6 +2054,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	}
 	mutex_unlock(&fs_info->chunk_mutex);
 
+	if (!ret)
+		set_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
+
 	return ret;
 }
 
-- 
2.35.1

