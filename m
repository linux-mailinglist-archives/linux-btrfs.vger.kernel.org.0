Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAC60E8C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiJZTMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiJZTLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900D101E14
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g16so10716470qtu.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElAed3+QZfQO5PqJWhjqHGBaDcNe4SA0HgdgavJrxRI=;
        b=OndQ7wGIl28JDJ4qtQWL+XFvRxdfuluf0sL4/TT2E0tLv5ntbZIEpnv/pgtovsPAEH
         M7adQLaICMBi+fWjVvvxPSlHKKXVDYpLmaS2d23Ux59X9LJ3uucX8usOTRYbvTEN6ZSq
         P14FdD+bm/XSTQKQOBvIPrIYIkHIxzLjqnvr8xdblg3nudUp0KnyZvC/enR9nRpLj3Vq
         b9rOw/43I8ePWb45a97zXSHg8zHw2jzOTFw3Pq26O8AMZDJIpNggzh+YezkWUz2UrOik
         x2kv1bP9afDxXr7sTmj9Qrn4Y0DBgYSL4dkeY1CyVN6bHPvxpy1JdTP/R+b4JigiALFe
         JsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElAed3+QZfQO5PqJWhjqHGBaDcNe4SA0HgdgavJrxRI=;
        b=axWsxz8NMiMlUTB7qLtWUjRC9yDgNVfemtHVCDCsdNYnHA6KtFIXGAwe31b0Sae6yQ
         Bnw0VRMQs0iYR6NlQuhiRf1LvWdLOOpnLPBBqsHZsYCd4Fmli0jzUlfKXPQOL4CtHAuD
         btHPsh0+3L9l+kFZuWAhI3xXZUjBSqEkavos2n7ZH1eTml68xpMUHBJk7Um6dfyzucEP
         tyuB4uaOrzFR+yAWU6dnBDC/ndF8amoYFcRbDbEWzaHIhA49PeNA2iQ0IAj6vMgQv1Uj
         01ulHKE9xSAp+RN/nxyE4uxNeWMsV/FrOBSNKtcE5Xgr5g81bqJIGmDwpAB18V2cFWi5
         U33w==
X-Gm-Message-State: ACrzQf1OpwtjJwb4K73YEekVFD49tOMHIbUb0lSgw9Th3hlrPKNtFNbD
        9Z7nrXMWfHNMczgGD9kNWyUDGxMtmvejfQ==
X-Google-Smtp-Source: AMsMyM6HQ7lr0UeVb9GPbhSrBorRqBO1Bq10mz7OSYfNYy9u45pvlHKTtzljXVr6VjZQRalgCeRSqg==
X-Received: by 2002:ac8:5f0b:0:b0:399:6c9:fc05 with SMTP id x11-20020ac85f0b000000b0039906c9fc05mr36737660qta.611.1666811359126;
        Wed, 26 Oct 2022 12:09:19 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k14-20020ac8604e000000b0035badb499c7sm3589522qtm.21.2022.10.26.12.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/26] btrfs: move super_block specific helpers into super.h
Date:   Wed, 26 Oct 2022 15:08:40 -0400
Message-Id: <8117066d4011676ed0ed58c23fdb0f1c93a468c9.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will make syncing fs.h to user space a little easier if we can pull
the super block specific helpers out of fs.h and put them in super.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c      |  1 +
 fs/btrfs/defrag.c           |  1 +
 fs/btrfs/export.c           |  1 +
 fs/btrfs/extent_io.c        |  1 +
 fs/btrfs/file-item.c        |  1 +
 fs/btrfs/file.c             |  1 +
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/fs.h               | 17 -----------------
 fs/btrfs/inode.c            |  1 +
 fs/btrfs/lzo.c              |  1 +
 fs/btrfs/messages.c         |  1 +
 fs/btrfs/ordered-data.c     |  1 +
 fs/btrfs/props.c            |  1 +
 fs/btrfs/reflink.c          |  1 +
 fs/btrfs/relocation.c       |  1 +
 fs/btrfs/super.h            | 17 +++++++++++++++++
 fs/btrfs/volumes.c          |  1 +
 17 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4ac42df7d35a..52df6c06cc91 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -35,6 +35,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "file-item.h"
+#include "super.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index e3cc41295a41..b03a83bccac4 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -15,6 +15,7 @@
 #include "subpage.h"
 #include "defrag.h"
 #include "file-item.h"
+#include "super.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index b6bc9684648f..744a02b7fd67 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -8,6 +8,7 @@
 #include "print-tree.h"
 #include "export.h"
 #include "accessors.h"
+#include "super.h"
 
 #define BTRFS_FID_SIZE_NON_CONNECTABLE (offsetof(struct btrfs_fid, \
 						 parent_objectid) / 4)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e27a6f1b33bb..069b4f848008 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -35,6 +35,7 @@
 #include "file-item.h"
 #include "file.h"
 #include "dev-replace.h"
+#include "super.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 50cd501d4f79..15d6a7872c1f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -20,6 +20,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "super.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index be9048dc4658..838b3c0ea329 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -36,6 +36,7 @@
 #include "file-item.h"
 #include "ioctl.h"
 #include "file.h"
+#include "super.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 776dfd8f79a2..61e04b008d97 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -30,6 +30,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "file.h"
+#include "super.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 98efca140435..7a6c4829c02b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -801,11 +801,6 @@ static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_info *fs_in
 	return READ_ONCE(fs_info->last_root_drop_gen);
 }
 
-static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
 /*
  * Take the number of bytes to be checksummed and figure out how many leaves
  * it would require to store the csums for that many bytes.
@@ -951,18 +946,6 @@ static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 		btrfs_fs_closing(fs_info);
 }
 
-static inline void btrfs_set_sb_rdonly(struct super_block *sb)
-{
-	sb->s_flags |= SB_RDONLY;
-	set_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
-}
-
-static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
-{
-	sb->s_flags &= ~SB_RDONLY;
-	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
-}
-
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 {
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6a172ccd7847..ef0bf2e070ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -68,6 +68,7 @@
 #include "acl.h"
 #include "relocation.h"
 #include "verity.h"
+#include "super.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 6751874a3e69..e7b1ceffcd33 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -16,6 +16,7 @@
 #include "messages.h"
 #include "compression.h"
 #include "ctree.h"
+#include "super.h"
 
 #define LZO_LEN	4
 
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index a94a213da02e..402f9791c899 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -5,6 +5,7 @@
 #include "discard.h"
 #include "transaction.h"
 #include "space-info.h"
+#include "super.h"
 
 #ifdef CONFIG_PRINTK
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index eec2a4fe2ef4..4bce6ded87f9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -19,6 +19,7 @@
 #include "qgroup.h"
 #include "subpage.h"
 #include "file.h"
+#include "super.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 9ad15d69718c..0755af0e53e3 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -14,6 +14,7 @@
 #include "space-info.h"
 #include "fs.h"
 #include "accessors.h"
+#include "super.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index bebe552d83be..3d713dd775e3 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -14,6 +14,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "file.h"
+#include "super.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f31a97d4f9ad..d119986d1599 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -34,6 +34,7 @@
 #include "root-tree.h"
 #include "file-item.h"
 #include "relocation.h"
+#include "super.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index 04e28aa01f8a..0fb62eceb86d 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -9,4 +9,21 @@ int btrfs_sync_fs(struct super_block *sb, int wait);
 char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 					  u64 subvol_objectid);
 
+static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+static inline void btrfs_set_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags |= SB_RDONLY;
+	set_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
+}
+
+static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags &= ~SB_RDONLY;
+	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
+}
+
 #endif /* BTRFS_SUPER_H */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7f4005d1c822..9c0edb3ed522 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -39,6 +39,7 @@
 #include "ioctl.h"
 #include "relocation.h"
 #include "scrub.h"
+#include "super.h"
 
 static struct bio_set btrfs_bioset;
 
-- 
2.26.3

