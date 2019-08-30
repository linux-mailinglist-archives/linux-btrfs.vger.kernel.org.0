Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967E5A3971
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Ooz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 10:44:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfH3Oox (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 10:44:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 405EBB662;
        Fri, 30 Aug 2019 14:44:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: Open-code name_in_log_ref in replay_one_name
Date:   Fri, 30 Aug 2019 17:44:49 +0300
Message-Id: <20190830144449.23882-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830144449.23882-1-nborisov@suse.com>
References: <20190830144449.23882-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That function adds unnecessary indirection between backref_in_log and
the caller. Furthermore it also "downgrades" backref_in_log's return
value to a boolean, when in fact it could very well be an error.

Rectify the situation by simply opencoding name_in_log_ref in
replay_one_name and properly handling possible return codes from
backref_in_log.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tree-log.c | 51 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ca294ff463de..822dd0486f7c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1863,33 +1863,6 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * Return true if an inode reference exists in the log for the given name,
- * inode and parent inode.
- */
-static bool name_in_log_ref(struct btrfs_root *log_root,
-			    const char *name, const int name_len,
-			    const u64 dirid, const u64 ino)
-{
-	struct btrfs_key search_key;
-	int ret;
-
-	search_key.objectid = ino;
-	search_key.type = BTRFS_INODE_REF_KEY;
-	search_key.offset = dirid;
-	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
-	if (ret == 1)
-		return true;
-
-	search_key.type = BTRFS_INODE_EXTREF_KEY;
-	search_key.offset = btrfs_extref_hash(dirid, name, name_len);
-	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
-	if (ret == 1)
-		return true;
-
-	return false;
-}
-
 /*
  * take a single entry in a log directory item and replay it into
  * the subvolume.
@@ -2006,8 +1979,28 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	return ret;
 
 insert:
-	if (name_in_log_ref(root->log_root, name, name_len,
-			    key->objectid, log_key.objectid)) {
+	/* Ensure the to-be-added name is not already in the subvol tree */
+	found_key.objectid = log_key.objectid;
+	found_key.type = BTRFS_INODE_REF_KEY;
+	found_key.offset = key->objectid;
+	ret = backref_in_log(root->log_root, &found_key, 0, name, name_len);
+	if (ret < 0)
+	        goto out;
+	else if (ret) {
+	        /* The dentry will be added later. */
+	        ret = 0;
+	        update_size = false;
+	        goto out;
+	}
+
+	found_key.objectid = log_key.objectid;
+	found_key.type = BTRFS_INODE_EXTREF_KEY;
+	found_key.offset = key->objectid;
+	ret = backref_in_log(root->log_root, &found_key, key->objectid, name,
+			     name_len);
+	if (ret < 0) {
+		goto out;
+	} else if (ret) {
 		/* The dentry will be added later. */
 		ret = 0;
 		update_size = false;
-- 
2.17.1

