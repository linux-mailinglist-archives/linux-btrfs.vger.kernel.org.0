Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE96D24C679
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHTUAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgHTUAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 16:00:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9FC061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so2631630qkd.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bPl0gDbJ0AuaTH4ZtOzzR4bzr7UMecHSM2/vwsTZl7g=;
        b=UAWreJYc9GTCXSpMYm2+eFK6DbVGU9FC8kE64Bn+w0h+KFowJeYb46EZOD8CO6pRyw
         c5xl+Jsp8k5gCsn/ZI3XLv58Pf2vGzoRtVK3iJyV3Xono0yvjUzJzafVVmtoTvcMFRKv
         ZoDNL4CCnYIOOJDgvOJDCE6G7n3dYXOAjY9aZ9utbCXWZ9HRI/WzfO/ixAwuPFLqqAZB
         oIq/NTicWGnunxj2qB7IUivXwQydmyupzIuvhSGOMgNxt0JhZkcobUyZ+XswvTNigUv4
         5qP9x3jNpCAWs2+2QrNLXpJMNBimvlkUio/5MOaT5nvU48Recwm/JlnYflV3hwziGdG5
         Ix4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPl0gDbJ0AuaTH4ZtOzzR4bzr7UMecHSM2/vwsTZl7g=;
        b=hjbQNnuP8Uy1d6nEk/uCOVrsv7Jaz4lcvG2ugdwRRzgoedhCjYvU1N/aNmFaxpURWD
         TjpwyoOGA0KxhM9IBbWcNgMZxueihz2WwydMlqKV6ZhSRqsQythk4ckRpaabClJLrsZm
         2rcY3YbXeyV8XoYHSA2uEtFkQGazbfdWzC365kjKalVLDxlheryHUZFKqAHHFGoxzqZ1
         uSB/BEqf9dWWQCmBq27GYAK9K2imLGKCbEmp4kdJrEKdJk+ImCAExC9egBqZwc4sXuki
         fgGwS7XhvRyrvhw10BfCJEz8csXCQgoJM2BnvzqIbwH0nnvpIQ3weOC0lq72SqqOk18j
         OrXw==
X-Gm-Message-State: AOAM533wnpaq/oQzUsT29a7ZPF5PedZqgmXHjHfAKAdjfUmLwLd2xuCQ
        csLgPoChGDmmP4vPJ9PxSqRyytsf5YDtb8kS
X-Google-Smtp-Source: ABdhPJzKhlCXlG5Eo6hQnnjvjs764/uf+zLDT0frO8VWBo6GeAYO0MxxtkGHenpvUQ5YcoE+Op71Ow==
X-Received: by 2002:a37:8484:: with SMTP id g126mr115834qkd.230.1597953620658;
        Thu, 20 Aug 2020 13:00:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z197sm2962775qkb.66.2020.08.20.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:00:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: pretty print leaked root name
Date:   Thu, 20 Aug 2020 16:00:15 -0400
Message-Id: <461693e5c015857e684878e99e5e65075bb97c13.1597953516.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597953516.git.josef@toxicpanda.com>
References: <cover.1597953516.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm a actual human being so am incapable of converting u64 to s64 in my
head, so add a helper to get the pretty name of a root objectid and use
that helper to spit out the name for any special roots for leaked roots,
so I don't have to scratch my head and figure out which root I messed up
the refs for.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c    |  8 +++++---
 fs/btrfs/print-tree.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/print-tree.h |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ac6d6fddd5f4..a7358e0f59de 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1506,11 +1506,13 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *root;
 
 	while (!list_empty(&fs_info->allocated_roots)) {
+		const char *name = btrfs_root_name(root->root_key.objectid);
+
 		root = list_first_entry(&fs_info->allocated_roots,
 					struct btrfs_root, leak_list);
-		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
-			  root->root_key.objectid, root->root_key.offset,
-			  refcount_read(&root->refs));
+		btrfs_err(fs_info, "leaked root %s%lld-%llu refcount %d",
+			  name ? name : "", root->root_key.objectid,
+			  root->root_key.offset, refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
 			btrfs_put_root(root);
 		btrfs_put_root(root);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 61f44e78e3c9..c633aec8973d 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -7,6 +7,43 @@
 #include "disk-io.h"
 #include "print-tree.h"
 
+struct name_map {
+	u64 id;
+	const char *name;
+};
+
+static const struct name_map root_map[] = {
+	{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
+	{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
+	{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
+	{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
+	{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
+	{ BTRFS_ROOT_TREE_DIR_OBJECTID,		"ROOT_TREE_DIR"		},
+	{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
+	{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
+	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
+	{ BTRFS_TREE_RELOC_OBJECTID,		"TREE_RELOC"		},
+	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
+	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
+	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
+};
+
+const char *btrfs_root_name(u64 objectid)
+{
+	int i;
+
+	if (objectid >= BTRFS_FIRST_FREE_OBJECTID &&
+	    objectid <= BTRFS_LAST_FREE_OBJECTID)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(root_map); i++) {
+		if (root_map[i].id == objectid)
+			return root_map[i].name;
+	}
+
+	return NULL;
+}
+
 static void print_chunk(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 {
 	int num_stripes = btrfs_chunk_num_stripes(eb, chunk);
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index e6bb38fd75ad..dffdfa495297 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -8,5 +8,6 @@
 
 void btrfs_print_leaf(struct extent_buffer *l);
 void btrfs_print_tree(struct extent_buffer *c, bool follow);
+const char *btrfs_root_name(u64 objectid);
 
 #endif
-- 
2.24.1

