Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628C60E8CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiJZTMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiJZTLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC711102536
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d13so11384463qko.5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DVsOFHF9exduGMuGNZtUfDS2WzyjDxNQEPNceICI38=;
        b=z/OQMTmdePbJoMm/hm0qH356m9ZZWTby8ep2IS0TfpkWznUfo/MwktHDy7UBgCHklh
         rqx5znZrTF+xNbt5EqTMgpN1/h1/XaWNtEi6V1vwLsZcvBCgPfm+P/vm8c4B8+5v5m9B
         V6BhZhMeW+HeeRrMDuvucfTDwFJgRb84w7hs2cEFKY+2io+Cn3k7kBHWME9vocTp4gv2
         12mp9P0JA8t9RerhgemnYsfxiAm/nUPVaGNzLAqVkTPRZqF6XHTQf/X9TxSDuAZAMqaB
         Jzei0pK1c3+PVQje1a494Dpwp3nQFsmaROdKwp1Mkzr4MaIvN3+ZFJEQYJ+RqVMzNkhx
         3dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DVsOFHF9exduGMuGNZtUfDS2WzyjDxNQEPNceICI38=;
        b=lhCtZ+N7gDCm2Hd/AWzR3M1g4jzyTvt3mK07jypvRG8L5Voxnw+bhGRaJlpsEFYBdq
         Z1curCAqKYb5Lo/Z0zJaWb/wR+ifsXN563+6+9fzt7CdYn7BjYz9UWi1mh1Zz2MV3iSH
         fjuQKMKghFnVWhsGutRvPjpgqZ+8cs/pYgztwXXAkpC0sYbxxxVaQlOGB1XwDjaKm459
         ykwYVobxWadAfKvddOy4OWk2vdqUQIt16++fe2yVNhbNRcLAzEQjvw4JXbgaHDE2fInH
         GJX3fuhEm0Or+DrEtrIzMCnss6V79hpyFoqShDeyL4KkxRGS6wfry2kKOnd04rECT11o
         97Dg==
X-Gm-Message-State: ACrzQf0zfqVEUhwrTdlP5kYVXdTD5w662AjrUvf2x5miCCut5GhpCKrC
        +eUqaYK1D7w1bq0YGXvjKJHf2KzdyiJyxg==
X-Google-Smtp-Source: AMsMyM6uml7oXUwyYn3N7OaTJV153cAbYXOSZZSdMQZvmxa6xaFCvNfICQffi02GQvdTQl3o/htLIw==
X-Received: by 2002:a37:8987:0:b0:6f9:9f1a:aee3 with SMTP id l129-20020a378987000000b006f99f1aaee3mr2053103qkd.478.1666811360686;
        Wed, 26 Oct 2022 12:09:20 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fz9-20020a05622a5a8900b00398426e706fsm3544478qtb.65.2022.10.26.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/26] btrfs: move orphan prototypes into orphan.h
Date:   Wed, 26 Oct 2022 15:08:41 -0400
Message-Id: <839fac08903cd0fea21bb8dacb2506332bae03c7.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into orphan.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  6 ------
 fs/btrfs/extent-tree.c |  1 +
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/orphan.h      | 11 +++++++++++
 fs/btrfs/root-tree.c   |  1 +
 fs/btrfs/tree-log.c    |  1 +
 fs/btrfs/verity.c      |  1 +
 7 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 fs/btrfs/orphan.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c32f6b6ae972..5649f8907984 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -676,12 +676,6 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 }
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
 
-/* orphan.c */
-int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root, u64 offset);
-int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root, u64 offset);
-
 /*
  * Get the correct offset inside the page of extent buffer.
  *
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 940d4fe23cfb..b037107678c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -41,6 +41,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "file-item.h"
+#include "orphan.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef0bf2e070ed..56ec304e2c6a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -69,6 +69,7 @@
 #include "relocation.h"
 #include "verity.h"
 #include "super.h"
+#include "orphan.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/orphan.h b/fs/btrfs/orphan.h
new file mode 100644
index 000000000000..8ec7a4bcca56
--- /dev/null
+++ b/fs/btrfs/orphan.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_ORPHAN_H
+#define BTRFS_ORPHAN_H
+
+int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root, u64 offset);
+int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root, u64 offset);
+
+#endif /* BTRFS_ORPHAN_H */
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 09175ffc143a..8efb8a91bf31 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -16,6 +16,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "root-tree.h"
+#include "orphan.h"
 
 /*
  * Read a root item from the tree. In case we detect a root item smaller then
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b014e6946534..3e91451fd8f1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -28,6 +28,7 @@
 #include "dir-item.h"
 #include "file-item.h"
 #include "file.h"
+#include "orphan.h"
 
 #define MAX_CONFLICT_INODES 10
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b31d6c7627ff..bf9eb693a6a7 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -20,6 +20,7 @@
 #include "accessors.h"
 #include "ioctl.h"
 #include "verity.h"
+#include "orphan.h"
 
 /*
  * Implementation of the interface defined in struct fsverity_operations.
-- 
2.26.3

