Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F147C459D2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 08:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhKWH4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 02:56:14 -0500
Received: from sender4-pp-o92.zoho.com ([136.143.188.92]:25265 "EHLO
        sender4-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhKWH4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 02:56:14 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2021 02:56:14 EST
ARC-Seal: i=1; a=rsa-sha256; t=1637653081; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=duaaSEfwUAMIbMJbSDKnk7s1jg4lLTaNA0pUsYnCsthcdki1DSmcSty9zNjsoz/4uRBwaHv6H2NMdcVgJAHpGLrSUjIn74GeGAfuuhfLqfiU3do7NOJcXLJEC4yOWBChwc4hhXbTu0qNRoYnjfRzAbK0cnFpltpKyt2MhG3l10I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1637653081; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject; 
        bh=3Y+qUJeaNQ3ezgfEV0tQ1mUUoFPP4Tb1REXm6sFl/fo=; 
        b=jmPqtxEvGreL8G13IBekQuBpFHH9uEoPYi+gR8sAj5NaxaVqQl4pYse4pRrNpt2DMiVHFQuF40pjt7d3aISO1freEJUm+EMGWVypire8V5Ytg9D11Krv7Pt39d/vsyFyVK2+0Cq0+ubsL5Xiuyn7nzze39z3tvovICSHmfsIVD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=qFzD54HsXPm+KGTLAi6xyNZtaDgBPfU9i7+haRugi4nXawjRjHHuM/aBTukqOydnhuZPRBZy9+E1
    Cwp+bTCP21WBFJ+pb0d//mxpCLDchDxbu1lmeVAcWCodu4lfd2S0  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637653081;
        s=zm2020; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=3Y+qUJeaNQ3ezgfEV0tQ1mUUoFPP4Tb1REXm6sFl/fo=;
        b=fFWmEg/793PsKMdt5FvyfDKPK+gi1niSabNIJl2VDvbLeiAUj8g5gyIEEXlI7dpk
        wk/Q0tPLURn1LtLjQrGHbGq+nCa2yb2RF5+eZ5Xc8mEcNWyNRm2AKfMkEPfMteFHCCK
        k9LDATRBfgHC6vMsdo77jPdo8TOX11tp68qcO3gE=
Received: from localhost.localdomain (94.177.118.151 [94.177.118.151]) by mx.zohomail.com
        with SMTPS id 1637653078772322.5672422435663; Mon, 22 Nov 2021 23:37:58 -0800 (PST)
From:   hmsjwzb <hmsjwzb@zoho.com>
Cc:     quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        hmsjwzb <hmsjwzb@zoho.com>
Subject: [PATCH] btrfs-fuse: Add listxattr and getxattr interface
Date:   Tue, 23 Nov 2021 02:37:47 -0500
Message-Id: <20211123073747.7497-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: hmsjwzb <hmsjwzb@zoho.com>
---
 inode.c         |  32 +++++++++++
 inode.h         |   7 +++
 main.c          | 140 ++++++++++++++++++++++++++++++++++++++++++++++++
 ondisk_format.h |   1 +
 4 files changed, 180 insertions(+)

diff --git a/inode.c b/inode.c
index 6ed6279..5ea023e 100644
--- a/inode.c
+++ b/inode.c
@@ -9,6 +9,38 @@
 #include "hash.h"
 #include "messages.h"
 
+struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
+							struct btrfs_path *path,
+							const char *name, int name_len)
+{
+	struct btrfs_dir_item *dir_item;
+	unsigned long name_ptr;
+	u32 total_len;
+	u32 cur = 0;
+	u32 this_len;
+	struct extent_buffer *leaf;
+
+	leaf = path->nodes[0];
+	dir_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
+
+	total_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	while (cur < total_len) {
+		this_len = sizeof(*dir_item) +
+			btrfs_dir_name_len(leaf, dir_item) +
+			btrfs_dir_data_len(leaf, dir_item);
+		name_ptr = (unsigned long)(dir_item + 1);
+
+		if (btrfs_dir_name_len(leaf, dir_item) == name_len &&
+		    memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+			return dir_item;
+
+		cur += this_len;
+		dir_item = (struct btrfs_dir_item *)((char *)dir_item +
+							this_len);
+	}
+	return NULL;
+}
+
 int btrfs_lookup_one_name(struct btrfs_fs_info *fs_info,
 			  struct btrfs_inode *dir, const char *name,
 			  size_t name_len, struct btrfs_inode *inode_ret)
diff --git a/inode.h b/inode.h
index 4515efd..f4cae8e 100644
--- a/inode.h
+++ b/inode.h
@@ -27,6 +27,12 @@ struct btrfs_inode {
 	u8 file_type;
 };
 
+/*
+ * Match one dir item name
+ */
+struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
+							struct btrfs_path *path,
+							const char *name, int name_len);
 /*
  * Lookup one name for @dir.
  *
@@ -132,4 +138,5 @@ static inline u32 btrfs_type_to_imode(u8 btrfs_ft)
 
 int btrfs_stat(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode,
 	       struct stat *stbuf);
+
 #endif
diff --git a/main.c b/main.c
index 3735d36..5e8828c 100644
--- a/main.c
+++ b/main.c
@@ -10,6 +10,7 @@
 #include "super.h"
 #include "inode.h"
 #include "data.h"
+#include "hash.h"
 
 static struct btrfs_fs_info *global_info = NULL;
 
@@ -190,6 +191,143 @@ static void btrfs_fuse_destroy(void *private_data)
 	btrfs_exit();
 }
 
+static int btrfs_fuse_listxattr(const char *pathname, char *list, size_t size)
+{
+	struct btrfs_key key;
+	struct btrfs_fs_info *fs_info = global_info;
+	struct btrfs_inode inode = {};
+	struct btrfs_path path;
+	size_t size_left = size;
+	int ret =  0;
+	size_t total_size = 0;
+
+	ret = btrfs_resolve_path(fs_info, pathname, strlen(pathname), &inode);
+	if (ret < 0)
+		return ret;
+
+	btrfs_init_path(&path);
+	key.objectid = inode.ino;
+	key.type = BTRFS_XATTR_ITEM_KEY;
+	key.offset = 0;
+
+	ret = __btrfs_search_slot(fs_info->default_root, &path, &key);
+	if (ret < 0)
+		return ret;
+
+	while (1) {
+		struct extent_buffer *leaf;
+		int slot;
+		struct btrfs_dir_item *di;
+		struct btrfs_key found_key;
+		u32 item_size;
+		u32 cur;
+
+		leaf = path.nodes[0];
+		slot = path.slots[0];
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(&path);
+			if (ret < 0)
+				goto err;
+			else if (ret > 0)
+				break;
+			continue;
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+		if (found_key.objectid != key.objectid)
+			break;
+		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
+			break;
+		if (found_key.type < BTRFS_XATTR_ITEM_KEY)
+			goto next_item;
+
+		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
+		item_size = btrfs_item_size_nr(leaf, slot);
+		cur = 0;
+		while (cur < item_size) {
+			u16 name_len = btrfs_dir_name_len(leaf, di);
+			u16 data_len = btrfs_dir_data_len(leaf, di);
+			u32 this_len = sizeof(*di) + name_len + data_len;
+			unsigned long name_ptr = (unsigned long)(di + 1);
+
+			total_size += name_len + 1;
+
+			if (!size)
+				goto next;
+
+			if (!list || (name_len + 1) > size_left) {
+				ret = -ERANGE;
+				goto err;
+			}
+
+			read_extent_buffer(leaf, list, name_ptr, name_len);
+			list[name_len] = '\0';
+
+			size_left -= name_len + 1;
+			list += name_len + 1;
+next:
+			cur += this_len;
+			di = (struct btrfs_dir_item *)((char *)di + this_len);
+		}
+next_item:
+		path.slots[0]++;
+	}
+	ret = total_size;
+err:
+	return ret;
+}
+
+int btrfs_fuse_getxattr(const char *pathname, const char *name, char *value, size_t size)
+{
+	struct btrfs_key key;
+	struct btrfs_dir_item *di;
+	struct btrfs_fs_info *fs_info = global_info;
+	struct btrfs_root *root = fs_info->default_root;
+	struct extent_buffer *leaf;
+	struct btrfs_inode inode = {};
+	struct btrfs_path path;
+	int ret = 0;
+	unsigned long data_ptr;
+
+	memset(&path, 0, sizeof(path));
+	ret = btrfs_resolve_path(fs_info, pathname, strlen(pathname), &inode);
+	if (ret < 0)
+		return ret;
+
+	key.objectid = inode.ino;
+	key.type = BTRFS_XATTR_ITEM_KEY;
+	key.offset = btrfs_name_hash(name, strlen(name));
+	ret = __btrfs_search_slot(root, &path, &key);
+	if (ret != 0)
+		return ret;
+	di = btrfs_match_dir_item_name(fs_info, &path, name, strlen(name));
+	if (!di) {
+		ret = -ENODATA;
+		goto out;
+	}
+
+	leaf = path.nodes[0];
+	if (!size) {
+		ret = btrfs_dir_data_len(leaf, di);
+		goto out;
+	}
+
+	if (btrfs_dir_data_len(leaf, di) > size) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	data_ptr = (unsigned long)((char *)(di + 1) +
+					btrfs_dir_name_len(leaf, di));
+	read_extent_buffer(leaf, value, data_ptr,
+			btrfs_dir_data_len(leaf, di));
+	ret = btrfs_dir_data_len(leaf, di);
+
+out:
+	return ret;
+}
+
 static const struct fuse_operations btrfs_fuse_ops = {
 	.statfs		= btrfs_fuse_statfs,
 	.getattr	= btrfs_fuse_getattr,
@@ -201,6 +339,8 @@ static const struct fuse_operations btrfs_fuse_ops = {
 	.readdir	= btrfs_fuse_readdir,
 	.init		= btrfs_fuse_init,
 	.destroy	= btrfs_fuse_destroy,
+	.listxattr	= btrfs_fuse_listxattr,
+	.getxattr	= btrfs_fuse_getxattr,
 };
 
 void usage(void)
diff --git a/ondisk_format.h b/ondisk_format.h
index 510c69d..7da533e 100644
--- a/ondisk_format.h
+++ b/ondisk_format.h
@@ -59,6 +59,7 @@ enum btrfs_csum_type {
 
 /* A subset of needed key types for read-only operations */
 #define BTRFS_INODE_ITEM_KEY		1
+#define BTRFS_XATTR_ITEM_KEY		24
 #define BTRFS_DIR_ITEM_KEY		84
 #define BTRFS_DIR_INDEX_KEY		96
 #define BTRFS_EXTENT_DATA_KEY		108
-- 
2.25.1

