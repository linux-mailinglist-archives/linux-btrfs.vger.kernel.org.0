Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4810DB5589
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfIQSn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:43:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34734 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfIQSn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so5168263qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1GMqWVBKJc3QOWMl5pxrGiyb3GprPkQHBSR+0/PEQJ4=;
        b=Bj55mCb7COz8qRloOxjS2fbgsenvfD37QnUIJwltlOm5ZCWUoxk3nUDAPsi6lUA1px
         EaSb8b7+VgekQvVBtXqqdV/aNMu+zroqHXvlXPZHcJZL/XeqvqEiKXBc1uO9vro4GeY9
         g8+LA7uuEm5I6Z31dRUWxbpjweBNmSW7+g6sZT9IW+8V94pMcYzcCbH1VpBujIqj/K6Q
         UUQCmJKGMxxL03SZOGl9tBWMntGFfoi2AZTx7cKCWs21hfMyohyTE4fInazJ6mnE4kvA
         oNew3j2Rr6RqE6JEaaN/c2iLTX6mSF5ZuLfhyrPqQKPlvYNwOyQBoXtvfOl+3i0TLisH
         pofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GMqWVBKJc3QOWMl5pxrGiyb3GprPkQHBSR+0/PEQJ4=;
        b=HtGBMh6+Hw+x3J4OY5WzeLxqIN8heH8vLZYWBjh1P5V8RCAyP1qsIr/Nakbp0LZPYf
         +39Umm3q84reZO5k/FK7MDstvvb4zPUV3AQrKvYwfXfT18vSnEW500+1b6sLfN78S9Hw
         Johf1djla+KKpbmpDVzulSMCMnK1qUFcgT3od1MtinStcvBvRMcTC3vD0indYgJEvOXH
         Kn/ftbtC8eoWfze/CeCozQ6vlgVkZe3TSPSgZD6DmD22Xm4OnyvoRcnqape+6/8HrYFG
         fMl3zeSmIuJ1prt6MnP7FFJye+FyFIbay1PmyPAxsdPFjs4NDDbTN8ZaPaTRVCyY4BC1
         unyA==
X-Gm-Message-State: APjAAAVnpQxTyl6jzDRbD0P+4JZcJY5iBAvphRviBHLUjDIJwOTHcQtT
        jz2Sm++eylX0coUzmGILOrrPn7RLj4MVsg==
X-Google-Smtp-Source: APXvYqy1amvOuoe9WuXHUSYQpCTUfaKClIljy9ZNbXW1VaQNVUDe+32bwaKfX4reWG70/uxkc3tz/A==
X-Received: by 2002:ae9:e902:: with SMTP id x2mr5537500qkf.293.1568745833950;
        Tue, 17 Sep 2019 11:43:53 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a190sm1830381qkf.118.2019.09.17.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: export find_delalloc_range
Date:   Tue, 17 Sep 2019 14:43:38 -0400
Message-Id: <20190917184344.13155-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This utilizes internal stuff to the extent_io_tree, so we need to export
it before we move it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h |  3 +++
 fs/btrfs/extent_io.c      | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6f53387445ca..02fbb0d4fa88 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -223,5 +223,8 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int extent_invalidatepage(struct extent_io_tree *tree,
 			  struct page *page, unsigned long offset);
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f5945f0a06da..c47cc2586b37 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1687,9 +1687,9 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  *
  * true is returned if we find something, false if nothing was in the tree
  */
-static noinline bool find_delalloc_range(struct extent_io_tree *tree,
-					u64 *start, u64 *end, u64 max_bytes,
-					struct extent_state **cached_state)
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -1807,8 +1807,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
-	found = find_delalloc_range(tree, &delalloc_start, &delalloc_end,
-				    max_bytes, &cached_state);
+	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
+					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start) {
 		*start = delalloc_start;
 		*end = delalloc_end;
-- 
2.21.0

