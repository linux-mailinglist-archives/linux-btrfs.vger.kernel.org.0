Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD4125693
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLRWUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 17:20:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35607 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 17:20:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so3349250qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZWYYHNPSb0eeg3q1ywcXRsInbeHmnCPUbkgYRnD6J6o=;
        b=wDOzv0OXjTKdttWjPB4bFej3YkhxpcPhwrd1oljaSiK/NokTLYn04oYRkYXzvbGQq/
         o35JUUbgvf3Wsna5v9kg16DTTUAI5Iln46W92vdY4j8gOWJ5yfE6RSJE0z62zIPJASly
         FbTZGrNNUWpCjLFU4d2wSByZKtWd5fkMFFwmlWR8TUGoarbgV3DIzxsEb8w0qKMB5xNT
         y9aLzvdkkbzgWPLlytjMNGHQwecRuOF2WDMdn6dhqJ+9GcMnsaJtfxHLnAEuk8I1Gcxv
         Dl0rvtMJdOPdOqG/tvpfdfp1k6R7eQSm6WuahovtEUuB16rd4Zc0CJJM0Q36cPr0UDoh
         KjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWYYHNPSb0eeg3q1ywcXRsInbeHmnCPUbkgYRnD6J6o=;
        b=bo4TJd3Ul/+DUkBIpqtNk7SDdeVQ4MWriORMDEspYaX1v4xifvqh/dDuJVFZ2EEpU0
         tl8ldVV3OsF0n991JHZEb3S00nhKRclk6VUYs6MRfsqx8c688aKenJh7rFgGK2MsLnmE
         XJEuTXf4Jy9ClIJsq1PRTtiUvPWtdaK/Rs1Oex5QRDSgUKAQQvporCEfdA8HmQc9GVKg
         PLikzZwxWnz9013B7sYRIiXR2QhKIbLAVNj9NBh82vmzezv1nEq4dKGcWj+wl0mxYIIl
         HfTovvvsPmb95/bsfQ4KT06D/AOz+1XE9c2Qs99cavRyfoQmZzfDsup2GZLKV4NJKBOt
         qFXA==
X-Gm-Message-State: APjAAAWDGq4BKhLZAQcmBKO9LUT1ANQQD3u8PUqeLGZFqc5GrSEy28rC
        3+yedDp6L2fGor4NQ+cu2aH7XeVPc6ooYA==
X-Google-Smtp-Source: APXvYqxGu5HQZdMwQRD3xm8qZMV2Q/+poOxFpvlmO483VVpH7qY/maPg2qc7RDlL25Gw90x48RdPZg==
X-Received: by 2002:a37:c24c:: with SMTP id j12mr5255954qkm.401.1576707633382;
        Wed, 18 Dec 2019 14:20:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p185sm1107379qkd.126.2019.12.18.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:20:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: rework arguments for btrfs_unlink_subvol
Date:   Wed, 18 Dec 2019 17:20:27 -0500
Message-Id: <20191218222029.49178-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218222029.49178-1-josef@toxicpanda.com>
References: <20191218222029.49178-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_unlink_subvol takes the name of the dentry and the root objectid
based on what kind of inode this is, either a real subvolume link or a
empty one that we inherited as a snapshot.  We need to fix how we unlink
in the case for BTRFS_EMPTY_SUBVOL_DIR_OBJECTID in the future, so rework
btrfs_unlink_subvol to just take the dentry and handle getting the right
objectid given the type of inode this is.  There is no functional change
here, simply pushing the work into btrfs_unlink_subvol() proper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c1c6e6afa3bc..3cbdca2749bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4234,17 +4234,29 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
-			       struct inode *dir, u64 objectid,
-			       const char *name, int name_len)
+			       struct inode *dir, struct dentry *dentry)
 {
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_dir_item *di;
+	const char *name = dentry->d_name.name;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_key key;
+	int name_len = dentry->d_name.len;
 	u64 index;
 	int ret;
 	u64 dir_ino = btrfs_ino(BTRFS_I(dir));
+	u64 objectid;
+
+	if (btrfs_ino(inode) == BTRFS_FIRST_FREE_OBJECTID) {
+		objectid = inode->root->root_key.objectid;
+	} else if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
+		objectid = inode->location.objectid;
+	} else {
+		WARN_ON(1);
+		return -EINVAL;
+	}
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4483,8 +4495,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 
 	btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
 
-	ret = btrfs_unlink_subvol(trans, dir, dest->root_key.objectid,
-				  dentry->d_name.name, dentry->d_name.len);
+	ret = btrfs_unlink_subvol(trans, dir, dentry);
 	if (ret) {
 		err = ret;
 		btrfs_abort_transaction(trans, ret);
@@ -4579,10 +4590,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return PTR_ERR(trans);
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		err = btrfs_unlink_subvol(trans, dir,
-					  BTRFS_I(inode)->location.objectid,
-					  dentry->d_name.name,
-					  dentry->d_name.len);
+		err = btrfs_unlink_subvol(trans, dir, dentry);
 		goto out;
 	}
 
@@ -9540,7 +9548,6 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	u64 new_ino = btrfs_ino(BTRFS_I(new_inode));
 	u64 old_idx = 0;
 	u64 new_idx = 0;
-	u64 root_objectid;
 	int ret;
 	bool root_log_pinned = false;
 	bool dest_log_pinned = false;
@@ -9646,10 +9653,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		root_objectid = BTRFS_I(old_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, old_dir, root_objectid,
-					  old_dentry->d_name.name,
-					  old_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
@@ -9665,10 +9669,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	/* dest is a subvolume */
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID) {
-		root_objectid = BTRFS_I(new_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, new_dir, root_objectid,
-					  new_dentry->d_name.name,
-					  new_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
@@ -9974,10 +9975,7 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				BTRFS_I(old_inode), 1);
 
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
-		root_objectid = BTRFS_I(old_inode)->root->root_key.objectid;
-		ret = btrfs_unlink_subvol(trans, old_dir, root_objectid,
-					old_dentry->d_name.name,
-					old_dentry->d_name.len);
+		ret = btrfs_unlink_subvol(trans, old_dir, old_dentry);
 	} else {
 		ret = __btrfs_unlink_inode(trans, root, BTRFS_I(old_dir),
 					BTRFS_I(d_inode(old_dentry)),
@@ -9997,9 +9995,7 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 			root_objectid = BTRFS_I(new_inode)->location.objectid;
-			ret = btrfs_unlink_subvol(trans, new_dir, root_objectid,
-						new_dentry->d_name.name,
-						new_dentry->d_name.len);
+			ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
 			ret = btrfs_unlink_inode(trans, dest, BTRFS_I(new_dir),
-- 
2.23.0

