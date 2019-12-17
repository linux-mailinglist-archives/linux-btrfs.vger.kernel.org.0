Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20A2123090
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfLQPhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33318 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so7518216qto.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WifRzoY8FYNUPXL4ZJUInx/PRhMHmSNbX6krZ/hcRzQ=;
        b=nexE8GSBR4Ls1nUSN3YwzPrLPkkrvUoiSVxmBsztuTZheiVGFSJgkXM4w+Bzom1F47
         4s3cZ0ohPvJqCw9SX44ssDuvwlNTj+hDNr6S/B5IjkksVoHUyCvYMayL4cehohvo0SDn
         1L23tQmiRROu39OE8Otp8QYbyvnJgVTDQBmrrAp92iv1X3HIhsvTZR3aVE7PDwkRgfrx
         /4vTIwZpISwSfihIr/FQHx4+YuH3k1KVkmdVFomS4zNIHv3NGs3jmll0Cg/c0CvEQjSH
         mW72wttXHRwVdYF4Xwwv0CmeVrCx8PZVhdWqCC9PRgDYDKqjq0mutztnlALifwLcVygv
         297w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WifRzoY8FYNUPXL4ZJUInx/PRhMHmSNbX6krZ/hcRzQ=;
        b=WwVp/RjDY4mtm8uxII1X2qYTEKGZeGdMMmGu635/LMojru2AyW5BhKjrvtrJHyHVP8
         yLfLihrL4S6Mppf8clHheMPOwQEd2bqTzqZ5NYvGoAImrDFytL7G5jDmMsAfeFVe/x/X
         V9d2d6aZUHkp2u3ox9VNY1DqXqwK4dN0+/OiTdHYVTnfWFwheNJNqlOzU6WCZLdPQDXo
         gvChccfB03fk42/bOuEYa5FdihbE8/8tvSsXEgAKLW7B3RNaEnqdjC8fAKc57R28NTWe
         ySsP84tzk0KmucQmEV0JmsHJyBV3scdnfZaB2ADbvivfFlFqYVPdQOy478RVdP+vWyfk
         lRgw==
X-Gm-Message-State: APjAAAVGIlh3a80iofnD9hLwn/Z8/b9GbH/gwlQVcTMkCPlzbjA4qREN
        CehpOx59xHXF5dA4oZHA/DTP5StIUucURA==
X-Google-Smtp-Source: APXvYqwwawPF1jOAdcCXC9U2RW/ef0NBtaeG/ReADMfMxbbmrBXtDxNaa6PVnugM0nzVgIB+OK1MRg==
X-Received: by 2002:ac8:490f:: with SMTP id e15mr2393030qtq.32.1576597052754;
        Tue, 17 Dec 2019 07:37:32 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i16sm7098282qkh.120.2019.12.17.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/45] btrfs: push grab_fs_root into read_fs_root
Date:   Tue, 17 Dec 2019 10:36:20 -0500
Message-Id: <20191217153635.44733-31-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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

