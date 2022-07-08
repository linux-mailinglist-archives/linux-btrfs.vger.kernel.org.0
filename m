Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24F56C52D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiGHXTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiGHXTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AC4198E;
        Fri,  8 Jul 2022 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322357; x=1688858357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pc1V+hc3nLWgOYR+olBZbWKKUSmpRc4Pzg4j2XhZTsc=;
  b=d3s20VfXAQpo7EUYJhov3LbnxmCHb0PsxoC/WVTpNulf9jSSbvFvjrX5
   fLrCi/+D8vibq94+rLMT4VDL9+vzkdma8SBZDWAaPZ6CyzfFiHtn+gJ9l
   uDyKq8qcXXk8PLl0NQun8IM0o8nlQJW2LVhs70HZQ/l/4A2y49vv+kz7X
   yzJBXZ0ap1fbn/heJM1GeKTsDVhSEiNi/RTLnm7EnO7H3fbMBBoos5QN7
   mJRdUXv99KFmTJGG5tlvMQVTIxlCZLQdIOYhwuLKQDlB0ofVYXXu9F96y
   LQAw+aaGliTD/NCpMXj+8Bp2AZkGQwITCAzgJQIYSBrztW6r641GH4Mv3
   A==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871836"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:17 +0800
IronPort-SDR: fwdJIj+8vtiTFBvlPVAfN0DqXZKVziEowQ7etfKPZRKh73SWByZie0zT/mpN7CnY2plsLVfBiu
 RqwTibA29BCC6ZCwybuwO8/5g+36BYAMDkJRr091DV/W9IUBkeEa9+e1Dg1DbZSmy2m10eJ6Ls
 E+MRqMwoTKksf3WYG0BBk7/KNJpNAFLTVSfU3NGOg8gGd9MKoRfbpV96BbnCtqHvkIsM1aLgi5
 71oVWYhGfNDI0qxuHBYvmeJ8qX8XGE2MQOPGnZ1hfSRs8Mdx34rbtxnTj599t75g28uvv5yNTn
 0XCbYX1IqusGBtSZNZlBWJvT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:22 -0700
IronPort-SDR: +9lmFEz7PD2i02CoLXx4j06g+16XdH2CuHirM0FvmwbCBHG2fyHc+zVwAHy36SYa2yi+VWKrxj
 I63ZtHTp7uTQeVcTPy1hkz1Z5NjNnb54fjQbKIKAf7eCh/U58BjqYGrr9Gq+pTslKbcxLnricQ
 x8bFZ1wpLx1XxAOHPlnPwfYEU90FoT98SR4j0+/MDBdrCIddvaqenaV61Wx0wwBmcJWbS7NhOM
 q6YlgwAh93M3B+6VNqT6A2TtM42zDl6DvSC+oo7cECDSQiTAn/kXKWyP4keIltwyCXeli1Ze82
 cwI=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/13] btrfs: zoned: wait until zone is finished when allocation didn't progress
Date:   Sat,  9 Jul 2022 08:18:50 +0900
Message-Id: <bfda89d79a418ce9bdb68bf3f444a95a04b63181.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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
index c215e15baea2..ddecd92fa848 100644
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
index 914557d59472..1fe5f79770a0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3135,6 +3135,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	init_waitqueue_head(&fs_info->transaction_blocked_wait);
 	init_waitqueue_head(&fs_info->async_submit_wait);
 	init_waitqueue_head(&fs_info->delayed_iputs_wait);
+	init_waitqueue_head(&fs_info->zone_finish_wait);
 
 	/* Usable values until the real ones are cached from the superblock */
 	fs_info->nodesize = 4096;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 681e2cb4dd9c..815121350d91 100644
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
index 67098f3fcd14..471d870875ed 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2006,6 +2006,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	/* For active_bg_list */
 	btrfs_put_block_group(block_group);
 
+	clear_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
+	wake_up_all(&fs_info->zone_finish_wait);
+
 	return 0;
 }
 
@@ -2042,6 +2045,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	}
 	mutex_unlock(&fs_info->chunk_mutex);
 
+	if (!ret)
+		set_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
+
 	return ret;
 }
 
-- 
2.35.1

