Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D244CF1F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfJHEts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729730AbfJHEtr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B7B4AF6B
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs-progs: check: Introduce support for bg-tree feature
Date:   Tue,  8 Oct 2019 12:49:35 +0800
Message-Id: <20191008044936.157873-7-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044936.157873-1-wqu@suse.com>
References: <20191008044936.157873-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just some minor modification.

- original mode:
  * Block group item can occur in extent tree and bg tree.
- lowmem mode:
  * search block group items in bg tree if BG_TREE feature is set.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 3 ++-
 check/mode-lowmem.c | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 94ffab46cb70..3fd0bb2317bb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6034,7 +6034,8 @@ static int check_type_with_root(u64 rootid, u8 key_type)
 	case BTRFS_EXTENT_ITEM_KEY:
 	case BTRFS_METADATA_ITEM_KEY:
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
-		if (rootid != BTRFS_EXTENT_TREE_OBJECTID)
+		if (rootid != BTRFS_EXTENT_TREE_OBJECTID &&
+		    rootid != BTRFS_BLOCK_GROUP_TREE_OBJECTID)
 			goto err;
 		break;
 	case BTRFS_ROOT_ITEM_KEY:
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 5f7f101daab1..fcb8210984eb 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4365,7 +4365,7 @@ next:
 static int check_chunk_item(struct btrfs_fs_info *fs_info,
 			    struct extent_buffer *eb, int slot)
 {
-	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_root *root;
 	struct btrfs_root *dev_root = fs_info->dev_root;
 	struct btrfs_path path;
 	struct btrfs_key chunk_key;
@@ -4387,6 +4387,11 @@ static int check_chunk_item(struct btrfs_fs_info *fs_info,
 	int ret;
 	int err = 0;
 
+	if (btrfs_fs_incompat(fs_info, BG_TREE))
+		root = fs_info->bg_root;
+	else
+		root = fs_info->extent_root;
+
 	btrfs_item_key_to_cpu(eb, &chunk_key, slot);
 	chunk = btrfs_item_ptr(eb, slot, struct btrfs_chunk);
 	length = btrfs_chunk_length(eb, chunk);
@@ -4406,7 +4411,7 @@ static int check_chunk_item(struct btrfs_fs_info *fs_info,
 	bg_key.offset = length;
 
 	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, extent_root, &bg_key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &bg_key, &path, 0, 0);
 	if (ret) {
 		error(
 		"chunk[%llu %llu) did not find the related block group item",
-- 
2.23.0

