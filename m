Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB914047A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAQHaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 02:30:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbgAQHaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 02:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FB6AABEA
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 07:30:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: Repair invalid extent item generation
Date:   Fri, 17 Jan 2020 15:29:57 +0800
Message-Id: <20200117072959.27929-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117072959.27929-1-wqu@suse.com>
References: <20200117072959.27929-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, the only way to repair extent item generation is
--init-extent-tree.

Unfortunately that operation is super slow since it needs to start and
commit transaction to each extent backref repaired.

This has caused end-user several failed repair, so introduce the
repairability for lowmem mode.

Please note that, there is a trade off between accurate generation
against complexity.
In theory we should grab the accurate generation number from EXTENT_DATA
item, but that's a little complex to parse in lowmem mode.

So this patch will just reset extent generation to current transid,
passing tree-checker.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f76d634bdb5..6fe9dc780285 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4140,6 +4140,68 @@ out:
 	return ret;
 }
 
+static int reset_extent_item_gen(struct btrfs_fs_info *fs_info,
+				 struct btrfs_path *path)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key;
+	struct btrfs_extent_item *ei;
+	struct extent_buffer *leaf;
+	u64 transid;
+	int slot;
+	int ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ASSERT(key.type == BTRFS_EXTENT_ITEM_KEY ||
+	       key.type == BTRFS_METADATA_ITEM_KEY);
+
+	btrfs_release_path(path);
+	trans = btrfs_start_transaction(fs_info->extent_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	transid = trans->transid;
+	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 1);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search extent tree: %m");
+		goto abort;
+	}
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("unable to find key (%llu %u %llu)", key.objectid,
+				key.type, key.offset);
+		goto abort;
+	}
+	slot = path->slots[0];
+	leaf = path->nodes[0];
+	if (btrfs_item_size_nr(leaf, slot) < sizeof(*ei)) {
+		ret = -EUCLEAN;
+		error("invalid extent item size, have %u expect >= %zu",
+			btrfs_item_size_nr(leaf, slot), sizeof(*ei));
+		goto abort;
+	}
+	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+	/*
+	 * The best generation should be fetched from EXTENT_DATA item,
+	 * but in lowmem mode we hadn't get the info.
+	 * So here use transid for it, which is good enough to pass
+	 * tree-checker and not cause any problem.
+	 */
+	btrfs_set_extent_generation(leaf, ei, transid);
+	ret = btrfs_commit_transaction(trans, fs_info->extent_root);
+	if (!ret)
+		printf("reset extent item generation to %llu for extent %llu\n",
+			transid, key.objectid);
+	return ret;
+abort:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 /*
  * This function will check a given extent item, including its backref and
  * itself (like crossing stripe boundary and type)
@@ -4203,6 +4265,18 @@ static int check_extent_item(struct btrfs_fs_info *fs_info,
 		"invalid generation for extent %llu, have %llu expect (0, %llu]",
 			key.objectid, gen, super_gen + 1);
 		err |= INVALID_GENERATION;
+		if (repair) {
+			ret = reset_extent_item_gen(fs_info, path);
+			if (!ret)
+				err &= ~INVALID_GENERATION;
+			/* Fatal error in repair, path unreliable */
+			if (!path->nodes[0])
+				return ret;
+			/* Reset related eb/slots to new path */
+			eb = path->nodes[0];
+			slot = path->slots[0];
+			ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
+		}
 	}
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)
-- 
2.24.1

