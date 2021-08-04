Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907813E083C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhHDStq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbhHDStk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E0E6A1FE18;
        Wed,  4 Aug 2021 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8Hi2oWNJjlFo269eqZoIHXcqr48cq44HRIGXvFmLwE=;
        b=mlq9E0F0KjdZ3/J9cofZicQa/mdFdiMb7NorFCyXYCSSXUR4SMkfVqFMgfZQk+Wl0/go+X
        9diNKzJuGetuRWXXe9ta2/aFtZ7ganrJrEx/oPpx23bzihomwzxIBk2Z2eDDtyAcXeW1hE
        LG3xl1X4ibzn6WX2sKQf01/cQno4uJ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95A5313D24;
        Wed,  4 Aug 2021 18:49:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qNTFFzLhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:22 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/7] btrfs: Reorder btrfs_find_item arguments
Date:   Wed,  4 Aug 2021 15:48:48 -0300
Message-Id: <20210804184854.10696-2-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's more natural do use objectid, type and offset, in this order, when
dealing with btrfs keys.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/backref.c | 9 ++++-----
 fs/btrfs/ctree.c   | 2 +-
 fs/btrfs/ctree.h   | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f735b8798ba1..9e92faaafa02 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1691,8 +1691,8 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 				btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 		}
-		ret = btrfs_find_item(fs_root, path, parent, 0,
-				BTRFS_INODE_REF_KEY, &found_key);
+		ret = btrfs_find_item(fs_root, path, parent, BTRFS_INODE_REF_KEY,
+					0, &found_key);
 		if (ret > 0)
 			ret = -ENOENT;
 		if (ret)
@@ -2063,9 +2063,8 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 	struct btrfs_key found_key;
 
 	while (!ret) {
-		ret = btrfs_find_item(fs_root, path, inum,
-				parent ? parent + 1 : 0, BTRFS_INODE_REF_KEY,
-				&found_key);
+		ret = btrfs_find_item(fs_root, path, inum, BTRFS_INODE_REF_KEY,
+				parent ? parent + 1 : 0, &found_key);
 
 		if (ret < 0)
 			break;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 84627cbd5b5b..c0002ec9c025 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1528,7 +1528,7 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *path,
-		u64 iobjectid, u64 ioff, u8 key_type,
+		u64 iobjectid, u8 key_type, u64 ioff,
 		struct btrfs_key *found_key)
 {
 	int ret;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a898257ad2b5..0a971e98f5f9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2858,7 +2858,7 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
 			 struct btrfs_path *path,
 			 const struct btrfs_key *new_key);
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *path,
-		u64 inum, u64 ioff, u8 key_type, struct btrfs_key *found_key);
+		u64 inum, u8 key_type, u64 ioff, struct btrfs_key *found_key);
 int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, struct btrfs_path *p,
 		      int ins_len, int cow);
-- 
2.31.1

