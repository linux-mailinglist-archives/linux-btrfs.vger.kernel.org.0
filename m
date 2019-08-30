Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74F9A35D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfH3LgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 07:36:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfH3LgO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 07:36:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9450B028;
        Fri, 30 Aug 2019 11:36:13 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 2/4] btrfs: create structure to encode checksum type and length
Date:   Fri, 30 Aug 2019 13:36:09 +0200
Message-Id: <20190830113611.16865-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190830113611.16865-1-jthumshirn@suse.de>
References: <20190830113611.16865-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a structure to encode the type and length for the known on-disk
checksums.

This makes it easier to add new checksums later.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v4:
- Move table and accessor functions from ctree.h to ctree.c

Changes to v2:
- Really remove initializer macro *doh*

Changes to v1:
- Remove initializer macro (David)
---
 fs/btrfs/ctree.c | 22 ++++++++++++++++++++++
 fs/btrfs/ctree.h | 20 ++------------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2f3cd7a619c..9c36b1a878ec 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -29,6 +29,28 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 		    int level, int slot);
 
+static const struct btrfs_csums {
+	u16		size;
+	const char	*name;
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
+};
+
+int btrfs_super_csum_size(const struct btrfs_super_block *s)
+{
+	u16 t = btrfs_super_csum_type(s);
+	/*
+	 * csum type is validated at mount time
+	 */
+	return btrfs_csums[t].size;
+}
+
+const char *btrfs_super_csum_name(u16 csum_type)
+{
+	/* csum type is validated at mount time */
+	return btrfs_csums[csum_type].name;
+}
+
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d27b39858339..2359480749e1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -82,10 +82,6 @@ struct btrfs_ref;
  */
 #define BTRFS_LINK_MAX 65535U
 
-/* four bytes for CRC32 */
-static const int btrfs_csum_sizes[] = { 4 };
-static const char *btrfs_csum_names[] = { "crc32c" };
-
 #define BTRFS_EMPTY_DIR_SIZE 0
 
 /* ioprio of readahead is set to idle */
@@ -2201,20 +2197,8 @@ BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 
-static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
-{
-	u16 t = btrfs_super_csum_type(s);
-	/*
-	 * csum type is validated at mount time
-	 */
-	return btrfs_csum_sizes[t];
-}
-
-static inline const char *btrfs_super_csum_name(u16 csum_type)
-{
-	/* csum type is validated at mount time */
-	return btrfs_csum_names[csum_type];
-}
+int btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
 
 /*
  * The leaf data grows from end-to-front in the node.
-- 
2.16.4

