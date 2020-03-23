Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F118F2BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCWKZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:25:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgCWKZq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:25:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 339D6AF79
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:25:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 28/40] btrfs: relocation: Open-code read_fs_root() for handle_indirect_tree_backref()
Date:   Mon, 23 Mar 2020 18:24:04 +0800
Message-Id: <20200323102416.112862-29-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
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
index 29bf34b1114c..df2897f6f206 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -481,12 +481,16 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 	struct btrfs_backref_edge *edge;
 	struct extent_buffer *eb;
 	struct btrfs_root *root;
+	struct btrfs_key root_key;
 	struct rb_node *rb_node;
 	int level;
 	bool need_check = true;
 	int ret;
 
-	root = read_fs_root(fs_info, ref_key->offset);
+	root_key.objectid = ref_key->offset;
+	root_key.type = BTRFS_ROOT_ITEM_KEY;
+	root_key.offset = (u64)-1;
+	root = btrfs_get_fs_root(fs_info, &root_key, false);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
-- 
2.25.2

