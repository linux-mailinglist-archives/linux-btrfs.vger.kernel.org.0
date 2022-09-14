Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492565B8E0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiINRS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiINRSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195C8274E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m9so12260173qvv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=89iGh0PzaDU4P370m++sUNiVz7WWMGu42jP3BZhwMBA=;
        b=MrR7byOMvKn1tTORv20S6Nv+E13ualYNPaa51JaplDMV9i/isYAbWXuLzi7a7qEbHU
         HV2OhxTPG8xPYrzzRqTQwKRV+5OsSnHjeZFW4o/S/9wl0gQqChdwb7VEye1TMnBX8I/m
         R1DRw/wqWkJ89lRNi0qLKPpbbzwzTumclqkMuaAyITrSKFDvxZXcrsJYghrgrUAbPrjE
         7UuFQmH0hEFsFVwXEOPBptqLGirgSBr0U9gpU8E49zETWAMWoM4RrdslrLHt9Y6GzARz
         xPrWEfzaJMwxNj3N4g+Gok6G3W8rmnUAnUG7iApWO1hi/7/cG6zqc5XAVHwmsDi04o+I
         ABEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=89iGh0PzaDU4P370m++sUNiVz7WWMGu42jP3BZhwMBA=;
        b=D24/s1dn5cD9cdehPX6VFCRYw5Sr4BiW51GqGiMLUedqe1fAsysk1rxjeWxzMi+uoE
         f5t9L1n30pJ0mMZ7xSw9opBomSSFcMl0CR1rUxS1Byv0bUUCMGZ8myUHyQGkL4BWYPUT
         QYCSGvvWmA+lc1uGpjU4GWG/8l+msmNLoXqDGk69m3WHakrCdVUODXTBqgAk3sZxy5F1
         exOH+v8SjljkiyR57kinCeArZ4zEce1uVCGkhmpyk6w7PkuxRpumxaiUJEHoYpgowgoL
         VHvsx57sqFonJ8le68Afo1XHcMBqZBIEU7aJvJTJBk8GfJPyeOdiKAn6iSgcMqtM/052
         HOjA==
X-Gm-Message-State: ACgBeo306B6UuCiibwAhnWyYhshOsugF31ykzhkVhLL0tzAUCiwQqjGt
        UkIFS5okor/PWCTWicaSUoe9J7WcDs6k1A==
X-Google-Smtp-Source: AA6agR7T8Qv8HO4JQwrJqr/XhAO2WiENE1XwdDBvPIJzF7KPT9KGlrqJzs7Y9Ad3M4fo1QjooOov4Q==
X-Received: by 2002:a05:6214:cab:b0:4a7:3c1a:a4d7 with SMTP id s11-20020a0562140cab00b004a73c1aa4d7mr31799437qvs.50.1663175924078;
        Wed, 14 Sep 2022 10:18:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y6-20020a05620a25c600b006ccc96c78easm2384072qko.134.2022.09.14.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/16] btrfs: move btrfs_map_token to item-accessors
Date:   Wed, 14 Sep 2022 13:18:20 -0400
Message-Id: <980fa7926d0aa651c42a4ff4e58c0d644d712b7e.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is specific to the item-accessor code, move it out of ctree.h into
item-accessor.h/.c and then update the users to include the new header
file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c          |  1 +
 fs/btrfs/ctree.h          | 16 ++--------------
 fs/btrfs/inode.c          |  1 +
 fs/btrfs/item-accessors.c |  9 +++++++++
 fs/btrfs/item-accessors.h | 14 ++++++++++++++
 fs/btrfs/tree-log.c       |  1 +
 6 files changed, 28 insertions(+), 14 deletions(-)
 create mode 100644 fs/btrfs/item-accessors.h

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a5fd4e2369f1..de01c892a885 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -19,6 +19,7 @@
 #include "tree-mod-log.h"
 #include "tree-checker.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b6e86c1bc4b2..324400c5597f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -46,6 +46,8 @@ struct btrfs_ref;
 struct btrfs_bio;
 struct btrfs_ioctl_encoded_io_args;
 
+struct btrfs_map_token;
+
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
@@ -1174,23 +1176,9 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
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
index a6615106002a..ca6fa9b01785 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -56,6 +56,7 @@
 #include "subpage.h"
 #include "inode-item.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/item-accessors.c b/fs/btrfs/item-accessors.c
index ec6b0436d09a..7edb59ba99fc 100644
--- a/fs/btrfs/item-accessors.c
+++ b/fs/btrfs/item-accessors.c
@@ -7,6 +7,7 @@
 
 #include "btrfs-printk.h"
 #include "ctree.h"
+#include "item-accessors.h"
 
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
diff --git a/fs/btrfs/item-accessors.h b/fs/btrfs/item-accessors.h
new file mode 100644
index 000000000000..1f40aa503047
--- /dev/null
+++ b/fs/btrfs/item-accessors.h
@@ -0,0 +1,14 @@
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
+#endif /* BTRFS_ITEM_ACCESSORS_H */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 90cc8a97c13b..8818a2b19192 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -22,6 +22,7 @@
 #include "zoned.h"
 #include "inode-item.h"
 #include "fs.h"
+#include "item-accessors.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

