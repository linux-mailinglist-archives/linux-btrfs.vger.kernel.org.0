Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05217123ED0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLRFTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39639 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so600287pga.6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQp0+yCbYWFng8+Qfyn8OYobsCx76RYJGM6CXJnYTd8=;
        b=C1/B3Mdc/O3y10MpExrl+w7unCvs5/0eaxb5Mzan5GA23p164KHCjS4GeZmOPkV+bc
         sA9YoeQqyW19Y4vSYxQ5B/qMxgOwD7IOZrJSdmLdOAL3Id9uDh6JoXQqfeQymg3j/pem
         /GNo+QgsVXcmCaplhzZQxPvbFSBAET8b9nzEQeD0y/Nquj3aqp0A4+myu3A8iNdAkuRe
         RZ4z6+NepUrjpe9jXAo+PyC/qYToV465ap5JmGRhJlw5XMj6/x7pe3jN8ZQNn5D83sbh
         kcBlRUTvcvBEzxOeMuwBd/zXHyeAbXMSYH24sKl0FjIi5bBZXxp4hV4M0MvKNpTvJC1R
         P2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQp0+yCbYWFng8+Qfyn8OYobsCx76RYJGM6CXJnYTd8=;
        b=j+17ncTMkrMbGVivDeJu8iooannlwejMQUCeucB2zjnH+dAWLJLokxmylWw0XVfmRl
         t/dWIZA6oQswwAjTf6L8ceVB1qs2Xm8drSmKf7X6m9Gg+wuAF4NhImMF+bbUxYLx1qWb
         c+yDa4e7rU/w+gVibVKX5itT85AdFiqAhuYaVezt5XE/couwJuBbNMDxe6pZ37eKFNWR
         z2UQsZIHEYH4dc0naALx78y5uiwI2UlLWfvRgJVI0szSXrid7BhXLwVnoevY50kB5MLx
         FURDDrmAX/Ch1wjO0qMhz7IZEoM18iDQ13UC0guD5MjS5Z+tX2DO+XsG/W4HjnHzWmgz
         tcCA==
X-Gm-Message-State: APjAAAV9DRQX6wDPMabJdfyJgbrsnMUKurIrUQ1SVkNs/QaRkIs9dCch
        lLATCbl/vQSRFezk4WTaEosoM2yR2zQ=
X-Google-Smtp-Source: APXvYqws8bTHUJv0a959DL7m3BDV9WlOX2t0WHSOIQE1riYSyWTtLwUtsuCLWrT+wNAM7v/Kp9NnvQ==
X-Received: by 2002:a62:ed19:: with SMTP id u25mr975178pfh.173.1576646354232;
        Tue, 17 Dec 2019 21:19:14 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:13 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 10/10] btrfs-progs: cleanups after block group cache reform
Date:   Wed, 18 Dec 2019 13:18:49 +0800
Message-Id: <20191218051849.2587-11-Damenly_Su@gmx.com>
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

btrfs_fs_info::block_group_cache and the bit BLOCK_GROUP_DIRY are
useless. So is the block_group_state_bits().

Remove them.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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
index b7d5aa104a37..11879d89d1a7 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -329,18 +329,6 @@ wrapped:
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
2.21.0 (Apple Git-122.2)

