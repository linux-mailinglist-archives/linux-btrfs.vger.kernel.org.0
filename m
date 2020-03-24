Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68349190B8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXKx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXKx1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E3D6AF43
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: check/original: Fix uninitialized return value from btrfs_write_dirty_block_groups()
Date:   Tue, 24 Mar 2020 18:53:13 +0800
Message-Id: <20200324105315.136569-5-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324105315.136569-1-wqu@suse.com>
References: <20200324105315.136569-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Valgrind reports the following error for fsck/007, which is only
repairable for original mode:
  ==97599== Conditional jump or move depends on uninitialised value(s)
  ==97599==    at 0x1D4A42: btrfs_commit_transaction (transaction.c:207)
  ==97599==    by 0x16475C: check_extent_refs (main.c:8097)
  ==97599==    by 0x166199: check_chunks_and_extents (main.c:8786)
  ==97599==    by 0x166441: do_check_chunks_and_extents (main.c:8842)
  ==97599==    by 0x169D13: cmd_check (main.c:10324)
  ==97599==    by 0x11CDC6: cmd_execute (commands.h:125)
  ==97599==    by 0x11D712: main (btrfs.c:386)
  ==97599==

[CAUSE]
If btrfs_write_dirty_block_groups() get called with no block group
dirtied (no dirty extents created), the return value of it is
uninitialized, as the stack @ret is not initialized at all.

[FIX]
Initialize @ret to 0 for btrfs_write_dirty_block_groups() as if there is
no dirty block groups, we do nothing and shouldn't fail.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index dc4b052c1666..f0cb9faa4da6 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1564,7 +1564,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_path *path;
-	int ret;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
-- 
2.25.2

