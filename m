Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8283C248806
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHROnh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 10:43:37 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.89]:20412 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHROng (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 10:43:36 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 30E57400C9C38
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 09:43:33 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 82ppkfWdnCjCV82ppkVvG6; Tue, 18 Aug 2020 09:43:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FiENVS20hcNKwZD+8Um695qjZUX9sRr2WWaPUGT4niA=; b=VbhbMECYDRAP3WUJc4TDRVy+yq
        y3q7J1go9R+2PZAwrHGDXKAtlZeenTgeVZTgTzIbmia4D5PASWc1rhlHAaYUvtL+LiPN/FRCZUajh
        9XkmilW8SYpWRJ+IbhBQR1RkEBI9O39Hb/stAqtQc6Y3cxlh0W0MAWxrLnXc95HWnwNJ0I2F8dUiA
        VLxtBMFsBmfaxtsWJEpVPJ2AZx6xuVzbSZRjveVRgxGDyc1Yc+ErBKvZdPyFSl92gv6K5ezl1J2wo
        s/jkhkRlu04WF3lxV2HKPFzifiJhpWqMMvnWueUwGxLzw88O2kzpJkulUIdtV7lSZw1v9TMXQ7Ek1
        SE7vlVdQ==;
Received: from [179.185.223.25] (port=42408 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k82po-00223d-Hd; Tue, 18 Aug 2020 11:43:32 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: Make btrfs_lookup_dir_index in parity with kernel code
Date:   Tue, 18 Aug 2020 11:43:24 -0300
Message-Id: <20200818144324.25917-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.223.25
X-Source-L: No
X-Exim-ID: 1k82po-00223d-Hd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.223.25]:42408
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function exists in kernel side but using the _item suffix, and
objectid argument is placed before the name argument. Change the
function to reflect the kernel version.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 check/main.c             |  6 +++---
 ctree.h                  | 11 ++++++-----
 inode.c                  | 14 +++++++-------
 kernel-shared/dir-item.c | 13 +++++++------
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/check/main.c b/check/main.c
index f93bd7d4..176bc508 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2072,9 +2072,9 @@ static int delete_dir_index(struct btrfs_root *root,
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
diff --git a/ctree.h b/ctree.h
index 39e03640..a4f70847 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2760,11 +2760,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_path *path, u64 dir,
 					     const char *name, int name_len,
 					     int mod);
-struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
-					      struct btrfs_root *root,
-					      struct btrfs_path *path, u64 dir,
-					      const char *name, int name_len,
-					      u64 index, int mod);
+struct btrfs_dir_item *
+btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path, u64 dir,
+			    u64 objectid, const char *name, int name_len,
+			    int mod);
 int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_path *path,
diff --git a/inode.c b/inode.c
index c2d77aa6..67ba9596 100644
--- a/inode.c
+++ b/inode.c
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
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index c8a5a354..d99ace4f 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -225,11 +225,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return btrfs_match_dir_item_name(root, path, name, name_len);
 }
 
-struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
-					      struct btrfs_root *root,
-					      struct btrfs_path *path, u64 dir,
-					      const char *name, int name_len,
-					      u64 index, int mod)
+struct btrfs_dir_item *
+btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path, u64 dir,
+			    u64 objectid, const char *name, int name_len,
+			    int mod)
 {
 	int ret;
 	struct btrfs_key key;
@@ -238,7 +239,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_index(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = index;
+	key.offset = objectid;
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
-- 
2.28.0

