Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83706CB5E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC1FUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjC1FUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5D26AA
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4Uv1PNwJ+hXcUXFcwVw7wXjqrYxbzLaQjwWZqL9Y4UA=; b=w/9RSeKZa8gSI0nuQ2FMTBeOxu
        tLDYewE0NaoZnQfSxz/QUShZqfSsaG7yEZnuKyGK5oL0Hlg8SPLxyOJaQ2WNRM3ENOJ/6TYk3/Ezq
        Icq1XrKH/Q/s7AFAC+xIC/uSlIYE299defjWnAJjaec9pVpnKT7rSpXaFW+2Qc3EC1/xGtcDvxgwf
        ZkCZAfPS4rYQW276cb8A3gUnuL9diWmisTiEnDJe66hJPIjbzRRmpTc6HRy2wBuu/BaAPj04UyCxR
        cCs/pgorRUTQQG6lYdesSu5RSKFycov34eWlad9taUFCp2r1lJVIjQj9AoBMApthsP4pQALTZx3ko
        4KSJS5Qg==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1ke-00DAUx-0n;
        Tue, 28 Mar 2023 05:20:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/11] btrfs: stash ordered extent in dio_data during iomap dio
Date:   Tue, 28 Mar 2023 14:19:49 +0900
Message-Id: <20230328051957.1161316-4-hch@lst.de>
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

From: Boris Burkov <boris@bur.io>

While it is not feasible for an ordered extent to survive across the
calls btrfs_direct_write makes into __iomap_dio_rw, it is still helpful
to stash it on the dio_data in between creating it in iomap_begin and
finishing it in either end_io or iomap_end.

The specific use I have in mind is that we can check if a partcular bio
is partial in submit_io without unconditionally looking up the ordered
extent. This is a preparatory patch for a later patch which does just
that.

Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 865d56ff2ce150..1441fe89a208d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -81,6 +81,7 @@ struct btrfs_dio_data {
 	struct extent_changeset *data_reserved;
 	bool data_space_reserved;
 	bool nocow_done;
+	struct btrfs_ordered_extent *ordered;
 };
 
 struct btrfs_dio_private {
@@ -6965,6 +6966,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -6975,7 +6977,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const int type)
 {
 	struct extent_map *em = NULL;
-	int ret;
+	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, orig_start, block_start,
@@ -6985,18 +6987,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
-				       block_len, 0,
-				       (1 << type) |
-				       (1 << BTRFS_ORDERED_DIRECT),
-				       BTRFS_COMPRESS_NONE);
-	if (ret) {
+	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
+					     block_start, block_len, 0,
+					     (1 << type) |
+					     (1 << BTRFS_ORDERED_DIRECT),
+					     BTRFS_COMPRESS_NONE);
+	if (IS_ERR(ordered)) {
 		if (em) {
 			free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
 						    start + len - 1, false);
 		}
-		em = ERR_PTR(ret);
+		em = ERR_CAST(ordered);
+	} else {
+		ASSERT(!dio_data->ordered);
+		dio_data->ordered = ordered;
 	}
  out:
 
@@ -7004,6 +7009,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
@@ -7019,7 +7025,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data,
+				     start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7364,7 +7371,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
 					      ram_bytes, type);
@@ -7406,7 +7413,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			goto out;
 		space_reserved = true;
 
-		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
+		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -7712,6 +7719,10 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 				      pos + length - 1, NULL);
 		ret = -ENOTBLK;
 	}
+	if (write) {
+		btrfs_put_ordered_extent(dio_data->ordered);
+		dio_data->ordered = NULL;
+	}
 
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
@@ -7773,7 +7784,7 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = { 0 };
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
@@ -7782,7 +7793,7 @@ ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_be
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 				  size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = { 0 };
 
 	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
-- 
2.39.2

