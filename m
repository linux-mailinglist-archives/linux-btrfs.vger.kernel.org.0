Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086433E083E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhHDStr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhHDStm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10B13201D2;
        Wed,  4 Aug 2021 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fatp8DYVQeRDvvl4mHcDwHwiKCtgyq+/eqCCJqqjp+A=;
        b=Q296psR4yJ9pvc4FaI9htnoElLtMgedu7oqIYL9Ea7Kdlhn+xH9GU5LgW7STiMPkenl5G2
        6AVywp7HsvnFd9LyVkQjv1lsU2U5ttXan98OkkzFN3kCQE03NvgzBGKChrwW5hWM1LmpPt
        wI9JXWY9tJe4tMzSemzTNQCQwb6+GXM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC47713D24;
        Wed,  4 Aug 2021 18:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ePoHITfhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:27 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 4/7] btrfs: root-tree: Use btrfs_find_item in btrfs_find_orphan_roots
Date:   Wed,  4 Aug 2021 15:48:51 -0300
Message-Id: <20210804184854.10696-5-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prefer btrfs_find_item instead of btrfs_search_slot, since it calls
btrfs_next_leaf if needed and checks if the item found has the same
objectid and type passed in the search key.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/root-tree.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..4bb0ad192a2f 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -207,10 +207,10 @@ int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct extent_buffer *leaf;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_root *root;
+	u64 offset = 0;
 	int err = 0;
 	int ret;
 
@@ -218,38 +218,22 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = BTRFS_ORPHAN_OBJECTID;
-	key.type = BTRFS_ORPHAN_ITEM_KEY;
-	key.offset = 0;
-
 	while (1) {
 		u64 root_objectid;
 
-		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
+		ret = btrfs_find_item(tree_root, path, BTRFS_ORPHAN_OBJECTID,
+				BTRFS_ORPHAN_ITEM_KEY, offset, &key);
+
+		btrfs_release_path(path);
 		if (ret < 0) {
 			err = ret;
 			break;
-		}
-
-		leaf = path->nodes[0];
-		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(tree_root, path);
-			if (ret < 0)
-				err = ret;
-			if (ret != 0)
-				break;
-			leaf = path->nodes[0];
-		}
-
-		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-		btrfs_release_path(path);
-
-		if (key.objectid != BTRFS_ORPHAN_OBJECTID ||
-		    key.type != BTRFS_ORPHAN_ITEM_KEY)
+		} else if (ret > 0) {
 			break;
+		}
 
 		root_objectid = key.offset;
-		key.offset++;
+		offset++;
 
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
 		err = PTR_ERR_OR_ZERO(root);
-- 
2.31.1

