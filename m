Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F58710184
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjEXXKd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 19:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEXXKc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 19:10:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06F999
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 16:10:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6AE7321D39;
        Wed, 24 May 2023 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684969830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEKwnrW6pE2XBy6avslAJH5Kun/LZTa9iDzrXL1yh/4=;
        b=Cj1+lPFq/IEXeKDw/BfRsqQ68N1+mirzDF93M/u0V7Cpnul1EmX5lljHybbC3yLjY0DVBK
        cop098s81QhA/3wtFxF4ob8JV1VN4Kc7jvCObXm2zoSeww9iikoPclOfor0tG7bykpGsjS
        FmE0fgwCZv09bh4LFlKRvWyBYZHPAkA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5B1912C141;
        Wed, 24 May 2023 23:10:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02ECFDA85B; Thu, 25 May 2023 01:04:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/9] btrfs: open code set_extent_delalloc
Date:   Thu, 25 May 2023 01:04:23 +0200
Message-Id: <7a0532b77dd6f3571da6b17228bb19501e9b3f26.1684967923.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684967923.git.dsterba@suse.com>
References: <cover.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper is used once in fs code and a few times in the self test
code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h        | 9 ---------
 fs/btrfs/inode.c                 | 4 ++--
 fs/btrfs/tests/extent-io-tests.c | 6 +++---
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ea344e5ca24f..e5289d67b6b7 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -193,15 +193,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		       u32 bits, u32 clear_bits,
 		       struct extent_state **cached_state);
 
-static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
-				      u64 end, u32 extra_bits,
-				      struct extent_state **cached_state)
-{
-	return set_extent_bit(tree, start, end,
-			      EXTENT_DELALLOC | extra_bits,
-			      cached_state, GFP_NOFS);
-}
-
 static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
 		u64 end)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e83fb225052..6144a2b89db2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2922,8 +2922,8 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			return ret;
 	}
 
-	return set_extent_delalloc(&inode->io_tree, start, end, extra_bits,
-				   cached_state);
+	return set_extent_bit(&inode->io_tree, start, end,
+			      EXTENT_DELALLOC | extra_bits, cached_state, GFP_NOFS);
 }
 
 /* see btrfs_writepage_start_hook for details on why this is required */
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index dfc5c7fa6038..b9de94a50868 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -159,7 +159,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 * |--- delalloc ---|
 	 * |---  search  ---|
 	 */
-	set_extent_delalloc(tmp, 0, sectorsize - 1, 0, NULL);
+	set_extent_bit(tmp, 0, sectorsize - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
 	start = 0;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
@@ -190,7 +190,7 @@ static int test_find_delalloc(u32 sectorsize)
 		test_err("couldn't find the locked page");
 		goto out_bits;
 	}
-	set_extent_delalloc(tmp, sectorsize, max_bytes - 1, 0, NULL);
+	set_extent_bit(tmp, sectorsize, max_bytes - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
@@ -245,7 +245,7 @@ static int test_find_delalloc(u32 sectorsize)
 	 *
 	 * We are re-using our test_start from above since it works out well.
 	 */
-	set_extent_delalloc(tmp, max_bytes, total_dirty - 1, 0, NULL);
+	set_extent_bit(tmp, max_bytes, total_dirty - 1, EXTENT_DELALLOC, NULL, GFP_NOFS);
 	start = test_start;
 	end = start + PAGE_SIZE - 1;
 	found = find_lock_delalloc_range(inode, locked_page, &start,
-- 
2.40.0

