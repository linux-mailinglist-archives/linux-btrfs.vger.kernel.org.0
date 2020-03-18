Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6B318A3DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRUkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:40:23 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:31316 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:40:23 -0400
X-Greylist: delayed 1294 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 16:40:23 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 6DEA02CE60
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:55 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9Tj3vXJ8vkBEf9Tjv9Ga; Wed, 18 Mar 2020 15:18:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2kZwrVJXQnHBOYUdClAiEtoWTFk30qt64/jtbofxREU=; b=umhzgqdC63rW4H7NgnlUaU8HKS
        HgPJyAtfqIeCUe90FppEbT6daFJW8oERD612T7F+F1Rvu7Bb1OEZBofWJvhZEuAe1yk4N1MImPux9
        7R1V7DUCGuRgu/rz+BJ79aVgrsIdx9pv7hZ7QNyp0TftJcyA2sjzQJQY9hsKDSNcy2baq1XDiaD0d
        nAtC9mreZ+dH6w6VqWsasgsFcHckftjL0zcF92pCyFiM1a7lRdl9ZOlUzqAgcB5LrsJ4R4HQnvDxE
        nKUXJ7ziHByf9bzilhxlZbJT7WPI6Ylc4WApzkKpskVpvAbJR0xiVDn5M4OwhLBL/i0zqGMUxFsyJ
        MFcxthbw==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9S-000yAj-FG; Wed, 18 Mar 2020 17:18:54 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 06/11] btrfs-progs: ctree: Introduce function to create an empty tree
Date:   Wed, 18 Mar 2020 17:21:43 -0300
Message-Id: <20200318202148.14828-7-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEf9S-000yAj-FG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 22
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Introduce a new function, btrfs_create_tree(), to create an empty tree.

Currently, there is only one caller to create new tree, namely
data reloc tree in mkfs.
However it's copying fs tree to create a new root.

This copy fs tree method is not a good idea if we only need an empty
tree.

So here introduce a new function, btrfs_create_tree() to create new
tree.
Which will handle the following things:
1) New tree root leaf
   Using generic tree allocation

2) New root item in tree root

3) Modify special tree root pointers in fs_info
   Only quota_root is supported yet, but can be expended easily

This patch provides the basis to implement quota support in mkfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[ solved minor conflicts ]
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 ctree.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ctree.h |   2 ++
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/ctree.c b/ctree.c
index 97b44d48..49598a45 100644
--- a/ctree.c
+++ b/ctree.c
@@ -21,8 +21,9 @@
 #include "print-tree.h"
 #include "repair.h"
 #include "common/internal.h"
-#include "kernel-lib/sizes.h"
 #include "common/messages.h"
+#include "common/utils.h"
+#include "kernel-lib/sizes.h"
 #include "volumes.h"
 
 static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
@@ -182,6 +183,112 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+/*
+ * Create a new tree root, with root objectid set to @objectid.
+ *
+ * NOTE: Doesn't support tree with non-zero offset, like data reloc tree.
+ */
+int btrfs_create_root(struct btrfs_trans_handle *trans,
+		      struct btrfs_fs_info *fs_info, u64 objectid)
+{
+	struct extent_buffer *node;
+	struct btrfs_root *new_root;
+	struct btrfs_disk_key disk_key;
+	struct btrfs_key location;
+	struct btrfs_root_item root_item = { 0 };
+	int ret;
+
+	new_root = malloc(sizeof(*new_root));
+	if (!new_root)
+		return -ENOMEM;
+
+	btrfs_setup_root(new_root, fs_info, objectid);
+	if (!is_fstree(objectid))
+		new_root->track_dirty = 1;
+	add_root_to_dirty_list(new_root);
+
+	new_root->objectid = objectid;
+	new_root->root_key.objectid = objectid;
+	new_root->root_key.type = BTRFS_ROOT_ITEM_KEY;
+	new_root->root_key.offset = 0;
+
+	node = btrfs_alloc_free_block(trans, new_root, fs_info->nodesize,
+				      objectid, &disk_key, 0, 0, 0);
+	if (IS_ERR(node)) {
+		ret = PTR_ERR(node);
+		error("failed to create root node for tree %llu: %d (%s)",
+		      objectid, ret, strerror(-ret));
+		return ret;
+	}
+	new_root->node = node;
+
+	btrfs_set_header_generation(node, trans->transid);
+	btrfs_set_header_backref_rev(node, BTRFS_MIXED_BACKREF_REV);
+	btrfs_clear_header_flag(node, BTRFS_HEADER_FLAG_RELOC |
+				      BTRFS_HEADER_FLAG_WRITTEN);
+	btrfs_set_header_owner(node, objectid);
+	btrfs_set_header_nritems(node, 0);
+	btrfs_set_header_level(node, 0);
+	ret = btrfs_inc_ref(trans, new_root, node, 0);
+	if (ret < 0)
+		goto free;
+
+	/*
+	 * Special tree roots may need to modify pointers in @fs_info
+	 * Only quota is supported yet.
+	 */
+	switch (objectid) {
+	case BTRFS_QUOTA_TREE_OBJECTID:
+		if (fs_info->quota_root) {
+			error("quota root already exists");
+			ret = -EEXIST;
+			goto free;
+		}
+		fs_info->quota_root = new_root;
+		fs_info->quota_enabled = 1;
+		break;
+	/*
+	 * Essential trees can't be created by this function, yet.
+	 * As we expect such skeleton exists, or a lot of functions like
+	 * btrfs_alloc_free_block() doesn't work at all
+	 */
+	case BTRFS_ROOT_TREE_OBJECTID:
+	case BTRFS_EXTENT_TREE_OBJECTID:
+	case BTRFS_CHUNK_TREE_OBJECTID:
+	case BTRFS_FS_TREE_OBJECTID:
+		ret = -EEXIST;
+		goto free;
+	default:
+		/* Subvolume trees don't need special handles */
+		if (is_fstree(objectid))
+			break;
+		/* Other special trees are not supported yet */
+		ret = -ENOTTY;
+		goto free;
+	}
+	btrfs_mark_buffer_dirty(node);
+	btrfs_set_root_bytenr(&root_item, btrfs_header_bytenr(node));
+	btrfs_set_root_level(&root_item, 0);
+	btrfs_set_root_generation(&root_item, trans->transid);
+	btrfs_set_root_dirid(&root_item, 0);
+	btrfs_set_root_refs(&root_item, 1);
+	btrfs_set_root_used(&root_item, fs_info->nodesize);
+	location.objectid = objectid;
+	location.type = BTRFS_ROOT_ITEM_KEY;
+	location.offset = 0;
+
+	ret = btrfs_insert_root(trans, fs_info->tree_root, &location,
+				&root_item);
+	if (ret < 0)
+		goto free;
+	return ret;
+
+free:
+	free_extent_buffer(node);
+	free(new_root);
+	return ret;
+}
+
 /*
  * check if the tree block can be shared by multiple trees
  */
diff --git a/ctree.h b/ctree.h
index 083bde3c..41565b52 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2641,6 +2641,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
+int btrfs_create_root(struct btrfs_trans_handle *trans,
+		      struct btrfs_fs_info *fs_info, u64 objectid);
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		u32 data_size);
 int btrfs_truncate_item(struct btrfs_root *root, struct btrfs_path *path,
-- 
2.25.0

