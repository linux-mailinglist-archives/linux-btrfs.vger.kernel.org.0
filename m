Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C19B0713
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfILDLp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:11:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:33224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfILDLp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:11:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65DECB033
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 03:11:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/6] btrfs-progs: check/common: Introduce a function to find imode using info from INODE_REF item
Date:   Thu, 12 Sep 2019 11:11:31 +0800
Message-Id: <20190912031135.79696-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912031135.79696-1-wqu@suse.com>
References: <20190912031135.79696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a function, find_file_type(), to find filetype using
info from INODE_REF, including dir_id from key index/name from
inode_ref_item.

This function will:
- Search DIR_INDEX first
  DIR_INDEX is easier since there is only one item in it.

- Validate the DIR_INDEX item
  If the DIR_INDEX is valid, use the filetype and call it a day.

- Search DIR_ITEM then
  It needs extra iteration since it's possible to have hash collision.

- Validate the DIR_ITEM
  If valid, call it a day. Or return -ENOENT;

This would be used as the primary method to determine the imode in later
imode repair code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/check/mode-common.c b/check/mode-common.c
index 195b6efaa7aa..9ccde5cdc2e5 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -16,6 +16,7 @@
 
 #include <time.h>
 #include "ctree.h"
+#include "hash.h"
 #include "common/internal.h"
 #include "common/messages.h"
 #include "transaction.h"
@@ -836,6 +837,134 @@ int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return ret;
 }
 
+static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
+				    u64 index, const char *name, u32 name_len,
+				    u32 *imode_ret)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct btrfs_key location;
+	struct btrfs_dir_item *di;
+	char namebuf[BTRFS_NAME_LEN] = {0};
+	bool found = false;
+	u8 filetype;
+	u32 len;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = dirid;
+	key.offset = index;
+	key.type = BTRFS_DIR_INDEX_KEY;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+	di = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_dir_item);
+	btrfs_dir_item_key_to_cpu(path.nodes[0], di, &location);
+
+	/* Various basic check */
+	if (location.objectid != ino || location.type != BTRFS_INODE_ITEM_KEY ||
+	    location.offset != 0)
+		goto out;
+	filetype = btrfs_dir_type(path.nodes[0], di);
+	if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
+		goto out;
+	len = min_t(u32, BTRFS_NAME_LEN,
+		btrfs_item_size_nr(path.nodes[0], path.slots[0]) - sizeof(*di));
+	len = min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
+	read_extent_buffer(path.nodes[0], namebuf, (unsigned long)(di + 1), len);
+	if (name_len != len || memcmp(namebuf, name, len))
+		goto out;
+	found = true;
+	*imode_ret = btrfs_type_to_imode(filetype);
+out:
+	btrfs_release_path(&path);
+	if (!found && !ret)
+		ret = -ENOENT;
+	return ret;
+}
+
+static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
+				   const char *name, u32 name_len,
+				   u32 *imode_ret)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct btrfs_key location;
+	struct btrfs_dir_item *di;
+	char namebuf[BTRFS_NAME_LEN] = {0};
+	bool found = false;
+	unsigned long cur;
+	unsigned long end;
+	u8 filetype;
+	u32 len;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = dirid;
+	key.offset = btrfs_name_hash(name, name_len);
+	key.type = BTRFS_DIR_INDEX_KEY;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	cur = btrfs_item_ptr_offset(path.nodes[0], path.slots[0]);
+	end = cur + btrfs_item_size_nr(path.nodes[0], path.slots[0]);
+	while (cur < end) {
+		di = (struct btrfs_dir_item *)cur;
+		cur += btrfs_dir_name_len(path.nodes[0], di) + sizeof(*di);
+
+		btrfs_dir_item_key_to_cpu(path.nodes[0], di, &location);
+		/* Various basic check */
+		if (location.objectid != ino ||
+		    location.type != BTRFS_INODE_ITEM_KEY ||
+		    location.offset != 0)
+			continue;
+		filetype = btrfs_dir_type(path.nodes[0], di);
+		if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
+			continue;
+		len = min_t(u32, BTRFS_NAME_LEN,
+			    btrfs_item_size_nr(path.nodes[0], path.slots[0]) -
+			    sizeof(*di));
+		len = min_t(u32, len, btrfs_dir_name_len(path.nodes[0], di));
+		read_extent_buffer(path.nodes[0], namebuf,
+				   (unsigned long)(di + 1), len);
+		if (name_len != len || memcmp(namebuf, name, len))
+			continue;
+		*imode_ret = btrfs_type_to_imode(filetype);
+		found = true;
+		goto out;
+	}
+out:
+	btrfs_release_path(&path);
+	if (!found && !ret)
+		ret = -ENOENT;
+	return ret;
+}
+
+static int find_file_type(struct btrfs_root *root, u64 ino, u64 dirid,
+			  u64 index, const char *name, u32 name_len,
+			  u32 *imode_ret)
+{
+	int ret;
+	ret = find_file_type_dir_index(root, ino, dirid, index, name, name_len,
+				       imode_ret);
+	if (ret == 0)
+		return ret;
+	return find_file_type_dir_item(root, ino, dirid, name, name_len,
+				       imode_ret);
+}
+
 /*
  * Reset the inode mode of the inode specified by @path.
  *
-- 
2.23.0

