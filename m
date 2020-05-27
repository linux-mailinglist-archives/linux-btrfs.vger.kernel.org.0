Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937541E3EB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgE0KLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgE0KLC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F069FAB5C;
        Wed, 27 May 2020 10:11:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: remove redundant local var in read_block_for_search
Date:   Wed, 27 May 2020 13:10:59 +0300
Message-Id: <20200527101059.7391-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The local 'b' variable is only used to directly read values from passed
extent buffer. So eliminate  it and directly use the input parameter. Furthermore
this shrinks the size of the following functions:

./scripts/bloat-o-meter ctree.orig fs/btrfs/ctree.o
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-73 (-73)
Function                                     old     new   delta
read_block_for_search.isra                   876     871      -5
push_node_left                              1112    1044     -68
Total: Before=50348, After=50275, chg -0.14%

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3ab307b4b294..72a3389d2d87 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2335,16 +2335,15 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 blocknr;
 	u64 gen;
-	struct extent_buffer *b = *eb_ret;
 	struct extent_buffer *tmp;
 	struct btrfs_key first_key;
 	int ret;
 	int parent_level;

-	blocknr = btrfs_node_blockptr(b, slot);
-	gen = btrfs_node_ptr_generation(b, slot);
-	parent_level = btrfs_header_level(b);
-	btrfs_node_key_to_cpu(b, &first_key, slot);
+	blocknr = btrfs_node_blockptr(*eb_ret, slot);
+	gen = btrfs_node_ptr_generation(*eb_ret, slot);
+	parent_level = btrfs_header_level(*eb_ret);
+	btrfs_node_key_to_cpu(*eb_ret, &first_key, slot);

 	tmp = find_extent_buffer(fs_info, blocknr);
 	if (tmp) {
--
2.17.1

