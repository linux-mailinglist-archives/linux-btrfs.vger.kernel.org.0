Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340006FB4CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjEHQJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjEHQIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0465A1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+bNBPEBDZq/ti6ccN9tX78n/lLCsqMuVy8+1rijmzWE=; b=3/qr9d7uP3CW8l73kL29dvI19P
        tTCODdRid7QL9k1ij8mEC9I5yETGWB597ZzEcCloiHf4nnMe28AzC/teJiVGsGFnwlBBdeaAWad1i
        w6A+LjUo0+23zGnkAYIRFn36FheL1DI9wLWpuKKNHsOBYQie56bW+BeTLdZ/caWMGW7W+/CzqfG8C
        4N7bDwQIXYrAjcgRtORzPBFmQk3V6y4J3FUD3+12XkWu/ihJSASCb65AeXiVMwUT0oAKoLUBrPShB
        7mAfYWpxBZmdaS/ehDmHYfSkf5XENxslzwD7maB8WJOS+q9dQOZ3uy30y9Fo0MlBAleO/fRhwXmSS
        vAF1VI4g==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pt-000w1I-28;
        Mon, 08 May 2023 16:08:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/21] btrfs: remove btrfs_add_ordered_extent
Date:   Mon,  8 May 2023 09:08:31 -0700
Message-Id: <20230508160843.133013-10-hch@lst.de>
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

All callers are gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 25 +------------------------
 fs/btrfs/ordered-data.h |  4 ----
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index f6855e37e7f94d..0ea4efc1264512 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -264,29 +264,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 	return entry;
 }
 
-/*
- * Add a new btrfs_ordered_extent for the range, but drop the reference instead
- * of returning it to the caller.
- */
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned long flags,
-			     int compress_type)
-{
-	struct btrfs_ordered_extent *ordered;
-
-	ordered = btrfs_alloc_ordered_extent(inode, file_offset, num_bytes,
-					     ram_bytes, disk_bytenr,
-					     disk_num_bytes, offset, flags,
-					     compress_type);
-
-	if (IS_ERR(ordered))
-		return PTR_ERR(ordered);
-	btrfs_put_ordered_extent(ordered);
-
-	return 0;
-}
-
 /*
  * Add a struct btrfs_ordered_sum into the list of checksums to be inserted
  * when an ordered extent is finished.  If the list covers more than one
@@ -564,7 +541,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 	freespace_inode = btrfs_is_free_space_inode(btrfs_inode);
 
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
-	/* This is paired with btrfs_add_ordered_extent. */
+	/* This is paired with btrfs_alloc_ordered_extent. */
 	spin_lock(&btrfs_inode->lock);
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
 	spin_unlock(&btrfs_inode->lock);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 150f75a155ca0c..87a61a2bb722fd 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -183,10 +183,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
 			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
 			u64 disk_num_bytes, u64 offset, unsigned long flags,
 			int compress_type);
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned long flags,
-			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *inode,
-- 
2.39.2

