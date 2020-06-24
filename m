Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0032120783B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbgFXQDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:32 -0400
Received: from mail.nic.cz ([217.31.204.67]:48128 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404751AbgFXQD2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 0B2131409E2;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014605; bh=HZQkWPJKK8BEJwEZGEOD8mYXeXgeXVGyPcZp1SBltQg=;
        h=From:To:Date;
        b=s4/RWei2rhYY246cOAOciEzHWQ+ZEk+hALHWBJs90cisMBj2UcIJNsaST0sd+z/we
         amyVnohbtB/swr2iTC/jioCcX50ZtNv6+lwlWZZZA3GnjRsiIML/67WYK1Wxx8KIS2
         uOBxvlHhXR8Nywjem0u0anftYvjFAEvRl/KqcH3I=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 21/30] fs: btrfs: Use btrfs_lookup_path() to implement btrfs_exists() and btrfs_size()
Date:   Wed, 24 Jun 2020 18:03:07 +0200
Message-Id: <20200624160316.5001-22-marek.behun@nic.cz>
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

After this the only remaining function that still utilizes
__btrfs_lookup_path() is btrfs_read().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/btrfs.c | 65 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 2278b52e4d..aec91a57ec 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -188,37 +188,66 @@ int btrfs_ls(const char *path)
 
 int btrfs_exists(const char *file)
 {
-	struct __btrfs_root root = btrfs_info.fs_root;
-	u64 inr;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_root *root;
+	u64 ino;
 	u8 type;
+	int ret;
+
+	ASSERT(fs_info);
 
-	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, NULL, 40);
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				file, &root, &ino, &type, 40);
+	if (ret < 0)
+		return 0;
 
-	return (inr != -1ULL && type == BTRFS_FT_REG_FILE);
+	if (type == BTRFS_FT_REG_FILE)
+		return 1;
+	return 0;
 }
 
 int btrfs_size(const char *file, loff_t *size)
 {
-	struct __btrfs_root root = btrfs_info.fs_root;
-	struct btrfs_inode_item inode;
-	u64 inr;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_inode_item *ii;
+	struct btrfs_root *root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	u64 ino;
 	u8 type;
+	int ret;
 
-	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
-				40);
-
-	if (inr == -1ULL) {
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				file, &root, &ino, &type, 40);
+	if (ret < 0) {
 		printf("Cannot lookup file %s\n", file);
-		return -1;
+		return ret;
 	}
-
 	if (type != BTRFS_FT_REG_FILE) {
 		printf("Not a regular file: %s\n", file);
-		return -1;
+		return -ENOENT;
 	}
+	btrfs_init_path(&path);
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
 
-	*size = inode.size;
-	return 0;
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0) {
+		printf("Cannot lookup ino %llu\n", ino);
+		return ret;
+	}
+	if (ret > 0) {
+		printf("Ino %llu does not exist\n", ino);
+		ret = -ENOENT;
+		goto out;
+	}
+	ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_inode_item);
+	*size = btrfs_inode_size(path.nodes[0], ii);
+out:
+	btrfs_release_path(&path);
+	return ret;
 }
 
 int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
@@ -270,7 +299,9 @@ void btrfs_close(void)
 int btrfs_uuid(char *uuid_str)
 {
 #ifdef CONFIG_LIB_UUID
-	uuid_bin_to_str(btrfs_info.sb.fsid, uuid_str, UUID_STR_FORMAT_STD);
+	if (current_fs_info)
+		uuid_bin_to_str(current_fs_info->super_copy->fsid, uuid_str,
+				UUID_STR_FORMAT_STD);
 	return 0;
 #endif
 	return -ENOSYS;
-- 
2.26.2

