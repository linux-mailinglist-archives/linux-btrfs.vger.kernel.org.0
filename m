Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405D047639C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhLOUn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:56 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B82C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:56 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t34so23199058qtc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q41sGwQV/wZeaG+cAVt7MnUBaDkdfWww1o0C3YLitoA=;
        b=g8V9JF6ZRNVCvggXkrGfrSDYIg9NNTQQdgPilc0xBdgaSeAsS30+C4kdkbb1TJcF5w
         cs3GuU6XDLjGSFkK+vXdJWSjB9ws6u9xnVuSLLEwJRLLinvmQGh6VtXw5r4s0PguMLtW
         K9OLYaYTyO1TifKweajRn5muXVHrlml1WNndiwxIpCYKvJReLG32HqpDHOuvld1ZleEz
         MJSINGzaverVUueA6gsJBGyzhy7TZ2fSlEebIvtTeFvzA3WX7jqzra/j3rCwvgSRWVtO
         Ok7gZy7JTVNZYLL39wLzaq0kabFj5K33wFiOG3TvR8B3l4ZJ6XujhXA2mEYDQ1OUlTJF
         9n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q41sGwQV/wZeaG+cAVt7MnUBaDkdfWww1o0C3YLitoA=;
        b=XAgui7qfGNqZ6UNTlTU0kYmTmh/smbvisVYbKz5kMJWH5TdkMdpGqITgBV68rMwUEe
         pc+6GWdV1jEgndlswZgifYha6SO7grHAiCvN0FOzSFlpkKrQw6cIncjCJH35LFechtzv
         4Vbnm87iD+4a4jbWuOvClt0gj5l5Pezf7aHRUnhXudQWPoKbWn3W2W6hBvDojCl/lDVq
         GV7XQWPxYTTO4d9zMt9Ar3iHjhWZHJh/TEdnCfca0SaxOAIdinmtoWspzrfSU1C0kcjT
         7/fPPKDWlt6P7aXoURV476IXuTzNN0mIiU1SsEpISJ6Uqfd/loj22sqWGbIMaXc+UgUI
         jcYg==
X-Gm-Message-State: AOAM532ygCXnXs3PZIGJHwZ+Lhl8ghR45upiX3w7eW/OEoL706scyNaY
        B/4G4+OkmpRe8/CMjzWeS3ejhUcnUhbvJQ==
X-Google-Smtp-Source: ABdhPJxwwOgBRXI8iGyXJqd2Z1gAlEYs5XqTcMT7E/6uNHjvC+kRYe/RHcW4co/TwVksCodg1W2Usg==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr13918646qtw.211.1639601035130;
        Wed, 15 Dec 2021 12:43:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v10sm2317521qtk.13.2021.12.15.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/9] btrfs: add definitions and read support for the garbage collection tree
Date:   Wed, 15 Dec 2021 15:43:42 -0500
Message-Id: <37b33df7b776efe884385f73f92f9d01b5ec0689.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds the on disk definitions for the garbage collection tree and
the code to load it on mount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c              | 6 ++++++
 fs/btrfs/print-tree.c           | 4 ++++
 include/uapi/linux/btrfs_tree.h | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2a70f61345aa..98b37850d614 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2668,6 +2668,12 @@ static int load_global_roots(struct btrfs_root *tree_root)
 	ret = load_global_roots_objectid(tree_root, path,
 					 BTRFS_FREE_SPACE_TREE_OBJECTID,
 					 "free space");
+	if (ret)
+		goto out;
+	if (!btrfs_fs_incompat(tree_root->fs_info, EXTENT_TREE_V2))
+		goto out;
+	ret = load_global_roots_objectid(tree_root, path,
+					 BTRFS_GC_TREE_OBJECTID, "gc");
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 524fdb0ddd74..7fa202105e97 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -24,6 +24,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
+	{ BTRFS_GC_TREE_OBJECTID,		"GC_TREE"		},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 };
 
@@ -348,6 +349,9 @@ void btrfs_print_leaf(struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size(l, i));
 			break;
+		case BTRFS_GC_INODE_ITEM_KEY:
+			pr_info("\t\tgc inode item\n");
+			break;
 		}
 	}
 }
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 854df92520a1..690b01e0138b 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -56,6 +56,9 @@
 /* holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* holds the garbage collection itesm for extent tree v2. */
+#define BTRFS_GC_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -147,6 +150,9 @@
 #define BTRFS_ORPHAN_ITEM_KEY		48
 /* reserve 2-15 close to the inode for later flexibility */
 
+/* The garbage collection items. */
+#define BTRFS_GC_INODE_ITEM_KEY		49
+
 /*
  * dir items are the name -> inode pointers in a directory.  There is one
  * for every name in a directory.  BTRFS_DIR_LOG_ITEM_KEY is no longer used
-- 
2.26.3

