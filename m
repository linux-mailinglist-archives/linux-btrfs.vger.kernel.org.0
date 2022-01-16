Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D148FBCA
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiAPItE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPItD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:49:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57577C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:49:03 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso2833751pjh.0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=e3mvjCRCsR0Swov/K+9n7idBmM6wdvyYWBZQcPD4B9k=;
        b=UJkrpWWuhFUvUmb9AtBSaVo9Wcf93GPXVxVgiLhTf4sSw45d5dCGLc8jBA0PWwGq7N
         hKSmgfJ9FC1b7Otq2sZAubgV+DnCNli4nqNzq788X1muCOc7oOyxglIdfWie5WVUytIv
         AFPWC6iVmdAbGqdJmVJf+soHR3KTrb03OOIhMjwvKdyWxLRNxGe+MCZvkn62QSCwfOYr
         ffhSEb4CQQ5vPfTBY6RCIOWQe20R6tyI/gzQ3et/yQJtqH26mvtBDTLnaCTCRs6nhQnY
         W+YtsXQ3kEy87WC4+uPuRkZbScWaVeB9+88Vi2+wBGug5rOKpF00W+jpQlhD7WUV9YeI
         HoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e3mvjCRCsR0Swov/K+9n7idBmM6wdvyYWBZQcPD4B9k=;
        b=HL4X6hPYr6u77rJ/panz4eThHm4sjgOlbQM9cOwwXlPPfPMKKpJH+vKRhc1sdnmnO1
         XLnwWYB7lwjID2k+QZJhjnRyOO3zV5xgFXA3uZ3zRyS3KPQSBRu1gLgjcKdiP3EHVrTq
         F28wpXsOJ3jH1TLMbs/NzO7j4mSOndbTwNa2p7UZSxvoLCVFsqQ2ujiF1ZU4GgAMXboo
         jEkO2lyd4BQy3EJS7r4UaDIxGWKDRH7TME+v9N5WzshFiGFsUYc6u0aXRIGSRSpfgpOo
         vPZfmH/5VRnSmDMp5fjGGV1ssGQsPjhyY+rm95Am9kTnoWhbov7xMwRyhIXSmlXb6EJy
         09Rg==
X-Gm-Message-State: AOAM53316WpJt1AZrEtjAk3WRah18rp1Z7qVqDRPziqzWUqnzByt7ZWq
        93lXJmhZ0dAOi/QaSR5oPFX1UJ6W0D4ltLGF
X-Google-Smtp-Source: ABdhPJy1zmdQcuKffEZJoL30cAF2lAxyMhvA/8twj9VihuIPK0q1We40Cv2ZFUO1D3Gq+G4pwTldnQ==
X-Received: by 2002:a17:90b:384a:: with SMTP id nl10mr5114187pjb.233.1642322942337;
        Sun, 16 Jan 2022 00:49:02 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id ng18sm16964968pjb.36.2022.01.16.00.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:49:01 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 1/5] btrfs: Introduce memory-only flag BTRFS_INODE_HEURISTIC_NOCOMPRESS.
Date:   Sun, 16 Jan 2022 16:48:54 +0800
Message-Id: <1642322934-1804-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce the memory flag BTRFS_INODE_HEURISTIC_NOCOMPRESS which is kept
in memory only. This flag should be unset every time the filesystem writes
to disk.

1. If the compressed file is larger than the original size,
BTRFS_INODE_HEURISTIC_NOCOMPRESS will be set.

2. If the btrfs file system wants to write the btrfs_inode flag to
the disk or journal tree, the btrfs_inode flag should be and
with ~BTRFS_INODE_ONLY_MEM_FLAG_MASK to filter the memory-only flag.

3. In the inode_need_compress function, if btrfs_info is set to
BTRFS_INODE_HEURISTIC_NOCOMPRESS, it returns 0, which means
that the file is not compressed as much as possible.

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/ctree.h    | 13 ++++++++++++-
 fs/btrfs/inode.c    | 13 +++++++++----
 fs/btrfs/tree-log.c |  8 ++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b4a9b1c..754ac0f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1507,6 +1507,7 @@ enum {
 #define BTRFS_INODE_NOATIME		(1U << 9)
 #define BTRFS_INODE_DIRSYNC		(1U << 10)
 #define BTRFS_INODE_COMPRESS		(1U << 11)
+#define BTRFS_INODE_HEURISTIC_NOCOMPRESS  (1U << 12)
 
 #define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
 
@@ -1523,7 +1524,17 @@ enum {
 	 BTRFS_INODE_NOATIME |						\
 	 BTRFS_INODE_DIRSYNC |						\
 	 BTRFS_INODE_COMPRESS |						\
-	 BTRFS_INODE_ROOT_ITEM_INIT)
+	 BTRFS_INODE_ROOT_ITEM_INIT |               \
+     BTRFS_INODE_HEURISTIC_NOCOMPRESS )
+
+/*
+ * Inode only memory flags
+ */
+
+#define BTRFS_INODE_ONLY_MEM_FLAG_MASK  \
+    (BTRFS_INODE_HEURISTIC_NOCOMPRESS)
+
+
 
 #define BTRFS_INODE_RO_VERITY		(1U << 0)
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b2403b..3fe485b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -550,7 +550,8 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	if (inode->defrag_compress)
 		return 1;
 	/* bad compression ratios */
-	if (inode->flags & BTRFS_INODE_NOCOMPRESS)
+	if (inode->flags & BTRFS_INODE_NOCOMPRESS ||
+        inode->flags & BTRFS_INODE_HEURISTIC_NOCOMPRESS)
 		return 0;
 	if (btrfs_test_opt(fs_info, COMPRESS) ||
 	    inode->flags & BTRFS_INODE_COMPRESS ||
@@ -838,7 +839,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		/* flag the file so we don't compress in the future */
 		if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) &&
 		    !(BTRFS_I(inode)->prop_compress)) {
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
+			BTRFS_I(inode)->flags |= BTRFS_INODE_HEURISTIC_NOCOMPRESS;
 		}
 	}
 cleanup_and_bail_uncompressed:
@@ -3970,8 +3971,12 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
-	flags = btrfs_inode_combine_flags(BTRFS_I(inode)->flags,
-					  BTRFS_I(inode)->ro_flags);
+    /*
+     * get rid of memory only flag
+     */
+	flags = btrfs_inode_combine_flags(
+                    BTRFS_I(inode)->flags & ~BTRFS_INODE_ONLY_MEM_FLAG_MASK,
+					BTRFS_I(inode)->ro_flags);
 	btrfs_set_token_inode_flags(&token, item, flags);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c1ddbe8..2d4e5fc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4165,8 +4165,12 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
 	btrfs_set_token_inode_transid(&token, item, trans->transid);
 	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
-	flags = btrfs_inode_combine_flags(BTRFS_I(inode)->flags,
-					  BTRFS_I(inode)->ro_flags);
+    /*
+     * clear memory only flag
+     */
+	flags = btrfs_inode_combine_flags(
+                BTRFS_I(inode)->flags & ~BTRFS_INODE_ONLY_MEM_FLAG_MASK,
+			    BTRFS_I(inode)->ro_flags);
 	btrfs_set_token_inode_flags(&token, item, flags);
 	btrfs_set_token_inode_block_group(&token, item, 0);
 }
-- 
1.8.3.1

