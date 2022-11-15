Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC262A0F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiKOSBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiKOSBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E22AD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB58D336D2;
        Tue, 15 Nov 2022 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkPDwZwoqHgEKeNvYJ9df9I0XhzJmdZcYflX9P2sc+I=;
        b=qYNvLFYV2q4Nx6cT2l/oaEE+3Tty/sMli9A+QBQAmny0hviB8uleTEjZC1wXPBMG2YL/+G
        djqk0P/SIo6jJt9mgwKPcU1xoRYUPsKZbuviPi4OCihH7LWIMr351O8Enm0BuBoAFfKfa+
        mMmfxOjkjMK1YrcjtSmTJixM9LA/9Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkPDwZwoqHgEKeNvYJ9df9I0XhzJmdZcYflX9P2sc+I=;
        b=ngebfW6h8EQSkFWsurCYihRD8Ir4XUeIZjN5+XCdgGlFzeh4e2578kApQf2DaloJIhFsjM
        sLLEHqRvMlfPx4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B34013A91;
        Tue, 15 Nov 2022 18:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JMtSDtDTc2OcZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:48 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/16] btrfs: No need to lock extent while performing invalidate_folio()
Date:   Tue, 15 Nov 2022 12:00:23 -0600
Message-Id: <259239dfcb4ab26250036c6429c47ff6214ac8ef.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Don't lock extents while performing invalidate_folio because this is
performed by the calling function higher up the call chain.

With this change, extent_invalidate_folio() calls only
folio_wait_writeback(). Remove and cleanup this function.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/disk-io.c   |  4 +---
 fs/btrfs/extent_io.c | 32 --------------------------------
 fs/btrfs/extent_io.h |  2 --
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 91a088210e5a..8ac9612f8f27 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -888,9 +888,7 @@ static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
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
index 65ba5c3658cf..92068e4ff9c3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3324,38 +3324,6 @@ void extent_readahead(struct readahead_control *rac)
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
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a0bafc7f6c07..3adb22a034a0 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -239,8 +239,6 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-int extent_invalidate_folio(struct extent_io_tree *tree,
-			    struct folio *folio, size_t offset);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
-- 
2.35.3

