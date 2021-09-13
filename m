Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E5408C78
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhIMNTz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:19:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhIMNSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0632A21FEA;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ELKfB0wS2JMFkwwip3HTY+dG+iHdYfDky85+wbq8+I=;
        b=pYRQoSvxSX56pCLLex24SswZqFzQPS13nAEMsCCTEnE6plQcFpXg35b2TNAaryo/Cwlbt0
        mOUDlOB+iDgEammp6BIO+xR//mI6sOcPqcZ0OayyPmVO2p9Xl9JqGv6ehnCjWfSq4i/+yI
        YgmH1mhHNzlaYJaDT06LeQnK18dIO9g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9B9213AB4;
        Mon, 13 Sep 2021 13:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHysLmtPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:31 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/8] btrfs-progs: Remove root argument from btrfs_truncate_item
Date:   Mon, 13 Sep 2021 16:17:25 +0300
Message-Id: <20210913131729.37897-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function lies in the kernel-shared directory and is supposed to be
close to 1:1 copy with its kernel counterpart, yet it takes one extra
argument - root. But this is now unused to simply remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel-shared/ctree.c       | 3 +--
 kernel-shared/ctree.h       | 3 +--
 kernel-shared/dir-item.c    | 2 +-
 kernel-shared/extent-tree.c | 2 +-
 kernel-shared/file-item.c   | 4 ++--
 kernel-shared/inode-item.c  | 4 ++--
 6 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 77766c2a7931..78f94c6cd42f 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2545,8 +2545,7 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *path,
-			u32 new_size, int from_end)
+int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 {
 	int ret = 0;
 	int slot;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a17bf50e29b4..91a85796a678 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2670,8 +2670,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 objectid);
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		u32 data_size);
-int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *path,
-			u32 new_size, int from_end);
+int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 7dc606c132b5..590b79a929d3 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -284,7 +284,7 @@ int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 		start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 		memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			item_len - (ptr + sub_item_len - start));
-		btrfs_truncate_item(root, path, item_len - sub_item_len, 1);
+		btrfs_truncate_item(path, item_len - sub_item_len, 1);
 	}
 	return ret;
 }
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 056a9256b9a4..a8e0c1e60e2e 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1166,7 +1166,7 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
 			memmove_extent_buffer(leaf, ptr, ptr + size,
 					      end - ptr - size);
 		item_size -= size;
-		ret = btrfs_truncate_item(root, path, item_size, 1);
+		ret = btrfs_truncate_item(path, item_size, 1);
 		BUG_ON(ret);
 	}
 	btrfs_mark_buffer_dirty(leaf);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 7e16b747e36c..c910e27e5a5d 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -362,7 +362,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		 */
 		u32 new_size = (bytenr - key->offset) / blocksize;
 		new_size *= csum_size;
-		ret = btrfs_truncate_item(root, path, new_size, 1);
+		ret = btrfs_truncate_item(path, new_size, 1);
 		BUG_ON(ret);
 	} else if (key->offset >= bytenr && csum_end > end_byte &&
 		   end_byte > key->offset) {
@@ -375,7 +375,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		u32 new_size = (csum_end - end_byte) / blocksize;
 		new_size *= csum_size;
 
-		ret = btrfs_truncate_item(root, path, new_size, 0);
+		ret = btrfs_truncate_item(path, new_size, 0);
 		BUG_ON(ret);
 
 		key->offset = end_byte;
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index 4e009746de0e..67173eb141d8 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -311,7 +311,7 @@ int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	memmove_extent_buffer(leaf, ptr, ptr + del_len,
 			      item_size - (ptr + del_len - item_start));
 
-	btrfs_truncate_item(root, path, item_size - del_len, 1);
+	btrfs_truncate_item(path, item_size - del_len, 1);
 
 out:
 	btrfs_free_path(path);
@@ -432,7 +432,7 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	item_start = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	memmove_extent_buffer(leaf, ptr, ptr + sub_item_len,
 			      item_size - (ptr + sub_item_len - item_start));
-	btrfs_truncate_item(root, path, item_size - sub_item_len, 1);
+	btrfs_truncate_item(path, item_size - sub_item_len, 1);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 out:
 	btrfs_free_path(path);
-- 
2.17.1

