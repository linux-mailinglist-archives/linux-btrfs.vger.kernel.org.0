Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28FE115386
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLFOqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:35 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36277 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:35 -0500
Received: by mail-qv1-f67.google.com with SMTP id b18so2738494qvy.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WifRzoY8FYNUPXL4ZJUInx/PRhMHmSNbX6krZ/hcRzQ=;
        b=sO8lJnJBDzEWj+WsmmAJ5+ey7RoJ6083aGa4MjWvacHdbq9XvIquJjNkUajQfKL3Nx
         yIu09JphBl6lE0KUOH/KMZVpdzeQ+fubcLcQaK5WAATdJPIR/xTrQCqW9K4UUjywUlIY
         T7pe2WmuzMBc6ws6tGArDUW683HSvMeC6UDoAUGb8DoKdkGxC2t5kG5mDuwxQb73GzXh
         95uNY38T06dmfQ3CNylChL5sADqCn7zyrJ2c2/v7MiHhnkhg5/e/iv2UoKM+gtmfnJtv
         4edwsFpA3k9qPNmCMHmwz+NFqFOHh6bbvPTw7dA2fIrBUDno2iHlb9zEpxi82+/iorTD
         Qbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WifRzoY8FYNUPXL4ZJUInx/PRhMHmSNbX6krZ/hcRzQ=;
        b=qmgSnBkJAEiWU09Pfq7DBfk5A1eTC31Ql3GkVgdL7n5hREBA8tzkC8huk2UDxbEiNe
         lyosrQ7wrJORoYTMX45WGsYkruWtz2iUQeRLkvItHid4MGRF5t/lIZ0NhXV/9d4/1y+U
         0cUx/VANbHSnBaBQzlngCPgWRmUltEO0MSBP9ufyZsBDuiT5Mhn7qP+EsLjdSqpXFAkQ
         Ey6gfppzFF0udR/Zn7DWJdE6ahrx7Kywi+pxHZvyUwVUWI72KpokEbBzfuw/G5fVZopn
         mupev478w/+XXUP8zbhT+MhV6CwAPLRtX9OXqKIWoF49cHopd+eP2dFqTWvkfy0PLh/E
         R7Pg==
X-Gm-Message-State: APjAAAXbqRSmCM3pSM4TnauB5aklRpNPSVmjClwEFd/5nRym5oN4zPuv
        cjxFpak8HxwkSly3GVw/m4Z1iA39T0YbXA==
X-Google-Smtp-Source: APXvYqxqKkeYPXqWedLllHOBZEGk5m2EFqtLXLQlc5lYRLvL1YTSt0YuHrnDP3FZQDtOzWoYp+dKgw==
X-Received: by 2002:ad4:46ce:: with SMTP id g14mr12922406qvw.67.1575643593323;
        Fri, 06 Dec 2019 06:46:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f6sm6008495qkk.12.2019.12.06.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/44] btrfs: push grab_fs_root into read_fs_root
Date:   Fri,  6 Dec 2019 09:45:24 -0500
Message-Id: <20191206144538.168112-31-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of relocation uses read_fs_root to lookup fs roots, so push the
btrfs_grab_fs_root() up into that helper and remove the individual
calls.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d40d145588f3..086c8126ebf2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -581,6 +581,7 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
 	struct btrfs_key key;
+	struct btrfs_root *root;
 
 	key.objectid = root_objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -589,7 +590,12 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	else
 		key.offset = (u64)-1;
 
-	return btrfs_get_fs_root(fs_info, &key, false);
+	root = btrfs_get_fs_root(fs_info, &key, false);
+	if (IS_ERR(root))
+		return root;
+	if (!btrfs_grab_fs_root(root))
+		return ERR_PTR(-ENOENT);
+	return root;
 }
 
 static noinline_for_stack
@@ -861,10 +867,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			err = PTR_ERR(root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			err = -ENOENT;
-			goto out;
-		}
 
 		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 			cur->cowonly = 1;
@@ -2433,8 +2435,6 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
-		if (!btrfs_grab_fs_root(root))
-			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2505,8 +2505,6 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
-			if (!btrfs_grab_fs_root(root))
-				BUG();
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
@@ -2569,8 +2567,6 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = read_fs_root(fs_info, reloc_root->root_key.offset);
-	if (!btrfs_grab_fs_root(root))
-		BUG();
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
 	ret = btrfs_record_root_in_trans(trans, root);
@@ -3671,10 +3667,6 @@ static int find_data_references(struct reloc_control *rc,
 		err = PTR_ERR(root);
 		goto out_free;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		err = -ENOENT;
-		goto out_free;
-	}
 
 	key.objectid = ref_objectid;
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -4269,8 +4261,6 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
-	if (!btrfs_grab_fs_root(root))
-		return ERR_PTR(-ENOENT);
 
 	trans = btrfs_start_transaction(root, 6);
 	if (IS_ERR(trans)) {
@@ -4542,10 +4532,6 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			fs_root = read_fs_root(fs_info,
 					       reloc_root->root_key.offset);
-			if (!btrfs_grab_fs_root(fs_root)) {
-				err = -ENOENT;
-				goto out;
-			}
 			if (IS_ERR(fs_root)) {
 				ret = PTR_ERR(fs_root);
 				if (ret != -ENOENT) {
@@ -4608,10 +4594,6 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
-		if (!btrfs_grab_fs_root(fs_root)) {
-			err = -ENOENT;
-			goto out_free;
-		}
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
@@ -4651,10 +4633,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 		} else {
-			if (btrfs_grab_fs_root(fs_root)) {
-				err = btrfs_orphan_cleanup(fs_root);
-				btrfs_put_fs_root(fs_root);
-			}
+			err = btrfs_orphan_cleanup(fs_root);
+			btrfs_put_fs_root(fs_root);
 		}
 	}
 	return err;
-- 
2.23.0

