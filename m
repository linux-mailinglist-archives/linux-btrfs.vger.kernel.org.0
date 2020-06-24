Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C503920783F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404801AbgFXQDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404789AbgFXQD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:29 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC6C061796
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:28 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id F0EDD1409AD;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014606; bh=aA1AqkkVCkm0RXPcoJ+3RjIZ/FYumKZ+5DLnKkpQM+k=;
        h=From:To:Date;
        b=j5pTG5266Te+rDSXZ9I9WDyb5WUMKbhCRB5F5U6Pcge9oLhu6tylVnm7S1ggaLWqi
         A24KYzTi0EOdQzTY6zkWhmzQeoclQ4I0qdj0GLHda89oMYIkZ4hvGj9VXYlYwB9qEb
         ybWhv+sSuAEHqPTeCQwmNbdSh2VRU4Uxx19YBAWc=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 27/30] fs: btrfs: Introduce function to resolve the path of one subvolume
Date:   Wed, 24 Jun 2020 18:03:13 +0200
Message-Id: <20200624160316.5001-28-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

This patch introduces a new function, list_one_subvol(), which will
resolve the path to FS_TREE of one subvolume.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/subvolume.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index b446e729cd..258c3dafef 100644
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

