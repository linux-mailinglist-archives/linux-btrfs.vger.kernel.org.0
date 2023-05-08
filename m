Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F476FB4CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEHQJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjEHQI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BE6EAE
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uie9UZUG8vdVd0Yi8qQ5As3KmYkbazcHCHvKuw7SOxs=; b=WGHP3JrBtCExeBP6wWu22Op1G8
        kPlJhNU8+3Outo6GvwMThNyVxrIcschRKCffCyEuy+lCGdSDlmPBRUJ9Pj6Qs4uioWNc5KvJj4RLi
        p+Fh1vEEZmfe2Xk5tiGrPsPsB9Ccp/KbRsB6gRVD3D3DlZ6MlwCtLBn3qTsuiVAr7gKQjr3PV8Dcu
        haCovg67226ffZR7TMxxWxhLWXKnJz1ndOr6ZVSYsUbXyOXr+I9NfJ8LmhO5nkOSwDacdSHDAIgFN
        LcK9b7sjw3cz6cDMH2HlSkuSJNiB4t/MePIJXf7M5mYBiyLFOYpmmka2xDoKAt6+SGy0iwVg35SEz
        ZcyaF98A==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Py-000w3z-30;
        Mon, 08 May 2023 16:08:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/21] btrfs: add a btrfs_finish_ordered_extent helper
Date:   Mon,  8 May 2023 09:08:39 -0700
Message-Id: <20230508160843.133013-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index f474585e6234fe..a54bf49bd5c849 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -356,6 +356,26 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
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
index 87a61a2bb722fd..16e2e7b91267cb 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -172,6 +172,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
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

