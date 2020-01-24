Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1E148943
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbgAXOdz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34924 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgAXOdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so1652315qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vDbW1mrEYanbdYu0SIhgQpf/34kUYfIu/uyTtfNmUlw=;
        b=RXM/JJLVHWSon8V6Ync3PB6DUaFIcyRiKL2Oqv09eQeYU+yEs3McGYxJbAX0FX5Vj5
         m27tFzIhrRBd2wFbd7Ul2OZYrDitzV1qBoJYWtwG/UBweHuNXgxZyzZhso7C1fU/xIQ1
         fKuimzOanxKpimyharVMUv7leN5K2tsRqS8Py/QhGscoYr14uM7Pe9jR2TxRzL+OO7YJ
         NUhYHWXtU3P8jI0XM4VQohIZlbFt1fwYEbnFYm83BXVYVmHS0//04/QCdRfyFk4SKyDo
         Q9jtIsP3p92hXwJPGVgeE7YmBlKOid82vqJZdlD+YbNYHXcwu4jbJNhnTSx7Vf5bbpoV
         zlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDbW1mrEYanbdYu0SIhgQpf/34kUYfIu/uyTtfNmUlw=;
        b=DX66A6O7G7ovltrF2W0CxWC1i4Ww2EFOqJmjwd1p4dgjn03L8sSZ8LKxUCC6XPD7W6
         WJQR/IKhTHO4X0nqRwoAmCufZ5UopfSTNGSKhDmjqDx5JQ/YjtnHF+za2PGZcl1w0E7m
         +7GOX39Qu5ttKjj7L0HCinTmzhXIypUSuv37NTpY00xc/8cXaKKrvH6XpThLVwlGCb2V
         O8uVnTMreOyG0LOOXiYRNxgAuyeZ7d8lFW5FzkK42oKDdc9mUohT4IHrXXU2S48JjNHl
         sI6bC+BECZtrrOsLDNF492ssXjP2QJAFyixq51uNAUulHpGABmAAbm1FVx3t2Dwr4iAc
         ZoTw==
X-Gm-Message-State: APjAAAWKaVd1Q3x0V6bbLmjccrqf1hViJPJP30HEmSGyAwfr+4RaL1Jh
        4fytF7z8CflKbNguEh5HEFMNynumNWys/A==
X-Google-Smtp-Source: APXvYqxQRb3Ib/tKzTvINDTd2ruAGDgrHWtDAXo1Qmy/tL2I+Z92CEEbotGxSckZyEDvWhuRU+B1dg==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr2386568qtb.86.1579876433249;
        Fri, 24 Jan 2020 06:33:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x8sm3110350qki.60.2020.01.24.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 28/44] btrfs: push grab_fs_root into read_fs_root
Date:   Fri, 24 Jan 2020 09:32:45 -0500
Message-Id: <20200124143301.2186319-29-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

