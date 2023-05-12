Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953326FFF23
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 05:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbjELDAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 23:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjELDAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 23:00:04 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 20:00:02 PDT
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27761B7;
        Thu, 11 May 2023 20:00:01 -0700 (PDT)
Received: from vbm-samho.. (unknown [10.17.211.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id E0F525B039585;
        Fri, 12 May 2023 10:41:44 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1683859305; bh=Y67WksmBilFV6xWdagrLpjikadFsRz5+NrupSGkmcag=;
        h=From:To:Cc:Subject:Date;
        b=dmd6sLDVIqg415aDq2GBEFSUmNpYnBN3Hz3QQjZGfkZVazv0LnFMpihlKXKMyUXcI
         bmq/doL7rq9wXAVgYn9HUaSMZWF43+YYg4LXNbS5l0uwJfPJtTsgRf4+Gba54bHxJh
         0cZvcbxvtRYHtzM+vuCyGKXS9gufTos87wGy0duI=
From:   samho <samho@synology.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        samho <samho@synology.com>
Subject: [PATCH] btrfs: check extent type while finding extent clone source
Date:   Fri, 12 May 2023 02:41:35 +0000
Message-Id: <20230512024135.325711-1-samho@synology.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs incremental backup:
`btrfs send -p /vol/subvol_835 /vol/subvol_846 | btrfs receive /vol/`

The following pattern will result in the data inconsistency between
the received subvol and the subvol to be sent.

(66755 EXTENT_DATA 2121728) is supposed to be regular extent data,
while `find_extent_clone()` may find the extent item in tree 835
which is prealloc data.

DS:server[~]# btrfs-debug-tree -t 835 /dev/dev_1
        item 129 key (58924 EXTENT_DATA 2412544) itemoff 7891 itemsize 53
                prealloc data disk byte 6599543226368 nr 389120
                prealloc data offset 0 nr 389120
DS:server[~]# btrfs-debug-tree -t 846 /dev/dev_1
        item 42 key (66755 EXTENT_DATA 2109440) itemoff 9964 itemsize 53
                prealloc data disk byte 6599543226368 nr 389120
                prealloc data offset 0 nr 12288
        item 43 key (66755 EXTENT_DATA 2121728) itemoff 9911 itemsize 53
                extent data disk byte 6599543226368 nr 389120
                extent data offset 12288 nr 4096 ram 389120
                extent compression(none)
        item 44 key (66755 EXTENT_DATA 2125824) itemoff 9858 itemsize 53
                prealloc data disk byte 6599543226368 nr 389120
                prealloc data offset 16384 nr 159744
DS:server[~]#

Signed-off-by: samho <samho@synology.com>
---
 fs/btrfs/backref.c | 10 +++++++---
 fs/btrfs/backref.h |  2 +-
 fs/btrfs/scrub.c   |  2 +-
 fs/btrfs/send.c    | 12 ++++++++++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e54f0884802a..e446ca35b96c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -29,6 +29,7 @@ struct extent_inode_elem {
 	u64 inum;
 	u64 offset;
 	u64 num_bytes;
+	int extent_type;
 	struct extent_inode_elem *next;
 };
 
@@ -40,6 +41,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 {
 	const u64 data_len = btrfs_file_extent_num_bytes(eb, fi);
 	u64 offset = key->offset;
+	const int extent_type = btrfs_file_extent_type(eb, fi);
 	struct extent_inode_elem *e;
 	const u64 *root_ids;
 	int root_count;
@@ -70,7 +72,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 		int ret;
 
 		ret = ctx->indirect_ref_iterator(key->objectid, offset,
-						 data_len, root_ids[i],
+						 data_len, extent_type, root_ids[i],
 						 ctx->user_ctx);
 		if (ret)
 			return ret;
@@ -85,6 +87,7 @@ static int check_extent_in_eb(struct btrfs_backref_walk_ctx *ctx,
 	e->inum = key->objectid;
 	e->offset = offset;
 	e->num_bytes = data_len;
+	e->extent_type = btrfs_file_extent_type(eb, fi);
 	*eie = e;
 
 	return 0;
@@ -2388,7 +2391,7 @@ static int iterate_leaf_refs(struct btrfs_fs_info *fs_info,
 			    "ref for %llu resolved, key (%llu EXTEND_DATA %llu), root %llu",
 			    extent_item_objectid, eie->inum,
 			    eie->offset, root);
-		ret = iterate(eie->inum, eie->offset, eie->num_bytes, root, ctx);
+		ret = iterate(eie->inum, eie->offset, eie->num_bytes, eie->extent_type, root, ctx);
 		if (ret) {
 			btrfs_debug(fs_info,
 				    "stopping iteration for %llu due to ret=%d",
@@ -2526,7 +2529,8 @@ int iterate_extent_inodes(struct btrfs_backref_walk_ctx *ctx,
 	return ret;
 }
 
-static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, u64 root, void *ctx)
+static int build_ino_list(u64 inum, u64 offset, u64 num_bytes, int extent_type,
+				u64 root, void *ctx)
 {
 	struct btrfs_data_container *inodes = ctx;
 	const size_t c = 3 * sizeof(u64);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ef6bbea3f456..bcbea7baefc5 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -28,7 +28,7 @@
  * value to immediately stop iteration and possibly signal an error back to
  * the caller.
  */
-typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_bytes,
+typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 num_bytes, int extent_type,
 				      u64 root, void *ctx);
 
 /*
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 836725a19661..904051bebe0d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -374,7 +374,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	return ERR_PTR(-ENOMEM);
 }
 
-static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
+static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes, int extent_type,
 				     u64 root, void *warn_ctx)
 {
 	u32 nlink;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index af2e153543a5..77b4b5db11be 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1297,6 +1297,9 @@ struct backref_ctx {
 	u64 backref_owner;
 	/* The offset of the data backref for the current extent. */
 	u64 backref_offset;
+
+	/* used for extent iteration to check if the type is matched */
+	int extent_type;
 };
 
 static int __clone_root_cmp_bsearch(const void *key, const void *elt)
@@ -1327,8 +1330,8 @@ static int __clone_root_cmp_sort(const void *e1, const void *e2)
  * Called for every backref that is found for the current extent.
  * Results are collected in sctx->clone_roots->ino/offset.
  */
-static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root_id,
-			    void *ctx_)
+static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, int extent_type,
+			    u64 root_id, void *ctx_)
 {
 	struct backref_ctx *bctx = ctx_;
 	struct clone_root *clone_root;
@@ -1341,6 +1344,10 @@ static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root_id,
 	if (!clone_root)
 		return 0;
 
+	/* Type is not matched */
+	if (extent_type != bctx->extent_type)
+		return 0;
+
 	/* This is our own reference, bail out as we can't clone from it. */
 	if (clone_root->root == bctx->sctx->send_root &&
 	    ino == bctx->cur_objectid &&
@@ -1599,6 +1606,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	extent_type = btrfs_file_extent_type(eb, fi);
 	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
 		return -ENOENT;
+	backref_ctx.extent_type = extent_type;
 
 	disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
 	if (disk_byte == 0)
-- 
2.34.1

