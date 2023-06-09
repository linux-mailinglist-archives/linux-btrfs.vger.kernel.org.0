Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277C0729B07
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbjFINFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjFINFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 09:05:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ABA2D74
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 06:05:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BCA81FDF3
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686315946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=QgZydqiRxnvDWGjrCW1cdywQc5Z/py+T0VxFWPRxRN4=;
        b=Ki5N4dB43eHBJ7RbrL1B89W7IsxdOZ9v8Xnbdmou1HlqwWGXJbK8FsAgtsyWTjOPMud7Oy
        MiXWzBm8DEdNDAZXu/tZDmiNcDPqZMGI+MbL4vFRZ0WZbkN6Z+GOchOJe5lomAJNlcsEr7
        xVIRKmZJFtLiRILf5Jjh4qQMo5sx7+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686315946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=QgZydqiRxnvDWGjrCW1cdywQc5Z/py+T0VxFWPRxRN4=;
        b=ga/UlUAO/HnBgkllnhb7zeLJ4N04LNXr7D6mYLJkenQ2tCo9NBSssYWQwL3zEkLVZF7EvK
        +61knlBum3h8LpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F05D513A47
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 13:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cnPTK6kjg2SHTgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 13:05:45 +0000
Date:   Fri, 9 Jun 2023 08:06:21 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: check if page is extent locked early during release
Message-ID: <sw3jkfih2ztq4jsjwmkfu3mh7msqvbfripxael24krfp3ablgw@tqwogynwdix6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While performing release, check for locking is the last step performed
in try_release_extent_state(). This happens after finding the em and
decoupling the em from the page. try_release_extent_mapping() also
checks if extents are locked.

During memory pressure, it is better to return early if btrfs cannot
release a page and skip all the extent mapping finding and decoupling.
Check if page is locked in try_release_extent_mapping() before starting
extent map resolution. If locked, return immediately with zero (cannot
free page).

Move extent locked check from try_release_extent_state() to
try_release_extent_mapping().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e5bec73b5991..5b49ef95c653 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2352,31 +2352,24 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
-
-	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
-		ret = 0;
-	} else {
-		u32 clear_bits = ~(EXTENT_NODATASUM |
-				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+	int ret;
+	u32 clear_bits = ~(EXTENT_NODATASUM |
+			EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
 
-		/*
-		 * At this point we can safely clear everything except the
-		 * locked bit, the nodatasum bit and the delalloc new bit.
-		 * The delalloc new bit will be cleared by ordered extent
-		 * completion.
-		 */
-		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
+	/*
+	 * At this point we can safely clear everything except the
+	 * locked bit, the nodatasum bit and the delalloc new bit.
+	 * The delalloc new bit will be cleared by ordered extent
+	 * completion.
+	 */
+	ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
 
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret < 0)
-			ret = 0;
-		else
-			ret = 1;
-	}
-	return ret;
+	/* if clear_extent_bit failed for enomem reasons,
+	 * we can't allow the release to continue.
+	 */
+	if (ret < 0)
+		return 0;
+	return 1;
 }
 
 /*
@@ -2393,6 +2386,9 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_io_tree *tree = &btrfs_inode->io_tree;
 	struct extent_map_tree *map = &btrfs_inode->extent_tree;
 
+	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL))
+		return 0;
+
 	if (gfpflags_allow_blocking(mask) &&
 	    page->mapping->host->i_size > SZ_16M) {
 		u64 len;
@@ -2413,6 +2409,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 				free_extent_map(em);
 				break;
 			}
+			/* Check if entire range is not locked */
 			if (test_range_bit(tree, em->start,
 					   extent_map_end(em) - 1,
 					   EXTENT_LOCKED, 0, NULL))
-- 
2.40.1


-- 
Goldwyn
