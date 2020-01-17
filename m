Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62929140B7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAQNsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45727 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so22642705qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XQkyX9NhbJnlQLlw10D1zmJZlSrrns0mkKH8wZihwUA=;
        b=e9chPfFFOEbrRCuF7gqcYcEVWGNFep3ZvFlSiYilcpHPzivNDwU/khX/gp+46MwbGq
         PeWEfLmCyj2lrxsesWE2YWWAYbc069yUvEPBlaBBXMkYb9LaLRO76yl/iSGeza3hl81/
         vL101wUFb+wNchNssYtcz58rCpcMh2L9le4ZxsSWyK7dzMbpb8R2WUOMgi+0hVa6N5Hu
         49O9A4eEsB8NPU/WQDHLPbPqCVkIwtnCsfbjiE4Tnuqcr5qW+g1tyoCLVUp/9NqfvYXI
         DHYCvnLlwgYN71HeKKKiUZAKy77WMdv42i4FbiO5g4RvDiyCIfVSgUlpwVUodEuZwCvL
         pQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQkyX9NhbJnlQLlw10D1zmJZlSrrns0mkKH8wZihwUA=;
        b=lYoBb4GAT5VuDrKcpVFj7I6XEqTbKisA8OBUa7IePW4LhJs7aDCwoeFRhwNrP45QQb
         sBLAbytHC1jVlBFqoAurwEUqkEq1FzjWYm8H/0lkQjeQze221gO/Xn6JPju4yG4zYMX/
         IIoLrHWJrqtD9hO2NdMsyQ1spOr2RB+jFUWhFUfuAqdr01EWP4aFPCsjIgEI7Tm2E7z1
         q59AYdUDymfYNbeE/2dRbmBTeE8qZPle80tr+dib2NZrd/Ng5lHSFo+3HNeFd1hQsf12
         bbCbVyv0m49114PI+eRzEuIODk26uKrf2UjK1IcbrCFiy68naB2ay28/C0YJUkMYeP9R
         bqbg==
X-Gm-Message-State: APjAAAXMmleGn7UJ4Qb+7vbY3Ur7ridnaSV08cy3ybrftI6BR+i37JSl
        9R9i4uGOeTA9FH8uYEid8lnMuqeyBpk4CQ==
X-Google-Smtp-Source: APXvYqwXggpWHIqGQnZqvJVP4rW5JWyL6faF+8/JLMz1CaRRUzoNCSy+AyCwGsk0X2M4VgiP2Zf9gQ==
X-Received: by 2002:a37:61ce:: with SMTP id v197mr33032321qkb.467.1579268928481;
        Fri, 17 Jan 2020 05:48:48 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c13sm11769353qko.87.2020.01.17.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/43] btrfs: push grab_fs_root into read_fs_root
Date:   Fri, 17 Jan 2020 08:47:43 -0500
Message-Id: <20200117134758.41494-29-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index de123894c513..7f0a25e19eb8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -613,6 +613,7 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
 	struct btrfs_key key;
+	struct btrfs_root *root;
 
 	key.objectid = root_objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -621,7 +622,12 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
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
@@ -893,10 +899,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			err = PTR_ERR(root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			err = -ENOENT;
-			goto out;
-		}
 
 		if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 			cur->cowonly = 1;
@@ -2474,8 +2476,6 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
-		if (!btrfs_grab_fs_root(root))
-			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2546,8 +2546,6 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
-			if (!btrfs_grab_fs_root(root))
-				BUG();
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
@@ -2610,8 +2608,6 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = read_fs_root(fs_info, reloc_root->root_key.offset);
-	if (!btrfs_grab_fs_root(root))
-		BUG();
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
 	ret = btrfs_record_root_in_trans(trans, root);
@@ -3710,10 +3706,6 @@ static int find_data_references(struct reloc_control *rc,
 		err = PTR_ERR(root);
 		goto out_free;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		err = -ENOENT;
-		goto out_free;
-	}
 
 	key.objectid = ref_objectid;
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -4308,8 +4300,6 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
-	if (!btrfs_grab_fs_root(root))
-		return ERR_PTR(-ENOENT);
 
 	trans = btrfs_start_transaction(root, 6);
 	if (IS_ERR(trans)) {
@@ -4593,10 +4583,6 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4659,10 +4645,6 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			goto out_free;
 		}
-		if (!btrfs_grab_fs_root(fs_root)) {
-			err = -ENOENT;
-			goto out_free;
-		}
 
 		err = __add_reloc_root(reloc_root);
 		BUG_ON(err < 0); /* -ENOMEM or logic error */
@@ -4702,10 +4684,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
2.24.1

