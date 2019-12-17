Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BB12306D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLQPgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41526 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so3112331qtk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/v/1MUHQh186WHeONpwvXL7aadzf1MSQfMqeYAqYnwo=;
        b=e+ViSpP99g9JRuFpmve8au97SgivJSstrPMmKgK6B7WIUU5eP3FVN13rId591/rIvx
         2+6YNE3145GCNfuTPKPOtoF/epV5uO/CUODuDJ38nSemyPqYThHRb8goeVi8EQD5PPeG
         c7HFIM+gUwHpAkFksonIAZPh2j30EQbXKFLyIXtmvT24fbJziuMijrpuAo2xMC9/Ryu/
         Rc1ACMxFM7jOcisGN73etorQNxgm2Sl9tavzJqui/b4YICQcT+XKf4C/8s3+jUuOOuSe
         E/Jh+SzyAqEI8pe3KRnQjeZjAr6OajIvg/nvnhze8/5W0oqokuY7nO8yGt1/gp3eNsIS
         wjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v/1MUHQh186WHeONpwvXL7aadzf1MSQfMqeYAqYnwo=;
        b=V7Yxt+eyAJxze97djkXLcYCX3hgPAb3See7uBWzhG8rVBPca66NbqRpB1z3NpZXj2p
         P7aqPEmg1CyEvKN7MmdSODueZGiU7x4rL91S/9BGaTNLHCCSEwzjLWHucBxr4jE49uqS
         D8QqVUdvCkyAt6M7BZeUM6NrHVzMEcORiMUhOXihTyGYuUQxkTLx9kaXc4qhW8XCmcXh
         oHqqilHyeLGd9Gqo3uYjQaRX6vb/m9TyNSqh+YjWy7W8HIFCh7FO7IWqlRNi+fvSboJd
         Zi2OMxeb8qJHJrVj+3SYrEJukWph4ppX803/DECaWv21GamB42/KtAj4y35puhgCZZQH
         ma0A==
X-Gm-Message-State: APjAAAU0uCAhT9otSlz29KWs4qiYlrTVxhWv6Nl6XlIDEMpK2/NCZXyK
        iPSsGaRhYkqykKBfFHuv9KWB/9YNd9e/NQ==
X-Google-Smtp-Source: APXvYqwcYIaU4WZqKQMezEEUrHeWlTcSxO20pgg0HM1A2hAqhYSX/mANoMUe1kYZM3iBmN8zsKqiWA==
X-Received: by 2002:ac8:40d8:: with SMTP id f24mr4826562qtm.215.1576597003789;
        Tue, 17 Dec 2019 07:36:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b7sm7170766qkh.106.2019.12.17.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/45] btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
Date:   Tue, 17 Dec 2019 10:35:53 -0500
Message-Id: <20191217153635.44733-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_orphan_roots has this weird thing where it looks up the root
in cache to see if it is there before just reading the root.  But the
read it uses just reads the root, it doesn't do any of the init work, we
do that by hand here.  But this is unnecessary, all we really want is to
see if the root still exists and add it to the dead roots list to be
cleaned up, otherwise we delete the orphan item.

Fix this by just using btrfs_get_fs_root directly with check_ref set to
false so we get the orphan root items.  Then we just handle in cache and
out of cache roots the same, add them to the dead roots list and carry
on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 3b17b647d002..9617dcedf521 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -255,25 +255,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		root_key.objectid = key.offset;
 		key.offset++;
 
-		/*
-		 * The root might have been inserted already, as before we look
-		 * for orphan roots, log replay might have happened, which
-		 * triggers a transaction commit and qgroup accounting, which
-		 * in turn reads and inserts fs roots while doing backref
-		 * walking.
-		 */
-		root = btrfs_lookup_fs_root(fs_info, root_key.objectid);
-		if (root) {
-			WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
-					  &root->state));
-			if (btrfs_root_refs(&root->root_item) == 0) {
-				set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
-				btrfs_add_dead_root(root);
-			}
-			continue;
-		}
-
-		root = btrfs_read_fs_root(tree_root, &root_key);
+		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
 		if (err && err != -ENOENT) {
 			break;
@@ -300,21 +282,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		err = btrfs_init_fs_root(root);
-		if (err) {
-			btrfs_free_fs_root(root);
-			break;
-		}
-
-		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
-
-		err = btrfs_insert_fs_root(fs_info, root);
-		if (err) {
-			BUG_ON(err == -EEXIST);
-			btrfs_free_fs_root(root);
-			break;
-		}
-
+		WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
+				  &root->state));
 		if (btrfs_root_refs(&root->root_item) == 0) {
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
-- 
2.23.0

