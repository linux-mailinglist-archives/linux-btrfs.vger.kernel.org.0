Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073EB645C64
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGOXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiLGOWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:36 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF61102B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422955; x=1701958955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NnbP1GzXNU55fc78KgmESPEZwYVpMmeoR2cb74KFQxY=;
  b=Tqye0ykKx36QVzsoVYR49xghv9/QNaIF7ppHNpscNYSK/ePVpBbUXhmK
   8sYRgMZhIcKj07rWBU+4gExWnOi4673WdzZ1yxqv1kjoF+nl47xNF7V03
   9uu5hsBhAJLjXteCWfdXj5dxskew6OT/CGRBzpZCsUC+tDAO77lMGNY46
   qpV1cpVxPh3zey2z5AyyVvVEe4+oQxcwAGST+Y2n+oCnVwBKL6IUxnNbl
   a1KHmn83il2fW/Mvp8GQo6t7A3jQw5Yn3f4di89guJ4rBXO6iQqOi4H02
   XEJeFN9QOdTByuH3te9ziwCJTLbI28VKTDTNT3LGAiBqPVA1kL3Uk1P6P
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099493"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:35 +0800
IronPort-SDR: dvZXy3L1Hgrk1gmpkikHvxf4n5IQ1rtoiDJ4TmA3NjOueKDC6s3itn0cQF9qVParJxxyvNhe7K
 sDD38owrPYuZK3rcJc91hrrHfwXwAHki0t1BCrWdkAqjcwRA9UmbtrzMXW2MzcGJgJsAL29wWd
 iXkQ15VC+eoLxIHxSLbvXtFf79/XYLqBu9UGrJmS+up/p4lp389bBGvw80bz8ChrjRGaGsUs9D
 Ums9scHKkNMPyFJdImpZJP30IDiojJr1eaBbEuafrkydbAU8ks0eEFDh5XJvl77qST7Tjh07Eq
 SMw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:21 -0800
IronPort-SDR: pK8asGROlvTSB74KtFRhfnZo0BCsjU8NAN9yON54stO9+wgFGMBfWaJHKFjZGPKIysHAZCJFtf
 EF8pfCSEq9TqPza9+uebCPJOk7jO+L4ahvv/QPCGfEBpLdUCwwNZZaEJeYvJEMuKc6f7tJeYDh
 q6mUApa8bnfoYslJQaWVUvGHypLW4TZoB6TlEqcGSuKpZepdQcoCnOLiBCQwygSoT8jNkCFxSS
 OOYRSBnyf6eht32HYji8X3y6B0NIc3VCZcQ9qSmvHu3jckRxORe99Iku2jhqBhKcTmDyOV45CF
 YQ4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:34 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 9/9] btrfs: add tracepoints for ordered stripes
Date:   Wed,  7 Dec 2022 06:22:18 -0800
Message-Id: <0cdec0f61fd93fd6c6d7a0721d9c0bdf9b88bfae.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
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
index ed13b30001e0..b5ef3daec295 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -106,6 +106,7 @@ int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 		return -EINVAL;
 	}
 
+	trace_btrfs_ordered_stripe_add(fs_info, stripe);
 	return 0;
 }
 
@@ -121,6 +122,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *f
 	if (node) {
 		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
 		refcount_inc(&stripe->ref);
+		trace_btrfs_ordered_stripe_lookup(fs_info, stripe);
 	}
 	read_unlock(&fs_info->stripe_update_lock);
 
@@ -131,6 +133,7 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 				 struct btrfs_ordered_stripe *stripe)
 {
 	write_lock(&fs_info->stripe_update_lock);
+	trace_btrfs_ordered_stripe_put(fs_info, stripe);
 	if (refcount_dec_and_test(&stripe->ref)) {
 		struct rb_node *node = &stripe->rb_node;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 93f52ee85f6f..532852105668 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -58,6 +58,7 @@
 #include "scrub.h"
 #include "verity.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0bce0b4ff2fa..93b0fbc69413 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -32,6 +32,7 @@ struct prelim_ref;
 struct btrfs_space_info;
 struct btrfs_raid_bio;
 struct raid56_bio_trace_info;
+struct btrfs_ordered_stripe;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -2411,6 +2412,55 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
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
2.38.1

