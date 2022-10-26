Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2F60E8D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiJZTMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiJZTLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:38 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30B12607
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bb5so10683173qtb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lk3G87kUPkIoaLDfkRgqJAhQxdV7wIpzunw6nyqadM=;
        b=0FO9COB5tcCm80XP21mNHXfzCteuvnfki0EDuDRzLszhJV3DveSdOJ8s1jl9MzyfHB
         XQ2Dg/r2tgWlrx+wJ5G5AEUqXVg1KWP448VkDz8nFaPLjRDwYmzKso0r4gVJXw6aAWPR
         uoPRCA7s1WPd9CmTAKhtHMFO7dk+LoiVRpkXk37Uc7aswZSCGOpp5zbSprQPIAihrXBg
         s1xmoY19PS/ytM0H9Vva2g41q8UHRi2l3nTxt4dBElxOTIKVScpu70OXEFXEJs2P48kC
         B4a65wfIr08h+qRtbbiM3tu/trkzJqsQTehn1rCSGRVHVqqNoaHfcNgN7udLUyDuVxqU
         wQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lk3G87kUPkIoaLDfkRgqJAhQxdV7wIpzunw6nyqadM=;
        b=entXid04lRskfrZjy68duKVodAlnZVLYROETj4JePgrjhbBDp2XGUTXNpzqTq06eut
         AMYs2SD3qwCqSf/TuMe6FXPdT0w/uLXiSwFubeJym6wNup9E+oWRrviYwp7ttQwfdG8d
         Vmz/+MTTXkCYZIrVBqox/eVWqz6NAj/N9Wwq9YCZvqzGZE2UVoyIWPBFQcJlBe8jY1XN
         3Bp1uf2a/FI7aMFMAssAcXMD1aL1otjcNcfA+kxufi99lD1WU57cJhx56XAkHe1Y/tNL
         pnGDXsSxwH4UUmAd9o82mPNTC51eNEULyRe7mTAXTwyOG9p8SlqMnLmOrb9bfSW/dcNJ
         VtPQ==
X-Gm-Message-State: ACrzQf1b0sR0lQBoG7BI7jPCyDnAiy/MWIvvav7zIajoDszCNMHyJAD+
        gQOupKGvCsuPwRhXcCu6UkmxvkEqxD3eDA==
X-Google-Smtp-Source: AMsMyM7CMLrNWs/90Y2/EpvD4N0GXZeccezsjkOHsqpBgN3loqSBqfYeMpi8jFdlqWQQPkrtFTKINg==
X-Received: by 2002:a05:622a:446:b0:39c:d995:4548 with SMTP id o6-20020a05622a044600b0039cd9954548mr36989164qtx.59.1666811350388;
        Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj22-20020a05620a191600b006f956766f76sm1184515qkb.1.2022.10.26.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/26] btrfs: move relocation prototypes into relocation.h
Date:   Wed, 26 Oct 2022 15:08:34 -0400
Message-Id: <9fad37625a4062c100ecfc78fe27bfac1aa1515e.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into relocation.h to cut down on code in
ctree.h

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c     |  1 +
 fs/btrfs/ctree.c       |  1 +
 fs/btrfs/ctree.h       | 20 --------------------
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/relocation.c  |  1 +
 fs/btrfs/relocation.h  | 25 +++++++++++++++++++++++++
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/volumes.c     |  1 +
 9 files changed, 32 insertions(+), 20 deletions(-)
 create mode 100644 fs/btrfs/relocation.h

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a53fa2dad01f..013c2c085229 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -18,6 +18,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "relocation.h"
 
 /* Just arbitrary numbers so we can be sure one of these happened. */
 #define BACKREF_FOUND_SHARED     6
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 140257f22c69..05c5ac54fe52 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -21,6 +21,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "relocation.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 040b640b0222..b1b6de508e20 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -732,26 +732,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-/* relocation.c */
-int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
-int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root);
-int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root);
-int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
-int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
-int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, struct extent_buffer *buf,
-			  struct extent_buffer *cow);
-void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
-			      u64 *bytes_to_reserve);
-int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
-			      struct btrfs_pending_snapshot *pending);
-int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
-struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
-				   u64 bytenr);
-int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
-
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c5ff0b12cd5b..215f95b90cc7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -49,6 +49,7 @@
 #include "root-tree.h"
 #include "defrag.h"
 #include "uuid-tree.h"
+#include "relocation.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e5443d44610c..fd733fc3c583 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -66,6 +66,7 @@
 #include "ioctl.h"
 #include "file.h"
 #include "acl.h"
+#include "relocation.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e86364bdac8e..f31a97d4f9ad 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -33,6 +33,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "file-item.h"
+#include "relocation.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
new file mode 100644
index 000000000000..1a3cac9197ff
--- /dev/null
+++ b/fs/btrfs/relocation.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_RELOCATION_H
+#define BTRFS_RELOCATION_H
+
+int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
+int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root);
+int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root);
+int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
+int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
+int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root, struct extent_buffer *buf,
+			  struct extent_buffer *cow);
+void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
+			      u64 *bytes_to_reserve);
+int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
+			      struct btrfs_pending_snapshot *pending);
+int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info);
+struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
+				   u64 bytenr);
+int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
+
+#endif /* BTRFS_RELOCATION_H */
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e491fbcd404f..f7a1af84ae33 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -32,6 +32,7 @@
 #include "dir-item.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
+#include "relocation.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b70cfab02ab..af58abf34462 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -37,6 +37,7 @@
 #include "accessors.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
+#include "relocation.h"
 
 static struct bio_set btrfs_bioset;
 
-- 
2.26.3

