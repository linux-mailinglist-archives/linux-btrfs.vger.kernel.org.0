Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE35F1402
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiI3Upy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiI3Upb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:31 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977749B42
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id jy22so2986933qvb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=7G0VBfrFSnmesaUv90Ni1HN/o+XFwj9kArRQdCGAzcw=;
        b=nYHj7JlZRIpuqBzhEr+X4oj7Fc4TsNblbyRxelmSD3p2twaaodayjlQbFG4tkWUPJl
         25pbbqdBBPUkAmeY4rWeOh0e/rHhnHybKpKXsa9R5KHnEQPfR/FCvy5mokt1cxe9fK5d
         qBFDzxbyJ4ZX7I4TRWInWtmOED8X2OGIwdfFvy/H40sFFxg4QYVad8LMb1d/0WTpw/Tj
         XHi5Gx7Gcbj2ygXv9iVam9ErtHdpRghXMy+W+Wrx1hejp2stFgg6IAm+WrHcnh7FU9Mz
         BhjGSxc9oE5kEcNZc6rNMKetSPwdrcWb+R46oLjtf3QY54iJ6BZX26UH4yvcwhwI/Luh
         0Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7G0VBfrFSnmesaUv90Ni1HN/o+XFwj9kArRQdCGAzcw=;
        b=Yf5bw/yQ9LPYdgJ9Lyig2bAn4h90T/rQFdQRQVaVRmX9qfxTzDVsqc6GVp2CjbLYut
         rEp9/eV0laulauP0CoaEbT3iPuap1N2GtjyyH5gdpSzgFfm122wpqrkaZGfKm+oZimtL
         UOj/j7T26+DjY8xZ98f7kVVFtW51uIe2bQVmWPQdE1d7C5ZpJSb8TrrCCI26p4nb6rBF
         NSeJY3pAmqfyX4LH/src407S4qXwtrMcET5aB165UPd4hltRhHxQtc4uPpxuXbzV+LZE
         y3dAmjpyFxyRWZCUwbw9LFgCdfbhjzhUnWf0iNJHXVNz40dZ63lqAv6wnXvwUVJSJkZF
         jXhg==
X-Gm-Message-State: ACrzQf1mx2KbQFFsATVU8Mi8flxaeJysS5KI+0yNgSY2ymMTvWLSJbxW
        Ta5WF4BnWJAeK+8I9mClQc7z2fVDZVXKcg==
X-Google-Smtp-Source: AMsMyM6rqETvxMa0wwzShMKXv1nKYFyM2qXafsBLAupVxh5bE/Uts6SZ0QZvo5tGVY5kiTfG4Fg1iw==
X-Received: by 2002:ad4:5e86:0:b0:4aa:b556:6447 with SMTP id jl6-20020ad45e86000000b004aab5566447mr8520228qvb.121.1664570726193;
        Fri, 30 Sep 2022 13:45:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a410300b006b5bf5d45casm3797569qko.27.2022.09.30.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: add a cached_state to try_lock_extent
Date:   Fri, 30 Sep 2022 16:45:09 -0400
Message-Id: <4462e764a291ae5a247ede78962c985c8163fca4.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With nowait becoming more pervasive throughout our codebase go ahead and
add a cached_state to try_lock_extent().  This allows us to be faster
about clearing the locked area if we have contention, and then gives us
the same optimization for unlock if we are able to lock the range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 7 ++++---
 fs/btrfs/extent-io-tree.h | 3 ++-
 fs/btrfs/extent_io.c      | 3 ++-
 fs/btrfs/file.c           | 3 ++-
 fs/btrfs/inode.c          | 3 ++-
 fs/btrfs/ordered-data.c   | 2 +-
 fs/btrfs/relocation.c     | 2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 83cb0378096f..1b0a45b51f4c 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1615,17 +1615,18 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 				  changeset);
 }
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		    struct extent_state **cached)
 {
 	int err;
 	u64 failed_start;
 
 	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
-			       NULL, NULL, GFP_NOFS);
+			       cached, NULL, GFP_NOFS);
 	if (err == -EEXIST) {
 		if (failed_start > start)
 			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, NULL);
+					 EXTENT_LOCKED, cached);
 		return 0;
 	}
 	return 1;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index a855f40dd61d..786be8f38f0b 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -106,7 +106,8 @@ void extent_io_tree_release(struct extent_io_tree *tree);
 int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 		struct extent_state **cached);
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end);
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		    struct extent_state **cached);
 
 int __init extent_state_init_cachep(void);
 void __cold extent_state_free_cachep(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eae68fbae21..e29e8aafc3b7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4962,7 +4962,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 
 	if (wait == WAIT_NONE) {
-		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1))
+		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
+				     NULL))
 			return -EAGAIN;
 	} else {
 		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1, NULL);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 176b432035ae..64bf29848723 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1302,7 +1302,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 		struct btrfs_ordered_extent *ordered;
 
 		if (nowait) {
-			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos)) {
+			if (!try_lock_extent(&inode->io_tree, start_pos, last_pos,
+					     cached_state)) {
 				for (i = 0; i < num_pages; i++) {
 					unlock_page(pages[i]);
 					put_page(pages[i]);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45ebef8d3ea8..c5630a3b8011 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7255,7 +7255,8 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 	while (1) {
 		if (nowait) {
-			if (!try_lock_extent(io_tree, lockstart, lockend))
+			if (!try_lock_extent(io_tree, lockstart, lockend,
+					     cached_state))
 				return -EAGAIN;
 		} else {
 			lock_extent(io_tree, lockstart, lockend, cached_state);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e54f8280031f..b648c9d4ea0f 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1073,7 +1073,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end)
 {
 	struct btrfs_ordered_extent *ordered;
 
-	if (!try_lock_extent(&inode->io_tree, start, end))
+	if (!try_lock_extent(&inode->io_tree, start, end, NULL))
 		return false;
 
 	ordered = btrfs_lookup_ordered_range(inode, start, end - start + 1);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 666a37a0ee89..e81a21082e58 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1120,7 +1120,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
 				end--;
 				ret = try_lock_extent(&BTRFS_I(inode)->io_tree,
-						      key.offset, end);
+						      key.offset, end, NULL);
 				if (!ret)
 					continue;
 
-- 
2.26.3

