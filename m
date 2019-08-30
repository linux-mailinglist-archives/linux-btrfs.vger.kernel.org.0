Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5310A396F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH3Oox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 10:44:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:41218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbfH3Oox (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 10:44:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03453B65C;
        Fri, 30 Aug 2019 14:44:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Properly handle backref_in_log retval
Date:   Fri, 30 Aug 2019 17:44:48 +0300
Message-Id: <20190830144449.23882-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830144449.23882-1-nborisov@suse.com>
References: <20190830144449.23882-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function can return a negative error value if btrfs_search_slot
errors for whatever reason or if btrfs_alloc_path runs out of memory.
This is currently problemattic because backref_in_log is treated by its
callers as if it returns boolean.

Fix this by adding proper error handling in callers. That also enables
the function to return the direct error code from btrfs_search_slot.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 369046a754b0..ca294ff463de 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -952,10 +952,8 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
-	if (ret != 0) {
-		ret = 0;
+	if (ret != 0)
 		goto out;
-	}
 
 	if (key->type == BTRFS_INODE_EXTREF_KEY)
 		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
@@ -1026,10 +1024,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					   (unsigned long)(victim_ref + 1),
 					   victim_name_len);
 
-			if (!backref_in_log(log_root, &search_key,
-					    parent_objectid,
-					    victim_name,
-					    victim_name_len)) {
+			ret = backref_in_log(log_root, &search_key,
+					     parent_objectid, victim_name,
+					     victim_name_len);
+			if (ret < 0) {
+				kfree(victim_name);
+				return ret;
+			} else if (!ret) {
 				inc_nlink(&inode->vfs_inode);
 				btrfs_release_path(path);
 
@@ -1091,10 +1092,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 			search_key.offset = btrfs_extref_hash(parent_objectid,
 							      victim_name,
 							      victim_name_len);
-			ret = 0;
-			if (!backref_in_log(log_root, &search_key,
-					    parent_objectid, victim_name,
-					    victim_name_len)) {
+			ret = backref_in_log(log_root, &search_key,
+					     parent_objectid, victim_name,
+					     victim_name_len);
+			if (ret < 0) {
+				return ret;
+			} else if (!ret) {
 				ret = -ENOENT;
 				victim_parent = read_one_inode(root,
 						parent_objectid);
@@ -1869,16 +1872,19 @@ static bool name_in_log_ref(struct btrfs_root *log_root,
 			    const u64 dirid, const u64 ino)
 {
 	struct btrfs_key search_key;
+	int ret;
 
 	search_key.objectid = ino;
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = dirid;
-	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
+	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
+	if (ret == 1)
 		return true;
 
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
 	search_key.offset = btrfs_extref_hash(dirid, name, name_len);
-	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
+	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
+	if (ret == 1)
 		return true;
 
 	return false;
-- 
2.17.1

