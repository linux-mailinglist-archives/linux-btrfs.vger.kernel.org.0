Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C181E0718
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbgEYGec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGec (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B614BAD08;
        Mon, 25 May 2020 06:34:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 27/30] fs: btrfs: Introduce function to resolve the path of one subvolume
Date:   Mon, 25 May 2020 14:32:54 +0800
Message-Id: <20200525063257.46757-28-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new function, list_one_subvol(), which will
resolve the path to FS_TREE of one subvolume.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subvolume.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index b446e729cd89..258c3dafef60 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -8,6 +8,7 @@
 #include <malloc.h>
 #include "ctree.h"
 #include "btrfs.h"
+#include "disk-io.h"
 
 /*
  * Resolve the path of ino inside subvolume @root into @path_ret.
@@ -74,6 +75,86 @@ out:
 	return ret;
 }
 
+static int list_one_subvol(struct btrfs_root *root, char *path_ret)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	char *tmp;
+	u64 cur = root->root_key.objectid;
+	int ret = 0;
+
+	tmp = malloc(PATH_MAX);
+	if (!tmp)
+		return -ENOMEM;
+	tmp[0] = '\0';
+	path_ret[0] = '\0';
+	btrfs_init_path(&path);
+	while (cur != BTRFS_FS_TREE_OBJECTID) {
+		struct btrfs_root_ref *rr;
+		struct btrfs_key location;
+		int name_len;
+		u64 ino;
+
+		key.objectid = cur;
+		key.type = BTRFS_ROOT_BACKREF_KEY;
+		key.offset = (u64)-1;
+		btrfs_release_path(&path);
+
+		ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+		if (ret == 0)
+			ret = -EUCLEAN;
+		if (ret < 0)
+			goto out;
+		ret = btrfs_previous_item(tree_root, &path, cur,
+					  BTRFS_ROOT_BACKREF_KEY);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			goto out;
+
+		/* Get the subvolume name */
+		rr = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_root_ref);
+		strncpy(tmp, path_ret, PATH_MAX);
+		name_len = btrfs_root_ref_name_len(path.nodes[0], rr);
+		if (name_len > BTRFS_NAME_LEN) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
+		ino = btrfs_root_ref_dirid(path.nodes[0], rr);
+		read_extent_buffer(path.nodes[0], path_ret,
+				   (unsigned long)(rr + 1), name_len);
+		path_ret[name_len] = '/';
+		path_ret[name_len + 1] = '\0';
+		strncat(path_ret, tmp, PATH_MAX);
+
+		/* Get the path inside the parent subvolume */
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		location.objectid = key.offset;
+		location.type = BTRFS_ROOT_ITEM_KEY;
+		location.offset = (u64)-1;
+		root = btrfs_read_fs_root(fs_info, &location);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+		ret = get_path_in_subvol(root, ino, path_ret);
+		if (ret < 0)
+			goto out;
+		cur = key.offset;
+	}
+	/* Add the leading '/' */
+	strncpy(tmp, path_ret, PATH_MAX);
+	strncpy(path_ret, "/", PATH_MAX);
+	strncat(path_ret, tmp, PATH_MAX);
+out:
+	btrfs_release_path(&path);
+	free(tmp);
+	return ret;
+}
+
 static int get_subvol_name(u64 subvolid, char *name, int max_len)
 {
 	struct btrfs_root_ref rref;
-- 
2.26.2

