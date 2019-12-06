Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E711536B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFOps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37736 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOps (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so6674460qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/v/1MUHQh186WHeONpwvXL7aadzf1MSQfMqeYAqYnwo=;
        b=oicjLvutTfTcOTBIuN0yrtrIF6RMmSV8vEU0+AOhsxYRxBZsDndmtwYLi6lXQs7NZ8
         Q11KUJC0Q0znZVp3IaaKAIS59gggWkIsmzC+dd4cy5m8F7pA50xWLULHcmeoPKAmuFgu
         as0mmhGkgaCr/U58HPCfJXIjE2hiHYz41LuXNXrazQtfZjyECwk4uInEYZOsDFvtTwcC
         Jza0Jw66xTDw1n9jdk0pI10SvgzSRxneHzlHfB/BZiP+Km/MdncZxWSeJV85e4tDCQEX
         wI2hIxmZ4IjMmNDhQqOwwrnmU1+Vas4igUc/iUUlodOwQt6FwxJSEqFoZRSrRqe0HuRV
         Osyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v/1MUHQh186WHeONpwvXL7aadzf1MSQfMqeYAqYnwo=;
        b=iugBTXyC3sFpTUYxpDoMVkCgNlEX+rBly/XQGbKwL3SbCjSz4AO7oXDRWJdhvCN8QW
         iKHFTSWsW8PKSpKNluo4pmp9zAQ4Cr1Nuery3lQwgTKAa1ZJYy7izLyOVGXBq8+X8yX3
         EQUgCXOSFnTX31RLp5Y9zHBgYIS1jUxf1GNZdNrUp258YXwBmsUWSAh3X8OL7WhaUByJ
         GiT0VuOGoL5ReNQSt+Lid8g/AgQgW930xSPRQ1zjqkH59weEGsi9p2Rs1HlE/NIGJE7B
         zAffe9byEseSOYdd+nOQzGT1gK41x9SKkLCU81i3b+3E7PV4aSmv5+RnbH3Jm9CoKKFz
         82yg==
X-Gm-Message-State: APjAAAXWhZbRoE0uT1+2hjvH97suJRUkOKmRR7cfotw0/D3qXV0RmKcS
        EHJtUOYDa15uOGOdBtSZz1LGJdUVPB4Jyw==
X-Google-Smtp-Source: APXvYqyYFcq2dmhGBEYXmAYuo9KfdKfY+8xAB+dyWW5wpvItwTZmi1pgmLeYoQ4ZA1tRLfESbqxVmg==
X-Received: by 2002:a37:aa45:: with SMTP id t66mr13961339qke.218.1575643546745;
        Fri, 06 Dec 2019 06:45:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m8sm6337480qti.91.2019.12.06.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/44] btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
Date:   Fri,  6 Dec 2019 09:44:57 -0500
Message-Id: <20191206144538.168112-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

