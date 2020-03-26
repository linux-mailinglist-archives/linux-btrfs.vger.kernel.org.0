Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF3193AF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCZIeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgCZIeT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2D2FACAE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 27/39] btrfs: Rename should_ignore_root() to btrfs_should_ignore_reloc_root() and export it
Date:   Thu, 26 Mar 2020 16:33:04 +0800
Message-Id: <20200326083316.48847-28-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
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
btrfs_should_ignore_reloc_root() make the name a little more clear.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/relocation.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1e8a0a513e73..01b03e8a671f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3383,6 +3383,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr);
+int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5448cc2f1b28..23ed17cd54c4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -305,7 +305,8 @@ static bool reloc_root_is_dead(struct btrfs_root *root)
  *
  * Reloc tree after swap is considered dead, thus not considered as valid.
  * This is enough for most callers, as they don't distinguish dead reloc root
- * from no reloc root.  But should_ignore_root() below is a special case.
+ * from no reloc root.  But btrfs_should_ignore_reloc_root() below is a
+ * special case.
  */
 static bool have_reloc_root(struct btrfs_root *root)
 {
@@ -316,7 +317,7 @@ static bool have_reloc_root(struct btrfs_root *root)
 	return true;
 }
 
-static int should_ignore_root(struct btrfs_root *root)
+int btrfs_should_ignore_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root;
 
@@ -342,6 +343,7 @@ static int should_ignore_root(struct btrfs_root *root)
 	 */
 	return 1;
 }
+
 /*
  * find reloc tree by address of tree root
  */
@@ -486,7 +488,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 	if (btrfs_root_level(&root->root_item) == cur->level) {
 		/* tree root */
 		ASSERT(btrfs_root_bytenr(&root->root_item) == cur->bytenr);
-		if (should_ignore_root(root)) {
+		if (btrfs_should_ignore_reloc_root(root)) {
 			btrfs_put_root(root);
 			list_add(&cur->list, &cache->useless_node);
 		} else {
@@ -527,7 +529,7 @@ static int handle_indirect_tree_backref(struct btrfs_backref_cache *cache,
 		if (!path->nodes[level]) {
 			ASSERT(btrfs_root_bytenr(&root->root_item) ==
 			       lower->bytenr);
-			if (should_ignore_root(root)) {
+			if (btrfs_should_ignore_reloc_root(root)) {
 				btrfs_put_root(root);
 				list_add(&lower->list, &cache->useless_node);
 			} else {
-- 
2.26.0

