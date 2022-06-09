Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6D5451E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiFIQ2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiFIQ20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 12:28:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0555365
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654792089; x=1686328089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufb7TDcOmL4Wsw+VZXrnnKKe8uUA+Mw7mPtcu+iAJiM=;
  b=hVeo4twknCfgkQ1ThNdUkbnLVP0cAzc93t5D9Ceui1xnU9nJzNegVqzr
   UEdXEJRd5Ikbnh5VFI4xm9otFz7wElJkLqMhbIiEraDg3Mpp0TVo9tCvr
   1AxGj0GhZXntzkEx7c6KNUVSNelq4HUdFTXgazNyc05dQLOKe+ZjlzWMk
   Kiadk2zuAxy3jHJhq8ZKHqlnN/VaJ5Wnds+h1vcH9XjSpW0mDIM92pFDI
   PW7ZYvViekecvj1yzc3rhr8FOldq0rfq39EttBnIwnk56NpxyXAgawsuR
   Gu3Xai2mhpOBylWIxiUsixAe9KuWfA0DGYYK42tR3I5M4a+e0WpDlkZjb
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647273600"; 
   d="scan'208";a="314767703"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 00:28:08 +0800
IronPort-SDR: Mk7ljS3ipXj+ET6bAP/I9rWWv6PrgAlmPYPR+/mUz91mgaCuSeGIvGlzpQbpjN137jHDI5tmlG
 tvulmGXX0I2hBFL28SuWCCD1WEBLawulXwXeiNcD4FHugJD/JtQaxlHqxvwuo93hsTMClRtzRq
 zEknjiVZgCZ3Iuu+IYr9OHJHkKmUOLEq1MRuFipThRua8QGZoheXRq8dWZIgL/+lvShA9DBcU5
 cHWwFgZai0w0DKix6FIEXTIz1eCYvvGR+OC1kL0sGiedUN1pk19U7SlnFjUkvaGNu69rEnyfiB
 q2Jr9V1uHgKTtAk7q9zSLWOn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jun 2022 08:51:21 -0700
IronPort-SDR: TGHE6VI0JNOxzc52H0tfLOFrHInkaXsPYsN8BjdVH8sYcVR+75WrlRnqBvESYPl10GTHgrK3Ev
 2J3Gv1C5TZ0N7PdlobitOgBqj3A1XjthBxHLCUA8gL2vgV7fFTUtlcckRZ+D4ltFC0jAFi1ZFP
 KbA3626Cb4mKAC+ZJzPS4Fdd47Hdo6lEKBZfTP5RmFOAbaQoC44tN+X3B5RYvN3JZIJu24LnUV
 2abG9/PWBnwxZ/uoYjBpTWJMnoNKA9PLWS5fDN53Zb6o9n4SdDJTCjSZwq2c0lR/ktz/a8XfrE
 O/c=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2022 09:28:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add tracepoints for ordered extents
Date:   Thu,  9 Jun 2022 09:28:04 -0700
Message-Id: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When debugging a reference counting issue with ordered extents, I've found
we're lacking a lot of tracepoint coverage in the ordered-extent code.

Close these gaps by adding tracepoints after every refcount_inc() in the
ordered-extent code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ordered-data.c      | 19 +++++++++--
 include/trace/events/btrfs.h | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index dc88d2b3721f..41b3bc44c92b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -401,6 +401,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
 			cond_wake_up(&entry->wait);
 			refcount_inc(&entry->refs);
+			trace_btrfs_ordered_extent_mark_finished(inode, entry);
 			spin_unlock_irqrestore(&tree->lock, flags);
 			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
 			btrfs_queue_work(wq, &entry->work);
@@ -473,6 +474,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 	if (finished && cached && entry) {
 		*cached = entry;
 		refcount_inc(&entry->refs);
+		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
 	}
 	spin_unlock_irqrestore(&tree->lock, flags);
 	return finished;
@@ -807,8 +809,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
 		entry = NULL;
-	if (entry)
+	if (entry) {
 		refcount_inc(&entry->refs);
+		trace_btrfs_ordered_extent_lookup(inode, entry);
+	}
 out:
 	spin_unlock_irqrestore(&tree->lock, flags);
 	return entry;
@@ -848,8 +852,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 			break;
 	}
 out:
-	if (entry)
+	if (entry) {
 		refcount_inc(&entry->refs);
+		trace_btrfs_ordered_extent_lookup_range(inode, entry);
+	}
 	spin_unlock_irq(&tree->lock);
 	return entry;
 }
@@ -878,6 +884,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 		ASSERT(list_empty(&ordered->log_list));
 		list_add_tail(&ordered->log_list, list);
 		refcount_inc(&ordered->refs);
+		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
 	}
 	spin_unlock_irq(&tree->lock);
 }
@@ -901,6 +908,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 	refcount_inc(&entry->refs);
+	trace_btrfs_ordered_extent_lookup_first(inode, entry);
 out:
 	spin_unlock_irq(&tree->lock);
 	return entry;
@@ -975,8 +983,11 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	/* No ordered extent in the range */
 	entry = NULL;
 out:
-	if (entry)
+	if (entry) {
 		refcount_inc(&entry->refs);
+		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
+	}
+
 	spin_unlock_irq(&tree->lock);
 	return entry;
 }
@@ -1055,6 +1066,8 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int ret = 0;
 
+	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
+
 	spin_lock_irq(&tree->lock);
 	/* Remove from tree once */
 	node = &ordered->rb_node;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 29fa8ea2cc0f..73df80d462dc 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -598,6 +598,70 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_put,
 	TP_ARGS(inode, ordered)
 );
 
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_range,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first_range,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_for_logging,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_split,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_dec_test_pending,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
+DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_mark_finished,
+
+	     TP_PROTO(const struct btrfs_inode *inode,
+		      const struct btrfs_ordered_extent *ordered),
+
+	     TP_ARGS(inode, ordered)
+);
+
 DECLARE_EVENT_CLASS(btrfs__writepage,
 
 	TP_PROTO(const struct page *page, const struct inode *inode,
-- 
2.35.3

