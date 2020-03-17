Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CA187AF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCQIMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:12:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:42884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQIMn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08805ADA1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:12:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 26/39] btrfs: Rename should_ignore_root() to should_ignore_reloc_root() and export it
Date:   Tue, 17 Mar 2020 16:11:12 +0800
Message-Id: <20200317081125.36289-27-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is mostly single purpose to relocation backref cache, but
since we're moving the main part of backref cache to backref.c, we need
to export such function.

And to avoid confusing, rename the function to
should_ignore_reloc_root() make the name a little more clear.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      | 1 +
 fs/btrfs/relocation.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b57bb3e5f1f2..e45aad90b45e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3383,6 +3383,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr);
+int should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f0291177525c..d16d5f128d8e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -312,7 +312,7 @@ static bool reloc_root_is_dead(struct btrfs_root *root)
  *
  * Reloc tree after swap is considered dead, thus not considered as valid.
  * This is enough for most callers, as they don't distinguish dead reloc root
- * from no reloc root.  But should_ignore_root() below is a special case.
+ * from no reloc root.  But should_ignore_reloc_root() below is a special case.
  */
 static bool have_reloc_root(struct btrfs_root *root)
 {
@@ -323,7 +323,7 @@ static bool have_reloc_root(struct btrfs_root *root)
 	return true;
 }
 
-static int should_ignore_root(struct btrfs_root *root)
+int should_ignore_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root;
 
@@ -349,6 +349,7 @@ static int should_ignore_root(struct btrfs_root *root)
 	 */
 	return 1;
 }
+
 /*
  * find reloc tree by address of tree root
  */
@@ -494,7 +495,7 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 		/* tree root */
 		ASSERT(btrfs_root_bytenr(&root->root_item) ==
 		       cur->bytenr);
-		if (should_ignore_root(root)) {
+		if (should_ignore_reloc_root(root)) {
 			btrfs_put_root(root);
 			list_add(&cur->list, &cache->useless_node);
 		} else {
@@ -535,7 +536,7 @@ static int handle_indirect_tree_backref(struct backref_cache *cache,
 		if (!path->nodes[level]) {
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       lower->bytenr);
-			if (should_ignore_root(root)) {
+			if (should_ignore_reloc_root(root)) {
 				btrfs_put_root(root);
 				list_add(&lower->list, &cache->useless_node);
 			} else {
-- 
2.25.1

