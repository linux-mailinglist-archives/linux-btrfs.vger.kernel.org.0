Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29DB207849
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404830AbgFXQDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404668AbgFXQD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A545BC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:28 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id CD70E1409EE;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014605; bh=q1JTZzrtK3qZJMPVo9OkDmm2fqc/441MOPHMGdFw6xw=;
        h=From:To:Date;
        b=KXh4pZJxxiiquuyvCyV0PoFpOig+avTIwbdsj19tSoiddLDfOnZ+3DEjQBABMIMCd
         mTGrFFJ7hG/XbeJoEy9lk/GLbnwWBJJ92pFZAqGUXsOs40PNrK8g08832wao59pXMb
         rwCcPtH984hpmbhNRanQRBp+Hsd1K5kAUaNphePw=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 26/30] fs: btrfs: Introduce function to resolve path in one subvolume
Date:   Wed, 24 Jun 2020 18:03:12 +0200
Message-Id: <20200624160316.5001-27-marek.behun@nic.cz>
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

This patch introduces a new function, get_path_in_subvolume(), which
resolves inode number into path inside a subvolume.

This function will be later used for btrfs subvolume list functionality.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/compat.h    |  1 +
 fs/btrfs/subvolume.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 2dbeb90d33..321681814f 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -24,6 +24,7 @@ static inline void error(const char *fmt, ...)
 
 /* No <linux/limits.h> so have to define it here */
 #define XATTR_NAME_MAX		255
+#define PATH_MAX		4096
 
 /*
  * Macros to generate set/get funcs for the struct fields
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 0e72577d0d..b446e729cd 100644
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

