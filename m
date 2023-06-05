Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DD722157
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjFEIpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFEIpg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:45:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534EB0
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WkmW6FngTZpGZpAU0L5bukZ1tI7TJIwU/Hp0ccDcxXo=; b=cw7OlYs4NeJOyFMATY5xeqyLeU
        EaRXxkaBwUqst6UImuKYnHV8BkRaY9trY2j8jCw0wRd3ft/73NlmyQKf6dZo8QBsYPe9YRy1lML1L
        JgXju79619K3cQnXJEXU99gfph9HOU+VR14KqAp9UhcAjti4GPgiOs6euT1gmhudeSZFKriU/UmUK
        dTYjK5/sXQvU8/B0+SHC2nyO2OnJWNdTqtnCXzmiOx6EazgKHyiTqKWIcOglmSaNDESr7dR2aa4zV
        KdVUD561HR6BFd5EPitvenmhnaOG9Ekh+zupZE6ZEtZ6AO0wmGQQXIeBjnvw2rlEgty/6hU7Gz1NB
        JDhvj7Rw==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65qC-00Ekan-05;
        Mon, 05 Jun 2023 08:45:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: allocate dummy ordereded_sums objects for nocsum I/O on zoned file systems
Date:   Mon,  5 Jun 2023 10:45:19 +0200
Message-Id: <20230605084519.580346-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605084519.580346-1-hch@lst.de>
References: <20230605084519.580346-1-hch@lst.de>
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

Zoned file systems now need the ordereded_sums structure to record the
actual write location returned by zone append, so allocate dummy
structures without the csum array for them when the I/O doesn't use
checksums, and free them when completing the ordered_extent.

Fixes: 5a1b7f2b6306 ("btrfs: optimize the logical to physical mapping for zoned writes")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c       |  4 ++++
 fs/btrfs/file-item.c | 12 ++++++++++--
 fs/btrfs/zoned.c     | 11 ++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 627d06fbb4c425..2482739be49163 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -668,6 +668,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
 				goto fail_put_bio;
+		} else if (use_append) {
+			ret = btrfs_csum_one_bio(bbio);
+			if (ret)
+				goto fail_put_bio;
 		}
 	}
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5e6603e76e5ac0..1308c369b1ebd8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -751,8 +751,16 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	index = 0;
 
-	shash->tfm = fs_info->csum_shash;
+	/*
+	 * If we are called for a nodatasum inode, this means we are on a zoned
+	 * file system.  In this case a ordered_csum structure needs to be
+	 * allocated to track the logical address actually written, but it does
+	 * notactually carry any checksums.
+	 */
+	if (btrfs_inode_is_nodatasum(inode))
+		goto done;
 
+	shash->tfm = fs_info->csum_shash;
 	bio_for_each_segment(bvec, bio, iter) {
 		if (!ordered) {
 			ordered = btrfs_lookup_ordered_extent(inode, offset);
@@ -817,7 +825,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 
 	}
 	this_sum_bytes = 0;
-
+done:
 	/*
 	 * The ->sums assignment is for zoned writes, where a bio never spans
 	 * ordered extents and is only done unconditionally because that's cheaper
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bbde4ddd475492..1f5497b9b2695c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1717,7 +1717,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 		if (!btrfs_zoned_split_ordered(ordered, logical, len)) {
 			set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
 			btrfs_err(fs_info, "failed to split ordered extent\n");
-			return;
+			goto out;
 		}
 		logical = sum->logical;
 		len = sum->len;
@@ -1725,6 +1725,15 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 
 	if (ordered->disk_bytenr != logical)
 		btrfs_rewrite_logical_zoned(ordered, logical);
+
+out:
+	if (btrfs_inode_is_nodatasum(BTRFS_I(ordered->inode))) {
+		while ((sum = list_first_entry_or_null(&ordered->list,
+						       typeof(*sum), list))) {
+			list_del(&sum->list);
+			kfree(sum);
+		}
+	}
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.39.2

