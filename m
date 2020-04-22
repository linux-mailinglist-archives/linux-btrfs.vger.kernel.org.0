Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2C1B37DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVGuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:50:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVGue (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:50:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9302AA4F;
        Wed, 22 Apr 2020 06:50:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 04/26] fs: btrfs: Cross-port rbtree-utils from btrfs-progs
Date:   Wed, 22 Apr 2020 14:49:47 +0800
Message-Id: <20200422065009.69392-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is needed for incoming extent-cache infrastructure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile              |  3 +-
 fs/btrfs/common/rbtree-utils.c | 83 ++++++++++++++++++++++++++++++++++
 fs/btrfs/common/rbtree-utils.h | 53 ++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/common/rbtree-utils.c
 create mode 100644 fs/btrfs/common/rbtree-utils.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index bd4b848d1b1f..53be6e8835f2 100644
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
index 000000000000..7a7d7e84e6a9
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
index 000000000000..d977cfd9554d
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
2.26.0

