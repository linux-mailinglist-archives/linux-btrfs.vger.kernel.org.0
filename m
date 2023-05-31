Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FD71792D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjEaH43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjEaH4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F6A0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jqoUDI5r74/H+mliqEO4arZbTd47fg+5EIKy7ibSGo8=; b=foBMtmFFngoat1v+H7P1XjmKoF
        k1gKktIM8o9Wu+hAsh+risal01tu9SWHekmxECbjVe9QqE/DBb2ky09UVs9IwEqARsTZWmjOZb6tu
        2bipejX8BvQICJQZLIK2/ODPD9QEAK1GVvCE//t6bgB3osIbj7zmT1Xfz4btvS5trIeFGzZ2dhlGS
        PzPdVCL0D1V7BiGHntIjOO/fFqxPSNM/FNgMjE3Wr/ARVY8J/CkQv8peKiMAV1oPKcL8GDVf4nJIe
        1rUGWSU3q0/D6hSmNBt0iPjGIM1Jc2Ud7i3VPYB3NoAMTbkXyEebUM6x8EgGclsS7BFrylZzfr0SS
        N8Di/oJg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfS-00GWwj-2l;
        Wed, 31 May 2023 07:54:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/17] btrfs: add a btrfs_finish_ordered_extent helper
Date:   Wed, 31 May 2023 09:54:06 +0200
Message-Id: <20230531075410.480499-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to complete an ordered_extent without first doing a lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c      | 20 ++++++++++++++++++++
 fs/btrfs/ordered-data.h      |  3 +++
 include/trace/events/btrfs.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 70f411412ca158..22571c6b7ff6f7 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -371,6 +371,26 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 	btrfs_queue_work(wq, &ordered->work);
 }
 
+bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+				 struct page *page, u64 file_offset, u64 len,
+				 bool uptodate)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	unsigned long flags;
+	bool ret;
+
+	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
+
+	spin_lock_irqsave(&inode->ordered_tree.lock, flags);
+	ret = can_finish_ordered_extent(ordered, page, file_offset, len,
+					uptodate);
+	spin_unlock_irqrestore(&inode->ordered_tree.lock, flags);
+
+	if (ret)
+		btrfs_queue_ordered_fn(ordered);
+	return ret;
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 0bd0f036813298..173bd5c5df2624 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -167,6 +167,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
+bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+				 struct page *page, u64 file_offset, u64 len,
+				 bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				struct page *page, u64 file_offset,
 				u64 num_bytes, bool uptodate);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 8ea9cea9bfeb4d..c0f308ef6f7699 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -661,6 +661,35 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_mark_finished,
 	     TP_ARGS(inode, ordered)
 );
 
+TRACE_EVENT(btrfs_finish_ordered_extent,
+
+	TP_PROTO(const struct btrfs_inode *inode, u64 start, u64 len,
+		 int uptodate),
+
+	TP_ARGS(inode, start, len, uptodate),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	 ino		)
+		__field(	u64,	 start		)
+		__field(	u64,	 len		)
+		__field(	int,	 uptodate	)
+		__field(	u64,	 root_objectid	)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->ino	= btrfs_ino(inode);
+		__entry->start	= start;
+		__entry->len	= len;
+		__entry->uptodate = uptodate;
+		__entry->root_objectid = inode->root->root_key.objectid;
+	),
+
+	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu uptodate=%d",
+		  show_root_type(__entry->root_objectid),
+		  __entry->ino, __entry->start,
+		  __entry->len, __entry->uptodate)
+);
+
 DECLARE_EVENT_CLASS(btrfs__writepage,
 
 	TP_PROTO(const struct page *page, const struct inode *inode,
-- 
2.39.2

