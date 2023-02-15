Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE7697E75
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBOOeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBOOeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:07 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9B39288
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471646; x=1708007646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReU2dIpqcxDBplx1Qs0jKo3zdn7/Yg+Hw8Jj23xMN4U=;
  b=kdaExewzBKaqcah+f5Ou/RvXN8egaRkbLU4jqTxUUNA9B4iUjZRaqeL5
   gd4MLWo8MB/xqdhiAzgoqtN9OLcbnN+XbtZ3S9XSbAoOywqHKoxzsn0Y3
   4gmT9ODym5QtanshZzVWrYUdfBR8j8ZkogdvoKAOk6tjDrCvHtftCg2AL
   B7Ekv2MNHWka6mxDp41YTCYUDGrvkdF4/A6ckDPkWenucDjbOKzNDOM9M
   L8+buo1q22xsb5ma9/BETeKGgj8LikaiZCxUzqIj358bKExMaZ3BspS0E
   U1MQ5fphKoZUHn/e0ueuiJOJZCFvuT4g2lg2hIhNOj5Jr8QCZOOtwNZsk
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394076"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:47 +0800
IronPort-SDR: zKd+htoNr6MKaspzzGPQpEeKUBvU09Yb1eomOvR9lYGBMaWHfyiqNv5Kwm9KUFCyFz1KVtHS/f
 O7Dkm2Kww+HBxQqJ1rn7dpDbeMFomcVKG3OgP5bnIW/cjE2pIHzO9AKQ+9jaj9EcPDY1FR5AlJ
 Pqm2qRrVq71wcCNqbBCQTV4GGpEMzpY6FM5fQyWYaUMh8yhfUx+ULnJDOsVokxJM2A3A6FjFWj
 5EmvVbS9dgL4VMsO1HlQ5VBo+XMRg4Nx0i9nFZAODM7BqafiNYXtXdctkMr7O76Jco6ZS7K+aN
 6xs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:09 -0800
IronPort-SDR: CkyNTMcozIkhfoUxBOL0pouN3+cxKWZzx81MrbQ2JNgtujpOAxSDBzj1QMHM8PocZ2MK5TVaD5
 Y1vG9d67Ujjn33uXzEEq1B95qD/3RfL3SVQb3hx9tAck8oyi/eU7WvYhI9wWKxstdBqTdGGzUx
 UvByH3i8So0dbK2oHO9AorzHs6sXL0IwerFWiPPl6LfPoUM6g/aJ5P8A4NU1M0rejGLQKntZV5
 UNSK8swpJx0TJTW2idofvEE8UxSwd0R7t1EYO719D43/IUTIJGP2Ieym17wVLkELJC627bjDsV
 OtE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:47 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 10/13] btrfs: add tracepoints for ordered stripes
Date:   Wed, 15 Feb 2023 06:33:31 -0800
Message-Id: <71d4e246d1e9f6e4876de242aaa9111d7d9db303.1676470614.git.johannes.thumshirn@wdc.com>
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
index 581845bc206a..3345eb0ffebc 100644
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
index 75d7d22c3a27..8efea1445dd9 100644
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
2.39.0

