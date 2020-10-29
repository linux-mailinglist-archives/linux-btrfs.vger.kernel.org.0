Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232DD29EB34
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ2MDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:03:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:32814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2MDA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:03:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYp6JkXd8Vvw0e2wPqWof8hRWj2nuJnXVdfgGzzCQrk=;
        b=OozTMiQCxc6s69gFj/toOxPR54fFzjF8vhYoP39FqnHyQDkgywXCVrfvLJU2AlE74PNwtY
        qb0EbWblaS2ZnUPPU5TM8zY0TjWVB8WwbdeIjom6ZNSD5eObvQjWQFP9xphar21c9tI+C+
        yEmSWV5gaCgiO3zXE//CSmsSJ602PpA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D84E1ACF1;
        Thu, 29 Oct 2020 12:02:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0B6EDA7D9; Thu, 29 Oct 2020 13:01:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/8] btrfs: generate lockdep keyset names at compile time
Date:   Thu, 29 Oct 2020 13:01:23 +0100
Message-Id: <48d72991d46fe1fa25a3c417a07aff31ee818418.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The names in btrfs_lockdep_keysets are generated from a simple pattern
using snprintf but we can generate them directly with some macro magic
and remove the helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 56 ++++++++++++++++++++++++----------------------
 fs/btrfs/disk-io.h |  3 ---
 fs/btrfs/super.c   |  2 --
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c4052f171f04..42465b8728dd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -150,40 +150,42 @@ struct async_submit_bio {
 #  error
 # endif
 
+#define DEFINE_LEVEL(stem, level)					\
+	.names[level] = "btrfs-" stem "-0" #level,
+
+#define DEFINE_NAME(stem)						\
+	DEFINE_LEVEL(stem, 0)						\
+	DEFINE_LEVEL(stem, 1)						\
+	DEFINE_LEVEL(stem, 2)						\
+	DEFINE_LEVEL(stem, 3)						\
+	DEFINE_LEVEL(stem, 4)						\
+	DEFINE_LEVEL(stem, 5)						\
+	DEFINE_LEVEL(stem, 6)						\
+	DEFINE_LEVEL(stem, 7)
+
 static struct btrfs_lockdep_keyset {
 	u64			id;		/* root objectid */
-	const char		*name_stem;	/* lock name stem */
+	/* Longest entry: btrfs-free-space-00 */
 	char			names[BTRFS_MAX_LEVEL][20];
 	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
 } btrfs_lockdep_keysets[] = {
-	{ .id = BTRFS_ROOT_TREE_OBJECTID,	.name_stem = "root"	},
-	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	.name_stem = "extent"	},
-	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	.name_stem = "chunk"	},
-	{ .id = BTRFS_DEV_TREE_OBJECTID,	.name_stem = "dev"	},
-	{ .id = BTRFS_FS_TREE_OBJECTID,		.name_stem = "fs"	},
-	{ .id = BTRFS_CSUM_TREE_OBJECTID,	.name_stem = "csum"	},
-	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	.name_stem = "quota"	},
-	{ .id = BTRFS_TREE_LOG_OBJECTID,	.name_stem = "log"	},
-	{ .id = BTRFS_TREE_RELOC_OBJECTID,	.name_stem = "treloc"	},
-	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	.name_stem = "dreloc"	},
-	{ .id = BTRFS_UUID_TREE_OBJECTID,	.name_stem = "uuid"	},
-	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	.name_stem = "free-space" },
-	{ .id = 0,				.name_stem = "tree"	},
+	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
+	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	DEFINE_NAME("extent")	},
+	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	DEFINE_NAME("chunk")	},
+	{ .id = BTRFS_DEV_TREE_OBJECTID,	DEFINE_NAME("dev")	},
+	{ .id = BTRFS_FS_TREE_OBJECTID,		DEFINE_NAME("fs")	},
+	{ .id = BTRFS_CSUM_TREE_OBJECTID,	DEFINE_NAME("csum")	},
+	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	DEFINE_NAME("quota")	},
+	{ .id = BTRFS_TREE_LOG_OBJECTID,	DEFINE_NAME("log")	},
+	{ .id = BTRFS_TREE_RELOC_OBJECTID,	DEFINE_NAME("treloc")	},
+	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	DEFINE_NAME("dreloc")	},
+	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
+	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
+	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
-void __init btrfs_init_lockdep(void)
-{
-	int i, j;
-
-	/* initialize lockdep class names */
-	for (i = 0; i < ARRAY_SIZE(btrfs_lockdep_keysets); i++) {
-		struct btrfs_lockdep_keyset *ks = &btrfs_lockdep_keysets[i];
-
-		for (j = 0; j < ARRAY_SIZE(ks->names); j++)
-			snprintf(ks->names[j], sizeof(ks->names[j]),
-				 "btrfs-%s-%02d", ks->name_stem, j);
-	}
-}
+#undef DEFINE_LEVEL
+#undef DEFINE_NAME
 
 void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 				    int level)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 182540bdcea0..d47894260cfa 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -135,12 +135,9 @@ int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-void btrfs_init_lockdep(void);
 void btrfs_set_buffer_lockdep_class(u64 objectid,
 			            struct extent_buffer *eb, int level);
 #else
-static inline void btrfs_init_lockdep(void)
-{ }
 static inline void btrfs_set_buffer_lockdep_class(u64 objectid,
 					struct extent_buffer *eb, int level)
 {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1ffa50bae1dd..9f51b0a22b14 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2572,8 +2572,6 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_end_io_wq;
 
-	btrfs_init_lockdep();
-
 	btrfs_print_mod_info();
 
 	err = btrfs_run_sanity_tests();
-- 
2.25.0

