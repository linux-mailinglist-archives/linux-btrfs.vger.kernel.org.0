Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB1717927
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjEaH4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjEaHz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:55:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E551BD1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pdcNVybOulXhjyeXhcubHQfA+raeNORGAfriYsLXdDQ=; b=iTlkXQI6Hwvhq4WCwqVBFfB7WF
        o7vFzQNUr/H1VtGBquQ4dUqzA1dLBlC/kRC6v0l0fTEQ2FY7xOtRX/GZS0CM09M/r+jOjJsdimJFn
        NI5iPaiw6wMjT1CnfIUeVYxZqwfC68cC1OxFSBA5f9jLx+4+OkgIbmsHKCR0w8mUU5dUKMeBSrmSQ
        IcrD6dB6w8XBtWwjm/kY3JvrxoOTZMzF7EO3APXD7xp2Y3P0Yo/ZdERU7fxkFT6g2LrLy9oF/2m9e
        1ZND2KGgokIIeshjo/0y4ErkwXNbPy7Wp2qEimeoOKTuLfpYd+5bjlZehMwdQDVJ1eTOEyjjcBTiH
        SQZbez0w==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfA-00GWsb-1l;
        Wed, 31 May 2023 07:54:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/17] btrfs: remove btrfs_add_ordered_extent
Date:   Wed, 31 May 2023 09:53:59 +0200
Message-Id: <20230531075410.480499-7-hch@lst.de>
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

All callers are gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ordered-data.c | 25 +------------------------
 fs/btrfs/ordered-data.h |  4 ----
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index bb76bf01a33292..3aee77f40f01eb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -279,29 +279,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
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
@@ -579,7 +556,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 	freespace_inode = btrfs_is_free_space_inode(btrfs_inode);
 
 	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
-	/* This is paired with btrfs_add_ordered_extent. */
+	/* This is paired with btrfs_alloc_ordered_extent. */
 	spin_lock(&btrfs_inode->lock);
 	btrfs_mod_outstanding_extents(btrfs_inode, -1);
 	spin_unlock(&btrfs_inode->lock);
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 828bb039634ac7..0bd0f036813298 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -178,10 +178,6 @@ struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
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

