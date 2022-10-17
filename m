Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C2600E49
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJQLzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJQLzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF1957E1D
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007742; x=1697543742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDnieQdzQiAlgtdJ8yro6VF2VEXcovI8CAs8SLqFkig=;
  b=nJm+zivID0KGLu3j3jJIaLHgE+xKV+t//pbboYTFSgGpTC1z7baYOUfo
   FfFCGMR5SFfQOE4QSNi0vuoetjiqBGD2VcFGp+7tn1JF6jOBjGWHPMbR7
   +I+1VphCX1HvJS/bXMzWypiyVFrphcn1D5p5C2x1CBSzjcKsYFY/l5QmJ
   S8lZIFrKNuWOdvKJ678i4OZmQx3j2Lkk8+c9UgB7wfCYZq+kFH7iGyGzn
   IJGtz/e60808kDghsWbLypwH8wcSVa+3XPllQMCoZfo/Sr6jYu+IVVcHE
   HeO0Zgn8vNkpLrt4mKQzBZ0SwvLaMPc2jFLkSGKrF57aNRyOlAGBZTSOo
   A==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337173"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:42 +0800
IronPort-SDR: NCRJ+86HFbjd/31TzId74TNsCxYU7dGJJkUHnEtNNJ4vlNrHMZqtQmJGo/Jn+uiDqRPxmJ3Az/
 HXg+MwHs3hIHjI9Xy/pwKhMwZcnWcQVg/VEi4bniKH5QzFuwp+jF8+BLJhM2jAxZxqwwdsQALF
 IdXYBNwkj/fr7D9Pii2hpw6eQWLLqL/wCz6uabXm+81wPpOTq01AKKFxdSdrVWfVQuCmEEw3FB
 prRFyXbYQkIDs7rLPXUSz+Ecbq5V76H9bMRPdXdfrxhtxE2wFmtGQiWT56urMZ2zhMM/YOofw3
 hrTbRuMg2QK8kVTq42mWz/sX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:15 -0700
IronPort-SDR: FFzCy0PQ95x3x54P3ZxRvZ3Hx2rq1zLe5n14kE2/+z1rCOgM2l7zVweEbgroweV+ehDUhTQlKj
 NoXnb1iqjpr1yK8PuRGy2zTBnM/cFXA2VJE4v71AxR5FjcLQtlfE8D41T2oWvV3RqRY9UCutNG
 iRah0DhreRrqJoVaRJAZu0jdnlX822mKidg994QMwsvv0QtR1NZ/zPqqEM5FR4D5sBTMFo0eYx
 ggTMnBZHsrVLiZCHBsTaTkmEnN573+PuX+2t6yMU9T/pv432xl/dCIUCcFSpVDdxlyeZR05eGI
 zTg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 11/11] btrfs: add tracepoints for ordered stripes
Date:   Mon, 17 Oct 2022 04:55:29 -0700
Message-Id: <f90279e15449e36f822db47d9759817fa9e72e56.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c  |  3 +++
 fs/btrfs/super.c             |  1 +
 include/trace/events/btrfs.h | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9a913c4cd44e..0d27b236445d 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -99,6 +99,7 @@ int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 		return -EINVAL;
 	}
 
+	trace_btrfs_ordered_stripe_add(fs_info, stripe);
 	return 0;
 }
 
@@ -114,6 +115,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(struct btrfs_fs_info *f
 	if (node) {
 		stripe = rb_entry(node, struct btrfs_ordered_stripe, rb_node);
 		refcount_inc(&stripe->ref);
+		trace_btrfs_ordered_stripe_lookup(fs_info, stripe);
 	}
 	mutex_unlock(&fs_info->stripe_update_lock);
 
@@ -124,6 +126,7 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 				 struct btrfs_ordered_stripe *stripe)
 {
 	mutex_lock(&fs_info->stripe_update_lock);
+	trace_btrfs_ordered_stripe_put(fs_info, stripe);
 	if (refcount_dec_and_test(&stripe->ref)) {
 		struct rb_node *node = &stripe->rb_node;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eb0ae7e396ef..e071245ef0b4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -49,6 +49,7 @@
 #include "discard.h"
 #include "qgroup.h"
 #include "raid56.h"
+#include "raid-stripe-tree.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ed50e81174bf..49510c687977 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -32,6 +32,7 @@ struct prelim_ref;
 struct btrfs_space_info;
 struct btrfs_raid_bio;
 struct raid56_bio_trace_info;
+struct btrfs_ordered_stripe;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -2414,6 +2415,55 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
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
2.37.3

