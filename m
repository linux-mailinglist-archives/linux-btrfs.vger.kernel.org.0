Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E4B6A8BB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCBWZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCBWZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83D2332B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D46F02006A;
        Thu,  2 Mar 2023 22:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mb1qSEFXDLy0O7gDF5NyHC5viBnd/0pzEjbGX65dYxo=;
        b=yACfjvX5oqNBtlR0U1w2vT9lDlhMIPgHVeXuDNZY+5nSDL7emjmSR/+rnffohQknqUfkkf
        pwMY5c14dIHmlzIWcCkNvWHq3nG7ySUL+yVL9HQDC8CgJ+do4olCOYCW7HrHW2xk0CZrfm
        nFyP5D5rpSZ7Z4HTCjPJKiN85ka4JiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795921;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mb1qSEFXDLy0O7gDF5NyHC5viBnd/0pzEjbGX65dYxo=;
        b=04i1mptw/CL2BfHYqJeVq83eWumJMzKZCUs1GgVVjo/IYi0GEPGjUAuV6l5DZ55A1RJhaz
        MGup3MjGDgC8WXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D9B013349;
        Thu,  2 Mar 2023 22:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zsF1DFEiAWSsSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:21 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 08/21] btrfs: no need to lock extent while performing invalidate_folio()
Date:   Thu,  2 Mar 2023 16:24:53 -0600
Message-Id: <c9dbd3472d3648a2c5e6c099ad1c50c0aa051f33.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Don't lock extents while performing invalidate_folio because this is
performed by the calling function higher up the call chain.

With this change, extent_invalidate_folio() calls only
folio_wait_writeback(). Remove and cleanup this function.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/disk-io.c   |  4 +---
 fs/btrfs/extent_io.c | 32 --------------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 48368d4bc331..c2b954134851 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -755,9 +755,7 @@ static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 static void btree_invalidate_folio(struct folio *folio, size_t offset,
 				 size_t length)
 {
-	struct extent_io_tree *tree;
-	tree = &BTRFS_I(folio->mapping->host)->io_tree;
-	extent_invalidate_folio(tree, folio, offset);
+	folio_wait_writeback(folio);
 	btree_release_folio(folio, GFP_NOFS);
 	if (folio_get_private(folio)) {
 		btrfs_warn(BTRFS_I(folio->mapping->host)->root->fs_info,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c25fa74d7615..ed054c2f38d8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2778,38 +2778,6 @@ void extent_readahead(struct readahead_control *rac)
 	submit_one_bio(&bio_ctrl);
 }
 
-/*
- * basic invalidate_folio code, this waits on any locked or writeback
- * ranges corresponding to the folio, and then deletes any extent state
- * records from the tree
- */
-int extent_invalidate_folio(struct extent_io_tree *tree,
-			  struct folio *folio, size_t offset)
-{
-	struct extent_state *cached_state = NULL;
-	u64 start = folio_pos(folio);
-	u64 end = start + folio_size(folio) - 1;
-	size_t blocksize = folio->mapping->host->i_sb->s_blocksize;
-
-	/* This function is only called for the btree inode */
-	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
-
-	start += ALIGN(offset, blocksize);
-	if (start > end)
-		return 0;
-
-	lock_extent(tree, start, end, &cached_state);
-	folio_wait_writeback(folio);
-
-	/*
-	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
-	 * so here we only need to unlock the extent range to free any
-	 * existing extent state.
-	 */
-	unlock_extent(tree, start, end, &cached_state);
-	return 0;
-}
-
 /*
  * a helper for release_folio, this tests for areas of the page that
  * are locked or under IO and drops the related state bits if it is safe
-- 
2.39.2

