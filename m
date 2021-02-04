Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D731008E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBDXWl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:22:41 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45139 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhBDXWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:22:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A6505C00BE;
        Thu,  4 Feb 2021 18:21:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=hj9m/BHKdmCwInKVRTCFfYK+j5
        NCJUzSvxYY7oF58tM=; b=qBexaR8fDKKjAis3jus31PjFhP4ADR1ygNnSN6wKUe
        D5YnhgSF4Rlrt9cDbNCWmTt5Tm5yAOiJjB9q2I6aYoUgYEv1p7f5Uyeslfa5d+Xn
        VcmkhpTB/hPnD2raCB/PANeMINfjocS+2ZkMcvqdQzvlYv0o12VNFtmNJszWpKjF
        Pvq8CXqDLx3I+UnyuIWCnS6PxL3N//U9tz3SSQZHtX+BFksCaIU+wVcn5Cvf7CxT
        YXj8jAKwlXdMW0n5+/ExX5vSuobQhX60XiQ5ao2TcRxMKrL/FENr8dIXIpxQ4qBm
        +MF/kj0ApD1rh6sGfWfO8NojxgQ8OXSECV8cng7CiB6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hj9m/BHKdmCwInKVRTCFfYK+j5NCJUzSvxYY7oF58tM=; b=ldvKdf2l
        GG7c3MSYDq5WqFDw3ArI3kdBlNbUYQFBgwiFO5cU8BekRSBFuHpl566jqalSFIUS
        CSXyfcaoAn2WIeoR6a5N2sZfsHpa867eHi19OzTSgIkKlmWt0YG4AMqpS9TwOCW0
        ZDpQ4z6MauJ5e8LQS2ND8BbtBRJ5gV2ABnCaUnVOkxOod2EE/O7nhAGBpaWH6Rbp
        PIDUKPOGme+9VBwLiVkrWyEent5uZOo8rKVrl1KpU1tmjen9RIuerQkZwKFh9PUK
        i86onSyyBT3E0ApEbspEE6x3zB+WvMFmlxh4giQHGlrlYIliSqJcrR6KlgODfZk2
        Nb5g1rvWttdGZQ==
X-ME-Sender: <xms:koEcYB1URgKZyNf1EiFUIoJiPRLZKiSw24afjSlbXzS-ufckmgpl8Q>
    <xme:koEcYIH6NSDG0nawEtgRtWm-pe7H1w9dUfCQp8KdDzDt5GMOQ-u1HA0Iu7UWmoynj
    QPFEMYxjlFl5HN5_dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiue
    ffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:koEcYB7nV_oue88BwSlb-ZCkT11DBG8rFTK8aRnud31BvetmLvWpCQ>
    <xmx:koEcYO3HnelFNjOKUVdiXp2pgL55D-F4b8dfBx_jBe8qaLAD19iwNQ>
    <xmx:koEcYEHSjEqa9P1Wg-x70qqx1gtaLKe5JQ-QNal1KJWPge4-dW8wMg>
    <xmx:koEcYPOJgw_thaDEdt-_lbCr7TCbgSue_4Sm6mHeAgzltLgmc6DMXw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB1A0108005B;
        Thu,  4 Feb 2021 18:21:53 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 3/5] btrfs: check verity for reads of inline extents and holes
Date:   Thu,  4 Feb 2021 15:21:39 -0800
Message-Id: <489ca41d09a928df5f9b54c3340cf3866daacdfd.1612475783.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612475783.git.boris@bur.io>
References: <cover.1612475783.git.boris@bur.io>
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
 fs/btrfs/extent_io.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7254387200a2..16e3f4304d2e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/cleancache.h>
+#include <linux/fsverity.h>
 #include "extent_io.h"
 #include "extent-io-tree.h"
 #include "extent_map.h"
@@ -2197,18 +2198,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -3344,6 +3333,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 			set_extent_uptodate(tree, cur, cur + iosize - 1,
 					    &cached, GFP_NOFS);
+
 			unlock_extent_cached(tree, cur,
 					     cur + iosize - 1, &cached);
 			cur = cur + iosize;
@@ -3353,7 +3343,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		/* the get_extent function already copied into the page */
 		if (test_range_bit(tree, cur, cur_end,
 				   EXTENT_UPTODATE, 1, NULL)) {
-			check_page_uptodate(tree, page);
 			unlock_extent(tree, cur, cur + iosize - 1);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -3390,8 +3379,13 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	}
 out:
 	if (!nr) {
-		if (!PageError(page))
-			SetPageUptodate(page);
+		if (!PageError(page) && !PageUptodate(page)) {
+			if (start < last_byte && fsverity_active(inode) &&
+			    fsverity_verify_page(page) != true)
+				ret = -EIO;
+			else
+				SetPageUptodate(page);
+		}
 		unlock_page(page);
 	}
 	return ret;
-- 
2.24.1

