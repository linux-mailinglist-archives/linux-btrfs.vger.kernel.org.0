Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7662A0EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiKOSBu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A914CD8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59BFE336CD;
        Tue, 15 Nov 2022 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlvVevUyxLJUPaEGndY91b0zfj8IZJxwb8yZRJLnu0Q=;
        b=il/WWpO2JTofiCWruz7+HErZM/LEm613Zo50L1ghJrHWvozWCiVonjfvxOMVZ1wZw7Z8D5
        fviG5oeLBwq46ASUBBcrFV5BYH3oaHj2q26DGf8N1otgYrNsgFf+2HR95THuJe4C2ltypN
        M37n514E8d7RIjt176/jTHtfsuCm8mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlvVevUyxLJUPaEGndY91b0zfj8IZJxwb8yZRJLnu0Q=;
        b=HlMnX3CZ0U6YiHkhc/oBS067uTkpsi99zzP+6PffFGD75P4LvaWouGIWIrPEUchQUpp+HN
        tNWdkGijV75TN0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E0FA13A91;
        Tue, 15 Nov 2022 18:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4hoCN9bTc2OjZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:54 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 08/16] btrfs: Lock extents before pages for buffered write()
Date:   Tue, 15 Nov 2022 12:00:26 -0600
Message-Id: <387d15a567d7c56ceb2408783ebe31e431cb537f.1668530684.git.rgoldwyn@suse.com>
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

While performing writes, lock the extents before locking the pages.

Ideally, this should be done before  space reservations. However,
This is performed after check for space because qgroup initiates
writeback which may cause deadlocks.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 78 ++++++++++++-------------------------------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9266ee6c1a61..559214ded4eb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -967,8 +967,8 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
  * the other < 0 number - Something wrong happens
  */
 static noinline int
-lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
-				size_t num_pages, loff_t pos,
+lock_and_cleanup_extent_if_need(struct btrfs_inode *inode,
+				loff_t pos,
 				size_t write_bytes,
 				u64 *lockstart, u64 *lockend, bool nowait,
 				struct extent_state **cached_state)
@@ -976,7 +976,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 start_pos;
 	u64 last_pos;
-	int i;
 	int ret = 0;
 
 	start_pos = round_down(pos, fs_info->sectorsize);
@@ -987,15 +986,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 
 		if (nowait) {
 			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
-					     cached_state)) {
-				for (i = 0; i < num_pages; i++) {
-					unlock_page(pages[i]);
-					put_page(pages[i]);
-					pages[i] = NULL;
-				}
-
+					     cached_state))
 				return -EAGAIN;
-			}
 		} else {
 			lock_extent(&inode->io_tree, start_pos, last_pos, cached_state);
 		}
@@ -1007,10 +999,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		    ordered->file_offset <= last_pos) {
 			unlock_extent(&inode->io_tree, start_pos, last_pos,
 				      cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
 			btrfs_start_ordered_extent(ordered, 1);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
@@ -1023,13 +1011,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		ret = 1;
 	}
 
-	/*
-	 * We should be called after prepare_pages() which should have locked
-	 * all pages in the range.
-	 */
-	for (i = 0; i < num_pages; i++)
-		WARN_ON(!PageLocked(pages[i]));
-
 	return ret;
 }
 
@@ -1306,13 +1287,22 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		release_bytes = reserve_bytes;
-again:
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 			break;
 		}
 
+		extents_locked = lock_and_cleanup_extent_if_need(BTRFS_I(inode),
+				pos, write_bytes, &lockstart, &lockend,
+				nowait, &cached_state);
+		if (extents_locked < 0) {
+			ret = extents_locked;
+			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+			break;
+		}
+
+
 		/*
 		 * This is going to setup the pages array with the number of
 		 * pages we want, so we don't really need to worry about the
@@ -1320,25 +1310,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 */
 		ret = prepare_pages(inode, pages, num_pages,
 				    pos, write_bytes, force_page_uptodate, false);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			break;
-		}
-
-		extents_locked = lock_and_cleanup_extent_if_need(
-				BTRFS_I(inode), pages,
-				num_pages, pos, write_bytes, &lockstart,
-				&lockend, nowait, &cached_state);
-		if (extents_locked < 0) {
-			if (!nowait && extents_locked == -EAGAIN)
-				goto again;
-
+		if (ret)
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
-			ret = extents_locked;
-			break;
-		}
 
 		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
 
@@ -1387,33 +1361,19 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
 					dirty_pages, pos, copied,
-					&cached_state, only_release_metadata);
-
-		/*
-		 * If we have not locked the extent range, because the range's
-		 * start offset is >= i_size, we might still have a non-NULL
-		 * cached extent state, acquired while marking the extent range
-		 * as delalloc through btrfs_dirty_pages(). Therefore free any
-		 * possible cached extent state to avoid a memory leak.
-		 */
-		if (extents_locked)
-			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
-				      lockend, &cached_state);
-		else
-			free_extent_state(cached_state);
+					NULL, only_release_metadata);
 
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-		if (ret) {
-			btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
+		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
+		if (extents_locked)
+			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend, &cached_state);
+		if (ret)
 			break;
-		}
 
 		release_bytes = 0;
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
-		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
-
 		cond_resched();
 
 		pos += copied;
-- 
2.35.3

