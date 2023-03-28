Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04206CB5E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC1FUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjC1FUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571621BE8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E2eaYFqnhqQ74bryGcdYr/z7KZkWwIAgW3SOEavuRQU=; b=W6imzK458+lqpiShQmoky+uWE8
        4zfikv9uplJBub17SsKaIDgoJwamO5Xqqjsc2oE8x6V8tRx8k39V/5hACegTTmg+cqMXanUPXuDhn
        KHycdlZY9fP3zcnf0QY3vOh0SjNuZjZ+3pdqIkl68KuDLk57fMvxHzI7eh1r+A/77jYB09kfBwfV8
        bzYtzRqfVw03RwSh2wDvEhK8zrWe8QQg3rSERYes1C6zPYYrLD9FdSkUcUku3rXl0Rv87EMZ+CNQF
        eXB1+eo8bHq4SSr5y/pDiROrDISHIjGi6JVEneo7Doil6gAz35FhlcXGebYYm8TIYA5RBNGqSQWLq
        BeR/gqGg==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1kj-00DAWG-0q;
        Tue, 28 Mar 2023 05:20:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/11] btrfs: simplify btrfs_extract_ordered_extent
Date:   Tue, 28 Mar 2023 14:19:51 +0900
Message-Id: <20230328051957.1161316-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
References: <20230328051957.1161316-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_extract_ordered_extent is always used to split an ordered_extent
and extent_map into two parts, so it doesn't need to deal with a three
way split.

Simplify it by only allowing for a single split point, and always split
out the beginning of the extent, as that is what we'll later need to
be able to hold on to a reference to the original ordered_extent that
the first part is split off for submission.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5013d1b0b00e29..428fa99711def1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2632,39 +2632,36 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
 	u64 len = bbio->bio.bi_iter.bi_size;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_ordered_extent *ordered;
-	u64 file_len;
-	u64 end = start + len;
-	u64 ordered_end;
-	u64 pre, post;
+	u64 ordered_len;
 	int ret = 0;
 
 	ordered = btrfs_lookup_ordered_extent(inode, bbio->file_offset);
 	if (WARN_ON_ONCE(!ordered))
 		return BLK_STS_IOERR;
+	ordered_len = ordered->num_bytes;
 
-	/* No need to split */
-	if (ordered->disk_num_bytes == len)
+	/* Must always be called for the beginning of an ordered extent. */
+	if (WARN_ON_ONCE(start != ordered->disk_bytenr)) {
+		ret = -EINVAL;
 		goto out;
+	}
 
-	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
-	/* bio must be in one ordered extent */
-	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
+	/* The bio must be entirely covered by the ordered extent */
+	if (WARN_ON_ONCE(len > ordered_len)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	file_len = ordered->num_bytes;
-	pre = start - ordered->disk_bytenr;
-	post = ordered_end - end;
+	/* No need to split if the ordered extent covers the entire bio */
+	if (ordered->disk_num_bytes == len)
+		goto out;
 
-	ret = btrfs_split_ordered_extent(ordered, pre, post);
+	ret = btrfs_split_ordered_extent(ordered, len, 0);
 	if (ret)
 		goto out;
-	ret = split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
-
+	ret = split_zoned_em(inode, bbio->file_offset, ordered_len, len, 0);
 out:
 	btrfs_put_ordered_extent(ordered);
-
 	return errno_to_blk_status(ret);
 }
 
-- 
2.39.2

