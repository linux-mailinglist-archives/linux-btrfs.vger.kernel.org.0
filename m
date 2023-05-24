Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8B70F9B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjEXPEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjEXPEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 11:04:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44AD132
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Yvh8gExhOvf7+Y0mSB6w1g7n4V86X+VwTMl5b5x7LmY=; b=F5BLyfNuu0RRsLLOdH/UsnsnXT
        xzrr3IMbIhmH/fXCKaybCjV7ese2owUnn6abRPmblLtekcXmxnjKTMvhwhUrcFVb7JKGUj6lEs7c6
        sCoh0chLhUI4H6oKWTMR5oASvNVUFZuXHAroRmDCxCIxKoCStOMvk23KODDFbP/2JSgZQmfkqmS7X
        O5mTR41FylczFa2eD6cKkKGvuvTZbqC0+hrOlMQ25lr8LC0VqJImE9vHD2U8YWEklleIsd8sfPiEm
        4FSd2dm0Yf+ipb3mdjmWWpGWGhUaBAhMABiC6jRKLHScnz+0y2mMcrANXnOSJkXD+Um5YJS0LMptr
        yK+r6yPg==;
Received: from [89.144.223.4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1q1s-00Dmgi-1R;
        Wed, 24 May 2023 15:03:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs: handle completed ordered extents in btrfs_split_ordered_extent
Date:   Wed, 24 May 2023 17:03:15 +0200
Message-Id: <20230524150317.1767981-13-hch@lst.de>
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

To delay splitting ordered_extents to I/O completion time we need to be
able to handle fully completed ordered extents in
btrfs_split_ordered_extent.  Besides a bit of accounting this primarily
involved moving over the csums to thew split bio for the range that
it covers, which is simple enough because we always have one
btrfs_ordered_sum per bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ordered-data.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index bf0a0d67306649..45364b75a9053f 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1141,9 +1141,11 @@ btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 file_offset = ordered->file_offset;
 	u64 disk_bytenr = ordered->disk_bytenr;
-	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
+	unsigned long flags = ordered->flags;
+	struct btrfs_ordered_sum *sum, *n;
 	struct btrfs_ordered_extent *new;
 	struct rb_node *node;
+	u64 offset = 0;
 
 	trace_btrfs_ordered_extent_split(inode, ordered);
 
@@ -1155,15 +1157,15 @@ btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	 */
 	if (WARN_ON_ONCE(len >= ordered->num_bytes))
 		return ERR_PTR(-EINVAL);
-	/* We cannot split once ordered extent is past end_bio. */
-	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
-		return ERR_PTR(-EINVAL);
+	/* We cannot split partially completed ordered extents. */
+	if (ordered->bytes_left) {
+		ASSERT(!(flags & ~BTRFS_ORDERED_TYPE_FLAGS));
+		if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes))
+			return ERR_PTR(-EINVAL);
+	}
 	/* We cannot split a compressed ordered extent. */
 	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes))
 		return ERR_PTR(-EINVAL);
-	/* Checksum list should be empty. */
-	if (WARN_ON_ONCE(!list_empty(&ordered->list)))
-		return ERR_PTR(-EINVAL);
 
 	new = alloc_ordered_extent(inode, file_offset, len, len, disk_bytenr,
 				   len, 0, flags, ordered->compress_type);
@@ -1186,7 +1188,29 @@ btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 len)
 	ordered->disk_bytenr += len;
 	ordered->num_bytes -= len;
 	ordered->disk_num_bytes -= len;
-	ordered->bytes_left -= len;
+
+	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
+		ASSERT(ordered->bytes_left == 0);
+		new->bytes_left = 0;
+	} else {
+		ordered->bytes_left -= len;
+	}
+
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags)) {
+		if (ordered->truncated_len > len) {
+			ordered->truncated_len -= len;
+		} else {
+			new->truncated_len = ordered->truncated_len;
+			ordered->truncated_len = 0;
+		}
+	}
+
+	list_for_each_entry_safe(sum, n, &ordered->list, list) {
+		if (offset == len)
+			break;
+		list_move_tail(&sum->list, &new->list);
+		offset += sum->len;
+	}
 
 	/* Re-insert the node */
 	node = tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node);
-- 
2.39.2

