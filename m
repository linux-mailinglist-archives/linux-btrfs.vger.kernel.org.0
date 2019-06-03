Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7872232D81
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfFCKGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 06:06:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbfFCKGF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:06:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6B7DAD29
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 10:06:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: Document __etree_search
Date:   Mon,  3 Jun 2019 13:05:59 +0300
Message-Id: <20190603100602.19362-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603100602.19362-1-nborisov@suse.com>
References: <20190603100602.19362-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function has a lot of return values and specific conventions making
it cumbersome to understand what's returned. Have a go at documenting
its parameters and return values.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e56afb826517..d5979558c96f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -359,6 +359,22 @@ static struct rb_node *tree_insert(struct rb_root *root,
 	return NULL;
 }
 
+/**
+ * __etree_search - searches @tree for an entry that contains @offset. Such
+ * entry would have entry->start <= offset && entry->end >= offset.
+ *
+ * @offset - offset that should fall within an entry in @tree
+ * @next_ret - pointer to the first entry whose range ends after @offset
+ * @prev - pointer to the first entry whose range begins before @offset
+ * @p_ret - pointer where new node should be anchored (used when inserting an
+ *	    entry in the tree)
+ * @parent_ret - points to entry which would have been the parent of the entry,
+ * containing @offset
+ *
+ * This function returns a pointer to the entry that contains @offset byte
+ * address. If no such entry exists, then NULL is returned and the other
+ * pointer arguments to the function are filled.
+ */
 static struct rb_node *__etree_search(struct extent_io_tree *tree, u64 offset,
 				      struct rb_node **next_ret,
 				      struct rb_node **prev_ret,
-- 
2.17.1

