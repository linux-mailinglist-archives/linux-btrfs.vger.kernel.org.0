Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493316A7E6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCBJql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCBJqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:24 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F043B201
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750378; x=1709286378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAMqcQ+s/ZI2meVZMBPOj5EOUE7UGTITqEVlqAuBBYQ=;
  b=rKkylGJhU0S9/FnA7zYySZl4GAJnR3+acq/S7xL62g6SPdAn/CaA9uv/
   NBTg6GGm4CaQXW30Dn6+YmUHEiK3cYZOYXjCl64HYN9ac4Qbf+/m+M5RX
   hW/yi5r3f2iDUvZZploVN0cbFhK5QM0O2XpZU6kKaFGR2Vevs3bSQvPOq
   /tCQetfEEhm4OWPksj8ydRPFwdmO28XxuzaqAnbB3SAcSjgY4o5tjWGTz
   tCvOCQ8xnHf8SeuWceeY7fW3FUHf/ew1/KhcRkgZpID4e87KGyeqO/fGb
   N1OVOFgWAYTwffQEsP8Pb5F+//Bap3RW8WeIm0uh1DHRt0oKESCcTTMMK
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939196"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:47 +0800
IronPort-SDR: 4bsMB0uzPSmU6dopT0vnKum2e0/DxvUa4Cld2TnMyty0QxWYOTjBMGYpYM1QEp7HIl6VjoSeiG
 Attqaf+WFm9hjcbqDVWoNlW2NEYShG1e6DWwYKfrZ23UVOahoCsCJLDiPmW7DJBLjOPjtrW0q3
 Auxk0tZZUfUnKWpNDEI7/v9l30RDxZyySVxaGU4jVhmw/THlJRdePf20qtUa3Ro6klzR97Vi79
 jIPkHVg8nqB9YzSp4+OosWoMFcy1d3cuGWEnuw64J24SVWeET3AE4LDPQCnaiAXQvH5svgbU1+
 e2k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:52 -0800
IronPort-SDR: XYibh1ODKBpFIM3McWZkmkINA5p3owhHVKRR9gx2QvXz1P1l56fgKeppgSjKGgyZkvMB2T1tb7
 CqParsYH2mzKWOI0Jt8exK3KNNb51cqQVr0mhNlb4t/WJSrc93PNkqgmAO901yIjhArBP2qToB
 xGaXF+h+K8h5PZj5EAwNwGHCT853l/DM5UP0nzJpcvPJHUzOl3TzjW0ffr71ZuuuIjNuDJvLWF
 wc4EE/ZVp6ASfER9YGWBs1j3rMJlD0z2sVEx/sVXaRTMwZSuypyqvuq3I4vbtB41C9eVbI+VdB
 R00=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:48 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 09/13] btrfs: check for leaks of ordered stripes on umount
Date:   Thu,  2 Mar 2023 01:45:31 -0800
Message-Id: <762259752f5ace3e35e40e6160515c3637071a80.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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
index ac200b367ec8..abbfd71f2cb6 100644
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
2.39.1

