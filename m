Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304C3123EC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLRFTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46703 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so420186pll.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bA/z/NOjsJfR+5fv7Nl7qo6RMjl6/6d04yGOoGNSkE=;
        b=UlH3famRpFxj+nbtrn7re7HHYoyeMp+rJITVeGyUtZ4ENokhy8Ff+iHdeTQ0ABy6rZ
         cwctEZvujQKEwA2vjlRV0PVyzLw/QbAYxA1EnqKgmC2JZuAZ1BsMFX0Dsi+2dLQAjvVd
         ZcgaJSunHE9iLp+22xxwRhJWfskHpJR8pheuJhsCH7sGQ40+DimWWtWxOIw4KHnMLiyb
         owKx4rSVGq2APFvVxjgslv4ShjcS47cBcV3dZt91GeBWZc4GTLpLK7XmR5dGHt+qD1z/
         eFspWHpVnyztOmNBJDKiPuHealcinFWHZWbAW3calsv5YEBTjFvt1a8fouXLM28bLbH4
         HHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bA/z/NOjsJfR+5fv7Nl7qo6RMjl6/6d04yGOoGNSkE=;
        b=sXEsnQM4YLVrGFBAYjlFhkrHwsbe8Ku5Mt9v17G0BxRKl6DN2iElcLcTfryYp1Ci67
         S8VUWBXhFj8bLL/Y+YIWp8IgVZKQux821oqis0FiWLeIEuOTU89fT5NqpgN9ulAf2eqF
         iSW+5DpULC9L/adPd195bpRSMCwxBAbkJtspLyF6Mcln4EzWmTNviTo7pk3HldCKbefL
         J3rJpf8lvZXkELwwC5sKaKrFikVJk3oKLqxh7KZUZrh6nKw5kXjJ5jwBOIW7tZgVlhX6
         DAgVuzPGqAOe/kW2WpELx2mwagXjcSrYkOulB2n5X2wgdmRZbEjrUa4/ufK4a/KpKtb1
         yZUw==
X-Gm-Message-State: APjAAAWpKbc9I+UY8iyGQWBMkz9MrAo/EKBbq0B3FzqJiPruAYOwBmrY
        2juA6iw4YGheQnqNm2Dw2aa/8vqM4RU=
X-Google-Smtp-Source: APXvYqyaSU+up3W2XZNoPssbGDMcf8LaHfZwkN4uOOdvFR8jKcuq9H7GoBc4VgNWNMwRNMPudaPwbA==
X-Received: by 2002:a17:902:aa96:: with SMTP id d22mr661104plr.218.1576646340029;
        Tue, 17 Dec 2019 21:19:00 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:18:59 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 03/10] btrfs-progs: port block group cache tree insertion and lookup functions
Date:   Wed, 18 Dec 2019 13:18:42 +0800
Message-Id: <20191218051849.2587-4-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Simple copy and paste codes, remove useless lock operantions in progs.
Th new coming lookup functions are named with suffix _kernel in
temporary.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/extent-tree.c b/extent-tree.c
index 4a3db029e811..ab576f8732a2 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,6 +164,92 @@ err:
 	return 0;
 }
 
+/*
+ * This adds the block group to the fs_info rb tree for the block group cache
+ */
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+				struct btrfs_block_group_cache *block_group)
+{
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct btrfs_block_group_cache *cache;
+
+	p = &info->block_group_cache_tree.rb_node;
+
+	while (*p) {
+		parent = *p;
+		cache = rb_entry(parent, struct btrfs_block_group_cache,
+				 cache_node);
+		if (block_group->key.objectid < cache->key.objectid)
+			p = &(*p)->rb_left;
+		else if (block_group->key.objectid > cache->key.objectid)
+			p = &(*p)->rb_right;
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&block_group->cache_node, parent, p);
+	rb_insert_color(&block_group->cache_node,
+			&info->block_group_cache_tree);
+
+	return 0;
+}
+
+/*
+ * This will return the block group at or after bytenr if contains is 0, else
+ * it will return the block group that contains the bytenr
+ */
+static struct btrfs_block_group_cache *block_group_cache_tree_search(
+		struct btrfs_fs_info *info, u64 bytenr, int contains)
+{
+	struct btrfs_block_group_cache *cache, *ret = NULL;
+	struct rb_node *n;
+	u64 end, start;
+
+	n = info->block_group_cache_tree.rb_node;
+
+	while (n) {
+		cache = rb_entry(n, struct btrfs_block_group_cache,
+				 cache_node);
+		end = cache->key.objectid + cache->key.offset - 1;
+		start = cache->key.objectid;
+
+		if (bytenr < start) {
+			if (!contains && (!ret || start < ret->key.objectid))
+				ret = cache;
+			n = n->rb_left;
+		} else if (bytenr > start) {
+			if (contains && bytenr <= end) {
+				ret = cache;
+				break;
+			}
+			n = n->rb_right;
+		} else {
+			ret = cache;
+			break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Return the block group that starts at or after bytenr
+ */
+struct btrfs_block_group_cache *btrfs_lookup_first_block_group_kernel(
+		struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 0);
+}
+
+/*
+ * Return the block group that contains the given bytenr
+ */
+struct btrfs_block_group_cache *btrfs_lookup_block_group_kernel(
+		struct btrfs_fs_info *info, u64 bytenr)
+{
+	return block_group_cache_tree_search(info, bytenr, 1);
+}
+
 /*
  * Return the block group that contains @bytenr, otherwise return the next one
  * that starts after @bytenr
-- 
2.21.0 (Apple Git-122.2)

