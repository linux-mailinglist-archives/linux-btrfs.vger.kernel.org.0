Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925F760E8CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiJZTMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiJZTLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55120FE930
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z30so11354714qkz.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpZq0+z0PAwW3zpfdF1sbpMYA/2f17N3tEnRTajRLP4=;
        b=XEVraDHaNwTmEWF5UbfunqydZXVe6aWm68LjCMHFV9ocxQtdx0q+IKH84Ra3hEIXoe
         /KCgTadShHzN4wtJ8DDrN+9feY4BIn2oUTEhst739Rle75BHfs/u2VSD0yexds1EYloY
         0XpdNPOvEIc/BiC61BPq0rvtyP+5JR+5Gj9X+8ZlQ99m/Hf3Qc2I4co0n1eLYpFlMvoo
         SPmpe2m/rdoHT9Hwn2079nb7y7Z92amypcsY7Ad4xYOMxQRUQJrNZgt6kO7jhf+/VknK
         vRmG+9Tjjzns+OVJVzp8B4sEMVHBNDQb5hmyO5OH9mAkk1J5w2r5vk7YoEeDb3zVmkZd
         5ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpZq0+z0PAwW3zpfdF1sbpMYA/2f17N3tEnRTajRLP4=;
        b=u+kvwppU3zjGrN6c8p1jASCOuShIInqE5tzZhjNOIjtXl5OC9/Gk4DSi+RnexwcM0i
         p3kMC0cu6ZN5BFoRrcZzaIRBKa9OOIjolZ5C/dXLPYgMsI9hM3SXl702TJg8WGc5OiVT
         WX0WLVcHge7SvQ+a1PvDUEFZKhjGVMncWDoht/X3UaCqANTkhHA4aaRil3zlSu2r36XD
         3xnJ2gsUamssOvQQ18IQUWaE5AOc1P5UoKf5x4WtsYwUuP6ld2ahI9EcpTLwvH6+YWak
         nKPeXSLPQfT4twe96bRMLc5ao/Y+4snOnbC+wKoRu3VNRCDKsK/cChcMIVZp1h+VBuDQ
         +QjA==
X-Gm-Message-State: ACrzQf34hYFzL0jd4zPU4YWrki1UJ5dfCBkvClUA0pUP0SlCEWDDn9UT
        Q0vC5H3/RWC0ANG5KR96e36EeBIVfUaPIA==
X-Google-Smtp-Source: AMsMyM4BD0C6Dq5WrD5CfdEWsjXxTr0ApkMvaWroiUQJyw7y4lJ4B0dRjzDDlzcmAAZj1CZeaotCXA==
X-Received: by 2002:a05:620a:191c:b0:6ed:88c5:e839 with SMTP id bj28-20020a05620a191c00b006ed88c5e839mr32679770qkb.627.1666811357673;
        Wed, 26 Oct 2022 12:09:17 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006bb2cd2f6d1sm4242698qke.127.2022.10.26.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/26] btrfs: move super prototypes into super.h
Date:   Wed, 26 Oct 2022 15:08:39 -0400
Message-Id: <c0794bdde20ee17cc6badcf059a1b870f5b470f1.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into super.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   |  7 -------
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/ioctl.c   |  1 +
 fs/btrfs/super.c   |  1 +
 fs/btrfs/super.h   | 12 ++++++++++++
 5 files changed, 15 insertions(+), 7 deletions(-)
 create mode 100644 fs/btrfs/super.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 27bfedf3a9fb..c32f6b6ae972 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -682,13 +682,6 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
 
-/* super.c */
-int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
-			unsigned long new_flags);
-int btrfs_sync_fs(struct super_block *sb, int wait);
-char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
-					  u64 subvol_objectid);
-
 /*
  * Get the correct offset inside the page of extent buffer.
  *
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 917594ff1786..5c099d046170 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -51,6 +51,7 @@
 #include "uuid-tree.h"
 #include "relocation.h"
 #include "scrub.h"
+#include "super.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a254207f98d5..da0147d3cb5d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -60,6 +60,7 @@
 #include "ioctl.h"
 #include "file.h"
 #include "scrub.h"
+#include "super.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ae49bdf71d32..d54bfec8e506 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -57,6 +57,7 @@
 #include "ioctl.h"
 #include "scrub.h"
 #include "verity.h"
+#include "super.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
new file mode 100644
index 000000000000..04e28aa01f8a
--- /dev/null
+++ b/fs/btrfs/super.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_SUPER_H
+#define BTRFS_SUPER_H
+
+int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
+			unsigned long new_flags);
+int btrfs_sync_fs(struct super_block *sb, int wait);
+char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
+					  u64 subvol_objectid);
+
+#endif /* BTRFS_SUPER_H */
-- 
2.26.3

