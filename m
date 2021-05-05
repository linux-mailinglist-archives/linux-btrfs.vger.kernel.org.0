Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB223748A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhEETVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 15:21:51 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41365 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234664AbhEETVr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 May 2021 15:21:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F25835C0129;
        Wed,  5 May 2021 15:20:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 May 2021 15:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=caQZjyJskGUp44yY38RSJmT9Zh
        kRy2L2kQ0XXqbIUjs=; b=C/31vazFwbfpcq9ndL0hT/MpVJEJ0bgYnsi7S4bpgG
        Jun+lsGBdVAN9VrwZ1pcmUIPH7CmYRMKRNM4ws4a24xWdLd7+g3+a3Rzj/J8cWjV
        eOMxeIy0ChtIa44iKLTUktUGTpNJApcfrjbqSicFTYtRD78QIBGkpbhWeXIO64aU
        IChD/cExwYtA8UcGeNi3m/fkKTitvRSd63ifSjLPYeMK137T1e8Xa9ONlMvqf+y7
        RoCHzHE2/+6rpcqEYa6zsXCwqvIaKW3pahMs1qhkKB+CrnX5kSDxS+3QmPP77GPh
        Y1gNEYZ6at1t5fRRpYjAkVPUOhN99/162u9pkyH0J+Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=caQZjyJskGUp44yY38RSJmT9ZhkRy2L2kQ0XXqbIUjs=; b=LMjixGP+
        3nSRskiQfc5MIK8V1PMbdOIJZWlG9N0O8dL5JZPEhdCBa/xI4frjyURofIt4TGe1
        RBUz3uHWi1oRy87GJrRek4qn7Htg5rE8MPEUslPF4tDweucYxdWwqPSrhA2goozo
        L7nm7+YvDECPqYM4L2Pndj7WMxGLTkvYZb+neKakjVSGxBZPV20x80HlLC3s7gB3
        Zm2X3Jz06QCbjkIU67tavxEuyM0EdnQcHr81fI78hArRop9w4EMTqsVlQR26YpXB
        uEaLfcfdsuQ+QUWRbsnfS8sxxauNh6Gq2PGiPXlzqcsjXMyhTyBWLleXU0WlnYG7
        MYPx2mkJP1fV4g==
X-ME-Sender: <xms:EfCSYD9j0ldbtPQlNdfRtE9s_dnLvi_uXAuUK1sKOQ1NvUWJnin-DA>
    <xme:EfCSYPv3yNFKFK715gh4fHzzKTTpk9GD8mUHlKZ5ASr4qpdLSBIBwIrNQRiNayAL3
    TDDmzjpL1__GGwJ1y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefkedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecukfhppedvtdejrdehfedrvdehfedrjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:EfCSYBBwIR7Z05DqCjyZmBU55nsQ0C1Ox89LP9gcmsWn4XtxFzD84A>
    <xmx:EfCSYPeCjlK_wGbhATAWp4F3fQaRlOiTivKO4oBmtCPkmHD6iQPuFw>
    <xmx:EfCSYINxT1opHR5tsEWh1JBtdKqivdq8EzOZPkU1rwd_e49DZM3zZg>
    <xmx:EfCSYCV_hvG1jE-8Lz0du2MOWUUFKaka3HofqLpZeQ65ARYCdviEcg>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed,  5 May 2021 15:20:49 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 3/5] btrfs: check verity for reads of inline extents and holes
Date:   Wed,  5 May 2021 12:20:41 -0700
Message-Id: <0cf02de467f18881ed84e483e21975ffdc86abca.1620241221.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620241221.git.boris@bur.io>
References: <cover.1620241221.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The majority of reads receive a verity check after the bio is complete
as the page is marked uptodate. However, there is a class of reads which
are handled with btrfs logic in readpage, rather than by submitting a
bio. Specifically, these are inline extents, preallocated extents, and
holes. Tweak readpage so that if it is going to mark such a page
uptodate, it first checks verity on it.

Now if a veritied file has corruption to this class of EXTENT_DATA
items, it will be detected at read time.

There is one annoying edge case that requires checking for start <
last_byte: if userspace reads to the end of a file with page aligned
size and then tries to keep reading (as cat does), the buffered read
code will try to read the page past the end of the file, and expects it
to be filled with 0s and marked uptodate. That bogus page is not part of
the data hashed by verity, so we have to ignore it.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d1f57a4ad2fb..d1493a876915 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2202,18 +2202,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-/*
- * helper function to set a given page up to date if all the
- * extents in the tree for that page are up to date
- */
-static void check_page_uptodate(struct extent_io_tree *tree, struct page *page)
-{
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	if (test_range_bit(tree, start, end, EXTENT_UPTODATE, 1, NULL))
-		SetPageUptodate(page);
-}
-
 int free_io_failure(struct extent_io_tree *failure_tree,
 		    struct extent_io_tree *io_tree,
 		    struct io_failure_record *rec)
@@ -3467,14 +3455,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 					    &cached, GFP_NOFS);
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
-			end_page_read(page, true, cur, iosize);
+			ret = end_page_read(page, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR_OR_NULL(em)) {
 			unlock_extent(tree, cur, end);
-			end_page_read(page, false, cur, end + 1 - cur);
+			ret = end_page_read(page, false, cur, end + 1 - cur);
 			break;
 		}
 		extent_offset = cur - em->start;
@@ -3555,9 +3543,10 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
+
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
-			end_page_read(page, true, cur, iosize);
+			ret = end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3565,9 +3554,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		/* the get_extent function already copied into the page */
 		if (test_range_bit(tree, cur, cur_end,
 				   EXTENT_UPTODATE, 1, NULL)) {
-			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
-			end_page_read(page, true, cur, iosize);
+			ret = end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3577,7 +3565,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		 */
 		if (block_start == EXTENT_MAP_INLINE) {
 			unlock_extent(tree, cur, cur + iosize - 1);
-			end_page_read(page, false, cur, iosize);
+			ret = end_page_read(page, false, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
 			continue;
@@ -3595,7 +3583,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			*bio_flags = this_bio_flag;
 		} else {
 			unlock_extent(tree, cur, cur + iosize - 1);
-			end_page_read(page, false, cur, iosize);
+			ret = end_page_read(page, false, cur, iosize);
 			goto out;
 		}
 		cur = cur + iosize;
-- 
2.30.2

