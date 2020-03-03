Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBC9176FDE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCCHPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgCCHPq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:15:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42EABAC53
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:15:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/19] btrfs: relocation: Open-code read_fs_root() for handle_one_tree_backref()
Date:   Tue,  3 Mar 2020 15:14:06 +0800
Message-Id: <20200303071409.57982-17-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303071409.57982-1-wqu@suse.com>
References: <20200303071409.57982-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The backref code is going to be moved to backref.c, and read_fs_root()
is just a simple wrapper, open-code it to prepare to the incoming code
move.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2230ea8a3698..441d2b28d8e7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -397,6 +397,7 @@ static int handle_one_tree_backref(struct backref_cache *cache,
 	struct backref_node *lower;
 	struct backref_edge *edge;
 	struct extent_buffer *eb;
+	struct btrfs_key root_key;
 	struct btrfs_root *root;
 	struct rb_node *rb_node;
 	bool need_check = true;
@@ -456,7 +457,10 @@ static int handle_one_tree_backref(struct backref_cache *cache,
 	 * ref_key.type == BTRFS_TREE_BLOCK_REF_KEY, ref_key->offset means the
 	 * root objectid. We need to search the tree to get its parent bytenr.
 	 */
-	root = read_fs_root(fs_info, ref_key->offset);
+	root_key.objectid = ref_key->offset;
+	root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root_key.offset = (u64)-1;
+	root = btrfs_get_fs_root(fs_info, &root_key, false);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-- 
2.25.1

