Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFD560E8CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiJZTMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiJZTLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:41 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD9DBBD1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cr19so10746935qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxtLu7rOWf4YatZY9mq5Cvs8QlJ+/d7F9DqDLXes5lM=;
        b=v6TljkC8agFynjLlBJ+09AW5y4TwWMbDzvCVfP6JwZZ8MZJN5EwHjq7pph8QR7KTuv
         QEILrQ1km5l/coFo1wPJfJiVTuI/ezJWow9DV58Hcpp50QiQGzofm3uPx73G1a1BpQ8p
         LrGBzx+ru2whZpq7dVLXvHNnzyl9Q3boTU3xmlBlkYdgjG4KSk90hnzMu8R1wiC5vdAZ
         81N2eZ3j2E6SbxFQSys3IdoiAUG6a5A0VPtshDD/WiitILnfAQ5dcMd4NogwYVftoHkA
         CsFXZif7JzmkHP/5sVmBNMRkbOD67PuHkpaBXNq2fr2CRE3oatSRqEoVe7Ug3AJVYVnP
         mC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxtLu7rOWf4YatZY9mq5Cvs8QlJ+/d7F9DqDLXes5lM=;
        b=Wf/u9juS0iqtMnNzKn4C2M7hLugOlq9+GfFO2xCsHXFrtjxIS1NPRxNnObDMdHoWjP
         0sgfKL8NXVVVo06HeZmyUJCCXi19CEAayDF4lJK4Wl0EZbk7G2S4q2whn4dznNU/RsAL
         l+m7Ln0XJq4j2LnCx+Xh+DXyQdfnScpGXK0xJD9SwVjug1/ZwwPlwZdT8EYoJ4aDuhT+
         zcIb2w8v2q1vANTB+ino+d2uDg3LDkFu6/Lh2hkEFKT4Wmo5dq12QZZjDU86bFdTL6HR
         ulILD2wiuQjLThzNPaVUz5T/2vwPAF9gR6i+1jMmj+cMljyZUeQnidBILI6yZ4NTyqWO
         R8bw==
X-Gm-Message-State: ACrzQf1tydlI9u04W5tdcL/YmHmvfOQRPecADSgAW9W5Mkhy6ZKLhaDU
        qpgNkTcVzHDrrT3XqQiboYAt8KJ0Yyub8w==
X-Google-Smtp-Source: AMsMyM4xf0Tcz7lL3ZFhffQqXAWlmm8hETO+RBpHup81wabWc/iNOKY8Nrn9AgqE1wbifN0BwZ1LQw==
X-Received: by 2002:a05:622a:488:b0:39c:f823:1539 with SMTP id p8-20020a05622a048800b0039cf8231539mr37828526qtx.78.1666811354691;
        Wed, 26 Oct 2022 12:09:14 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b006eeae49537bsm4252858qki.98.2022.10.26.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/26] btrfs: move verity prototypes into verity.h
Date:   Wed, 26 Oct 2022 15:08:37 -0400
Message-Id: <13e4b83f430478460fcee9eb6e4ab160346fb0d5.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into verity.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h  | 22 ----------------------
 fs/btrfs/inode.c  |  1 +
 fs/btrfs/send.c   |  1 +
 fs/btrfs/super.c  |  1 +
 fs/btrfs/verity.c |  1 +
 fs/btrfs/verity.h | 27 +++++++++++++++++++++++++++
 6 files changed, 31 insertions(+), 22 deletions(-)
 create mode 100644 fs/btrfs/verity.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 84bc33ff003f..15bb90536460 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -741,28 +741,6 @@ static inline int is_fstree(u64 rootid)
 	return 0;
 }
 
-/* verity.c */
-#ifdef CONFIG_FS_VERITY
-
-extern const struct fsverity_operations btrfs_verityops;
-int btrfs_drop_verity_items(struct btrfs_inode *inode);
-int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size);
-
-#else
-
-static inline int btrfs_drop_verity_items(struct btrfs_inode *inode)
-{
-	return 0;
-}
-
-static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
-					      size_t buf_size)
-{
-	return -EPERM;
-}
-
-#endif
-
 /* Sanity test specific functions */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 void btrfs_test_destroy_inode(struct inode *inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fd733fc3c583..6a172ccd7847 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -67,6 +67,7 @@
 #include "file.h"
 #include "acl.h"
 #include "relocation.h"
+#include "verity.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 1ee8149c0440..50063ac83830 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -31,6 +31,7 @@
 #include "dir-item.h"
 #include "file-item.h"
 #include "ioctl.h"
+#include "verity.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4bfda9be4556..ae49bdf71d32 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -56,6 +56,7 @@
 #include "dir-item.h"
 #include "ioctl.h"
 #include "scrub.h"
+#include "verity.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 00ba5143a17d..b31d6c7627ff 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -19,6 +19,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "ioctl.h"
+#include "verity.h"
 
 /*
  * Implementation of the interface defined in struct fsverity_operations.
diff --git a/fs/btrfs/verity.h b/fs/btrfs/verity.h
new file mode 100644
index 000000000000..960ce3556b33
--- /dev/null
+++ b/fs/btrfs/verity.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_VERITY_H
+#define BTRFS_VERITY_H
+
+#ifdef CONFIG_FS_VERITY
+
+extern const struct fsverity_operations btrfs_verityops;
+int btrfs_drop_verity_items(struct btrfs_inode *inode);
+int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size);
+
+#else
+
+static inline int btrfs_drop_verity_items(struct btrfs_inode *inode)
+{
+	return 0;
+}
+
+static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
+					      size_t buf_size)
+{
+	return -EPERM;
+}
+
+#endif /* CONFIG_FS_VERITY */
+
+#endif /* BTRFS_VERITY_H */
-- 
2.26.3

