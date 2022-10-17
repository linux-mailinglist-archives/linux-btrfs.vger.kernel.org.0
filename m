Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BF601704
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJQTJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJQTJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB215734
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:36 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z30so7259948qkz.13
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRVkKEAreGxSDxoqPufTKzxBkahLUDhqxHlL9+eXNK0=;
        b=bGdHH/TQX2dk5TJrkV6nTMZqjb2oH7rYQSK2Ik1lrHIn0ttOC5lERzMKGoGuXlYrj0
         FiRgzZWKgXw94SzVsTl2XYSkfPsk8YAgL54w9Bydocvzgrqq/fMcA/XVR+tyUZmRIqAZ
         qASRfNcL/2MsfqMdNRpCOkCuzhA2uHbaHUMvFeCBjWjcnWHTwcIRf5MwMGF7Lsl++W0u
         rNbS8gl8TOsf+guN0JPYW+0ngEvz8vz93gXJbQB1A5KPMtjT6fOIH6AL/UEB28X+FVsy
         2xu5EtBAs0zk0idcl45+qrqWKIbzYMZe4G+WMaCNv7jrhGas58HWYJjpPuwnLGkfoRTp
         sciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRVkKEAreGxSDxoqPufTKzxBkahLUDhqxHlL9+eXNK0=;
        b=u3Eaa1eDVRAtRksM7ll27FfAQ9lD9Z9Kjn/Glcl+AyZUL1ZS0yJowIo5G5AwjRKj8q
         yMglIHr3/oJ96NWv3DhH8Ryf8RwFZ6dBKO9yJinHC1aOOg5rTkBnM9rtkOpLDxoxwWYH
         TCvLp9DyDmV9AafAUaedtFEGQtV0IFwxGI7FJLOa25oDPxGCxfCWLM+VT6676Uz9C3ra
         bNHZQmCB2EURUJmxC/r8EX0AEjKBD6lk7UuHuM9uEOJehKWkh9GcvsOG1hzoKnMGRIY5
         jdsYh0Tn0CooYJKThWIvyH13qBX3+KoC+ae+WqsHs1OJbFBFVVBOPZSLNveedKQcr7Wl
         892Q==
X-Gm-Message-State: ACrzQf2imu48lgcgMzttxJtj5kYc0K0X8fvag7TTbs+cqwjG4xYb6TgW
        Pg1Qc4QBbLrYg9MlwsxjR0H0OVK2O2NomQ==
X-Google-Smtp-Source: AMsMyM6t1opO5u5E6oOPpP1I3iDqJLqAEvkK9Ko0CH/FvdthaO+L3LL9GIM3Ac3RCYK5+gCVKMyRIA==
X-Received: by 2002:a05:620a:1250:b0:6ee:8d19:d6de with SMTP id a16-20020a05620a125000b006ee8d19d6demr8791869qkl.669.1666033775581;
        Mon, 17 Oct 2022 12:09:35 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t12-20020ac8588c000000b0039cd4d87aacsm478007qta.15.2022.10.17.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/16] btrfs: move btrfs_map_token to accessors
Date:   Mon, 17 Oct 2022 15:09:11 -0400
Message-Id: <b46b06ce5126d8f3a16027dedc6aaa83fd31e110.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.c |  9 +++++++++
 fs/btrfs/accessors.h | 14 ++++++++++++++
 fs/btrfs/ctree.c     |  1 +
 fs/btrfs/ctree.h     | 16 ++--------------
 fs/btrfs/inode.c     |  1 +
 fs/btrfs/tree-log.c  |  1 +
 6 files changed, 28 insertions(+), 14 deletions(-)
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
index 000000000000..1f40aa503047
--- /dev/null
+++ b/fs/btrfs/accessors.h
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

