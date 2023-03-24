Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FB6C75E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCXCcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 22:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjCXCci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138F6EB9
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UpF854JGJfiJh7auA04jxfCxAaqCCBD2mP2tq0W6jvk=; b=fNAavY+eHTOwLmMktekJjRPbsQ
        lkRB4uUVpzxVOBrY4DtLpH8Cpa+GShbLRQAO1n6iiBeP9ad9hqqTlK5cSGkdmKAJrnTMnCDG+VMmf
        Rwx8up7aNUH+Wnj9QTLSLRAgN8nVVPa4e/W7sumzT+d0K5ihs8gQAxcTNNdry6QvfP/0XSdh9SIDV
        x7FWoQehWuy50z8U9r6Z8OVy217lbuTUOQsW6Uwy9OHImkkiMUf81decKvugXM4tFD8YAZr2YD0Oj
        y8kqF1KfcFO6XCPiMA7j74tArRtQpY7PfF8aprtwKSHlnLEu9dY6utmF84qCaFUEy1hhwrHilCAsi
        ekVwW+fw==;
Received: from [122.147.159.78] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfXEG-003PHf-2u;
        Fri, 24 Mar 2023 02:32:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: simplify btrfs_extract_ordered_extent
Date:   Fri, 24 Mar 2023 10:32:01 +0800
Message-Id: <20230324023207.544800-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324023207.544800-1-hch@lst.de>
References: <20230324023207.544800-1-hch@lst.de>
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

btrfs_extract_ordered_extent must always be called for the beginning of
an ordered_extent.  Add an assert to check for that and simplify the
calculation of the split ranges for btrfs_split_ordered_extent and
split_zoned_em.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f2f1aafd1720e..2cbc6c316effc1 100644
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

