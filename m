Return-Path: <linux-btrfs+bounces-7954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592BF975D5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6301F236B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213D184524;
	Wed, 11 Sep 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fz6f1SfR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fz6f1SfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FF1E4B2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094746; cv=none; b=U0FnH9pX+crrQHCAhrxBRucKMmeyQwQywQgfGpgntvr/96/I6uZe5jhP0uBSqu92X8sGCk9SQMOkFELkOCtl3Ktpr3rM5y9Dgdi0JEQzQDXJiF2pwmkCVmdaYaGpebbgH4EbLlz9A2FmrCNNseY6jmLFBrFuT6KfUclyE3RLEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094746; c=relaxed/simple;
	bh=c7yqj6UcV4gnq5kxt9NQEl+6vnkQJrXnrawnPNrOjNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgJ8wtBeegiWC1XDBIro1zUTWByz24TUoSViePC/s1qDuWK/NKCMS3PWAjMXCtQoIHiaBmCgCRFTb5g6SIJRxruQz93SGClqcsQCBjTK6xgV6K9cQbI7J2hcPiSPytrLem0duAH1lugcNZJsCNkUNlNPQga1Yi6JKuW6mZEpDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fz6f1SfR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fz6f1SfR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B377121AD3;
	Wed, 11 Sep 2024 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726094740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oGPiuYMle10rOPg9+LtSe+ZM6UzN8nR5IGpF898a2cY=;
	b=fz6f1SfRA5gv5VigfULR8q9/RDushb/mnNJD0pWS/+fxV/TqjRArg9sqTV8VyS+Psel5pS
	5fgN8G082Y9wSVKLTFB6pEhJFAivO91UDn+V7kJquqi22rS0LIigj+i4fobuWyLBDdbxDY
	QnqR9f82+MPpZFUSdC8v9SHfLhLHqcs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fz6f1SfR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726094740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oGPiuYMle10rOPg9+LtSe+ZM6UzN8nR5IGpF898a2cY=;
	b=fz6f1SfRA5gv5VigfULR8q9/RDushb/mnNJD0pWS/+fxV/TqjRArg9sqTV8VyS+Psel5pS
	5fgN8G082Y9wSVKLTFB6pEhJFAivO91UDn+V7kJquqi22rS0LIigj+i4fobuWyLBDdbxDY
	QnqR9f82+MPpZFUSdC8v9SHfLhLHqcs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B038313A6E;
	Wed, 11 Sep 2024 22:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UEJNHJMd4mZ0awAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 11 Sep 2024 22:45:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Archange <archange@archlinux.org>
Subject: [PATCH] btrfs-progs: fix a false failure for inode cache cleanup
Date: Thu, 12 Sep 2024 08:15:17 +0930
Message-ID: <6a7acf399863f0ad8627a082a92ef8fc332c2642.1726094645.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B377121AD3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is one report about `btrfs rescue clear-ino-cache` failed with
tree block level mismatch:

 # btrfs rescue clear-ino-cache /dev/mapper/rootext
 Successfully cleaned up ino cache for root id: 5
 Successfully cleaned up ino cache for root id: 257
 Successfully cleaned up ino cache for root id: 258
 corrupt node: root=7 block=647369064448 slot=0, invalid level for leaf, have 1 expect 0
 node 647369064448 level 1 items 252 free space 241 generation 6065173 owner CSUM_TREE
 node 647369064448 flags 0x1(WRITTEN) backref revision 1
 fs uuid e6614f01-6f56-4776-8b0a-c260089c35e7
 chunk uuid f665f535-4cfd-49e0-8be9-7f94bf59b75d
     key (EXTENT_CSUM EXTENT_CSUM 3714473984) block 677126111232 gen 6065002
     [...]
     key (EXTENT_CSUM EXTENT_CSUM 6192357376) block 646396493824 gen 6065032
 ERROR: failed to clear ino cache: Input/output error

[CAUSE]
During `btrfs rescue clear-ino-cache`, btrfs-progs will iterate through
all the subvolumes, and clear the inode cache inode from each subvolume.

The problem is in how we iterate the subvolumes.

We hold a path of tree root, and go modifiy the fs for each found
subvolume, then call btrfs_next_item().

This is not safe, because the path to tree root is not longer reliable
if we modified the fs.

So the btrfs_next_item() call will fail because the fs is modified
halfway, resulting the above problem.

[FIX]
Instead of holding a path to a subvolume root item, and modify the fs
halfway, here introduce a helper, find_next_root(), to locate the root
item whose objectid >= our target rootid, and return the found item key.

The path to root tree is only hold then released inside
find_next_root().

By this, we won't hold any unrelated path while modifying the
filesystem.

And since we're here, also adding back the missing new line when all ino
cache is cleared.

Reported-by: Archange <archange@archlinux.org>
Link: https://lore.kernel.org/linux-btrfs/4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue.c        |   2 +-
 common/clear-cache.c | 122 ++++++++++++++++++++++++-------------------
 2 files changed, 70 insertions(+), 54 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 5bbd47e5c2e3..c60bf11675b9 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -449,7 +449,7 @@ static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
 		errno = -ret;
 		error("failed to clear ino cache: %m");
 	} else {
-		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache");
+		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache\n");
 	}
 	close_ctree(fs_info->tree_root);
 out:
diff --git a/common/clear-cache.c b/common/clear-cache.c
index 960c3466ce44..f0bc40753e6d 100644
--- a/common/clear-cache.c
+++ b/common/clear-cache.c
@@ -555,69 +555,85 @@ out:
 	return ret;
 }
 
-int clear_ino_cache_items(struct btrfs_fs_info *fs_info)
+/*
+ * Find a root item whose key.objectid >= @rootid, and save the found
+ * key into @found_key.
+ *
+ * Return 0 if a root item is found.
+ * Return >0 if no more root item is found.
+ * Return <0 for error.
+ */
+static int find_next_root(struct btrfs_fs_info *fs_info, u64 rootid,
+			  struct btrfs_key *found_key)
 {
-	int ret;
+	struct btrfs_key key = {
+		.objectid = rootid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
 	struct btrfs_path path = { 0 };
-	struct btrfs_key key;
-
-	key.objectid = BTRFS_FS_TREE_OBJECTID;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = 0;
+	int ret;
 
 	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, &path, 0, 0);
 	if (ret < 0)
 		return ret;
-
-	while(1) {
-		struct btrfs_key found_key;
-
-		btrfs_item_key_to_cpu(path.nodes[0], &found_key, path.slots[0]);
-		if (found_key.type == BTRFS_ROOT_ITEM_KEY &&
-		    is_fstree(found_key.objectid)) {
-			struct btrfs_root *root;
-
-			found_key.offset = (u64)-1;
-			root = btrfs_read_fs_root(fs_info, &found_key);
-			if (IS_ERR(root))
-				goto next;
-			ret = truncate_free_ino_items(root);
-			if (ret)
-				goto out;
-			printf("Successfully cleaned up ino cache for root id: %lld\n",
-					root->objectid);
-		} else {
-			/* If we get a negative tree this means it's the last one */
-			if ((s64)found_key.objectid < 0 &&
-			    found_key.type == BTRFS_ROOT_ITEM_KEY)
-				goto out;
-		}
-
-		/*
-		 * Only fs roots contain an ino cache information - either
-		 * FS_TREE_OBJECTID or subvol id >= BTRFS_FIRST_FREE_OBJECTID
-		 */
-next:
-		if (key.objectid == BTRFS_FS_TREE_OBJECTID) {
-			key.objectid = BTRFS_FIRST_FREE_OBJECTID;
-			btrfs_release_path(&path);
-			ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
-						&path,	0, 0);
-			if (ret < 0)
-				return ret;
-		} else {
-			ret = btrfs_next_item(fs_info->tree_root, &path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = 0;
-				goto out;
-			}
+	while (true) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.type == BTRFS_ROOT_ITEM_KEY && key.objectid >= rootid) {
+			memcpy(found_key, &key, sizeof(key));
+			ret = 0;
+			goto out;
 		}
+		ret = btrfs_next_item(fs_info->tree_root, &path);
+		if (ret)
+			goto out;
 	}
-
 out:
 	btrfs_release_path(&path);
 	return ret;
 }
 
+int clear_ino_cache_items(struct btrfs_fs_info *fs_info)
+{
+	u64 cur_subvol = BTRFS_FS_TREE_OBJECTID;
+	int ret;
+
+	while (1) {
+		struct btrfs_key key = { 0 };
+		struct btrfs_root *root;
+
+		ret = find_next_root(fs_info, cur_subvol, &key);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to find the next root item: %m");
+			break;
+		}
+		if (ret > 0 || !is_fstree(key.objectid)) {
+			ret = 0;
+			break;
+		}
+		root = btrfs_read_fs_root(fs_info, &key);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			errno = -ret;
+			error("failed to read root %llu: %m", key.objectid);
+			break;
+		}
+		ret = truncate_free_ino_items(root);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to clean up ino cache for root %llu: %m",
+			      key.objectid);
+			break;
+		}
+		printf("Successfully cleaned up ino cache for root id: %lld\n",
+			root->objectid);
+
+		if (cur_subvol == BTRFS_FS_TREE_OBJECTID)
+			cur_subvol = BTRFS_FIRST_FREE_OBJECTID;
+		else
+			cur_subvol = root->objectid + 1;
+	}
+	return ret;
+}
+
-- 
2.46.0


