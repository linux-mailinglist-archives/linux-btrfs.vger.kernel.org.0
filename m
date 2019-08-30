Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E3A3970
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH3Oox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 10:44:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbfH3Oow (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 10:44:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEF64B02E;
        Fri, 30 Aug 2019 14:44:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Don't opencode btrfs_find_name_in_backref in backref_in_log
Date:   Fri, 30 Aug 2019 17:44:47 +0300
Message-Id: <20190830144449.23882-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830144449.23882-1-nborisov@suse.com>
References: <20190830144449.23882-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 48 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 77b6797fcac3..369046a754b0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -945,54 +945,30 @@ static noinline int backref_in_log(struct btrfs_root *log,
 				   const char *name, int namelen)
 {
 	struct btrfs_path *path;
-	struct btrfs_inode_ref *ref;
-	unsigned long ptr;
-	unsigned long ptr_end;
-	unsigned long name_ptr;
-	int found_name_len;
-	int item_size;
 	int ret;
-	int match = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
-	if (ret != 0)
-		goto out;
-
-	ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
-
-	if (key->type == BTRFS_INODE_EXTREF_KEY) {
-		if (btrfs_find_name_in_ext_backref(path->nodes[0],
-						   path->slots[0],
-						   ref_objectid,
-						   name, namelen))
-			match = 1;
-
+	if (ret != 0) {
+		ret = 0;
 		goto out;
 	}
 
-	item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-	ptr_end = ptr + item_size;
-	while (ptr < ptr_end) {
-		ref = (struct btrfs_inode_ref *)ptr;
-		found_name_len = btrfs_inode_ref_name_len(path->nodes[0], ref);
-		if (found_name_len == namelen) {
-			name_ptr = (unsigned long)(ref + 1);
-			ret = memcmp_extent_buffer(path->nodes[0], name,
-						   name_ptr, namelen);
-			if (ret == 0) {
-				match = 1;
-				goto out;
-			}
-		}
-		ptr = (unsigned long)(ref + 1) + found_name_len;
-	}
+	if (key->type == BTRFS_INODE_EXTREF_KEY)
+		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
+						       path->slots[0],
+						       ref_objectid,
+						       name, namelen);
+	else
+		ret = !!btrfs_find_name_in_backref(path->nodes[0],
+						   path->slots[0],
+						   name, namelen);
 out:
 	btrfs_free_path(path);
-	return match;
+	return ret;
 }
 
 static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
-- 
2.17.1

