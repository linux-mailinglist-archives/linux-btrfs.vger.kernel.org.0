Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EAA24E4F3
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Aug 2020 05:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHVDoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 23:44:13 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.224]:29868 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgHVDoI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 23:44:08 -0400
X-Greylist: delayed 1208 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 23:44:08 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 93B0E4B21
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 22:23:58 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 9K8MkPXLsdbRz9K8MkIDcj; Fri, 21 Aug 2020 22:23:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vVPRH9F8YrkpHU8xdfeGoUgSA8/uUhzKXo/wzMRkzWE=; b=DcxuJYJNVD1mBlXkZR/C5ocEbj
        siZnGPKDCh6BNgcQOX4MZYTEQeq6meE6UtK5O7016VwmxUGu65it2uqHdks8RuTfKjaqH4sO7d+kO
        shoTkLN1HULOCL0f8FfFH2C07/6mQBQXxvgH91mIFmqvMQQlHKMioBJdaBbVV29JyIGSEzUkIL0KR
        0KWSHq9R1r93GqhWrWP8jN7csB6rnyo1MKJsqEW0AnP2VrvQvYvoDqEuIHqkpd08OY3rDJH4izujt
        bS0a7q52HKvF928efWzn8Yc+zCKOHQoI/9rKGFIZWnMldK56JLB9xQCKJDqu7TJ9QF6ALPVdQzbAs
        PpKv9Wng==;
Received: from [177.96.43.33] (port=33548 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k9K8M-003wCq-DW; Sat, 22 Aug 2020 00:23:58 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] btrfs-progs: Make btrfs_lookup_dir_index in parity with kernel code
Date:   Sat, 22 Aug 2020 00:23:31 -0300
Message-Id: <20200822032331.5088-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.96.43.33
X-Source-L: No
X-Exim-ID: 1k9K8M-003wCq-DW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [177.96.43.33]:33548
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function exists in kernel side but using the _item suffix, and
objectid argument is placed before the name argument. Change the
function to reflect the kernel version.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Changes from v1:
 * Added a reviewed-by tag from Josef
 * Put the return type in the same line of the function name (David)

 check/main.c             |  6 +++---
 kernel-shared/ctree.h    | 10 +++++-----
 kernel-shared/dir-item.c | 12 ++++++------
 kernel-shared/inode.c    | 14 +++++++-------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/check/main.c b/check/main.c
index cc902e15..9a2ee2a0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2068,9 +2068,9 @@ static int delete_dir_index(struct btrfs_root *root,
 		(unsigned long long)root->objectid);
 
 	btrfs_init_path(&path);
-	di = btrfs_lookup_dir_index(trans, root, &path, backref->dir,
-				    backref->name, backref->namelen,
-				    backref->index, -1);
+	di = btrfs_lookup_dir_index_item(trans, root, &path, backref->dir,
+					 backref->index, backref->name,
+					 backref->namelen, -1);
 	if (IS_ERR(di)) {
 		ret = PTR_ERR(di);
 		btrfs_release_path(&path);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 11b77775..85c755f8 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2760,11 +2760,11 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_path *path, u64 dir,
 					     const char *name, int name_len,
 					     int mod);
-struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
-					      struct btrfs_root *root,
-					      struct btrfs_path *path, u64 dir,
-					      const char *name, int name_len,
-					      u64 index, int mod);
+struct btrfs_dir_item * btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
+					struct btrfs_root *root,
+					struct btrfs_path *path, u64 dir,
+					u64 objectid, const char *name, int name_len,
+					int mod);
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index c0a1d025..7dc606c1 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -225,11 +225,11 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return btrfs_match_dir_item_name(root, path, name, name_len);
 }
 
-struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
-					      struct btrfs_root *root,
-					      struct btrfs_path *path, u64 dir,
-					      const char *name, int name_len,
-					      u64 index, int mod)
+struct btrfs_dir_item *btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
+					struct btrfs_root *root,
+					struct btrfs_path *path, u64 dir,
+					u64 objectid, const char *name, int name_len,
+					int mod)
 {
 	int ret;
 	struct btrfs_key key;
@@ -238,7 +238,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = index;
+	key.offset = objectid;
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 1d6452cc..8dfe5b0d 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -136,8 +136,8 @@ int check_dir_conflict(struct btrfs_root *root, char *name, int namelen,
 	btrfs_release_path(path);
 
 	/* Index conflicting? */
-	dir_item = btrfs_lookup_dir_index(NULL, root, path, dir, name,
-					  namelen, index, 0);
+	dir_item = btrfs_lookup_dir_index_item(NULL, root, path, dir, index,
+					  name, namelen, 0);
 	if (IS_ERR(dir_item) && PTR_ERR(dir_item) == -ENOENT)
 		dir_item = NULL;
 	if (IS_ERR(dir_item)) {
@@ -311,8 +311,8 @@ int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		del_dir_item = 1;
 	btrfs_release_path(path);
 
-	dir_item = btrfs_lookup_dir_index(NULL, root, path, parent_ino,
-					  name, namelen, index, 0);
+	dir_item = btrfs_lookup_dir_index_item(NULL, root, path, parent_ino,
+					       index, name, namelen, 0);
 	/*
 	 * Since lookup_dir_index() will return -ENOENT when not found,
 	 * we need to do extra check.
@@ -369,9 +369,9 @@ int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 
 	if (del_dir_index) {
-		dir_item = btrfs_lookup_dir_index(trans, root, path,
-						  parent_ino, name, namelen,
-						  index, -1);
+		dir_item = btrfs_lookup_dir_index_item(trans, root, path,
+						       parent_ino, index, name,
+						       namelen, -1);
 		if (IS_ERR(dir_item)) {
 			ret = PTR_ERR(dir_item);
 			goto out;
-- 
2.28.0

