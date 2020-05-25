Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E71E0719
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbgEYGef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGef (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96F61B071;
        Mon, 25 May 2020 06:34:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 28/30] fs: btrfs: Imeplement btrfs_list_subvols() using new infrastructure
Date:   Mon, 25 May 2020 14:32:55 +0800
Message-Id: <20200525063257.46757-29-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subvolume.c | 78 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 258c3dafef60..6fc28d53e552 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -155,6 +155,72 @@ out:
 	return ret;
 }
 
+static int list_subvolums(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_root *root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	char *result;
+	int ret = 0;
+
+	result = malloc(PATH_MAX);
+	if (!result)
+		return -ENOMEM;
+
+	ret = list_one_subvol(fs_info->fs_root, result);
+	if (ret < 0)
+		goto out;
+	root = fs_info->fs_root;
+	printf("ID %llu gen %llu path %.*s\n",
+		root->root_key.objectid, btrfs_root_generation(&root->root_item),
+		PATH_MAX, result);
+
+	key.objectid = BTRFS_FIRST_FREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+	while (1) {
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+			goto next;
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid > BTRFS_LAST_FREE_OBJECTID)
+			break;
+		if (key.objectid < BTRFS_FIRST_FREE_OBJECTID ||
+		    key.type != BTRFS_ROOT_ITEM_KEY)
+			goto next;
+		key.offset = (u64)-1;
+		root = btrfs_read_fs_root(fs_info, &key);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			if (ret == -ENOENT)
+				goto next;
+		}
+		ret = list_one_subvol(root, result);
+		if (ret < 0)
+			goto out;
+		printf("ID %llu gen %llu path %.*s\n",
+			root->root_key.objectid,
+			btrfs_root_generation(&root->root_item),
+			PATH_MAX, result);
+next:
+		ret = btrfs_next_item(tree_root, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+	}
+out:
+	free(result);
+	return ret;
+}
+
 static int get_subvol_name(u64 subvolid, char *name, int max_len)
 {
 	struct btrfs_root_ref rref;
@@ -268,10 +334,12 @@ static void list_subvols(u64 tree, char *nameptr, int max_name_len, int level)
 
 void btrfs_list_subvols(void)
 {
-	char *nameptr = malloc(4096);
-
-	list_subvols(BTRFS_FS_TREE_OBJECTID, nameptr, nameptr ? 4096 : 0, 40);
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	int ret;
 
-	if (nameptr)
-		free(nameptr);
+	if (!fs_info)
+		return;
+	ret = list_subvolums(fs_info);
+	if (ret < 0)
+		error("failed to list subvolume: %d", ret);
 }
-- 
2.26.2

