Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C578D3BBA07
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 11:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGEJTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 05:19:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhGEJTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 05:19:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1ABB71FE36;
        Mon,  5 Jul 2021 09:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625476605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A3v+qmS5smI2YB1m2O3ZOdNLkXHCRUch9uurrl2leWc=;
        b=NGLrbg2RGuT5ktE03L1OHYtWhy65qA85uGqDKRjRYTFyAkwPlV3sWVzBdqoaMWH5k36auV
        s1XGbIaeNB2rygdNvDccjs0+DXfpp3SQqtOAWyA6kNXCVwlGPPF9vgyZzM0vWMmFOoKF9d
        Myf0dJNotMIccQTw1JXQDdwziSMsihA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D627713440;
        Mon,  5 Jul 2021 09:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id msMqMfzN4mBXKwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 05 Jul 2021 09:16:44 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: rename btrfs_alloc_chunk to btrfs_create_chunk
Date:   Mon,  5 Jul 2021 12:16:43 +0300
Message-Id: <20210705091643.3404691-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The user facing function used to allocate new chunks is
btrfs_chunk_alloc, unfortunately there is yet another similar sounding
function - btrfs_alloc_chunk. This creates confusion, especially since
the latter function can be considered "private" in the sense that it
implements the first stage of chunk creation and as such is called by
btrfs_chunk_alloc.

To avoid the awkwardness that comes with having similarly named but
distinctly different in their purpose function rename btrfs_alloc_chunk
to btrfs_create_chunk, given that the main purpose of this function is
to orchestrate the whole process of allocating a chunk - reserving space
into devices, deciding on characteristics of the stripe size and
creating the in-memory structures.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Fix changlog to reflect reality

 fs/btrfs/block-group.c | 6 +++---
 fs/btrfs/volumes.c     | 8 ++++----
 fs/btrfs/volumes.h     | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5c2361168363..500a85e4320f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3358,7 +3358,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 	 */
 	check_system_chunk(trans, flags);

-	bg = btrfs_alloc_chunk(trans, flags);
+	bg = btrfs_create_chunk(trans, flags);
 	if (IS_ERR(bg)) {
 		ret = PTR_ERR(bg);
 		goto out;
@@ -3419,7 +3419,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 		const u64 sys_flags = btrfs_system_alloc_profile(trans->fs_info);
 		struct btrfs_block_group *sys_bg;

-		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -3712,7 +3712,7 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 		 * could deadlock on an extent buffer since our caller may be
 		 * COWing an extent buffer from the chunk btree.
 		 */
-		bg = btrfs_alloc_chunk(trans, flags);
+		bg = btrfs_create_chunk(trans, flags);
 		if (IS_ERR(bg)) {
 			ret = PTR_ERR(bg);
 		} else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f820c32f4a0d..4f84b5d871dd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3086,7 +3086,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 		const u64 sys_flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *sys_bg;

-		sys_bg = btrfs_alloc_chunk(trans, sys_flags);
+		sys_bg = btrfs_create_chunk(trans, sys_flags);
 		if (IS_ERR(sys_bg)) {
 			ret = PTR_ERR(sys_bg);
 			btrfs_abort_transaction(trans, ret);
@@ -5363,7 +5363,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	return block_group;
 }

-struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
@@ -5564,12 +5564,12 @@ static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 	 */

 	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
-	meta_bg = btrfs_alloc_chunk(trans, alloc_profile);
+	meta_bg = btrfs_create_chunk(trans, alloc_profile);
 	if (IS_ERR(meta_bg))
 		return PTR_ERR(meta_bg);

 	alloc_profile = btrfs_system_alloc_profile(fs_info);
-	sys_bg = btrfs_alloc_chunk(trans, alloc_profile);
+	sys_bg = btrfs_create_chunk(trans, alloc_profile);
 	if (IS_ERR(sys_bg))
 		return PTR_ERR(sys_bg);

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 70c749eee3ad..f9e13e8ca703 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -450,7 +450,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
 			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
-struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
--
2.25.1

