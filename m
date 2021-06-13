Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820F03A58C0
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhFMNmX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:23 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71A9621972;
        Sun, 13 Jun 2021 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaWqpBXHLJh12ZyzW3RVu6eaJSWxCUfEnSj+SOEakZI=;
        b=Ta9g42fVk0R+1hLlW1+v6W2AF0/Ti7diOD1IhbdQQK794Wwtq9uUdBTSJ/j5aPCzbzb1ud
        BRAWzLZ0PmD2vmHFb+DJ90AsWdWPwzYA5iUKtplqGXMd/x55Lcrt8vHZ2+afVPSQK2a999
        dHsoM5jWBS3NjO1lOEp35E6lcf65VG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaWqpBXHLJh12ZyzW3RVu6eaJSWxCUfEnSj+SOEakZI=;
        b=TRwPehKM29qyqbCh1PhUOvyD+ojnkgX9/574ISGUKt6fgtU4oiIWmytTkx94tJuq6DUZZA
        JQdxIxpLALoDpLAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 15ABE118DD;
        Sun, 13 Jun 2021 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaWqpBXHLJh12ZyzW3RVu6eaJSWxCUfEnSj+SOEakZI=;
        b=Ta9g42fVk0R+1hLlW1+v6W2AF0/Ti7diOD1IhbdQQK794Wwtq9uUdBTSJ/j5aPCzbzb1ud
        BRAWzLZ0PmD2vmHFb+DJ90AsWdWPwzYA5iUKtplqGXMd/x55Lcrt8vHZ2+afVPSQK2a999
        dHsoM5jWBS3NjO1lOEp35E6lcf65VG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591621;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaWqpBXHLJh12ZyzW3RVu6eaJSWxCUfEnSj+SOEakZI=;
        b=TRwPehKM29qyqbCh1PhUOvyD+ojnkgX9/574ISGUKt6fgtU4oiIWmytTkx94tJuq6DUZZA
        JQdxIxpLALoDpLAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id D6gLNcQKxmA/JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:20 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 05/31] btrfs: writepage() lock extent before pages
Date:   Sun, 13 Jun 2021 08:39:33 -0500
Message-Id: <412df27129a676f4bca6724960350569573a3791.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock Order change: Extent locks before page locks

writepage() is called with the page locked. So make an attempt
to lock the extents and proceed only if successful.

The new function best_effort_lock_extent() attempts to lock the range
provided.

If the entire range was not locked, but it still covers the locked
page, work with the reduced range by resetting delalloc_end()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 66 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..75ad809e8c86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1488,6 +1488,47 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 	return 1;
 }
 
+/*
+ * best_effort_lock_extent() - locks the extent to the best of effort
+ * making sure the minimum range is locked and the
+ * delalloc bits are set. If the full requested range is not locked,
+ * delalloc_end shifts to until the range that can be locked.
+ */
+static bool best_effort_lock_extent(struct extent_io_tree *tree, u64 start,
+		u64 *delalloc_end, u64 min_end, struct extent_state **cached_state)
+{
+	u64 failed_start;
+	u64 end = *delalloc_end;
+	int ret;
+
+	ret = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
+			     &failed_start, cached_state, GFP_NOFS, NULL);
+
+	if (!ret)
+		return false;
+
+	if (failed_start < min_end) {
+		/* Could not lock the whole range */
+		if (failed_start > start)
+			unlock_extent_cached(tree, start,
+					failed_start - 1, cached_state);
+		return false;
+	} else if (end > failed_start) {
+		/* Work with what could be locked */
+		end = failed_start - 1;
+	}
+
+	/* Check if delalloc bits are set */
+	ret = test_range_bit(tree, start, end,
+			     EXTENT_DELALLOC, 1, *cached_state);
+	if (!ret) {
+		unlock_extent_cached(tree, start, end - 1, cached_state);
+		return false;
+	}
+	*delalloc_end = end;
+	return true;
+}
+
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
@@ -2018,7 +2059,16 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	if (delalloc_end + 1 - delalloc_start > max_bytes)
 		delalloc_end = delalloc_start + max_bytes - 1;
 
-	/* step two, lock all the pages after the page that has start */
+	/* step two, lock the state bits for the range */
+	found = best_effort_lock_extent(tree, delalloc_start, &delalloc_end,
+			((page_index(locked_page) + 1) << PAGE_SHIFT),
+			&cached_state);
+	if (!found) {
+		free_extent_state(cached_state);
+		goto out_failed;
+	}
+
+	/* step three, lock all the pages after the page that has start */
 	ret = lock_delalloc_pages(inode, locked_page,
 				  delalloc_start, delalloc_end);
 	ASSERT(!ret || ret == -EAGAIN);
@@ -2038,20 +2088,6 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 		}
 	}
 
-	/* step three, lock the state bits for the whole range */
-	lock_extent_bits(tree, delalloc_start, delalloc_end, &cached_state);
-
-	/* then test to make sure it is all still delalloc */
-	ret = test_range_bit(tree, delalloc_start, delalloc_end,
-			     EXTENT_DELALLOC, 1, cached_state);
-	if (!ret) {
-		unlock_extent_cached(tree, delalloc_start, delalloc_end,
-				     &cached_state);
-		__unlock_for_delalloc(inode, locked_page,
-			      delalloc_start, delalloc_end);
-		cond_resched();
-		goto again;
-	}
 	free_extent_state(cached_state);
 	*start = delalloc_start;
 	*end = delalloc_end;
-- 
2.31.1

