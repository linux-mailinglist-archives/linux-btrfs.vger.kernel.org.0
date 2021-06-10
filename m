Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866873A23B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 07:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJFLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 01:11:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59002 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFJFLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 01:11:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4B304219A4;
        Thu, 10 Jun 2021 05:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623301763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTQ6bjaBNc9ISYxr+ZsoAIKCL1z8NX0FajDXmuPwGho=;
        b=SdVWhMy31P/P0y50g9OJK5rmTtu4pXT1h3O/OivLmeRxQwKk37qQInFhZooPEVIo8pJ4mN
        S8huLXrbHyeznaEHBSQdD0b/YQOSTpEioI+Hwsdjtbkedd+Huu+DFALVs8SqYHHwB0MyoQ
        HtyY+t/RkNiNicCSYnBheCkkLH+aCRk=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id AC9CEA3B81;
        Thu, 10 Jun 2021 05:09:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 01/10] btrfs: defrag: pass file_ra_state instead of file for btrfs_defrag_file()
Date:   Thu, 10 Jun 2021 13:09:08 +0800
Message-Id: <20210610050917.105458-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
References: <20210610050917.105458-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_defrag_file() accepts both "struct inode" and "struct
file" as parameter, which can't be more confusing.
As we can easily grab "struct inode" from "struct file" using
file_inode() helper.

The reason why we need "struct file" is just to re-use its f_ra.

This patch will change this by passing "struct file_ra_state" parameter,
so that it's more clear what we really want.

Since we're here, also add some comment on the function
btrfs_defrag_file() to make later reader less miserable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h |  4 ++--
 fs/btrfs/ioctl.c | 27 ++++++++++++++++++---------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 45798e68331a..918df8877b45 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3212,9 +3212,9 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
-int btrfs_defrag_file(struct inode *inode, struct file *file,
+int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
-		      u64 newer_than, unsigned long max_pages);
+		      u64 newer_than, unsigned long max_to_defrag);
 void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 11adf4670c55..05af6f5ff3ff 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1350,13 +1350,22 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
 }
 
-int btrfs_defrag_file(struct inode *inode, struct file *file,
+/*
+ * Btrfs entrace for defrag.
+ *
+ * @inode:	   Inode to be defragged
+ * @ra:		   Readahead state. If NULL, one will be allocated at runtime.
+ * @range:	   Defrag options including range and flags.
+ * @newer_than:	   Minimal transid to defrag
+ * @max_to_defrag: Max number of sectors to be defragged, if 0, the whole inode
+ *		   will be defragged.
+ */
+int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct file_ra_state *ra = NULL;
 	unsigned long last_index;
 	u64 isize = i_size_read(inode);
 	u64 last_len = 0;
@@ -1374,6 +1383,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 	u64 new_align = ~((u64)SZ_128K - 1);
 	struct page **pages = NULL;
 	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
+	bool ra_allocated = false;
 
 	if (isize == 0)
 		return 0;
@@ -1392,16 +1402,15 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		extent_thresh = SZ_256K;
 
 	/*
-	 * If we were not given a file, allocate a readahead context. As
+	 * If we were not given a ra, allocate a readahead context. As
 	 * readahead is just an optimization, defrag will work without it so
 	 * we don't error out.
 	 */
-	if (!file) {
+	if (!ra) {
+		ra_allocated = true;
 		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
 		if (ra)
 			file_ra_state_init(ra, inode->i_mapping);
-	} else {
-		ra = &file->f_ra;
 	}
 
 	pages = kmalloc_array(max_cluster, sizeof(struct page *), GFP_KERNEL);
@@ -1483,7 +1492,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 			ra_index = max(i, ra_index);
 			if (ra)
 				page_cache_sync_readahead(inode->i_mapping, ra,
-						file, ra_index, cluster);
+						NULL, ra_index, cluster);
 			ra_index += cluster;
 		}
 
@@ -1554,7 +1563,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
 		btrfs_inode_unlock(inode, 0);
 	}
-	if (!file)
+	if (ra_allocated)
 		kfree(ra);
 	kfree(pages);
 	return ret;
@@ -3076,7 +3085,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			/* the rest are all set to zero by kzalloc */
 			range->len = (u64)-1;
 		}
-		ret = btrfs_defrag_file(file_inode(file), file,
+		ret = btrfs_defrag_file(file_inode(file), &file->f_ra,
 					range, BTRFS_OLDEST_GENERATION, 0);
 		if (ret > 0)
 			ret = 0;
-- 
2.32.0

