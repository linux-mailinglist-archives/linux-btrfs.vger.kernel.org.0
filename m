Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3139060E8CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiJZTMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiJZTLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B266F9704
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so10687918qto.10
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plYBOVgyJmba5LGC9zNt+lPBeB+11BDVf3tSRo/8otI=;
        b=WmIgXCMSc1KBjthzc50fRpjGgTX09hByWEm6QGoAKiNkuU7scCMuz58fUTT6CubSPe
         wOen/la9sIBX8IaBdVZOUZrZrpO/klEEA00xNaTJjEmJl5qKhb8lPmMF5ESv67MbIDfd
         uu4iEwP/MbPVr/ntkCaj0iNDZ23pyCBq0ZvKiAtXs1dIiPQYyQ2om7Tj4E7VmixI1S94
         YeRoffLQaHgh2MbG+KhbygAmLn0ib9XQ41i/31MSJNXpgZBZ1J3Q50BiKJEZIbDhsS95
         g33H7X/be7ItFVRg/C/A4Ew/A4axHEzL2IEBsBvFFNYfDVNL8D00oW2MwwJxSjHAM1rN
         R8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plYBOVgyJmba5LGC9zNt+lPBeB+11BDVf3tSRo/8otI=;
        b=IPYr1LuQ8890//8tChxcdulho2592cHNxiESosJqVeRTqOox97l+6cJGG+diN7QF8b
         CWhvTjvtbuJetp2lRmcf+dWnFq+stizK5Vzdag2YwKfUP5pjQKFfB0vJX/YnBw/QZVTk
         jQOYwSd7q9Aq95K7iTPVNl0ccoCxBcwiKSrqu2mB8gEoLufu0N1YcnG5M8Gfj2PoSZWG
         e5Ddfn68i9MheOENOLiOi/D1FpdooPjNsdoMhoXGnZJositH9FpUWTFd50/Z6q8Kp82t
         A087COBDihtVlgsQu5eqrC0iDvQM8FRezyRGamqHvIZmahoxJEqHcu2zSOdlrltpiCiL
         /caQ==
X-Gm-Message-State: ACrzQf1h44y+dO79BucORUMt5bu8eIS0bQ8uctwOaElKvHd7sgAqOzac
        dgc6BzuyI/TXWyuw6It2T5aItC0JalXIAA==
X-Google-Smtp-Source: AMsMyM7IKTFBOAcPS8dCcWA5QlIYokTc+MQmd2IzP9xGTlVLw96AlY5w0mvFn818XYCF6jXNZ76D0Q==
X-Received: by 2002:a05:622a:1011:b0:3a4:ee8d:db13 with SMTP id d17-20020a05622a101100b003a4ee8ddb13mr4121298qte.85.1666811351770;
        Wed, 26 Oct 2022 12:09:11 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fp9-20020a05622a508900b0039a08c0a594sm3554196qtb.82.2022.10.26.12.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/26] btrfs: move scrub prototypes into scrub.h
Date:   Wed, 26 Oct 2022 15:08:35 -0400
Message-Id: <8a09d9153dcdcddf52e3145cc9463354246e8663.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into scrub.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 11 -----------
 fs/btrfs/dev-replace.c |  1 +
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/ioctl.c       |  1 +
 fs/btrfs/scrub.c       |  1 +
 fs/btrfs/scrub.h       | 16 ++++++++++++++++
 fs/btrfs/super.c       |  1 +
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/volumes.c     |  1 +
 9 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 fs/btrfs/scrub.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b1b6de508e20..f3facc10646c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -732,17 +732,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-/* scrub.c */
-int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
-		    u64 end, struct btrfs_scrub_progress *progress,
-		    int readonly, int is_dev_replace);
-void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
-void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
-int btrfs_scrub_cancel(struct btrfs_fs_info *info);
-int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
-int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
-			 struct btrfs_scrub_progress *progress);
-
 /* dev-replace.c */
 void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
 void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 94f8975034ce..84af2010fae2 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -25,6 +25,7 @@
 #include "block-group.h"
 #include "fs.h"
 #include "accessors.h"
+#include "scrub.h"
 
 /*
  * Device replace overview
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 215f95b90cc7..917594ff1786 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -50,6 +50,7 @@
 #include "defrag.h"
 #include "uuid-tree.h"
 #include "relocation.h"
+#include "scrub.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfbb0e328bb2..a254207f98d5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -59,6 +59,7 @@
 #include "uuid-tree.h"
 #include "ioctl.h"
 #include "file.h"
+#include "scrub.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e6f9916501f6..2c7053d20c14 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -24,6 +24,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
+#include "scrub.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
new file mode 100644
index 000000000000..52e39619e27c
--- /dev/null
+++ b/fs/btrfs/scrub.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_SCRUB_H
+#define BTRFS_SCRUB_H
+
+int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
+		    u64 end, struct btrfs_scrub_progress *progress,
+		    int readonly, int is_dev_replace);
+void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
+void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
+int btrfs_scrub_cancel(struct btrfs_fs_info *info);
+int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
+int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
+			 struct btrfs_scrub_progress *progress);
+
+#endif /* BTRFS_SCRUB_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2cd05246bcd3..4bfda9be4556 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -55,6 +55,7 @@
 #include "defrag.h"
 #include "dir-item.h"
 #include "ioctl.h"
+#include "scrub.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f7a1af84ae33..bc4b48d9787e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -33,6 +33,7 @@
 #include "uuid-tree.h"
 #include "ioctl.h"
 #include "relocation.h"
+#include "scrub.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index af58abf34462..7f4005d1c822 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -38,6 +38,7 @@
 #include "uuid-tree.h"
 #include "ioctl.h"
 #include "relocation.h"
+#include "scrub.h"
 
 static struct bio_set btrfs_bioset;
 
-- 
2.26.3

