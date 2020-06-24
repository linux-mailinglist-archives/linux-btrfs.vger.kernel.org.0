Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7E20783E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbgFXQDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404783AbgFXQD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD68C0617BC
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:27 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5323D140649;
        Wed, 24 Jun 2020 18:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014604; bh=CduAvAQtNKW5Nu7fYOC1TBw0UdJ43jPLLHGrceLu1bQ=;
        h=From:To:Date;
        b=VlxII1TQWzlEnxtyAuAWU/9B6yDWbZQ/XnFjOSKdBGk0x6B78E1VnPOsp44ErI1jS
         PEn9MTClmQBmcP/qzJ9KAJ/+CdfzA14mqzye4LWQDTLAdcxm0pISHF4oDbq4wRDYqG
         21VNNvdxT+RdO44Rcc5jPvGPlDjoiDx30frfnXUk=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 17/30] fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
Date:   Wed, 24 Jun 2020 18:03:03 +0200
Message-Id: <20200624160316.5001-18-marek.behun@nic.cz>
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

The existing __btrfs_readlink() can be easily re-implemented using the
extent buffer based btrfs_readlink().

This is the first step to re-implement U-Boot's btrfs code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/btrfs.h |   1 +
 fs/btrfs/inode.c | 101 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index e8197391a2..53d53f310b 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -60,6 +60,7 @@ u64 __btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref
 int __btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
 		        struct btrfs_inode_item *, struct __btrfs_root *);
 int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
+int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
 u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
 u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb34f546b5..007cf32c16 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5,8 +5,9 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
 #include <malloc.h>
+#include "btrfs.h"
+#include "disk-io.h"
 
 u64 __btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
@@ -83,56 +84,82 @@ out:
 	return res;
 }
 
-int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
+/*
+ * Read the content of symlink inode @ino of @root, into @target.
+ * NOTE: @target will not be \0 termiated, caller should handle it properly.
+ *
+ * Return the number of read data.
+ * Return <0 for error.
+ */
+int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target)
 {
-	struct __btrfs_path path;
+	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *extent;
-	const char *data_ptr;
-	int res = -1;
+	struct btrfs_file_extent_item *fi;
+	int ret;
 
-	key.objectid = inr;
+	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
+	btrfs_init_path(&path);
 
-	if (btrfs_search_tree(root, &key, &path))
-		return -1;
-
-	if (__btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)))
-		goto out;
-
-	extent = btrfs_path_item_ptr(&path, struct btrfs_file_extent_item);
-	if (extent->type != BTRFS_FILE_EXTENT_INLINE) {
-		printf("%s: Extent for symlink %llu not of INLINE type\n",
-		       __func__, inr);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		ret = -ENOENT;
 		goto out;
 	}
-
-	btrfs_file_extent_item_to_cpu_inl(extent);
-
-	if (extent->compression != BTRFS_COMPRESS_NONE) {
-		printf("%s: Symlink %llu extent data compressed!\n", __func__,
-		       inr);
+	fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_file_extent_item);
+	if (btrfs_file_extent_type(path.nodes[0], fi) !=
+	    BTRFS_FILE_EXTENT_INLINE) {
+		ret = -EUCLEAN;
+		error("Extent for symlink %llu must be INLINE type!", ino);
 		goto out;
-	} else if (extent->encryption != 0) {
-		printf("%s: Symlink %llu extent data encrypted!\n", __func__,
-		       inr);
+	}
+	if (btrfs_file_extent_compression(path.nodes[0], fi) !=
+	    BTRFS_COMPRESS_NONE) {
+		ret = -EUCLEAN;
+		error("Extent for symlink %llu must not be compressed!", ino);
 		goto out;
-	} else if (extent->ram_bytes >= btrfs_info.sb.sectorsize) {
-		printf("%s: Symlink %llu extent data too long (%llu)!\n",
-		       __func__, inr, extent->ram_bytes);
+	}
+	if (btrfs_file_extent_ram_bytes(path.nodes[0], fi) >=
+	    root->fs_info->sectorsize) {
+		ret = -EUCLEAN;
+		error("Symlink %llu extent data too large (%llu)!\n",
+			ino, btrfs_file_extent_ram_bytes(path.nodes[0], fi));
 		goto out;
 	}
+	read_extent_buffer(path.nodes[0], target,
+			btrfs_file_extent_inline_start(fi),
+			btrfs_file_extent_ram_bytes(path.nodes[0], fi));
+	ret = btrfs_file_extent_ram_bytes(path.nodes[0], fi);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
 
-	data_ptr = (const char *) extent
-		   + offsetof(struct btrfs_file_extent_item, disk_bytenr);
+int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
+{
+	struct btrfs_root *subvolume;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_key key;
+	int ret;
+
+	ASSERT(fs_info);
+	key.objectid = root->objectid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	subvolume = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(subvolume))
+		return -1;
 
-	memcpy(target, data_ptr, extent->ram_bytes);
-	target[extent->ram_bytes] = '\0';
-	res = 0;
-out:
-	__btrfs_free_path(&path);
-	return res;
+	ret = btrfs_readlink(subvolume, inr, target);
+	if (ret < 0)
+		return -1;
+	target[ret] = '\0';
+	return 0;
 }
 
 /* inr must be a directory (for regular files with multiple hard links this
-- 
2.26.2

