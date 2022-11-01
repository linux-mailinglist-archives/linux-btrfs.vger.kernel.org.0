Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF79D6152EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKAUNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKAUNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20A1EAC1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E024B336C4;
        Tue,  1 Nov 2022 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+T3E4Aa7tocmlTYeeqduJk+3S4lgInD2PTEydAv61Lk=;
        b=DOSwWYC0j9hX595i3b8FOkk7pvOBfPUPDfikJfOopeZ0vIuuhTN1fpc9azl/sh+aTIzARu
        jUU88LV9/uUsLaZRGPI6dz//VhTBnM3IOJSvhE3m4nBvZBcbQDFAyuVG9PH3IJzPjrFTy9
        Y2mJBB2nYYHZGjp24Syq1f549rSLw2g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DA2412C141;
        Tue,  1 Nov 2022 20:13:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36D8DDA79D; Tue,  1 Nov 2022 21:12:45 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 30/40] btrfs: pass btrfs_inode to btrfs_split_delalloc_extent
Date:   Tue,  1 Nov 2022 21:12:45 +0100
Message-Id: <9b8a156fcea28eda80595b96f01e6c2597e949e7.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h    |  2 +-
 fs/btrfs/extent-io-tree.c |  2 +-
 fs/btrfs/inode.c          | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8a8280233199..ddf1867ba6d5 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -477,7 +477,7 @@ void btrfs_clear_delalloc_extent(struct inode *inode,
 				 struct extent_state *state, u32 bits);
 void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state *new,
 				 struct extent_state *other);
-void btrfs_split_delalloc_extent(struct inode *inode,
+void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *orig, u64 split);
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1b4c52d7201d..124aede5e492 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -461,7 +461,7 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node **node;
 
 	if (tree->inode)
-		btrfs_split_delalloc_extent(&tree->inode->vfs_inode, orig, split);
+		btrfs_split_delalloc_extent(tree->inode, orig, split);
 
 	prealloc->start = orig->start;
 	prealloc->end = split - 1;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c373125e13c2..9cbbccb2be5f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2277,10 +2277,10 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	return ret;
 }
 
-void btrfs_split_delalloc_extent(struct inode *inode,
+void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *orig, u64 split)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 size;
 
 	/* not delalloc, ignore it */
@@ -2304,9 +2304,9 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 			return;
 	}
 
-	spin_lock(&BTRFS_I(inode)->lock);
-	btrfs_mod_outstanding_extents(BTRFS_I(inode), 1);
-	spin_unlock(&BTRFS_I(inode)->lock);
+	spin_lock(&inode->lock);
+	btrfs_mod_outstanding_extents(inode, 1);
+	spin_unlock(&inode->lock);
 }
 
 /*
-- 
2.37.3

