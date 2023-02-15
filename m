Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD0697E72
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBOOeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBOOeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:07 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8539286
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471646; x=1708007646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOhqtTpOJUlLWBsw3r78n/BqZyjAZL3yWe9ThQ3HzjA=;
  b=SOrJGbLU/iHB1vwtSiqSuWmdKzhsOfQPLGqLHhfpEKXeb+mXWrSS0J5y
   mo/huwBXD6tro2rrLJdctu+fYa55yv9mQ1OXty03rHaquuoeHjpUVgyEd
   On5+bum0PaTaEruKAtZfjzZjo+aZlrJ2DyF0t/qa6MEDwiq1cVxTVLa6C
   b95E8PF5qoUaF7fMIKklfopl2TAhaw0HSkjNWJm8aAgOZ8oG3bX0Oc2cO
   /JzjDudEWfnO5KGA02TJrKoPH9aMRGFmLTzbDO/RyVV/EtACOFxeU3RxP
   3tPuZQCDJy786V3tM6co/h9NjZ6mklAuXe2l9UhiCVNOFxB5w8E0cyq/X
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394072"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:46 +0800
IronPort-SDR: CouU2ECZb/IhORaDSp/8RE+rN4Z2T4SJ0LZjvfrERgfVkw59JJPDGnZCTUhTF+LuJIPZFCtCs1
 sPwDTpZQ2AZQxz3Np1rhQg+v4uADBgfTDdcsCdTChI1QCxJnIcehpUIA/kOBhcUToLahS2Zs9o
 RuAiCEokoeMjwCoOae5nI/BSbwjupZwTMBxqS09mceob7/NqowEktmm/+xxI2eNRb7fmLgisHk
 2HSmHM4Ekgb+m8BOUIbIU0dBNH2FjCrQ0YxFXhK4DMoMt6CvE/oBmz59jfN6NZqJ016+kmsVli
 9mw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:08 -0800
IronPort-SDR: l8ojY+DwRUWPQQVXFwTCgvSsz/GAom1rffWnsZhSAVIRdlrTNxo4j3g7ZYnNX0qYdO1qGcEmEF
 UX6HlHquE6OsxMS20d0FHFKmSwcaKMXWZQOO1oFaOlvR8qm3zxT345cZiaYfj2xGTse4RlQ8YT
 SwC5HsmRtUiKflDlHb+2FjbRPeulV52tfi3KGD0AZbUbpbpEJ+zt6/f2SvKRWtKVXCkc8dwmZd
 k29mWAaxG6T+1MMa7/fMBG3c/W+/fX4erfIoMNV2y7L6pDLotYYsTqgxapT72/8PahtTvoE7XA
 tSM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:47 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 09/13] btrfs: check for leaks of ordered stripes on umount
Date:   Wed, 15 Feb 2023 06:33:30 -0800
Message-Id: <f615146176ed5ff7686c36710bc3cd7f613d6203.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check if we're leaking any ordered stripes when unmounting a filesystem
with an stripe tree.

This check is gated behind CONFIG_BTRFS_DEBUG to not affect any production
type systems.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c          |  2 ++
 fs/btrfs/raid-stripe-tree.c | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  1 +
 3 files changed, 33 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8f625cc6738d..181638af3c81 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -1522,6 +1523,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
+	btrfs_check_ordered_stripe_leak(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 836299fe0ebe..391f69effd90 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -36,6 +36,36 @@ static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
 	return ordered_stripe_cmp(&stripe->logical, rbb);
 }
 
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info)
+{
+#ifdef CONFIG_BTRFS_DEBUG
+	struct rb_node *node;
+
+	if (!btrfs_stripe_tree_root(fs_info) ||
+	    RB_EMPTY_ROOT(&fs_info->stripe_update_tree))
+		return;
+
+	WARN_ON_ONCE(1);
+	write_lock(&fs_info->stripe_update_lock);
+	while ((node = rb_first_postorder(&fs_info->stripe_update_tree))
+	       != NULL) {
+		struct btrfs_ordered_stripe *stripe =
+			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+
+		write_unlock(&fs_info->stripe_update_lock);
+		btrfs_err(fs_info,
+			  "ordered_stripe [%llu, %llu] leaked, refcount=%d",
+			  stripe->logical, stripe->logical + stripe->num_bytes,
+			  refcount_read(&stripe->ref));
+		while (refcount_read(&stripe->ref) > 1)
+			btrfs_put_ordered_stripe(fs_info, stripe);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+		write_lock(&fs_info->stripe_update_lock);
+	}
+	write_unlock(&fs_info->stripe_update_lock);
+#endif
+}
+
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index c7f6c5377aaa..371409351d60 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -38,6 +38,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc);
 void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 					    struct btrfs_ordered_stripe *stripe);
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 						 u64 map_type)
-- 
2.39.0

