Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7F6294A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiKOJoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 04:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiKOJoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 04:44:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290381FFAE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IfFEIdWKRDkv90F4k9yLztQaoiOnEOOnYjKnsimrY1E=; b=veS1jTgNbkaQa+2ANgGeueDxj+
        O3go1elHLgZLt46o+y+/1Cy3pHkd1VM3uofPCknfJvmdLaxaBeEXGL+NwAS+/mcWfVRBezMTzEqNX
        udo8zSpA9HzlxPkn7J7FfImIDOAjupWO1CaX3zipyele/8JxJvWClocq+FSlq0Ed0Tn3mG5wEqxp2
        5j6hH7JZq7I+BTjyu/jTVewxYSfotas4Cq3zHCM39ed11uVr7q+jHinLxeXtztCBUOcOggZGHqL76
        d8IoOSDd6Iri5AUYorHltoDvFsFuS4GZhd1+33qJNSLz6h+4dNFSLHzU9ZcoLdcZND4Nm0+JvhNEs
        9BIKgAog==;
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ousUF-009WqP-Pf; Tue, 15 Nov 2022 09:44:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: move struct btrfs_tree_parent_check out of disk-io.h
Date:   Tue, 15 Nov 2022 10:44:04 +0100
Message-Id: <20221115094407.1626250-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115094407.1626250-1-hch@lst.de>
References: <20221115094407.1626250-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move struct btrfs_tree_parent_check out of disk-io.h so that volumes.h
an various .c files don't have to include disk-io.h just for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c      |  1 +
 fs/btrfs/disk-io.h      | 30 +-----------------------------
 fs/btrfs/parent-check.h | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/print-tree.c   |  1 +
 fs/btrfs/qgroup.c       |  1 +
 fs/btrfs/tree-mod-log.c |  1 +
 fs/btrfs/volumes.h      |  2 +-
 7 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 fs/btrfs/parent-check.h

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 55c072ba67471..9496aa93a8dcc 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -19,6 +19,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "relocation.h"
+#include "parent-check.h"
 
 /* Just arbitrary numbers so we can be sure one of these happened. */
 #define BACKREF_FOUND_SHARED     6
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 03fe4154ffb83..363935cfc0844 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -25,37 +25,9 @@ static inline u64 btrfs_sb_offset(int mirror)
 	return BTRFS_SUPER_INFO_OFFSET;
 }
 
-/* All the extra info needed to verify the parentness of a tree block. */
-struct btrfs_tree_parent_check {
-	/*
-	 * The owner check against the tree block.
-	 *
-	 * Can be 0 to skip the owner check.
-	 */
-	u64 owner_root;
-
-	/*
-	 * Expected transid, can be 0 to skip the check, but such skip
-	 * should only be utlized for backref walk related code.
-	 */
-	u64 transid;
-
-	/*
-	 * The expected first key.
-	 *
-	 * This check can be skipped if @has_first_key is false, such skip
-	 * can happen for case where we don't have the parent node key,
-	 * e.g. reading the tree root, doing backref walk.
-	 */
-	struct btrfs_key first_key;
-	bool has_first_key;
-
-	/* The expected level. Should always be set. */
-	u8 level;
-};
-
 struct btrfs_device;
 struct btrfs_fs_devices;
+struct btrfs_tree_parent_check;
 
 void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/parent-check.h b/fs/btrfs/parent-check.h
new file mode 100644
index 0000000000000..333f23ea28e25
--- /dev/null
+++ b/fs/btrfs/parent-check.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BTRFS_PARENT_CHECK_H
+#define BTRFS_PARENT_CHECK_H
+
+#include <uapi/linux/btrfs_tree.h>
+
+/* All the extra info needed to verify the parentness of a tree block. */
+struct btrfs_tree_parent_check {
+	/*
+	 * The owner check against the tree block.
+	 *
+	 * Can be 0 to skip the owner check.
+	 */
+	u64 owner_root;
+
+	/*
+	 * Expected transid, can be 0 to skip the check, but such skip
+	 * should only be utlized for backref walk related code.
+	 */
+	u64 transid;
+
+	/*
+	 * The expected first key.
+	 *
+	 * This check can be skipped if @has_first_key is false, such skip
+	 * can happen for case where we don't have the parent node key,
+	 * e.g. reading the tree root, doing backref walk.
+	 */
+	struct btrfs_key first_key;
+	bool has_first_key;
+
+	/* The expected level. Should always be set. */
+	u8 level;
+};
+
+#endif /* BTRFS_PARENT_CHECK_H */
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 1469aa55ad482..00d5da5f3c333 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -8,6 +8,7 @@
 #include "disk-io.h"
 #include "print-tree.h"
 #include "accessors.h"
+#include "parent-check.h"
 
 struct root_name_map {
 	u64 id;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 05e79f7b4433a..365482ad0421b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -28,6 +28,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "parent-check.h"
 
 /*
  * Helpers to access qgroup reservation
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 779ad44d285f8..5b91a2a88a398 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -5,6 +5,7 @@
 #include "disk-io.h"
 #include "fs.h"
 #include "accessors.h"
+#include "parent-check.h"
 
 struct tree_mod_root {
 	u64 logical;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2c90e50c460a3..7467df319d3b2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -11,7 +11,7 @@
 #include <linux/btrfs.h>
 #include "async-thread.h"
 #include "messages.h"
-#include "disk-io.h"
+#include "parent-check.h"
 #include "rcu-string.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
-- 
2.30.2

