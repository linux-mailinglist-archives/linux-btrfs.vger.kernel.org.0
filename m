Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FF6A8BB5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCBWZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBWZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212DF1ABD1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5CC12237D;
        Thu,  2 Mar 2023 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4WThxZcQa544UM/K2TAl358TBd08zZ3lJ0tvpFv6Ss=;
        b=EC4D/DJLQAvNtq4By3pUK1oaF/XmFBEb8kV1jVK0nYQ4Vmz/20i9sEQi+Ct7HKTTNUpsSo
        envh3T1aWBAASkGHEYbdNppor2Nq/rL68JI/hue9faBMMRnHJ5SwIUBoBILLvrTDIn+5zV
        /4ZKYP2jtbqS62FndeEFL6j7e6oqE9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4WThxZcQa544UM/K2TAl358TBd08zZ3lJ0tvpFv6Ss=;
        b=j1OpGzgCZKEYGnaJt+sWyJXm0XKd3E8IIpw6+FLAdSOPWVEnwzAuD+Now+8kHlyrX0hjfI
        QMhlbuXdKwAojdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84DC813349;
        Thu,  2 Mar 2023 22:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VX4DFEkiAWShSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:13 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 05/21] btrfs: Lock extents before pages for buffered write()
Date:   Thu,  2 Mar 2023 16:24:50 -0600
Message-Id: <accc90edd4641a633fe23eae5088467977f8e436.1677793433.git.rgoldwyn@suse.com>
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

While performing writes, lock the extents before locking the pages.

Ideally, this should be done before  space reservations. However,
This is performed after check for space because qgroup initiates
writeback which may cause deadlocks.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 78 ++++++++++++-------------------------------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5..a2f8f566cfbf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -973,8 +973,8 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
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
@@ -982,7 +982,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 start_pos;
 	u64 last_pos;
-	int i;
 	int ret = 0;
 
 	start_pos = round_down(pos, fs_info->sectorsize);
@@ -993,15 +992,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 
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
@@ -1013,10 +1005,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		    ordered->file_offset <= last_pos) {
 			unlock_extent(&inode->io_tree, start_pos, last_pos,
 				      cached_state);
-			for (i = 0; i < num_pages; i++) {
-				unlock_page(pages[i]);
-				put_page(pages[i]);
-			}
 			btrfs_start_ordered_extent(ordered);
 			btrfs_put_ordered_extent(ordered);
 			return -EAGAIN;
@@ -1029,13 +1017,6 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
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
 
@@ -1299,13 +1280,22 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
@@ -1313,25 +1303,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
 
@@ -1380,33 +1354,19 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
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
2.39.2

