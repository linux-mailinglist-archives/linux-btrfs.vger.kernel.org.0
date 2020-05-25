Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93ED1E0717
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388957AbgEYGea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGea (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 505ADAD1E;
        Mon, 25 May 2020 06:34:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 26/30] fs: btrfs: Introduce function to reolve path in one subvolume
Date:   Mon, 25 May 2020 14:32:53 +0800
Message-Id: <20200525063257.46757-27-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new function, get_path_in_subvolume(), which
resolve inode number into path inside a subvolume.

This function will be later used for btrfs subvolume list functionality.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compat.h    |  1 +
 fs/btrfs/subvolume.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 2dbeb90d33ce..321681814f74 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -24,6 +24,7 @@ static inline void error(const char *fmt, ...)
 
 /* No <linux/limits.h> so have to define it here */
 #define XATTR_NAME_MAX		255
+#define PATH_MAX		4096
 
 /*
  * Macros to generate set/get funcs for the struct fields
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 0e72577d0df5..b446e729cd89 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -5,8 +5,74 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
 #include <malloc.h>
+#include "ctree.h"
+#include "btrfs.h"
+
+/*
+ * Resolve the path of ino inside subvolume @root into @path_ret.
+ *
+ * @path_ret must be at least PATH_MAX size.
+ */
+static int get_path_in_subvol(struct btrfs_root *root, u64 ino, char *path_ret)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	char *tmp;
+	u64 cur = ino;
+	int ret = 0;
+
+	tmp = malloc(PATH_MAX);
+	if (!tmp)
+		return -ENOMEM;
+	tmp[0] = '\0';
+
+	btrfs_init_path(&path);
+	while (cur != BTRFS_FIRST_FREE_OBJECTID) {
+		struct btrfs_inode_ref *iref;
+		int name_len;
+
+		btrfs_release_path(&path);
+		key.objectid = cur;
+		key.type = BTRFS_INODE_REF_KEY;
+		key.offset = (u64)-1;
+
+		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+		/* Impossible */
+		if (ret == 0)
+			ret = -EUCLEAN;
+		if (ret < 0)
+			goto out;
+		ret = btrfs_previous_item(root, &path, cur,
+					  BTRFS_INODE_REF_KEY);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0)
+			goto out;
+
+		strncpy(tmp, path_ret, PATH_MAX);
+		iref = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				      struct btrfs_inode_ref);
+		name_len = btrfs_inode_ref_name_len(path.nodes[0],
+						    iref);
+		if (name_len > BTRFS_NAME_LEN) {
+			ret = -ENAMETOOLONG;
+			goto out;
+		}
+		read_extent_buffer(path.nodes[0], path_ret,
+				   (unsigned long)(iref + 1), name_len);
+		path_ret[name_len] = '/';
+		path_ret[name_len + 1] = '\0';
+		strncat(path_ret, tmp, PATH_MAX);
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		cur = key.offset;
+	}
+out:
+	btrfs_release_path(&path);
+	free(tmp);
+	return ret;
+}
 
 static int get_subvol_name(u64 subvolid, char *name, int max_len)
 {
-- 
2.26.2

