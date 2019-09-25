Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5ABDC9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfIYLDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 07:03:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728040AbfIYLDJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 07:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FDDCAFDB;
        Wed, 25 Sep 2019 11:03:07 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Properly handle backref_in_log retval
Date:   Wed, 25 Sep 2019 14:03:03 +0300
Message-Id: <20190925110303.20466-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190924170920.GB2751@twin.jikos.cz>
References: <20190924170920.GB2751@twin.jikos.cz>
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

v2: 
 * Return 0 from backref_in_log in case btrfs_search_slot returns 1 (meaning it 
 didn't find appropriate item in the btree). 

 fs/btrfs/tree-log.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7cac09a6f007..7332f7a00790 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -952,7 +952,9 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
-	if (ret != 0) {
+	if (ret < 0) {
+		goto out;
+	} else if (ret == 1) {
 		ret = 0;
 		goto out;
 	}
@@ -1026,10 +1028,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
 
@@ -1091,10 +1096,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
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
@@ -1869,16 +1876,19 @@ static bool name_in_log_ref(struct btrfs_root *log_root,
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

