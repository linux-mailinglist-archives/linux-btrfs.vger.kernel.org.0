Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8462289F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGUUdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 16:33:46 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:49124 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbgGUUdp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 16:33:45 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-31.iol.local with ESMTPA
        id xyxKjpuK2GrpJxyxLjhpqL; Tue, 21 Jul 2020 22:33:43 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595363623; bh=c3vLeUveRjCik7aPGoeU5xMTgjgjEacA8zWflsIYwRw=;
        h=From;
        b=LOVv/Vep8eR0yKo3IgRwWUnnBGPHfBOA9z71FqWs0vz3OoAEkjeFymjTKm47CPlWk
         6a/BebfeQMK2Z875BV6nUofcC2vT4q/q3obowudTt8aEkOhXCSS6EGcABqiJ4XPtuS
         dY8H6ORrh3zttmSABsoYAbbMj2BdpNNMYx/N0tt3ZBWcvh1nO31D4nBfFCtKBAC+2l
         Mh07F8mKDf40BnD7+7OsF5LIMDIXGmjDqzpF3pm+dJY+iLZZWcsDWNFhzjMntaqCJT
         MQmewKTk0vm8fwK1qfKJVCY2eBqvJAyVGjUNwOdi62eZwMoNiZk74Cb+b0FrGR2fF2
         yjtEMHzbVJ6eg==
X-CNFS-Analysis: v=2.3 cv=Ief5plia c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=6qCQHZnU2otLWkq8RXcA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] btrfs: allow more subvol= option
Date:   Tue, 21 Jul 2020 22:33:40 +0200
Message-Id: <20200721203340.275921-2-kreijack@libero.it>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <20200721203340.275921-1-kreijack@libero.it>
References: <20200721203340.275921-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJnkIEmK12n3FcLLraiMbXam3c8qkta+5XlQ4uGXaaVit/hCm+mttCprR1YZnp7GkLJIgcBFh3bEF4okJQSs+l2O0QD+OZXLfpSVkWNzdaWhKXTT7rqM
 apFOwplL1JFtJSVoRMEdxk7/oJLI6G7AILkjpS2KsvAqN/FRTgljtrm0lP4k+mZMw2886R465m/TJ9yzxtJk4uPMalfxYpetBds=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When more than one subvol= options are passed, btrfs try to mount
each subvolume until the first one succeed. Up to 5 subvol= options
can be passed.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

---
 fs/btrfs/super.c | 71 ++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bc73fd670702..12d066e8d52c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -52,6 +52,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
+#define SUBVOL_NAMES_COUNT 5
+
 static const struct super_operations btrfs_super_ops;
 
 /*
@@ -974,12 +976,13 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
  *
  * The value is later passed to mount_subvol()
  */
-static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
-		u64 *subvol_objectid)
+static int btrfs_parse_subvol_options(const char *options, char **subvol_names,
+					u64 *subvol_objectid)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *opts, *orig, *p;
 	int error = 0;
+	int svi = 0;
 	u64 subvolid;
 
 	if (!options)
@@ -1002,12 +1005,17 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_subvol:
-			kfree(*subvol_name);
-			*subvol_name = match_strdup(&args[0]);
-			if (!*subvol_name) {
+			if (svi >= SUBVOL_NAMES_COUNT) {
+				pr_err("BTRFS: too much 'subvol=' mount options\n");
+				error = -E2BIG;
+				goto out;
+			}
+			subvol_names[svi] = match_strdup(&args[0]);
+			if (!subvol_names[svi]) {
 				error = -ENOMEM;
 				goto out;
 			}
+			svi++;
 			break;
 		case Opt_subvolid:
 			error = match_u64(&args[0], &subvolid);
@@ -1429,13 +1437,16 @@ static inline int is_subvolume_inode(struct inode *inode)
 	return 0;
 }
 
-static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
+static struct dentry *mount_subvol(char **subvol_names,
+				   u64 subvol_objectid,
 				   struct vfsmount *mnt)
 {
 	struct dentry *root;
 	int ret;
+	const char *sv;
+	int i;
 
-	if (!subvol_name) {
+	if (!subvol_names[0]) {
 		if (!subvol_objectid) {
 			ret = get_default_subvol_objectid(btrfs_sb(mnt->mnt_sb),
 							  &subvol_objectid);
@@ -1444,17 +1455,27 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 				goto out;
 			}
 		}
-		subvol_name = btrfs_get_subvol_name_from_objectid(
+		subvol_names[0] = btrfs_get_subvol_name_from_objectid(
 					btrfs_sb(mnt->mnt_sb), subvol_objectid);
-		if (IS_ERR(subvol_name)) {
-			root = ERR_CAST(subvol_name);
-			subvol_name = NULL;
+		if (IS_ERR(subvol_names[0])) {
+			root = ERR_CAST(subvol_names[0]);
+			subvol_names[0] = NULL;
 			goto out;
 		}
 
 	}
 
-	root = mount_subtree(mnt, subvol_name);
+	for (i = 0 ; i < SUBVOL_NAMES_COUNT ; i++) {
+		if (!subvol_names[i])
+			break;
+
+		root = mount_subtree(mnt, subvol_names[i]);
+		if (!IS_ERR(root)) {
+			sv = subvol_names[i];
+			break;
+		}
+	}
+
 	/* mount_subtree() drops our reference on the vfsmount. */
 	mnt = NULL;
 
@@ -1466,8 +1487,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 
 		ret = 0;
 		if (!is_subvolume_inode(root_inode)) {
-			btrfs_err(fs_info, "'%s' is not a valid subvolume",
-			       subvol_name);
+			btrfs_err(fs_info, "'%s' is not a valid subvolume", sv);
 			ret = -EINVAL;
 		}
 		if (subvol_objectid && root_objectid != subvol_objectid) {
@@ -1478,7 +1498,7 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 			 */
 			btrfs_err(fs_info,
 				  "subvol '%s' does not match subvolid %llu",
-				  subvol_name, subvol_objectid);
+				  sv, subvol_objectid);
 			ret = -EINVAL;
 		}
 		if (ret) {
@@ -1490,7 +1510,6 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 
 out:
 	mntput(mnt);
-	kfree(subvol_name);
 	return root;
 }
 
@@ -1636,15 +1655,16 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 {
 	struct vfsmount *mnt_root;
 	struct dentry *root;
-	char *subvol_name = NULL;
+	int i;
+	char *subvol_names[SUBVOL_NAMES_COUNT] = {0,};
 	u64 subvol_objectid = 0;
 	int error = 0;
 
-	error = btrfs_parse_subvol_options(data, &subvol_name,
-					&subvol_objectid);
+	error = btrfs_parse_subvol_options(data, subvol_names,
+				&subvol_objectid);
 	if (error) {
-		kfree(subvol_name);
-		return ERR_PTR(error);
+		root = ERR_PTR(error);
+		goto out;
 	}
 
 	/* mount device's root (/) */
@@ -1658,7 +1678,6 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 				flags | SB_RDONLY, device_name, data);
 			if (IS_ERR(mnt_root)) {
 				root = ERR_CAST(mnt_root);
-				kfree(subvol_name);
 				goto out;
 			}
 
@@ -1668,21 +1687,21 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
 			if (error < 0) {
 				root = ERR_PTR(error);
 				mntput(mnt_root);
-				kfree(subvol_name);
 				goto out;
 			}
 		}
 	}
 	if (IS_ERR(mnt_root)) {
 		root = ERR_CAST(mnt_root);
-		kfree(subvol_name);
 		goto out;
 	}
 
-	/* mount_subvol() will free subvol_name and mnt_root */
-	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
+	/* mount_subvol() will free mnt_root */
+	root = mount_subvol(subvol_names, subvol_objectid, mnt_root);
 
 out:
+	for (i = 0 ; i < SUBVOL_NAMES_COUNT ; i++)
+		kfree(subvol_names[i]);
 	return root;
 }
 
-- 
2.28.0.rc1

