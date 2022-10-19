Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E42604A24
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJSO6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiJSO5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:40 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50653317C0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z30so10810362qkz.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJlA6VltExscupToZ1JyaY3LksHw6pl6MumIg0yDP+o=;
        b=YMAMjrji/GXuq7vCcWhzSDxsAvbVcv2JaQULdoa2iz3ZjWcIw6YiGh9KsszJZ6c8uC
         7l0hCUbclQ36xrEDEbRaHZa2Jl8JRSoKBtsVQCJteb69yo2oNPDcdoKmIpECWicmh++6
         dW5rQAThFxK2doSDQFfiInYgBazAPwYi4YDfxge/1QG54o9Lw6hPdNbcC/cksQH+VqpY
         TRAxCCE6A5WDyVSr8pHF8Aq1kO05JeqSSUk8dIruC/BccG7ljUT2YRVxLEH95Rw4f1+q
         ESXp6fCoJaJA8zeWNxd1jlFzgZLJemPzyOLYtiY+gqlCA4SlBvUwMzE0cYzTxmOBxo/e
         QmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJlA6VltExscupToZ1JyaY3LksHw6pl6MumIg0yDP+o=;
        b=j/CSCzsOl1Cy8bWnK8HhqKe0W9VfvRu9+jCrahRhW2XqUmRl9BmJgVEcaC4hYH5TGH
         CMxhzW8MuEnso39/qyoVz8G04gZAmVob2pJM2RByUs/nB2jtooCzUxyMhuUjZ77Dxepq
         7WXWM3AgQp5ywzVV8f3YDbz2UT+kOpL1X/gR/VflRGiiXTsajHYgYrBP7+9c2tLUMmfo
         BHBSgFTWIvrNLHph12t65PcghFb6/kbMI4P0WcZx2fvCsXcBmHZZ6oi1PSafm0paCkOy
         OkqgOeFmDhTQu8UU1l5vXTXvKpBGNA6Czaw0L8FzWoTPt0K6jXOARCvAm1pDKX1NFu+6
         VJpQ==
X-Gm-Message-State: ACrzQf1XqoKSTa9yoUCUnEf6vxvtut6m717AdnNGJOwIUKC2lhydWIAC
        SA6HE0mNUnMFSYtsqdJjisC3HsfrLCER5w==
X-Google-Smtp-Source: AMsMyM6vS2JTPvReH3pTNmk69jXMrwvsQ7+mxt6OaUAmbkAWbqVKT4zVFwWGhzyuWuwacTXhswRt0w==
X-Received: by 2002:a05:620a:440d:b0:6ce:c800:c319 with SMTP id v13-20020a05620a440d00b006cec800c319mr5976277qkp.331.1666191081124;
        Wed, 19 Oct 2022 07:51:21 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i11-20020ac85e4b000000b0039cb59f00fcsm4297618qtx.30.2022.10.19.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 13/15] btrfs: move btrfs_map_token to accessors
Date:   Wed, 19 Oct 2022 10:50:59 -0400
Message-Id: <1eb9a18b17e156ae04b5df664f431e212b1cb02f.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

This is specific to the item-accessor code, move it out of ctree.h into
accessor.h/.c and then update the users to include the new header file.
This un-inline's btrfs_init_map_token, however this is only called once
per function.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.c |  9 +++++++++
 fs/btrfs/accessors.h | 15 +++++++++++++++
 fs/btrfs/ctree.c     |  1 +
 fs/btrfs/ctree.h     | 16 ++--------------
 fs/btrfs/inode.c     |  1 +
 fs/btrfs/tree-log.c  |  1 +
 6 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 fs/btrfs/accessors.h

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 6ba16c018d7f..a9ad217f598d 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -7,6 +7,7 @@
 
 #include "messages.h"
 #include "ctree.h"
+#include "accessors.h"
 
 static bool check_setget_bounds(const struct extent_buffer *eb,
 				const void *ptr, unsigned off, int size)
@@ -24,6 +25,14 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 	return true;
 }
 
+void btrfs_init_map_token(struct btrfs_map_token *token,
+			  struct extent_buffer *eb)
+{
+	token->eb = eb;
+	token->kaddr = page_address(eb->pages[0]);
+	token->offset = 0;
+}
+
 /*
  * Macro templates that define helpers to read/write extent buffer data of a
  * given size, that are also used via ctree.h for access to item members by
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
new file mode 100644
index 000000000000..8cc51814791a
--- /dev/null
+++ b/fs/btrfs/accessors.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_ITEM_ACCESSORS_H
+#define BTRFS_ITEM_ACCESSORS_H
+
+struct btrfs_map_token {
+	struct extent_buffer *eb;
+	char *kaddr;
+	unsigned long offset;
+};
+
+void btrfs_init_map_token(struct btrfs_map_token *token,
+			  struct extent_buffer *eb);
+
+#endif /* BTRFS_ITEM_ACCESSORS_H */
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8ba72009bacb..01c5b021ee1f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -19,6 +19,7 @@
 #include "tree-mod-log.h"
 #include "tree-checker.h"
 #include "fs.h"
+#include "accessors.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2570116aac88..caa58a404fc8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -51,6 +51,8 @@ struct btrfs_balance_control;
 struct btrfs_delayed_root;
 struct reloc_control;
 
+struct btrfs_map_token;
+
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
@@ -1191,23 +1193,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-struct btrfs_map_token {
-	struct extent_buffer *eb;
-	char *kaddr;
-	unsigned long offset;
-};
-
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sectorsize_bits)
 
-static inline void btrfs_init_map_token(struct btrfs_map_token *token,
-					struct extent_buffer *eb)
-{
-	token->eb = eb;
-	token->kaddr = page_address(eb->pages[0]);
-	token->offset = 0;
-}
-
 /* some macros to generate set/get functions for the struct fields.  This
  * assumes there is a lefoo_to_cpu for every type, so lets make a simple
  * one for u8:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c9e0ebcad0ef..1074871542fb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -56,6 +56,7 @@
 #include "subpage.h"
 #include "inode-item.h"
 #include "fs.h"
+#include "accessors.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e911139fd2d3..823fbd826944 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -22,6 +22,7 @@
 #include "zoned.h"
 #include "inode-item.h"
 #include "fs.h"
+#include "accessors.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

