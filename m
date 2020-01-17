Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F741412E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAQV05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45619 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAQV04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id w30so22860827qtd.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vDbW1mrEYanbdYu0SIhgQpf/34kUYfIu/uyTtfNmUlw=;
        b=L6pLQMz4oIHeppqwE/gkqSk/qm2kC7851euYi4yKlc/02iSMYzgum8RcaU2JHmsanK
         0+SMzKLZlPwuAcgy0NlAdjB3ykmW/fXfsaRvNouQzv67FtpqHXqhGxh/ue8kBtuuQ7pk
         E7k6ltuMXMtx53ZjF43z9nIbCigJkRcCOiUpgLccoQk/8V+tJ+taxVrhfWtOmWXUD1ns
         asxrSgZCil3y7efGtzz3xEOVokenZlFV5e+NwzTw2MYlF/BL+LTx7rCTC2z+W0zV5rM0
         XhtPFHxvb6QRyjl5JzXs9umpfmxwkRnHHpQxPxaddVjfep2iE/9hQ12j+1k/4zjueXyT
         XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDbW1mrEYanbdYu0SIhgQpf/34kUYfIu/uyTtfNmUlw=;
        b=B/FHrPbTeMoLXSz3EAY+Nc/12e/o/MbpkigTZGYBzUEphKSVxCkY+NWeuU1JM75uSd
         mGAzqlg3pw8jneU63lwQFz1OQP1G+Q9GVlN8ufvXrSgx2J/f/yR2toV8IM3/ixGvvT0n
         uBUXuoiNltkHTCjjtIsM0UGGibkltSTcLsCL4z38mpy1HABRzS24C2/apboXrlehRCDT
         vpCsYYZEskGQYs/lx2nxKZr/uvvgj11YZi/Ab28zJcMcQ7T+ykSH5ollmfXPFXt3b9ot
         sMXdvUO7drmbm3hpSgtyouYCOzwJ+U6L+Mp6TOmOLK83cbE65THDvo7Iw8i4LixUpSHn
         42fA==
X-Gm-Message-State: APjAAAVVCbYBx0vkT8GuAKW/74uTTVt6/5353SI9jE4Z9+W4Zw+BIAZe
        k084b4SrMMn3uoksMPttwD1xVQes+MTrag==
X-Google-Smtp-Source: APXvYqy1hANnpnp+Rv8IxHbRYPdJdZTzMFhP/G10QObaCE9RyZLMy7zw4SigD0BX7BZ3V5dLuNmTBw==
X-Received: by 2002:aed:3e53:: with SMTP id m19mr9323513qtf.32.1579296414969;
        Fri, 17 Jan 2020 13:26:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i4sm12204348qki.45.2020.01.17.13.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/43] btrfs: push grab_fs_root into read_fs_root
Date:   Fri, 17 Jan 2020 16:25:47 -0500
Message-Id: <20200117212602.6737-29-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
index 81f383df8f63..d166cc742f75 100644
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

