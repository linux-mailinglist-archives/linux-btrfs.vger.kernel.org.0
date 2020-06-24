Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E33207838
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404784AbgFXQD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404668AbgFXQDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:24 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BDEC061796
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:23 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 099751409A2;
        Wed, 24 Jun 2020 18:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014602; bh=7xngTyOJPyj3hNqWuppJtLrTVOd/hsMa911JgwPgTVg=;
        h=From:To:Date;
        b=yJMtdP/I9baEfB+Lf8xfjs0xH7tokd0xJAFca/FitBW0orA1Qq+nikibEQK+P55KK
         4e/SmhcmeH8DKW/bgxnZQj0P8ECiNj1FY1DNLrg8ZwSq71TvYwUEbWNdck+t03Qr0Y
         mNJOErQLQbtf+SPRgWuz57OtIs5N/zyxzvHvScjM=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 04/30] fs: btrfs: Crossport rbtree-utils from btrfs-progs
Date:   Wed, 24 Jun 2020 18:02:50 +0200
Message-Id: <20200624160316.5001-5-marek.behun@nic.cz>
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

This is needed for incoming extent-cache infrastructure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/Makefile              |  3 +-
 fs/btrfs/common/rbtree-utils.c | 83 ++++++++++++++++++++++++++++++++++
 fs/btrfs/common/rbtree-utils.h | 53 ++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/common/rbtree-utils.c
 create mode 100644 fs/btrfs/common/rbtree-utils.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index bd4b848d1b..53be6e8835 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -3,4 +3,5 @@
 # 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
 
 obj-y := btrfs.o chunk-map.o compression.o ctree.o dev.o dir-item.o \
-	extent-io.o inode.o root.o subvolume.o crypto/hash.o disk-io.o
+	extent-io.o inode.o root.o subvolume.o crypto/hash.o disk-io.o \
+	common/rbtree-utils.o extent-cache.o
diff --git a/fs/btrfs/common/rbtree-utils.c b/fs/btrfs/common/rbtree-utils.c
new file mode 100644
index 0000000000..7a7d7e84e6
--- /dev/null
+++ b/fs/btrfs/common/rbtree-utils.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2014 Facebook.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <linux/errno.h>
+#include "rbtree-utils.h"
+
+int rb_insert(struct rb_root *root, struct rb_node *node,
+	      rb_compare_nodes comp)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	int ret;
+
+	while(*p) {
+		parent = *p;
+
+		ret = comp(parent, node);
+		if (ret < 0)
+			p = &(*p)->rb_left;
+		else if (ret > 0)
+			p = &(*p)->rb_right;
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, root);
+	return 0;
+}
+
+struct rb_node *rb_search(struct rb_root *root, void *key, rb_compare_keys comp,
+			  struct rb_node **next_ret)
+{
+	struct rb_node *n = root->rb_node;
+	struct rb_node *parent = NULL;
+	int ret = 0;
+
+	while(n) {
+		parent = n;
+
+		ret = comp(n, key);
+		if (ret < 0)
+			n = n->rb_left;
+		else if (ret > 0)
+			n = n->rb_right;
+		else
+			return n;
+	}
+
+	if (!next_ret)
+		return NULL;
+
+	if (parent && ret > 0)
+		parent = rb_next(parent);
+
+	*next_ret = parent;
+	return NULL;
+}
+
+void rb_free_nodes(struct rb_root *root, rb_free_node free_node)
+{
+	struct rb_node *node;
+
+	while ((node = rb_first(root))) {
+		rb_erase(node, root);
+		free_node(node);
+	}
+}
diff --git a/fs/btrfs/common/rbtree-utils.h b/fs/btrfs/common/rbtree-utils.h
new file mode 100644
index 0000000000..d977cfd955
--- /dev/null
+++ b/fs/btrfs/common/rbtree-utils.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2014 Facebook.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#ifndef __RBTREE_UTILS__
+#define __RBTREE_UTILS__
+
+#include <linux/rbtree.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* The common insert/search/free functions */
+typedef int (*rb_compare_nodes)(struct rb_node *node1, struct rb_node *node2);
+typedef int (*rb_compare_keys)(struct rb_node *node, void *key);
+typedef void (*rb_free_node)(struct rb_node *node);
+
+int rb_insert(struct rb_root *root, struct rb_node *node,
+	      rb_compare_nodes comp);
+/*
+ * In some cases, we need return the next node if we don't find the node we
+ * specify. At this time, we can use next_ret.
+ */
+struct rb_node *rb_search(struct rb_root *root, void *key, rb_compare_keys comp,
+			  struct rb_node **next_ret);
+void rb_free_nodes(struct rb_root *root, rb_free_node free_node);
+
+#define FREE_RB_BASED_TREE(name, free_func)		\
+static void free_##name##_tree(struct rb_root *root)	\
+{							\
+	rb_free_nodes(root, free_func);			\
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.26.2

