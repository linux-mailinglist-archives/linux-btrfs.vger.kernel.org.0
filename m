Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC97A50267C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351312AbiDOIGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351300AbiDOIGk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 04:06:40 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025CFA1471
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 01:04:11 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650009849; bh=u6Vf4wA+ihq98SAbFDKwtFVLEsznxeXGsAx7Fdv3kjE=;
        h=From:To:Cc:Subject:Date;
        b=G/Tum1jiJBUiOKpjd8duyiudge2K4rSBekUamZcckhQerIibaIJP3aJnQB87O8Mhn
         ZLiB8jXj3AxLtxzdtvgrfxX8frEui/QyGAdznB0vwoJFiTgxyMdOz/A9lXB3U0vgAa
         A3DlXbrBXbfpysBx3xsk1YDLQacUHsy4YwVe8bHI=
To:     dsterba@suse.com, fdmanana@kernel.org
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH 1/2] btrfs: export a helper for compression hard check
Date:   Fri, 15 Apr 2022 16:04:05 +0800
Message-Id: <20220415080406.234967-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

inode_can_compress will be used outside of inode.c to check the
availability of setting compression flag by xattr. This patch moves
this function as an internal helper and renames it to
btrfs_inode_can_compress.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/btrfs/btrfs_inode.h | 11 +++++++++++
 fs/btrfs/inode.c       | 15 ++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 47e72d72f7d0..32131a5d321b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -384,6 +384,17 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	return ret;
 }
 
+/*
+ * Check if the inode has flags compatible with compression
+ */
+static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
+{
+	if (inode->flags & BTRFS_INODE_NODATACOW ||
+	    inode->flags & BTRFS_INODE_NODATASUM)
+		return false;
+	return true;
+}
+
 struct btrfs_dio_private {
 	struct inode *inode;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 17d5557f98ec..99725e5508f9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -480,17 +480,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
 	return 0;
 }
 
-/*
- * Check if the inode has flags compatible with compression
- */
-static inline bool inode_can_compress(struct btrfs_inode *inode)
-{
-	if (inode->flags & BTRFS_INODE_NODATACOW ||
-	    inode->flags & BTRFS_INODE_NODATASUM)
-		return false;
-	return true;
-}
-
 /*
  * Check if the inode needs to be submitted to compression, based on mount
  * options, defragmentation, properties or heuristics.
@@ -500,7 +489,7 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (!inode_can_compress(inode)) {
+	if (!btrfs_inode_can_compress(inode)) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
 			btrfs_ino(inode));
@@ -2020,7 +2009,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		       (zoned && btrfs_is_data_reloc_root(inode->root)));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
-	} else if (!inode_can_compress(inode) ||
+	} else if (!btrfs_inode_can_compress(inode) ||
 		   !inode_need_compress(inode, start, end)) {
 		if (zoned)
 			ret = run_delalloc_zoned(inode, locked_page, start, end,
-- 
2.34.1

