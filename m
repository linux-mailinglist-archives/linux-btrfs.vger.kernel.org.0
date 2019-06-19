Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8E4C14A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfFSTMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 15:12:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41515 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 15:12:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so331882qtj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UDgbdJIL2LebKuPbzcFn2XKYOaxASzAx8dKue1mBS5Y=;
        b=X8YOJvLKB8pBIqpcUVerptnp+nk+jUQP7tJrexjqmtyX/efk5lzsSKlMCeT/w3JaVJ
         mkCUHVAjI4yh0NPMcyTi95aeooU3xegXWWZL4oMadzRPK9gtBYxub2gikNbDz6ODPUxV
         nuElpx2DweGXNHzLms0b+lUtkNjvASXtOgyxJ9hY2P4i4viJG7KMq0O5/d99JDphUDXz
         GgL6/59qxPHfu+UEwr/oNj/J5Ol+LwMHp1jlv9t2do5HapDUZAMLPa/db2eFPB25hQfY
         BQLIyXkkbbtj4T1gmE+OdSrOz6CVdLwHB3XtW+uaxPILVswFtmQUrcSo5WO62FBcUgbB
         Ve8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UDgbdJIL2LebKuPbzcFn2XKYOaxASzAx8dKue1mBS5Y=;
        b=cN0GryXnj8qZ2ioPht86JynitR2vPEbur0schsZ1I+b2IqzOe9vGbFQRsQHKx5uRJr
         rxtHRZmzQRuWBCNqExLKrxck6VaO414FKHgjgvpskbsY4qoHujhfIRZRLeOpJLfnHBiq
         qStMj4UWJvXeI01F5Mzcn5fRyD/Wmea0jhXQh/IeQ0fYN+NOyQ6979wQDi5H/DqbeGkQ
         eWl5LZldrF8Zd57QB5RKWPeMkFBDD8hBuA+XPhfV33YKLz/aGNWVcsoL6UUPuN1abQra
         +ZVmq38yOlwW5oa1EdND/zSJI40APK2Qwvzi/sDoDOFGim4vLj5L+pD93sBD+CG/w1P5
         hkmw==
X-Gm-Message-State: APjAAAUsqSFp3LBqUJV6kuSwycpD2ErdFyH5jrGZ7BRnv0j6DdVg2W4H
        mgfryuHjuAsvpsqOVDCB5KcMleiP480hUg==
X-Google-Smtp-Source: APXvYqzXQvJ4+EZRcm8Q1e3BXnH0+M2J0xNAKrEGCmNC0ATjxdgVFaafIQUHwgRndgcoW7N3KTvwsw==
X-Received: by 2002:aed:36c5:: with SMTP id f63mr2860014qtb.239.1560971530731;
        Wed, 19 Jun 2019 12:12:10 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m6sm9399891qte.17.2019.06.19.12.12.09
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:12:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: move the subvolume reservation stuff out of extent-tree.c
Date:   Wed, 19 Jun 2019 15:12:01 -0400
Message-Id: <20190619191201.16689-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619191201.16689-1-josef@toxicpanda.com>
References: <20190619191201.16689-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is just two functions, put it in root-tree.c since it involves root
items.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 54 ------------------------------------------------
 fs/btrfs/root-tree.c   | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c407e3188845..a0115e019ee8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4107,60 +4107,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-/*
- * btrfs_subvolume_reserve_metadata() - reserve space for subvolume operation
- * root: the root of the parent directory
- * rsv: block reservation
- * items: the number of items that we need do reservation
- * use_global_rsv: allow fallback to the global block reservation
- *
- * This function is used to reserve the space for snapshot/subvolume
- * creation and deletion. Those operations are different with the
- * common file/directory operations, they change two fs/file trees
- * and root tree, the number of items that the qgroup reserves is
- * different with the free space reservation. So we can not use
- * the space reservation mechanism in start_transaction().
- */
-int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
-				     struct btrfs_block_rsv *rsv, int items,
-				     bool use_global_rsv)
-{
-	u64 qgroup_num_bytes = 0;
-	u64 num_bytes;
-	int ret;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
-
-	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
-		/* One for parent inode, two for dir entries */
-		qgroup_num_bytes = 3 * fs_info->nodesize;
-		ret = btrfs_qgroup_reserve_meta_prealloc(root,
-				qgroup_num_bytes, true);
-		if (ret)
-			return ret;
-	}
-
-	num_bytes = btrfs_calc_trans_metadata_size(fs_info, items);
-	rsv->space_info = btrfs_find_space_info(fs_info,
-					    BTRFS_BLOCK_GROUP_METADATA);
-	ret = btrfs_block_rsv_add(root, rsv, num_bytes,
-				  BTRFS_RESERVE_FLUSH_ALL);
-
-	if (ret == -ENOSPC && use_global_rsv)
-		ret = btrfs_block_rsv_migrate(global_rsv, rsv, num_bytes, true);
-
-	if (ret && qgroup_num_bytes)
-		btrfs_qgroup_free_meta_prealloc(root, qgroup_num_bytes);
-
-	return ret;
-}
-
-void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
-				      struct btrfs_block_rsv *rsv)
-{
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
-}
-
 static int update_block_group(struct btrfs_trans_handle *trans,
 			      u64 bytenr, u64 num_bytes, int alloc)
 {
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 22124122728c..47733fb55df7 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -9,6 +9,8 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "print-tree.h"
+#include "qgroup.h"
+#include "space-info.h"
 
 /*
  * Read a root item from the tree. In case we detect a root item smaller then
@@ -497,3 +499,57 @@ void btrfs_update_root_times(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_nsec(&item->ctime, ct.tv_nsec);
 	spin_unlock(&root->root_item_lock);
 }
+
+/*
+ * btrfs_subvolume_reserve_metadata() - reserve space for subvolume operation
+ * root: the root of the parent directory
+ * rsv: block reservation
+ * items: the number of items that we need do reservation
+ * use_global_rsv: allow fallback to the global block reservation
+ *
+ * This function is used to reserve the space for snapshot/subvolume
+ * creation and deletion. Those operations are different with the
+ * common file/directory operations, they change two fs/file trees
+ * and root tree, the number of items that the qgroup reserves is
+ * different with the free space reservation. So we can not use
+ * the space reservation mechanism in start_transaction().
+ */
+int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
+				     struct btrfs_block_rsv *rsv, int items,
+				     bool use_global_rsv)
+{
+	u64 qgroup_num_bytes = 0;
+	u64 num_bytes;
+	int ret;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		/* One for parent inode, two for dir entries */
+		qgroup_num_bytes = 3 * fs_info->nodesize;
+		ret = btrfs_qgroup_reserve_meta_prealloc(root,
+				qgroup_num_bytes, true);
+		if (ret)
+			return ret;
+	}
+
+	num_bytes = btrfs_calc_trans_metadata_size(fs_info, items);
+	rsv->space_info = btrfs_find_space_info(fs_info,
+					    BTRFS_BLOCK_GROUP_METADATA);
+	ret = btrfs_block_rsv_add(root, rsv, num_bytes,
+				  BTRFS_RESERVE_FLUSH_ALL);
+
+	if (ret == -ENOSPC && use_global_rsv)
+		ret = btrfs_block_rsv_migrate(global_rsv, rsv, num_bytes, true);
+
+	if (ret && qgroup_num_bytes)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_num_bytes);
+
+	return ret;
+}
+
+void btrfs_subvolume_release_metadata(struct btrfs_fs_info *fs_info,
+				      struct btrfs_block_rsv *rsv)
+{
+	btrfs_block_rsv_release(fs_info, rsv, (u64)-1);
+}
-- 
2.14.3

