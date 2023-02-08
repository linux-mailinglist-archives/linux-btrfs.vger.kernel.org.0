Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48568ED62
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjBHK6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBHK6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:05 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4B1BD0
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853882; x=1707389882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkCi1575S3bvKqEmnvqKepM6XD8ejcSOfuyZUT30T/Q=;
  b=Vn9dbuVtHMFufaK3wJCodRFAsur1YP2KO+l1w8SNtE+SoME2M0mnyaTe
   PjkfiXrb0vYCBctZYUkNGDQon0DHw/VtpdpvPVUYTUgxGTIhudmPTkuBv
   QIH4kagu1wK8sbKO3Uv4MkVU2t6lW5CHyBRkwT/pnNi3jNGiFo5ywFPWC
   HnHX8dWDHPGVvXaXfTvJxn5UpCxxxsvolgcxVWlbaBzu/0BOZJk0f9tp+
   PUImYV025iIBBkbkvYz5fLdHr6fBo7zevk53rQ/3d1gmfWevH1OKjzAfu
   f/GC8xNCVGc2+y4Tl/ieIezfyO1+Q7ppx9qculEqDzEt+gK+oVT9KQ7q3
   g==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115643"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:02 +0800
IronPort-SDR: d6i0lgBjrV9jJp4DWwpqtp3hsYdU+JUihQErUFZjGRCFUzyZxH9XD8V2fErpci/InhbRrhrbLV
 PQOLlKtJXHSl6CAe4clUdNw2/Ffu8OYpCa73x72vV99Fn5bI8hAOENt2Au8uHMpWdr3izWR2kz
 qMmxymUCH8z/0ZM+icUXa664UKoPi/BxvCdfS7jl4S6bSWvDXntElTmALoSJsBQYjEXnsVj80A
 8wmaKTFNwyVbyba7MbDFKmEQkogmj2uOwdNg9tebuILh7Bac6K/gEGC4GIi0cGW8NHw/b3TYsF
 ZPA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:18 -0800
IronPort-SDR: qrQcgr7BNOhtmqrB6XpopO3fizpjthm5ULRsnngL7GEgHNC6RLlY2BtIlf5T5+xtBBWmkCNiA7
 7QaoIHObR0ae+AX/zhrO10WcJgTMf+xF/huIVNIm2Ex5jNeBkeLxU6xslZT8OZG+oEj+gGj4KO
 oWZPWVb0kJ55dlrU7/wiJiJI3SCtWHqatyQ9vJJ3L5bKTQo1R9gjJNb4s4qCcP/C97cBVLB6pe
 kO/LkNi7a2ug4+xmgSpkJDZ3eRP7ybSwYhMVtZo9LhEy2XgVIq5HUyIjQEl1Whd76e+L/QUW9J
 sS4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:02 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 10/13] btrfs: add tracepoints for ordered stripes
Date:   Wed,  8 Feb 2023 02:57:47 -0800
Message-Id: <10aae0632d221643b66784b9f1dccdee1c90fc5b.1675853489.git.johannes.thumshirn@wdc.com>
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

Add tracepoints to check the lifetime of btrfs_ordered_stripe entries.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c  |  3 +++
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 32a428413f5b..4d4c7870547c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -113,6 +113,7 @@ int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 		write_unlock(&fs_info->stripe_update_lock);
 	}
 
+	trace_btrfs_ordered_stripe_add(fs_info, stripe);
 	return 0;
 }
 
@@ -128,6 +129,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *f
 	if (node) {
 		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
 		refcount_inc(&stripe->ref);
+		trace_btrfs_ordered_stripe_lookup(fs_info, stripe);
 	}
 	read_unlock(&fs_info->stripe_update_lock);
 
@@ -138,6 +140,7 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 				 struct btrfs_ordered_stripe *stripe)
 {
 	write_lock(&fs_info->stripe_update_lock);
+	trace_btrfs_ordered_stripe_put(fs_info, stripe);
 	if (refcount_dec_and_test(&stripe->ref)) {
 		struct rb_node *node = &stripe->rb_node;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e5136baef9af..7235106e8d08 100644
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

