Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9C70F9AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjEXPDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbjEXPDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:03:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A109C
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q/XpJrW/QbWAwOt67GDDOyMoAwyfQm4QzKhcI1nSEPI=; b=ZgFcirxmiJeOM+G3BcnWIDhcLk
        RsExNMCw8CWOJzv1VDZQMzHY2p1rzIB76IBy5MgdccPbj3AsHeWFCbChl8J+Jkj5B7FjhvTgBHdkG
        Nj8iPaOVRINOJbBh8KgMjKSRgTZ9vc/cS0TeSLz8bZqNVjB5P6LwrNciM2Hw7JfJgI6tiQ17zgo4r
        XxVdZp8isX9f+Qt0yQdCYEPZXH/oV8uRIWsu+SauAv1eDM0b7gji+MU9qY4QsKQYrjH7+cv78wtb4
        62aR5u1CCidGYi9IJ1zbw0bn2OZNL8oP5P+9OtgxI/WckvazIPdDYXhKXIEjWSYEeTqu8A3zl2b1B
        XT+blJxg==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1g-00DmdE-2b;
        Wed, 24 May 2023 15:03:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 08/14] btrfs: return the new ordered_extent from btrfs_split_ordered_extent
Date:   Wed, 24 May 2023 17:03:11 +0200
Message-Id: <20230524150317.1767981-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
References: <20230524150317.1767981-1-hch@lst.de>
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

Return the ordered_extent split from the passed in one.  This will be
needed to be able to store an ordered_extent in the btrfs_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c        |  7 ++++++-
 fs/btrfs/ordered-data.c | 19 ++++++++++---------
 fs/btrfs/ordered-data.h |  3 ++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5de029ef0b399c..31124954ec6ecf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2719,6 +2719,7 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
+	struct btrfs_ordered_extent *new;
 	int ret;
 
 	/* Must always be called for the beginning of an ordered extent. */
@@ -2740,7 +2741,11 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 			return ret;
 	}
 
-	return btrfs_split_ordered_extent(ordered, len);
+	new = btrfs_split_ordered_extent(ordered, len);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+	btrfs_put_ordered_extent(new);
+	return 0;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 324a5a8c844a72..997d79046d9b62 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1116,7 +1116,8 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 }
 
 /* Split out a new ordered extent for this first @len bytes of @ordered. */
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
+struct btrfs_ordered_extent *
+btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 {
 	struct inode *inode = ordered->inode;
 	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
@@ -1135,16 +1136,16 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	 * reduce the original extent to a zero length either.
 	 */
 	if (WARN_ON_ONCE(len >= ordered->num_bytes))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	/* We cannot split once ordered extent is past end_bio. */
 	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	/* We cannot split a compressed ordered extent. */
 	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	/* Checksum list should be empty. */
 	if (WARN_ON_ONCE(!list_empty(&ordered->list)))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	spin_lock_irq(&tree->lock);
 	/* Remove from tree once */
@@ -1171,13 +1172,13 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 
 	/*
 	 * The splitting extent is already counted and will be added again in
-	 * btrfs_add_ordered_extent(). Subtract len to avoid double counting.
+	 * btrfs_alloc_ordered_extent(). Subtract len to avoid double counting.
 	 */
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -len, fs_info->delalloc_batch);
 
-	return btrfs_add_ordered_extent(BTRFS_I(inode), file_offset, len, len,
-					disk_bytenr, len, 0, flags,
-					ordered->compress_type);
+	return btrfs_alloc_ordered_extent(BTRFS_I(inode), file_offset, len, len,
+					  disk_bytenr, len, 0, flags,
+					  ordered->compress_type);
 }
 
 int __init ordered_data_init(void)
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index dc700aa515b58b..2a20017d9ec6f5 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -206,7 +206,8 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					struct extent_state **cached_state);
 bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state);
-int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len);
+struct btrfs_ordered_extent *
+btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.39.2

