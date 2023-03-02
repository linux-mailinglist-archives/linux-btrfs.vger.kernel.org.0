Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C76A7E70
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCBJqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCBJqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:24 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461639CEC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750380; x=1709286380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mouDJAbVbx8rB75NcLOmREPJ46xZAnothKZPGkp9CNI=;
  b=UdSycMKfZfxw6uuq0IaQ1EKokwowtA/E808kjU1fPLdKzfLOHcgzPVkJ
   1xwO/pkQtUEJZGSLxyk5N8KLR0fokX+HtXfActVmZ9RGAS1q50Wqvoy4t
   dqVSlPwiKrYzHKcC2uMbj3w4jwJozXrc4rt65EZ+YQ2Y9LunzFCPeNfow
   C/Nh1F6ZCb6fCYm/fOFzOltpNjqUBxInMxRG6Ueeqhh+3IrwQ7Lqi7KAm
   W8g3nRNFsEe9ombpZcQ8sGYtsqOLUa8KCGe+pYUp2evhStXIBMANiqKA8
   le8XbxWIEoJgrLUAYsPVzoClsUK5FsvLbiFJyYfzIP06eGMd/Ba//PIA9
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939202"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:48 +0800
IronPort-SDR: r0m0wou3jox56OyG6qGd/vZfR1r/ssgMwRUwSUsUUI2zFODm46MR4oFwV0IjV8xNx+0e+TdLhP
 h+G7k0Gs/ZZFEoOvDoouZkg/FuayPU4Fyg4ByrMAJLSYTKJt57K3Xunf7ufGM9BY6d6+5YD+4H
 NCUiyF1wW4kMIcBalTl/Z67V2kp0OgiDADGTDdwua3OWz38kpq9rEGSYgRm4PwahWyzP0pWU3r
 7BI9GX6dAOfonbaauOPl7mKxgggxKvsLqyM4HaiLdvn6Sd/XpWuuKjklt7o7/nviD/KA3l1X3h
 Qnw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:53 -0800
IronPort-SDR: rC+Q4I5limTGSk31cMtqZfBE3rx7eUsXaBMJoIbBD9PWQPIhHCndkQzjiZ7SclRB6QGj9w9FZN
 k2btO8IeBBRmX4s4ZQ0rZrlFT4NYSHh9VTexFshKe2cCrTucfZwuStyabXv7OW/W8mwJo0KdW4
 kaxNByk7crR8cESDVds87526wGB2ObT53Thirz9z4NdK3UGKiU0vNKFflTZPpaHfWSzad86mWR
 SxrGCVLDULi+hKXV79ZoJigVNoRMTdx5u36Yv0Hy2VY2wuyUw2Bf9vcKGG443Dc0ZEz0Tvrnmy
 P/Q=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:49 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 10/13] btrfs: add tracepoints for ordered stripes
Date:   Thu,  2 Mar 2023 01:45:32 -0800
Message-Id: <793f20f1437eee4ee1faeeb937c0119c625e369d.1677750131.git.johannes.thumshirn@wdc.com>
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

Add tracepoints to check the lifetime of btrfs_ordered_stripe entries.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c  |  4 ++-
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 391f69effd90..8799a7abaf38 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -112,6 +112,7 @@ int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 	}
 	write_unlock(&fs_info->stripe_update_lock);
 
+	trace_btrfs_ordered_stripe_add(fs_info, stripe);
 	return 0;
 }
 
@@ -127,6 +128,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *f
 	if (node) {
 		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
 		refcount_inc(&stripe->ref);
+		trace_btrfs_ordered_stripe_lookup(fs_info, stripe);
 	}
 	read_unlock(&fs_info->stripe_update_lock);
 
@@ -136,7 +138,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *f
 void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 				 struct btrfs_ordered_stripe *stripe)
 {
-
+	trace_btrfs_ordered_stripe_put(fs_info, stripe);
 	if (refcount_dec_and_test(&stripe->ref)) {
 		struct rb_node *node;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d8885966e801..fd49da569a8a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -59,6 +59,7 @@
 #include "verity.h"
 #include "super.h"
 #include "extent-tree.h"
+#include "raid-stripe-tree.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8ea9cea9bfeb..7bdc8cc595cc 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -33,6 +33,7 @@ struct btrfs_space_info;
 struct btrfs_raid_bio;
 struct raid56_bio_trace_info;
 struct find_free_extent_ctl;
+struct btrfs_ordered_stripe;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -2492,6 +2493,55 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
 	TP_ARGS(rbio, bio, trace_info)
 );
 
+DECLARE_EVENT_CLASS(btrfs__ordered_stripe,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_ordered_stripe *stripe),
+
+	TP_ARGS(fs_info, stripe),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	logical		)
+		__field(	u64,	num_bytes	)
+		__field(	int,	num_stripes	)
+		__field(	int,	ref		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->logical	= stripe->logical;
+		__entry->num_bytes	= stripe->num_bytes;
+		__entry->num_stripes	= stripe->num_stripes;
+		__entry->ref		= refcount_read(&stripe->ref);
+	),
+
+	TP_printk_btrfs("logical=%llu, num_bytes=%llu, num_stripes=%d, ref=%d",
+			__entry->logical, __entry->num_bytes,
+			__entry->num_stripes, __entry->ref)
+);
+
+DEFINE_EVENT(btrfs__ordered_stripe, btrfs_ordered_stripe_add,
+
+	     TP_PROTO(const struct btrfs_fs_info *fs_info,
+		      const struct btrfs_ordered_stripe *stripe),
+
+	     TP_ARGS(fs_info, stripe)
+);
+
+DEFINE_EVENT(btrfs__ordered_stripe, btrfs_ordered_stripe_lookup,
+
+	     TP_PROTO(const struct btrfs_fs_info *fs_info,
+		      const struct btrfs_ordered_stripe *stripe),
+
+	     TP_ARGS(fs_info, stripe)
+);
+
+DEFINE_EVENT(btrfs__ordered_stripe, btrfs_ordered_stripe_put,
+
+	     TP_PROTO(const struct btrfs_fs_info *fs_info,
+		      const struct btrfs_ordered_stripe *stripe),
+
+	     TP_ARGS(fs_info, stripe)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.39.1

