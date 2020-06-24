Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6424E207848
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404757AbgFXQDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404786AbgFXQD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0976C0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:28 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 235D81409B8;
        Wed, 24 Jun 2020 18:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014606; bh=iQjWRiYOmP+RTADycA6LPFjvVll++ZVg30ZXd+vYsmo=;
        h=From:To:Date;
        b=hOP8VmB+aWhPkOD9mqopO2xl9nSm5utZN+/tDNrxOb0hpXW4OClyV8vQyTgGbWhit
         8YM2Eop3XljEPsmsixMPMqFPfCw6vvCm8qOjlCsH7bi+qQAzBds9Fjh0izBjy/EFpJ
         hfj3XeRlwaDY7HrjxZKGXTbNVaAg3EfD590YC7Jw=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 28/30] fs: btrfs: Imeplement btrfs_list_subvols() using new infrastructure
Date:   Wed, 24 Jun 2020 18:03:14 +0200
Message-Id: <20200624160316.5001-29-marek.behun@nic.cz>
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

Reimplement btrfs_list_subvols() to use new code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/subvolume.c | 78 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 258c3dafef..6fc28d53e5 100644
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

