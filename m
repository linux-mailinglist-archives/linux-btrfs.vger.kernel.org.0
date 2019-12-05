Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4172113AD8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfLEE37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42401 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfLEE36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so1861013ljo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nFPcahWz6Jkwg8oyCwSBtdB1weTJRg2TrMh+XqmgyI=;
        b=W9RKvPzhnl5caJHte14VbnNPJK1piY1+SwxuCZf9gysYMc+rzaQ3qXhWbxuvHd6WiJ
         8f7i7bQjKb0yF5c/byCGoFmJwRZZRrvzZEj2ImtH5oOLUt/3E3QfhJyoF+lltphV0JRy
         e4v3OMcw67/j+B1BSWoBRaoN45MOfbcBiQLSnmnl84XlJGLxtXxW6bmN1HfwM2w6gR5X
         KPIngkL+rce+rXdd8MSVS359rDgBgPoFnNoorttNF/oWaaIUfihM8+aiB0W5l9Oy6ToK
         ZaIwZK/182cr/M0mzUTrmFvA/7EM+e2EHE6Zygzogdt1V0PUm73T1xsYYLgRmp0koEjY
         dQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nFPcahWz6Jkwg8oyCwSBtdB1weTJRg2TrMh+XqmgyI=;
        b=n7zbU+c2DDwm1kZXKTkDnMRPuuMUgJO7TSw8cDyCAgyzyQ981w/IZoijcIOdLvXxC2
         HN+ntbO/jIdQVZlDbDqz6+pGGJdMHn/f+e3UF6Je7GjOMHHUaXWfHhqfCScOrhCKH8L+
         iDWdWB/WjJCUyvVx4I5yg4QhH/uvs1bzppV38bRAVYCsPF4fYxwCaQ6icO0eajbqXNGn
         w92J/+3WZ2ycK0Fql/OcHFVYxjFALvSUa7NwN4fMtv4xRg4d3tnpp4AloXuXuhg2GGds
         eIF5baoAcyIvYMRmVZyzussV9UDD1vD6QJQV1BsKReT0bjaOHb6tNLoqV6L05kHnrFMc
         lrqQ==
X-Gm-Message-State: APjAAAWfpw5OA27LnXHbn/47m7AEMZGWVDli4jYPRzCgNx/cm3cvNnKI
        5IX6jVq+yWZvia34m8yWT7gxnBbKcZ4=
X-Google-Smtp-Source: APXvYqzgS4aYsnJUCyqwl+j6Cdq4EC7mJbl5YHlScU9Ezrzetv84mfHz+AUJeE1XgaHfnVGFG4Gypw==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr3882363ljm.55.1575520196419;
        Wed, 04 Dec 2019 20:29:56 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:55 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 10/10] btrfs-progs: cleanups after block group cache reform
Date:   Thu,  5 Dec 2019 12:29:21 +0800
Message-Id: <20191205042921.25316-11-Damenly_Su@gmx.com>
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

btrfs_fs_info::block_group_cache and the bit BLOCK_GROUP_DIRY are
useless. So is the block_group_state_bits().

Remove them.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 ctree.h       |  1 -
 disk-io.c     |  2 --
 extent-tree.c | 12 ------------
 extent_io.h   |  2 --
 4 files changed, 17 deletions(-)

diff --git a/ctree.h b/ctree.h
index 53882d04ac03..6d2fad6406d7 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1146,7 +1146,6 @@ struct btrfs_fs_info {
 
 	struct extent_io_tree extent_cache;
 	struct extent_io_tree free_space_cache;
-	struct extent_io_tree block_group_cache;
 	struct extent_io_tree pinned_extents;
 	struct extent_io_tree extent_ins;
 	struct extent_io_tree *excluded_extents;
diff --git a/disk-io.c b/disk-io.c
index b7ae72a99f59..95958d9706da 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -794,7 +794,6 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 
 	extent_io_tree_init(&fs_info->extent_cache);
 	extent_io_tree_init(&fs_info->free_space_cache);
-	extent_io_tree_init(&fs_info->block_group_cache);
 	extent_io_tree_init(&fs_info->pinned_extents);
 	extent_io_tree_init(&fs_info->extent_ins);
 
@@ -1069,7 +1068,6 @@ void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info)
 	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
 	extent_io_tree_cleanup(&fs_info->extent_cache);
 	extent_io_tree_cleanup(&fs_info->free_space_cache);
-	extent_io_tree_cleanup(&fs_info->block_group_cache);
 	extent_io_tree_cleanup(&fs_info->pinned_extents);
 	extent_io_tree_cleanup(&fs_info->extent_ins);
 }
diff --git a/extent-tree.c b/extent-tree.c
index e227c4db51cf..2815888b6cc5 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -333,18 +333,6 @@ wrapped:
 	goto again;
 }
 
-static int block_group_state_bits(u64 flags)
-{
-	int bits = 0;
-	if (flags & BTRFS_BLOCK_GROUP_DATA)
-		bits |= BLOCK_GROUP_DATA;
-	if (flags & BTRFS_BLOCK_GROUP_METADATA)
-		bits |= BLOCK_GROUP_METADATA;
-	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-		bits |= BLOCK_GROUP_SYSTEM;
-	return bits;
-}
-
 static struct btrfs_block_group_cache *
 btrfs_find_block_group(struct btrfs_root *root, struct btrfs_block_group_cache
 		       *hint, u64 search_start, int data, int owner)
diff --git a/extent_io.h b/extent_io.h
index 1715acc60708..7f88e3f8a305 100644
--- a/extent_io.h
+++ b/extent_io.h
@@ -47,8 +47,6 @@
 #define BLOCK_GROUP_METADATA	(1U << 2)
 #define BLOCK_GROUP_SYSTEM	(1U << 4)
 
-#define BLOCK_GROUP_DIRTY 	(1U)
-
 /*
  * The extent buffer bitmap operations are done with byte granularity instead of
  * word granularity for two reasons:
-- 
2.21.0 (Apple Git-122)

