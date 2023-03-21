Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432126C374D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCUQqH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCUQp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 12:45:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581852915
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 09:45:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DA1B25C0194;
        Tue, 21 Mar 2023 12:45:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Mar 2023 12:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1679417138; x=
        1679503538; bh=zrGpKiPh2OFEqA9I9wGR/IEfFSnJXMuned77DwsLncQ=; b=Y
        V3qDvzErkgvuzQOyL3SIqvTAXBvVmTQDLV7Ay/XpyIWWpH1CJmZ3ylPjAd/lIong
        cJyAP7cqs3E38Z8yiBMPN8CuNcirvTr/z0FO522bQczISyFktHScYTNHptryXr4S
        LEb39L41tItpWvszaVYN2eVQ6nc2MJH9lit2n5e9fI5jQ1uZkYf74h7SlKx9DCaj
        wzz3NScq7+FZxWsQmrwzG375msVzGy3voe6SqV9SqLk94JhX2I71mfJetnKvUNPw
        pBH+t0Bci0UQnbJqgiAb2P3WE0bFqPdyo3N7TJMXsHv1FSqkHOoCxSLw6r+YebGp
        8McaJKWeCdDHwlEhf3/wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679417138; x=1679503538; bh=z
        rGpKiPh2OFEqA9I9wGR/IEfFSnJXMuned77DwsLncQ=; b=BEgzzF0S3PLSgev9+
        TxAb3qeKkbnIbExj+AgTvM5xaTLpwEOOF9iCcg6tlzgsrb4qRR2IurFKtB3i7Q2R
        VSWsoq51VxAvgNQBRjBM/zlx4N1Y3jj1+ELtjgFkLBFttDNIjgt3OCzC8IVAK39Q
        53kDr2DiPA5IgFN+gr92yEjtUSBMD6XHcGHtcr+ekjDvt3Az1FWuSa2qggLjW+d3
        oH4j7PBRBsHndhEEWhQyHOAim73IGCm2npU8PMEGi8RIMyBzR3XEgaLzw/fbhlnF
        5TJFjOiZvLusasRdmSONmCgfqiOb3U30Hx5Y1TrIlEkhtdW2dTwA2zYDvLHcOENt
        Otc7g==
X-ME-Sender: <xms:Mt8ZZINFru7zL9Hv_j_AxvRDBtqbo36l6pECQ6znxqLjEubIyWZNwQ>
    <xme:Mt8ZZO9mYSlUbYQgmnzUaeIl7xF6_0paASAW7ZcDpQHVKgP9a0xLzVd6q2f6edlnD
    ug8Iurs2Baqta-8unk>
X-ME-Received: <xmr:Mt8ZZPTlpz5expwPqVCQUM5G2_1PzQRaMtZnTTCX-ghQUqjIzusgIpzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Mt8ZZAuN6V_VolfH2Hp7WAht7YgEMTqqq4xDh7bJNS87o_YSdBdz5Q>
    <xmx:Mt8ZZAe0kHcivbR7ihlEzh7akXLOLkwRwBi0wbRENimp1Cdx1JajJg>
    <xmx:Mt8ZZE2NtXPryzFrOSKr_PS9c7PIr6drCAH7-yTtMl5_PM7mQZfATw>
    <xmx:Mt8ZZIlNCEw8wsrSwjvB2ehwWTB5Wh3RSuYyv4q2SIGpDBZ5N1HdYQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 12:45:38 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 2/6] btrfs: stash ordered extent in dio_data during iomap dio
Date:   Tue, 21 Mar 2023 09:45:29 -0700
Message-Id: <c19e49cef3e7bb85e15dae042281d3366fa4cf00.1679416511.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1679416511.git.boris@bur.io>
References: <cover.1679416511.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While it is not feasible for an ordered extent to survive across the
calls btrfs_direct_write makes into __iomap_dio_rw, it is still helpful
to stash it on the dio_data in between creating it in iomap_begin and
finishing it in either end_io or iomap_end.

The specific use I have in mind is that we can check if a partcular bio
is partial in submit_io without unconditionally looking up the ordered
extent. This is a preparatory patch for a later patch which does just
that.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/inode.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 76d93b9e94a9..5ab486f448eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -81,6 +81,7 @@ struct btrfs_dio_data {
 	struct extent_changeset *data_reserved;
 	bool data_space_reserved;
 	bool nocow_done;
+	struct btrfs_ordered_extent *ordered;
 };
 
 struct btrfs_dio_private {
@@ -6968,6 +6969,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -6978,7 +6980,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const int type)
 {
 	struct extent_map *em = NULL;
-	int ret;
+	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, orig_start, block_start,
@@ -6988,18 +6990,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
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
+		em = ERR_PTR(PTR_ERR(ordered));
+	} else {
+		ASSERT(!dio_data->ordered);
+		dio_data->ordered = ordered;
 	}
  out:
 
@@ -7007,6 +7012,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
@@ -7022,7 +7028,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data,
+				     start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7367,7 +7374,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
 					      ram_bytes, type);
@@ -7409,7 +7416,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			goto out;
 		space_reserved = true;
 
-		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
+		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -7715,6 +7722,10 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 				      pos + length - 1, NULL);
 		ret = -ENOTBLK;
 	}
+	if (write) {
+		btrfs_put_ordered_extent(dio_data->ordered);
+		dio_data->ordered = NULL;
+	}
 
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
@@ -7776,7 +7787,7 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = { 0 };
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
@@ -7785,7 +7796,7 @@ ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_be
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 				  size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = { 0 };
 
 	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
-- 
2.38.1

