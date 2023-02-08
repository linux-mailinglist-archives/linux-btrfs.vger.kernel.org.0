Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8268ED68
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBHK6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHK6D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:03 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA37113DDE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853882; x=1707389882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDSC7QZ7gl2/8xr/fpmdU9u2tvW8IXXjHfrdTCN8mlQ=;
  b=P3X3iqVJtu4mBO7nj10hLvytWxyCjMobp2m8MGEGYLlyoXw1ZjNbApJZ
   cfsGtp9r8pr7Hruii7juaQA+3En1zHs5MkL7LUi7VPNmRcAc40r0ZA2sK
   6RSP9+BLYfF+v0N2tQfW5UTCd6pyuqP7/OHyPeaBA4q7KxTdf89rAet9+
   8tPqXV181QXTgilc/N3PDzjjdsbScLcH0w1+ctYo6qLEOAt7E0Ygwbh6S
   EExw+jf6mbxzbtFg8GUaS9QWX+TW6l5UDH9R/sUUuV60SLkp+6SdJFF/r
   xmk+DLcOYNSoBaFxziepG7eDyhBFAnHCJ4+3Swsw+Q73KehWP6iA0ItvA
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115641"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:01 +0800
IronPort-SDR: 134QBTgmmymvUDKry1Flwy+b8UmPuMS1/t7uC728V8km8ZfB6FKcBWq/1hVhuMix1uXFIBvt0M
 8NRd1Fzb68k1Rv5pJBCHopHebPFPd7rBQ8RDqO6dBGW58AOLTSGhFncx4XOOGeq17jMMHudl2t
 DvYa3ecFkSfKxvArel8pWltCu3n2WBSoAJM/hvloxzrjyoEfEMi+BGK7uaiJKqXZpAX9YeAoJe
 Q6C/giY45CmoOMmRjRdtVP8jlgX3dQPaEcHLyT8R3O4JgSD41mxqeD918sa7CYFfuTSLzCW1hC
 xfM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:17 -0800
IronPort-SDR: zDowUkgHzqoWjadgupYPsJ5fjxFcNmsYoe7BeZX/GKTSAzaTksuiuBanbqyFbrGefdx2021M2a
 bAtbjkCTjuO5wYldv6KcSJ+GCrnLVf7OslQdAqKm6/1eLwluOglAD8ntxK3yNePLJ7VuiPdULx
 wJzdtWJCS1G2Yd0k4HvcNRMPlsMR6PlREXB5FjpXikjKl08gY1uCA/zD4MJ8Y8duphZmi4pRwS
 59j7vO/2zaKKfdLW80/PYmXgrbXDl3xVM9ZKXPGExjx4+Ne7nIdW/HcB6NGRqL4D7/a0GGhSya
 87Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:02 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 09/13] btrfs: check for leaks of ordered stripes on umount
Date:   Wed,  8 Feb 2023 02:57:46 -0800
Message-Id: <e39ca8369d7907b3f5714fac93dfaf342a9c2e82.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c          |  2 ++
 fs/btrfs/raid-stripe-tree.c | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  1 +
 3 files changed, 33 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b130c8dcd8d9..f2de4d3600d6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -1538,6 +1539,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
+	btrfs_check_ordered_stripe_leak(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 1eaa97378d1c..32a428413f5b 100644
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

