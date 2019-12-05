Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24FB113AD4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfLEE3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so1844742lji.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzGXAo6NWlDbJoJnmBn9VK8wJ79E6fS2CoAtW1V63aI=;
        b=ZvdVyLg7Au8pX78OpbzIRxV7ls/5ETfZS2k4coy0BHyjn0OjeaoWe/pmGjhFlAus6K
         /ZnE7rU5XUX9d+97h5Cf/SdPXeSyksS6uFNzRGPSi3YSoOJgwZuOQRayQl31DZP9NnPN
         JnV7VI4bJLnT84nIGdUdRENWKhsplcq4KnhFU6n7kkNtz0M8g/nEDD27xsmXrqy/4eWt
         KAOOQd1qvPsNmPSI10xYA8rO8pX7zIjOs08K7yoMzaGjXxwqM0CLLxLBbUaQFA8rFpnD
         HT7b61J2e7Vo6vuskDO+CM7RwxDTquoT9uK8SQ1qXyDRzAPCBuMKpw83n6Ur7vR45kn4
         jFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzGXAo6NWlDbJoJnmBn9VK8wJ79E6fS2CoAtW1V63aI=;
        b=EpZr4D3SFyDLFVbvWOWQ6yuxUOBnvqI6JoH0PZeUlVg/IyHvlqaPStO8C/z2NFkt/E
         r0OTVJ5zbMkWE88HhpvXcTjKHJLAPmBf7XhuQKeW8RJE5h1xVqu154CJ7FzvjdzBE8b5
         tXIKSHGGm8IQpLVuLudeeC/tFl+H2LkIq7v1nj2gNgJQZhLssgKPhXMBauYIrVF0ktCP
         Ye3TTfkmhfX+dtkT7YZ/4bS29go8tAfWzLDzOlG1aQz14rZtdPMLYFVw/IoDpPIldPA6
         v3Bu9IqaRWAiLfsR9IppLNE8I7rh6rayMXufVclHalwH9l6rU+WjmhLb62B/SuMQ9Ux8
         EAxw==
X-Gm-Message-State: APjAAAXE7HhfX62DoE6foNFS3zqLc4u6F028XXFPQOQazazCk5NBboB0
        MrZuN95s+/GL0TEJ7TeCJ6zuwhKL82k=
X-Google-Smtp-Source: APXvYqxNkTeh/s6ab5Urxx8VZZHDsoTg+9oiAEPojR4K2fcPjkH/qsgt30kgX47XNBnsGdVTNfnECw==
X-Received: by 2002:a2e:58c:: with SMTP id 134mr4197136ljf.12.1575520188149;
        Wed, 04 Dec 2019 20:29:48 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:47 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 07/10] block-progs: block_group: add dirty_bgs list related memebers
Date:   Thu,  5 Dec 2019 12:29:18 +0800
Message-Id: <20191205042921.25316-8-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The old style uses extent bit BLOCK_GROUP_DIRTY to mark dirty block
groups in extent cache. To replace it, add btrfs_trans_handle::dirty_bgs
and btrfs_block_group_cache::dirty_list.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 ctree.h       | 3 +++
 extent-tree.c | 4 ++++
 transaction.c | 1 +
 transaction.h | 3 ++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ctree.h b/ctree.h
index f3f5f52f2559..61ce53c46302 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1119,6 +1119,9 @@ struct btrfs_block_group_cache {
 
 	/* Block group cache stuff */
 	struct rb_node cache_node;
+
+	/* For dirty block groups */
+	struct list_head dirty_list;
 };
 
 struct btrfs_device;
diff --git a/extent-tree.c b/extent-tree.c
index ff3db5ca2e0c..981622e37ab7 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2819,6 +2819,8 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	cache->pinned = 0;
 	cache->flags = btrfs_block_group_flags(&bgi);
 	cache->used = btrfs_block_group_used(&bgi);
+	INIT_LIST_HEAD(&cache->dirty_list);
+
 	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
 		bit = BLOCK_GROUP_DATA;
 	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -2900,6 +2902,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	cache->used = bytes_used;
 	cache->flags = type;
+	INIT_LIST_HEAD(&cache->dirty_list);
 
 	exclude_super_stripes(fs_info, cache);
 	ret = update_space_info(fs_info, cache->flags, size, bytes_used,
@@ -2997,6 +3000,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		cache->used = 0;
 		cache->flags = group_type;
+		INIT_LIST_HEAD(&cache->dirty_list);
 
 		ret = update_space_info(fs_info, group_type, group_size,
 					0, &cache->space_info);
diff --git a/transaction.c b/transaction.c
index c9035c765a74..269e52c01d29 100644
--- a/transaction.c
+++ b/transaction.c
@@ -52,6 +52,7 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
 	root->last_trans = h->transid;
 	root->commit_root = root->node;
 	extent_buffer_get(root->node);
+	INIT_LIST_HEAD(&h->dirty_bgs);
 
 	return h;
 }
diff --git a/transaction.h b/transaction.h
index 750f456b3cc0..8fa65508fa8d 100644
--- a/transaction.h
+++ b/transaction.h
@@ -22,6 +22,7 @@
 #include "kerncompat.h"
 #include "ctree.h"
 #include "delayed-ref.h"
+#include "kernel-lib/list.h"
 
 struct btrfs_trans_handle {
 	struct btrfs_fs_info *fs_info;
@@ -35,7 +36,7 @@ struct btrfs_trans_handle {
 	unsigned long blocks_used;
 	struct btrfs_block_group_cache *block_group;
 	struct btrfs_delayed_ref_root delayed_refs;
-
+	struct list_head dirty_bgs;
 };
 
 struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
-- 
2.21.0 (Apple Git-122)

