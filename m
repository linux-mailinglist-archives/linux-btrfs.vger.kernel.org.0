Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD3167E12
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBUNL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:11:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBUNL1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:11:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7BF89AF22;
        Fri, 21 Feb 2020 13:11:26 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Use list_for_each_entry_safe in free_reloc_roots
Date:   Fri, 21 Feb 2020 15:11:24 +0200
Message-Id: <20200221131124.24105-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221131124.24105-1-nborisov@suse.com>
References: <20200221131124.24105-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function always works on a local copy of the reloc root list, which
cannot be modified outside of it so using list_for_each_entry is fine.
Additionally the macro handles empty lists so drop list_empty checks of
callers. No semantic changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e5cb64409f7c..f13b79adf6b0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2523,13 +2523,10 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 static noinline_for_stack
 void free_reloc_roots(struct list_head *list)
 {
-	struct btrfs_root *reloc_root;
+	struct btrfs_root *reloc_root, *tmp;
 
-	while (!list_empty(list)) {
-		reloc_root = list_entry(list->next, struct btrfs_root,
-					root_list);
+	list_for_each_entry_safe(reloc_root, tmp, list, root_list)
 		__del_reloc_root(reloc_root);
-	}
 }
 
 static noinline_for_stack
@@ -2588,15 +2585,13 @@ void merge_reloc_roots(struct reloc_control *rc)
 out:
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret, NULL);
-		if (!list_empty(&reloc_roots))
-			free_reloc_roots(&reloc_roots);
+		free_reloc_roots(&reloc_roots);
 
 		/* new reloc root may be added */
 		mutex_lock(&fs_info->reloc_mutex);
 		list_splice_init(&rc->reloc_roots, &reloc_roots);
 		mutex_unlock(&fs_info->reloc_mutex);
-		if (!list_empty(&reloc_roots))
-			free_reloc_roots(&reloc_roots);
+		free_reloc_roots(&reloc_roots);
 	}
 
 	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
@@ -4689,8 +4684,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 out_free:
 	kfree(rc);
 out:
-	if (!list_empty(&reloc_roots))
-		free_reloc_roots(&reloc_roots);
+	free_reloc_roots(&reloc_roots);
 
 	btrfs_free_path(path);
 
-- 
2.17.1

