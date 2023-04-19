Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A56E8344
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDSVRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDSVRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776D4EE3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dd8so959391qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939045; x=1684531045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFFaX60skZLvb/H5t5wGCjQZF9PslGWVWS6CF85ozQc=;
        b=5aGGk+Yz2gD9Td0KYWdDHR/Nkf76GvFsp78OQPq6Q37EsW34Jy2LFiVHUEeYOLW0g/
         6q9FKT6KMDuB5WC48VxIGya1yq+kSvNarcKyTr8OwFXLQ9GtMwDBCE48HVvjynfGu301
         SCsn/UtBKcFiynrqGYS0nUUTl89ObLtxuJOwza02lil5NAhtyZY6jDbt0sISdW6aulN0
         8ose17AHE7sCxtPjR9/CkLreEVEh1yqI/NDxAnrzEPIrFvcWDzL8ROyUaoa5tbSLk7Gm
         ys6jdn0cI2a3wFGwviO3F9MHLDTxDlgtbgzPmQccas+tt9lyOFlehCiZX/X6TiMrSOVO
         QAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939045; x=1684531045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFFaX60skZLvb/H5t5wGCjQZF9PslGWVWS6CF85ozQc=;
        b=Nmgo5+6XeVx5B0ZAVBdmtnxFG55CuhxQNRnqG75UImxlSaxcRv2IAUh5Hgz1GvG7/L
         VowKQMejOvgTKBNgp2Fm/xsROT98zFKt6cDhta+bDeFSdVgffpIxG5luBsPCgze/5FPg
         zozE2nFuQhqSjlC9fGWkuzyV8yI/Bvlk/dznHxOFdR6E95rEdb6XsUdf2ra6MK7iFdU1
         XCjeVS/+9EW1omiU870fpAyd6560s/oG5/yLz8ewSOru3DZhCJvK6JLGk2juqMDaU9tO
         P3qRCbne4wijPf4FWE4S+YtDYH7Pm46HqDqkJ4Kfzwl5SjiII8TbblZlkI2iB6uQyzML
         afEQ==
X-Gm-Message-State: AAQBX9e/DM/EqKtQ1PmtO2Pfxg0hV3Zgge+8I9Cv5a3r7VyNvq242iIz
        rHoJg4nmuWohViyWbieUyi5PN5Dg/pB/BlgkMEOhUw==
X-Google-Smtp-Source: AKy350asToS4bqs1UgnPWBJl7gQs0Xq1tTkoVpDbEfZ07CSlVT8DB+sIFsvWcgFBYkCkukiFsV7DRg==
X-Received: by 2002:a05:6214:1bcd:b0:5ef:423b:1f4c with SMTP id m13-20020a0562141bcd00b005ef423b1f4cmr30875812qvc.50.1681939044689;
        Wed, 19 Apr 2023 14:17:24 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v8-20020a0ccd88000000b005dd8b9345d7sm4607846qvm.111.2023.04.19.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs-progs: sync uapi/btrfs.h into btrfs-progs
Date:   Wed, 19 Apr 2023 17:17:12 -0400
Message-Id: <93f8af4b6a6164504f0aeb1221d57c59673f6df5.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
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

We want to keep this file locally as we want to be uptodate with
upstream, so we can build btrfs-progs regardless of which kernel is
currently installed.  Sync this with the upstream version and put it in
kernel-shared/uapi to maintain some semblance of where this file comes
from.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 btrfs-fragments.c                             |   2 +-
 check/main.c                                  |   2 +-
 cmds/balance.c                                |   2 +-
 cmds/device.c                                 |   2 +-
 cmds/filesystem-usage.h                       |   2 +-
 cmds/filesystem.c                             |   2 +-
 cmds/inspect.c                                |   2 +-
 cmds/property.c                               |   2 +-
 cmds/qgroup.c                                 |   2 +-
 cmds/qgroup.h                                 |   2 +-
 cmds/quota.c                                  |   2 +-
 cmds/receive.c                                |   2 +-
 cmds/replace.c                                |   2 +-
 cmds/rescue-chunk-recover.c                   |   2 +-
 cmds/scrub.c                                  |   2 +-
 cmds/send.c                                   |   2 +-
 cmds/subvolume-list.c                         |   2 +-
 cmds/subvolume.c                              |   2 +-
 common/device-scan.c                          |   2 +-
 common/device-scan.h                          |   2 +-
 common/fsfeatures.c                           |   2 +-
 common/send-stream.c                          |   2 +-
 common/send-utils.c                           |   2 +-
 common/utils.c                                |   2 +-
 common/utils.h                                |   2 +-
 convert/common.c                              |   2 +-
 image/main.c                                  |   2 +-
 include/kerncompat.h                          |   1 +
 kernel-shared/ctree.h                         |   2 +-
 include/ioctl.h => kernel-shared/uapi/btrfs.h | 566 ++++++++++--------
 mkfs/common.c                                 |   2 +-
 tests/ioctl-test.c                            |   2 +-
 tune/change-metadata-uuid.c                   |   2 +-
 tune/change-uuid.c                            |   2 +-
 34 files changed, 365 insertions(+), 266 deletions(-)
 rename include/ioctl.h => kernel-shared/uapi/btrfs.h (72%)

diff --git a/btrfs-fragments.c b/btrfs-fragments.c
index df8ad352..970b49e5 100644
--- a/btrfs-fragments.c
+++ b/btrfs-fragments.c
@@ -31,7 +31,7 @@
 #include <gd.h>
 #include "kernel-shared/ctree.h"
 #include "common/utils.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int use_color;
 static void
diff --git a/check/main.c b/check/main.c
index 467c8a57..b5748d85 100644
--- a/check/main.c
+++ b/check/main.c
@@ -61,7 +61,7 @@
 #include "check/mode-lowmem.h"
 #include "check/qgroup-verify.h"
 #include "check/clear-cache.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 /* Global context variables */
 struct btrfs_fs_info *gfs_info;
diff --git a/cmds/balance.c b/cmds/balance.c
index 2fc38164..d7f5cde4 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -33,7 +33,7 @@
 #include "common/messages.h"
 #include "common/help.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static const char * const balance_cmd_group_usage[] = {
 	"btrfs balance <command> [options] <path>",
diff --git a/cmds/device.c b/cmds/device.c
index ec70bb33..38b1d692 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -41,7 +41,7 @@
 #include "cmds/commands.h"
 #include "cmds/filesystem-usage.h"
 #include "mkfs/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static const char * const device_cmd_group_usage[] = {
 	"btrfs device <command> [<args>]",
diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
index 902c3384..2c0db9dc 100644
--- a/cmds/filesystem-usage.h
+++ b/cmds/filesystem-usage.h
@@ -20,7 +20,7 @@
 #define __CMDS_FI_USAGE_H__
 
 #include "kerncompat.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct device_info {
 	u64	devid;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index c3c6ee3e..2a2c9a8a 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -57,7 +57,7 @@
 #include "common/format-output.h"
 #include "cmds/commands.h"
 #include "cmds/filesystem-usage.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 /*
  * for btrfs fi show, we maintain a hash of fsids we've already printed.
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 20f433b9..d610b906 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -43,7 +43,7 @@
 #include "common/string-utils.h"
 #include "common/string-table.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static const char * const inspect_cmd_group_usage[] = {
 	"btrfs inspect-internal <command> <args>",
diff --git a/cmds/property.c b/cmds/property.c
index e4cb3037..0883be99 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -38,7 +38,7 @@
 #include "common/filesystem-utils.h"
 #include "cmds/commands.h"
 #include "cmds/props.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define XATTR_BTRFS_PREFIX     "btrfs."
 #define XATTR_BTRFS_PREFIX_LEN (sizeof(XATTR_BTRFS_PREFIX) - 1)
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index ab4e9ecf..e53f3934 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -39,7 +39,7 @@
 #include "common/messages.h"
 #include "cmds/commands.h"
 #include "cmds/qgroup.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define BTRFS_QGROUP_NFILTERS_INCREASE (2 * BTRFS_QGROUP_FILTER_MAX)
 #define BTRFS_QGROUP_NCOMPS_INCREASE (2 * BTRFS_QGROUP_COMP_MAX)
diff --git a/cmds/qgroup.h b/cmds/qgroup.h
index 69b8c11f..db48c0c2 100644
--- a/cmds/qgroup.h
+++ b/cmds/qgroup.h
@@ -20,7 +20,7 @@
 #define __CMDS_QGROUP_H__
 
 #include "kerncompat.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct btrfs_qgroup_info {
 	u64 generation;
diff --git a/cmds/quota.c b/cmds/quota.c
index 0178a242..3559290c 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -27,7 +27,7 @@
 #include "common/open-utils.h"
 #include "common/messages.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static const char * const quota_cmd_group_usage[] = {
 	"btrfs quota <command> [options] <path>",
diff --git a/cmds/receive.c b/cmds/receive.c
index ef40d91c..83fedb7e 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -55,7 +55,7 @@
 #include "common/string-utils.h"
 #include "cmds/commands.h"
 #include "cmds/receive-dump.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct btrfs_receive
 {
diff --git a/cmds/replace.c b/cmds/replace.c
index 2748b7fb..ebe366e8 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -39,7 +39,7 @@
 #include "common/messages.h"
 #include "cmds/commands.h"
 #include "mkfs/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int print_replace_status(int fd, const char *path, int once);
 static char *time2string(char *buf, size_t s, __u64 t);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 6a1b6734..728f7194 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -37,7 +37,7 @@
 #include "common/utils.h"
 #include "cmds/rescue.h"
 #include "check/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct recover_control {
 	int verbose;
diff --git a/cmds/scrub.c b/cmds/scrub.c
index 4e64ccfc..3cef08b7 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -51,7 +51,7 @@
 #include "common/units.h"
 #include "common/help.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static unsigned unit_mode = UNITS_DEFAULT;
 
diff --git a/cmds/send.c b/cmds/send.c
index caddb6dd..829d9d8c 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -35,7 +35,7 @@
 #include "common/string-utils.h"
 #include "common/messages.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define BTRFS_SEND_BUF_SIZE_V1	(SZ_64K)
 #define BTRFS_MAX_COMPRESSED	(SZ_128K)
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index e0a7b339..82204e3e 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -35,7 +35,7 @@
 #include "common/string-utils.h"
 #include "common/utils.h"
 #include "cmds/commands.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 /*
  * Naming of options:
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 8bb21f9f..0d109621 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -42,7 +42,7 @@
 #include "common/units.h"
 #include "cmds/commands.h"
 #include "cmds/qgroup.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int wait_for_subvolume_cleaning(int fd, size_t count, uint64_t *ids,
 				       int sleep_interval)
diff --git a/common/device-scan.c b/common/device-scan.c
index 8e5ee8ef..84640c00 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -50,7 +50,7 @@
 #include "common/defs.h"
 #include "common/open-utils.h"
 #include "common/units.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int btrfs_scan_done = 0;
 
diff --git a/common/device-scan.h b/common/device-scan.h
index 13a16e0a..f805b489 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -19,7 +19,7 @@
 
 #include "kerncompat.h"
 #include <dirent.h>
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define BTRFS_SCAN_MOUNTED	(1ULL << 0)
 #define BTRFS_SCAN_LBLKID	(1ULL << 1)
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 5a585664..13468818 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -29,7 +29,7 @@
 #include "common/string-utils.h"
 #include "common/utils.h"
 #include "common/messages.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 /*
  * Insert a root item for temporary tree root
diff --git a/common/send-stream.c b/common/send-stream.c
index e9f565e6..c745d97e 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -26,7 +26,7 @@
 #include "crypto/crc32c.h"
 #include "common/send-stream.h"
 #include "common/messages.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct btrfs_send_attribute {
 	u16 tlv_type;
diff --git a/common/send-utils.c b/common/send-utils.c
index 85c7f6ee..0ce437c1 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -28,7 +28,7 @@
 #include "common/send-utils.h"
 #include "common/messages.h"
 #include "common/utils.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int btrfs_subvolid_resolve_sub(int fd, char *path, size_t *path_len,
 				      u64 subvol_id);
diff --git a/common/utils.c b/common/utils.c
index 2c359dcf..1ab232ea 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -38,7 +38,7 @@
 #include "common/messages.h"
 #include "cmds/commands.h"
 #include "mkfs/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int rand_seed_initialized = 0;
 static unsigned short rand_seed[3];
diff --git a/common/utils.h b/common/utils.h
index c06d41bf..531b3c96 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -29,7 +29,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/fsfeatures.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 enum exclusive_operation {
 	BTRFS_EXCLOP_NONE,
diff --git a/convert/common.c b/convert/common.c
index f104d93f..ec614584 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -29,7 +29,7 @@
 #include "common/messages.h"
 #include "mkfs/common.h"
 #include "convert/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define BTRFS_CONVERT_META_GROUP_SIZE SZ_32M
 
diff --git a/image/main.c b/image/main.c
index 7fa215c1..9144cf50 100644
--- a/image/main.c
+++ b/image/main.c
@@ -54,7 +54,7 @@
 #include "cmds/commands.h"
 #include "image/metadump.h"
 #include "image/sanitize.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 #define MAX_WORKER_THREADS	(32)
 
diff --git a/include/kerncompat.h b/include/kerncompat.h
index cb2a9400..edb00276 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -576,5 +576,6 @@ typedef struct wait_queue_head_s {
 
 #define __init
 #define __cold
+#define __user
 
 #endif
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d81d7c02..f31db57b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -25,7 +25,7 @@
 #include "kerncompat.h"
 #include "common/extent-cache.h"
 #include "kernel-shared/extent_io.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
diff --git a/include/ioctl.h b/kernel-shared/uapi/btrfs.h
similarity index 72%
rename from include/ioctl.h
rename to kernel-shared/uapi/btrfs.h
index cbcc0672..6473e362 100644
--- a/include/ioctl.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * Copyright (C) 2007 Oracle.  All rights reserved.
  *
@@ -16,28 +17,20 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#ifndef __BTRFS_IOCTL_H__
-#define __BTRFS_IOCTL_H__
+#ifndef _UAPI_LINUX_BTRFS_H
+#define _UAPI_LINUX_BTRFS_H
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-#include <asm/types.h>
+#include <linux/types.h>
 #include <linux/ioctl.h>
-#include <stddef.h>
-
-#ifndef __user
-#define __user
-#endif
-
-/* We don't want to include entire kerncompat.h */
-#ifndef BUILD_ASSERT
-#define BUILD_ASSERT(x)
-#endif
+#include <linux/fs.h>
 
 #define BTRFS_IOCTL_MAGIC 0x94
 #define BTRFS_VOL_NAME_MAX 255
+#define BTRFS_LABEL_SIZE 256
 
 /* this should be 4k */
 #define BTRFS_PATH_NAME_MAX 4087
@@ -45,18 +38,20 @@ struct btrfs_ioctl_vol_args {
 	__s64 fd;
 	char name[BTRFS_PATH_NAME_MAX + 1];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
-#define BTRFS_DEVICE_PATH_NAME_MAX 1024
+#define BTRFS_DEVICE_PATH_NAME_MAX	1024
+#define BTRFS_SUBVOL_NAME_MAX 		4039
 
-/*
- * Obsolete since 5.15, functionality removed in kernel 5.7:
- * BTRFS_SUBVOL_CREATE_ASYNC		(1ULL << 0)
- */
+#ifndef __KERNEL__
+/* Deprecated since 5.7 */
+# define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
+#endif
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
+
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
-#define BTRFS_SUBVOL_SPEC_BY_ID		(1ULL << 4)
+
+#define BTRFS_SUBVOL_SPEC_BY_ID	(1ULL << 4)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
 			(BTRFS_SUBVOL_RDONLY |		\
@@ -66,8 +61,21 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
 #define BTRFS_FSID_SIZE 16
 #define BTRFS_UUID_SIZE 16
+#define BTRFS_UUID_UNPARSED_SIZE	37
 
-#define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
+/*
+ * flags definition for qgroup limits
+ *
+ * Used by:
+ * struct btrfs_qgroup_limit.flags
+ * struct btrfs_qgroup_limit_item.flags
+ */
+#define BTRFS_QGROUP_LIMIT_MAX_RFER	(1ULL << 0)
+#define BTRFS_QGROUP_LIMIT_MAX_EXCL	(1ULL << 1)
+#define BTRFS_QGROUP_LIMIT_RSV_RFER	(1ULL << 2)
+#define BTRFS_QGROUP_LIMIT_RSV_EXCL	(1ULL << 3)
+#define BTRFS_QGROUP_LIMIT_RFER_CMPR	(1ULL << 4)
+#define BTRFS_QGROUP_LIMIT_EXCL_CMPR	(1ULL << 5)
 
 struct btrfs_qgroup_limit {
 	__u64	flags;
@@ -76,7 +84,14 @@ struct btrfs_qgroup_limit {
 	__u64	rsv_referenced;
 	__u64	rsv_exclusive;
 };
-BUILD_ASSERT(sizeof(struct btrfs_qgroup_limit) == 40);
+
+/*
+ * flags definition for qgroup inheritance
+ *
+ * Used by:
+ * struct btrfs_qgroup_inherit.flags
+ */
+#define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
 
 struct btrfs_qgroup_inherit {
 	__u64	flags;
@@ -84,17 +99,38 @@ struct btrfs_qgroup_inherit {
 	__u64	num_ref_copies;
 	__u64	num_excl_copies;
 	struct btrfs_qgroup_limit lim;
-	__u64	qgroups[0];
+	__u64	qgroups[];
 };
-BUILD_ASSERT(sizeof(struct btrfs_qgroup_inherit) == 72);
 
 struct btrfs_ioctl_qgroup_limit_args {
 	__u64	qgroupid;
 	struct btrfs_qgroup_limit lim;
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_qgroup_limit_args) == 48);
 
-#define BTRFS_SUBVOL_NAME_MAX 4039
+/*
+ * Arguments for specification of subvolumes or devices, supporting by-name or
+ * by-id and flags
+ *
+ * The set of supported flags depends on the ioctl
+ *
+ * BTRFS_SUBVOL_RDONLY is also provided/consumed by the following ioctls:
+ * - BTRFS_IOC_SUBVOL_GETFLAGS
+ * - BTRFS_IOC_SUBVOL_SETFLAGS
+ */
+
+/* Supported flags for BTRFS_IOC_RM_DEV_V2 */
+#define BTRFS_DEVICE_REMOVE_ARGS_MASK					\
+	(BTRFS_DEVICE_SPEC_BY_ID)
+
+/* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
+#define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
+	 (BTRFS_SUBVOL_RDONLY |						\
+	 BTRFS_SUBVOL_QGROUP_INHERIT)
+
+/* Supported flags for BTRFS_IOC_SNAP_DESTROY_V2 */
+#define BTRFS_SUBVOL_DELETE_ARGS_MASK					\
+	(BTRFS_SUBVOL_SPEC_BY_ID)
+
 struct btrfs_ioctl_vol_args_v2 {
 	__s64 fd;
 	__u64 transid;
@@ -112,7 +148,6 @@ struct btrfs_ioctl_vol_args_v2 {
 		__u64 subvolid;
 	};
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args_v2) == 4096);
 
 /*
  * structure to report errors and progress to userspace, either as a
@@ -161,7 +196,6 @@ struct btrfs_ioctl_scrub_args {
 	/* pad to 1k */
 	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_scrub_args) == 1024);
 
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
@@ -172,7 +206,6 @@ struct btrfs_ioctl_dev_replace_start_params {
 	__u8 srcdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
 	__u8 tgtdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_start_params) == 2072);
 
 #define BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED	0
 #define BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED		1
@@ -187,7 +220,6 @@ struct btrfs_ioctl_dev_replace_status_params {
 	__u64 num_write_errors;	/* out */
 	__u64 num_uncorrectable_read_errors;	/* out */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_status_params) == 48);
 
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_START			0
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS			1
@@ -207,7 +239,6 @@ struct btrfs_ioctl_dev_replace_args {
 
 	__u64 spare[64];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_args) == 2600);
 
 struct btrfs_ioctl_dev_info_args {
 	__u64 devid;				/* in/out */
@@ -227,7 +258,18 @@ struct btrfs_ioctl_dev_info_args {
 	__u64 unused[377];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
+
+/*
+ * Retrieve information about the filesystem
+ */
+
+/* Request information about checksum type and size */
+#define BTRFS_FS_INFO_FLAG_CSUM_INFO			(1 << 0)
+
+/* Request information about filesystem generation */
+#define BTRFS_FS_INFO_FLAG_GENERATION			(1 << 1)
+/* Request information about filesystem metadata UUID */
+#define BTRFS_FS_INFO_FLAG_METADATA_UUID		(1 << 2)
 
 struct btrfs_ioctl_fs_info_args {
 	__u64 max_id;				/* out */
@@ -236,22 +278,70 @@ struct btrfs_ioctl_fs_info_args {
 	__u32 nodesize;				/* out */
 	__u32 sectorsize;			/* out */
 	__u32 clone_alignment;			/* out */
-	__u32 reserved32;
-	__u64 reserved[122];			/* pad to 1k */
+	/* See BTRFS_FS_INFO_FLAG_* */
+	__u16 csum_type;			/* out */
+	__u16 csum_size;			/* out */
+	__u64 flags;				/* in/out */
+	__u64 generation;			/* out */
+	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
+	__u8 reserved[944];			/* pad to 1k */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
+
+/*
+ * feature flags
+ *
+ * Used by:
+ * struct btrfs_ioctl_feature_flags
+ */
+#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE		(1ULL << 0)
+/*
+ * Older kernels (< 4.9) on big-endian systems produced broken free space tree
+ * bitmaps, and btrfs-progs also used to corrupt the free space tree (versions
+ * < 4.7.3).  If this bit is clear, then the free space tree cannot be trusted.
+ * btrfs-progs can also intentionally clear this bit to ask the kernel to
+ * rebuild the free space tree, however this might not work on older kernels
+ * that do not know about this bit. If not sure, clear the cache manually on
+ * first mount when booting older kernel versions.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
+#define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
+
+/*
+ * Put all block group items into a dedicated block group tree, greatly
+ * reducing mount time for large filesystem due to better locality.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
+
+#define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
+#define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
+#define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
+#define BTRFS_FEATURE_INCOMPAT_COMPRESS_LZO	(1ULL << 3)
+#define BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD	(1ULL << 4)
+
+/*
+ * older kernels tried to do bigger metadata blocks, but the
+ * code was pretty buggy.  Lets not let them try anymore.
+ */
+#define BTRFS_FEATURE_INCOMPAT_BIG_METADATA	(1ULL << 5)
+
+#define BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF	(1ULL << 6)
+#define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
+#define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
+#define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+#define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
+#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
 	__u64 compat_ro_flags;
 	__u64 incompat_flags;
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_feature_flags) == 24);
 
 /* balance control ioctl modes */
 #define BTRFS_BALANCE_CTL_PAUSE		1
 #define BTRFS_BALANCE_CTL_CANCEL	2
-#define BTRFS_BALANCE_CTL_RESUME	3
 
 /*
  * this is packed, because it should be exactly the same as its disk
@@ -272,7 +362,6 @@ struct btrfs_balance_args {
 			__u32 usage_max;
 		};
 	};
-
 	__u64 devid;
 	__u64 pstart;
 	__u64 pend;
@@ -295,19 +384,89 @@ struct btrfs_balance_args {
 			__u32 limit_max;
 		};
 	};
+
+	/*
+	 * Process chunks that cross stripes_min..stripes_max devices,
+	 * BTRFS_BALANCE_ARGS_STRIPES_RANGE
+	 */
 	__u32 stripes_min;
 	__u32 stripes_max;
+
 	__u64 unused[6];
 } __attribute__ ((__packed__));
 
 /* report balance progress to userspace */
 struct btrfs_balance_progress {
 	__u64 expected;		/* estimated # of chunks that will be
-				 * relocated to fulfil the request */
+				 * relocated to fulfill the request */
 	__u64 considered;	/* # of chunks we have considered so far */
 	__u64 completed;	/* # of chunks relocated so far */
 };
 
+/*
+ * flags definition for balance
+ *
+ * Restriper's general type filter
+ *
+ * Used by:
+ * btrfs_ioctl_balance_args.flags
+ * btrfs_balance_control.flags (internal)
+ */
+#define BTRFS_BALANCE_DATA		(1ULL << 0)
+#define BTRFS_BALANCE_SYSTEM		(1ULL << 1)
+#define BTRFS_BALANCE_METADATA		(1ULL << 2)
+
+#define BTRFS_BALANCE_TYPE_MASK		(BTRFS_BALANCE_DATA |	    \
+					 BTRFS_BALANCE_SYSTEM |	    \
+					 BTRFS_BALANCE_METADATA)
+
+#define BTRFS_BALANCE_FORCE		(1ULL << 3)
+#define BTRFS_BALANCE_RESUME		(1ULL << 4)
+
+/*
+ * flags definitions for per-type balance args
+ *
+ * Balance filters
+ *
+ * Used by:
+ * struct btrfs_balance_args
+ */
+#define BTRFS_BALANCE_ARGS_PROFILES	(1ULL << 0)
+#define BTRFS_BALANCE_ARGS_USAGE	(1ULL << 1)
+#define BTRFS_BALANCE_ARGS_DEVID	(1ULL << 2)
+#define BTRFS_BALANCE_ARGS_DRANGE	(1ULL << 3)
+#define BTRFS_BALANCE_ARGS_VRANGE	(1ULL << 4)
+#define BTRFS_BALANCE_ARGS_LIMIT	(1ULL << 5)
+#define BTRFS_BALANCE_ARGS_LIMIT_RANGE	(1ULL << 6)
+#define BTRFS_BALANCE_ARGS_STRIPES_RANGE (1ULL << 7)
+#define BTRFS_BALANCE_ARGS_USAGE_RANGE	(1ULL << 10)
+
+#define BTRFS_BALANCE_ARGS_MASK			\
+	(BTRFS_BALANCE_ARGS_PROFILES |		\
+	 BTRFS_BALANCE_ARGS_USAGE |		\
+	 BTRFS_BALANCE_ARGS_DEVID | 		\
+	 BTRFS_BALANCE_ARGS_DRANGE |		\
+	 BTRFS_BALANCE_ARGS_VRANGE |		\
+	 BTRFS_BALANCE_ARGS_LIMIT |		\
+	 BTRFS_BALANCE_ARGS_LIMIT_RANGE |	\
+	 BTRFS_BALANCE_ARGS_STRIPES_RANGE |	\
+	 BTRFS_BALANCE_ARGS_USAGE_RANGE)
+
+/*
+ * Profile changing flags.  When SOFT is set we won't relocate chunk if
+ * it already has the target profile (even though it may be
+ * half-filled).
+ */
+#define BTRFS_BALANCE_ARGS_CONVERT	(1ULL << 8)
+#define BTRFS_BALANCE_ARGS_SOFT		(1ULL << 9)
+
+
+/*
+ * flags definition for balance state
+ *
+ * Used by:
+ * struct btrfs_ioctl_balance_args.state
+ */
 #define BTRFS_BALANCE_STATE_RUNNING	(1ULL << 0)
 #define BTRFS_BALANCE_STATE_PAUSE_REQ	(1ULL << 1)
 #define BTRFS_BALANCE_STATE_CANCEL_REQ	(1ULL << 2)
@@ -324,7 +483,6 @@ struct btrfs_ioctl_balance_args {
 
 	__u64 unused[72];			/* pad to 1k */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_balance_args) == 1024);
 
 #define BTRFS_INO_LOOKUP_PATH_MAX 4080
 struct btrfs_ioctl_ino_lookup_args {
@@ -332,9 +490,8 @@ struct btrfs_ioctl_ino_lookup_args {
 	__u64 objectid;
 	char name[BTRFS_INO_LOOKUP_PATH_MAX];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_lookup_args) == 4096);
 
-#define BTRFS_INO_LOOKUP_USER_PATH_MAX	(4080 - BTRFS_VOL_NAME_MAX - 1)
+#define BTRFS_INO_LOOKUP_USER_PATH_MAX (4080 - BTRFS_VOL_NAME_MAX - 1)
 struct btrfs_ioctl_ino_lookup_user_args {
 	/* in, inode number containing the subvolume of 'subvolid' */
 	__u64 dirid;
@@ -348,33 +505,55 @@ struct btrfs_ioctl_ino_lookup_user_args {
 	 */
 	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_lookup_user_args) == 4096);
 
+/* Search criteria for the btrfs SEARCH ioctl family. */
 struct btrfs_ioctl_search_key {
-	/* which root are we searching.  0 is the tree of tree roots */
-	__u64 tree_id;
-
-	/* keys returned will be >= min and <= max */
-	__u64 min_objectid;
-	__u64 max_objectid;
-
-	/* keys returned will be >= min and <= max */
-	__u64 min_offset;
-	__u64 max_offset;
-
-	/* max and min transids to search for */
-	__u64 min_transid;
-	__u64 max_transid;
+	/*
+	 * The tree we're searching in. 1 is the tree of tree roots, 2 is the
+	 * extent tree, etc...
+	 *
+	 * A special tree_id value of 0 will cause a search in the subvolume
+	 * tree that the inode which is passed to the ioctl is part of.
+	 */
+	__u64 tree_id;		/* in */
 
-	/* keys returned will be >= min and <= max */
-	__u32 min_type;
-	__u32 max_type;
+	/*
+	 * When doing a tree search, we're actually taking a slice from a
+	 * linear search space of 136-bit keys.
+	 *
+	 * A full 136-bit tree key is composed as:
+	 *   (objectid << 72) + (type << 64) + offset
+	 *
+	 * The individual min and max values for objectid, type and offset
+	 * define the min_key and max_key values for the search range. All
+	 * metadata items with a key in the interval [min_key, max_key] will be
+	 * returned.
+	 *
+	 * Additionally, we can filter the items returned on transaction id of
+	 * the metadata block they're stored in by specifying a transid range.
+	 * Be aware that this transaction id only denotes when the metadata
+	 * page that currently contains the item got written the last time as
+	 * result of a COW operation.  The number does not have any meaning
+	 * related to the transaction in which an individual item that is being
+	 * returned was created or changed.
+	 */
+	__u64 min_objectid;	/* in */
+	__u64 max_objectid;	/* in */
+	__u64 min_offset;	/* in */
+	__u64 max_offset;	/* in */
+	__u64 min_transid;	/* in */
+	__u64 max_transid;	/* in */
+	__u32 min_type;		/* in */
+	__u32 max_type;		/* in */
 
 	/*
-	 * how many items did userland ask for, and how many are we
-	 * returning
+	 * input: The maximum amount of results desired.
+	 * output: The actual amount of items returned, restricted by any of:
+	 *  - reaching the upper bound of the search range
+	 *  - reaching the input nr_items amount of items
+	 *  - completely filling the supplied memory buffer
 	 */
-	__u32 nr_items;
+	__u32 nr_items;		/* in/out */
 
 	/* align to 64 bits */
 	__u32 unused;
@@ -392,7 +571,7 @@ struct btrfs_ioctl_search_header {
 	__u64 offset;
 	__u32 type;
 	__u32 len;
-} __attribute__((may_alias));
+} __attribute__ ((__may_alias__));
 
 #define BTRFS_SEARCH_ARGS_BUFSIZE (4096 - sizeof(struct btrfs_ioctl_search_key))
 /*
@@ -410,13 +589,12 @@ struct btrfs_ioctl_search_args {
  * The allocated size of the buffer is set in buf_size.
  */
 struct btrfs_ioctl_search_args_v2 {
-        struct btrfs_ioctl_search_key key; /* in/out - search parameters */
-        __u64 buf_size;			   /* in - size of buffer
-                                            * out - on EOVERFLOW: needed size
-                                            *       to store item */
-        __u64 buf[0];                      /* out - found items */
+	struct btrfs_ioctl_search_key key; /* in/out - search parameters */
+	__u64 buf_size;		   /* in - size of buffer
+					    * out - on EOVERFLOW: needed size
+					    *       to store item */
+	__u64 buf[];                       /* out - found items */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_search_args_v2) == 112);
 
 /* With a @src_length of zero, the range from @src_offset->EOF is cloned! */
 struct btrfs_ioctl_clone_range_args {
@@ -424,38 +602,15 @@ struct btrfs_ioctl_clone_range_args {
 	__u64 src_offset, src_length;
 	__u64 dest_offset;
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
 
-/* flags for the defrag range ioctl */
+/*
+ * flags definition for the defrag range ioctl
+ *
+ * Used by:
+ * struct btrfs_ioctl_defrag_range_args.flags
+ */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
-
-#define BTRFS_SAME_DATA_DIFFERS	1
-/* For extent-same ioctl */
-struct btrfs_ioctl_same_extent_info {
-	__s64 fd;		/* in - destination file */
-	__u64 logical_offset;	/* in - start of extent in destination */
-	__u64 bytes_deduped;	/* out - total # of bytes we were able
-				 * to dedupe from this file */
-	/* status of this dedupe operation:
-	 * 0 if dedup succeeds
-	 * < 0 for error
-	 * == BTRFS_SAME_DATA_DIFFERS if data differs
-	 */
-	__s32 status;		/* out - see above description */
-	__u32 reserved;
-};
-
-struct btrfs_ioctl_same_args {
-	__u64 logical_offset;	/* in - start of extent in source */
-	__u64 length;		/* in - length of extent */
-	__u16 dest_count;	/* in - total elements in info array */
-	__u16 reserved1;
-	__u32 reserved2;
-	struct btrfs_ioctl_same_extent_info info[0];
-};
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_same_args) == 24);
-
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
@@ -486,7 +641,32 @@ struct btrfs_ioctl_defrag_range_args {
 	/* spare for later */
 	__u32 unused[4];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_defrag_range_args) == 48);
+
+
+#define BTRFS_SAME_DATA_DIFFERS	1
+/* For extent-same ioctl */
+struct btrfs_ioctl_same_extent_info {
+	__s64 fd;		/* in - destination file */
+	__u64 logical_offset;	/* in - start of extent in destination */
+	__u64 bytes_deduped;	/* out - total # of bytes we were able
+				 * to dedupe from this file */
+	/* status of this dedupe operation:
+	 * 0 if dedup succeeds
+	 * < 0 for error
+	 * == BTRFS_SAME_DATA_DIFFERS if data differs
+	 */
+	__s32 status;		/* out - see above description */
+	__u32 reserved;
+};
+
+struct btrfs_ioctl_same_args {
+	__u64 logical_offset;	/* in - start of extent in source */
+	__u64 length;		/* in - length of extent */
+	__u16 dest_count;	/* in - total elements in info array */
+	__u16 reserved1;
+	__u32 reserved2;
+	struct btrfs_ioctl_same_extent_info info[];
+};
 
 struct btrfs_ioctl_space_info {
 	__u64 flags;
@@ -497,16 +677,15 @@ struct btrfs_ioctl_space_info {
 struct btrfs_ioctl_space_args {
 	__u64 space_slots;
 	__u64 total_spaces;
-	struct btrfs_ioctl_space_info spaces[0];
+	struct btrfs_ioctl_space_info spaces[];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_space_args) == 16);
 
 struct btrfs_data_container {
 	__u32	bytes_left;	/* out -- bytes not needed to deliver output */
 	__u32	bytes_missing;	/* out -- additional bytes needed for result */
 	__u32	elem_cnt;	/* out */
 	__u32	elem_missed;	/* out */
-	__u64	val[0];		/* out */
+	__u64	val[];		/* out */
 };
 
 struct btrfs_ioctl_ino_path_args {
@@ -516,13 +695,12 @@ struct btrfs_ioctl_ino_path_args {
 	/* struct btrfs_data_container	*fspath;	   out */
 	__u64				fspath;		/* out */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_ino_path_args) == 56);
 
 struct btrfs_ioctl_logical_ino_args {
 	__u64				logical;	/* in */
 	__u64				size;		/* in */
-	__u64				reserved[3];
-	__u64				flags;		/* in */
+	__u64				reserved[3];	/* must be 0 for now */
+	__u64				flags;		/* in, v2 only */
 	/* struct btrfs_data_container	*inodes;	out   */
 	__u64				inodes;
 };
@@ -531,7 +709,7 @@ struct btrfs_ioctl_logical_ino_args {
  * Return every ref to the extent, not just those containing logical block.
  * Requires logical == extent bytenr.
  */
-#define BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET    (1ULL << 0)
+#define BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET	(1ULL << 0)
 
 enum btrfs_dev_stat_values {
 	/* disk I/O failure stats */
@@ -563,26 +741,27 @@ struct btrfs_ioctl_get_dev_stats {
 	/* out values: */
 	__u64 values[BTRFS_DEV_STAT_VALUES_MAX];
 
-	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX]; /* pad to 1k + 8B */
+	/*
+	 * This pads the struct to 1032 bytes. It was originally meant to pad to
+	 * 1024 bytes, but when adding the flags field, the padding calculation
+	 * was not adjusted.
+	 */
+	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_dev_stats) == 1032);
 
-/* BTRFS_IOC_SNAP_CREATE is no longer used by the btrfs command */
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
-/* 3 has formerly been reserved for BTRFS_QUOTA_CTL_RESCAN */
+#define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
 struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_quota_ctl_args) == 16);
 
 struct btrfs_ioctl_quota_rescan_args {
 	__u64	flags;
 	__u64   progress;
 	__u64   reserved[6];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_quota_rescan_args) == 64);
 
 struct btrfs_ioctl_qgroup_assign_args {
 	__u64 assign;
@@ -594,8 +773,6 @@ struct btrfs_ioctl_qgroup_create_args {
 	__u64 create;
 	__u64 qgroupid;
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_qgroup_create_args) == 16);
-
 struct btrfs_ioctl_timespec {
 	__u64 sec;
 	__u32 nsec;
@@ -610,39 +787,6 @@ struct btrfs_ioctl_received_subvol_args {
 	__u64	flags;			/* in */
 	__u64	reserved[16];		/* in */
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_received_subvol_args) == 200);
-
-/*
- * If we have a 32-bit userspace and 64-bit kernel, then the UAPI
- * structures are incorrect, as the timespec structure from userspace
- * is 4 bytes too small. We define these alternatives here for backward
- * compatibility, the kernel understands both values.
- */
-
-/*
- * Structure size is different on 32bit and 64bit, has some padding if the
- * structure is embedded. Packing makes sure the size is same on both, but will
- * be misaligned on 64bit.
- *
- * NOTE: do not use in your code, this is for testing only
- */
-struct btrfs_ioctl_timespec_32 {
-	__u64 sec;
-	__u32 nsec;
-} __attribute__ ((__packed__));
-
-struct btrfs_ioctl_received_subvol_args_32 {
-	char	uuid[BTRFS_UUID_SIZE];	/* in */
-	__u64	stransid;		/* in */
-	__u64	rtransid;		/* out */
-	struct btrfs_ioctl_timespec_32 stime; /* in */
-	struct btrfs_ioctl_timespec_32 rtime; /* out */
-	__u64	flags;			/* in */
-	__u64	reserved[16];		/* in */
-} __attribute__ ((__packed__));
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_received_subvol_args_32) == 192);
-
-#define BTRFS_IOC_SET_RECEIVED_SUBVOL_32_COMPAT_DEFINED 1
 
 /*
  * Caller doesn't want file data in the send stream, even if the
@@ -690,39 +834,8 @@ struct btrfs_ioctl_send_args {
 	__u64 parent_root;		/* in */
 	__u64 flags;			/* in */
 	__u32 version;			/* in */
-	__u8 reserved[28];		/* in */
+	__u8  reserved[28];		/* in */
 };
-/*
- * Size of structure depends on pointer width, was not caught in the early
- * days.  Kernel handles pointer width differences transparently.
- */
-BUILD_ASSERT(sizeof(__u64 *) == 8
-	     ? sizeof(struct btrfs_ioctl_send_args) == 72
-	     : (sizeof(void *) == 4
-		? sizeof(struct btrfs_ioctl_send_args) == 68
-		: 0));
-
-/*
- * Different pointer width leads to structure size change. Kernel should accept
- * both ioctl values (derived from the structures) for backward compatibility.
- * Size of this structure is same on 32bit and 64bit though.
- *
- * NOTE: do not use in your code, this is for testing only
- */
-struct btrfs_ioctl_send_args_64 {
-	__s64 send_fd;			/* in */
-	__u64 clone_sources_count;	/* in */
-	union {
-		__u64 __user *clone_sources;	/* in */
-		__u64 __clone_sources_alignment;
-	};
-	__u64 parent_root;		/* in */
-	__u64 flags;			/* in */
-	__u64 reserved[4];		/* in */
-} __attribute__((packed));
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_send_args_64) == 72);
-
-#define BTRFS_IOC_SEND_64_COMPAT_DEFINED 1
 
 /*
  * Information about a fs tree root.
@@ -784,22 +897,21 @@ struct btrfs_ioctl_get_subvol_info_args {
 	__u64 reserved[8];
 };
 
-#define BTRFS_MAX_ROOTREF_BUFFER_NUM			255
+#define BTRFS_MAX_ROOTREF_BUFFER_NUM 255
 struct btrfs_ioctl_get_subvol_rootref_args {
-	/* in/out, minimum id of rootref's treeid to be searched */
-	__u64 min_treeid;
-
-	/* out */
-	struct {
-		__u64 treeid;
-		__u64 dirid;
-	} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];
-
-	/* out, number of found items */
-	__u8 num_items;
-	__u8 align[7];
+		/* in/out, minimum id of rootref's treeid to be searched */
+		__u64 min_treeid;
+
+		/* out */
+		struct {
+			__u64 treeid;
+			__u64 dirid;
+		} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];
+
+		/* out, number of found items */
+		__u8 num_items;
+		__u8 align[7];
 };
-BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
 /*
  * Data and metadata for an encoded read or write.
@@ -931,8 +1043,7 @@ struct btrfs_ioctl_encoded_io_args {
 
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
-	notused,
-	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET,
+	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
 	BTRFS_ERROR_DEV_RAID10_MIN_NOT_MET,
 	BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET,
 	BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
@@ -954,12 +1065,12 @@ enum btrfs_err_code {
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_FORGET_DEV _IOW(BTRFS_IOCTL_MAGIC, 5, \
 				   struct btrfs_ioctl_vol_args)
-/*
- * Removed in kernel since 4.17:
- * BTRFS_IOC_TRANS_START	_IO(BTRFS_IOCTL_MAGIC, 6)
- * BTRFS_IOC_TRANS_END		_IO(BTRFS_IOCTL_MAGIC, 7)
+/* trans start and trans end are dangerous, and only for
+ * use by applications that know how to avoid the
+ * resulting deadlocks
  */
-
+#define BTRFS_IOC_TRANS_START  _IO(BTRFS_IOCTL_MAGIC, 6)
+#define BTRFS_IOC_TRANS_END    _IO(BTRFS_IOCTL_MAGIC, 7)
 #define BTRFS_IOC_SYNC         _IO(BTRFS_IOCTL_MAGIC, 8)
 
 #define BTRFS_IOC_CLONE        _IOW(BTRFS_IOCTL_MAGIC, 9, int)
@@ -971,18 +1082,18 @@ enum btrfs_err_code {
 				   struct btrfs_ioctl_vol_args)
 
 #define BTRFS_IOC_CLONE_RANGE _IOW(BTRFS_IOCTL_MAGIC, 13, \
-				   struct btrfs_ioctl_clone_range_args)
+				  struct btrfs_ioctl_clone_range_args)
 
 #define BTRFS_IOC_SUBVOL_CREATE _IOW(BTRFS_IOCTL_MAGIC, 14, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_SNAP_DESTROY _IOW(BTRFS_IOCTL_MAGIC, 15, \
-				   struct btrfs_ioctl_vol_args)
+				struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG_RANGE _IOW(BTRFS_IOCTL_MAGIC, 16, \
 				struct btrfs_ioctl_defrag_range_args)
 #define BTRFS_IOC_TREE_SEARCH _IOWR(BTRFS_IOCTL_MAGIC, 17, \
 				   struct btrfs_ioctl_search_args)
 #define BTRFS_IOC_TREE_SEARCH_V2 _IOWR(BTRFS_IOCTL_MAGIC, 17, \
-				   struct btrfs_ioctl_search_args_v2)
+					   struct btrfs_ioctl_search_args_v2)
 #define BTRFS_IOC_INO_LOOKUP _IOWR(BTRFS_IOCTL_MAGIC, 18, \
 				   struct btrfs_ioctl_ino_lookup_args)
 #define BTRFS_IOC_DEFAULT_SUBVOL _IOW(BTRFS_IOCTL_MAGIC, 19, __u64)
@@ -997,14 +1108,14 @@ enum btrfs_err_code {
 #define BTRFS_IOC_SUBVOL_GETFLAGS _IOR(BTRFS_IOCTL_MAGIC, 25, __u64)
 #define BTRFS_IOC_SUBVOL_SETFLAGS _IOW(BTRFS_IOCTL_MAGIC, 26, __u64)
 #define BTRFS_IOC_SCRUB _IOWR(BTRFS_IOCTL_MAGIC, 27, \
-				struct btrfs_ioctl_scrub_args)
+			      struct btrfs_ioctl_scrub_args)
 #define BTRFS_IOC_SCRUB_CANCEL _IO(BTRFS_IOCTL_MAGIC, 28)
 #define BTRFS_IOC_SCRUB_PROGRESS _IOWR(BTRFS_IOCTL_MAGIC, 29, \
-					struct btrfs_ioctl_scrub_args)
+				       struct btrfs_ioctl_scrub_args)
 #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
-					struct btrfs_ioctl_dev_info_args)
+				 struct btrfs_ioctl_dev_info_args)
 #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
-                                 struct btrfs_ioctl_fs_info_args)
+			       struct btrfs_ioctl_fs_info_args)
 #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
 				   struct btrfs_ioctl_balance_args)
 #define BTRFS_IOC_BALANCE_CTL _IOW(BTRFS_IOCTL_MAGIC, 33, int)
@@ -1016,37 +1127,24 @@ enum btrfs_err_code {
 					struct btrfs_ioctl_logical_ino_args)
 #define BTRFS_IOC_SET_RECEIVED_SUBVOL _IOWR(BTRFS_IOCTL_MAGIC, 37, \
 				struct btrfs_ioctl_received_subvol_args)
-
-#ifdef BTRFS_IOC_SET_RECEIVED_SUBVOL_32_COMPAT_DEFINED
-#define BTRFS_IOC_SET_RECEIVED_SUBVOL_32 _IOWR(BTRFS_IOCTL_MAGIC, 37, \
-				struct btrfs_ioctl_received_subvol_args_32)
-#endif
-
-#ifdef BTRFS_IOC_SEND_64_COMPAT_DEFINED
-#define BTRFS_IOC_SEND_64 _IOW(BTRFS_IOCTL_MAGIC, 38, \
-		struct btrfs_ioctl_send_args_64)
-#endif
-
 #define BTRFS_IOC_SEND _IOW(BTRFS_IOCTL_MAGIC, 38, struct btrfs_ioctl_send_args)
 #define BTRFS_IOC_DEVICES_READY _IOR(BTRFS_IOCTL_MAGIC, 39, \
 				     struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_QUOTA_CTL _IOWR(BTRFS_IOCTL_MAGIC, 40, \
-					struct btrfs_ioctl_quota_ctl_args)
+			       struct btrfs_ioctl_quota_ctl_args)
 #define BTRFS_IOC_QGROUP_ASSIGN _IOW(BTRFS_IOCTL_MAGIC, 41, \
-					struct btrfs_ioctl_qgroup_assign_args)
+			       struct btrfs_ioctl_qgroup_assign_args)
 #define BTRFS_IOC_QGROUP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 42, \
-					struct btrfs_ioctl_qgroup_create_args)
+			       struct btrfs_ioctl_qgroup_create_args)
 #define BTRFS_IOC_QGROUP_LIMIT _IOR(BTRFS_IOCTL_MAGIC, 43, \
-					struct btrfs_ioctl_qgroup_limit_args)
+			       struct btrfs_ioctl_qgroup_limit_args)
 #define BTRFS_IOC_QUOTA_RESCAN _IOW(BTRFS_IOCTL_MAGIC, 44, \
 			       struct btrfs_ioctl_quota_rescan_args)
 #define BTRFS_IOC_QUOTA_RESCAN_STATUS _IOR(BTRFS_IOCTL_MAGIC, 45, \
 			       struct btrfs_ioctl_quota_rescan_args)
 #define BTRFS_IOC_QUOTA_RESCAN_WAIT _IO(BTRFS_IOCTL_MAGIC, 46)
-#define BTRFS_IOC_GET_FSLABEL _IOR(BTRFS_IOCTL_MAGIC, 49, \
-				   char[BTRFS_LABEL_SIZE])
-#define BTRFS_IOC_SET_FSLABEL _IOW(BTRFS_IOCTL_MAGIC, 50, \
-				   char[BTRFS_LABEL_SIZE])
+#define BTRFS_IOC_GET_FSLABEL 	FS_IOC_GETFSLABEL
+#define BTRFS_IOC_SET_FSLABEL	FS_IOC_SETFSLABEL
 #define BTRFS_IOC_GET_DEV_STATS _IOWR(BTRFS_IOCTL_MAGIC, 52, \
 				      struct btrfs_ioctl_get_dev_stats)
 #define BTRFS_IOC_DEV_REPLACE _IOWR(BTRFS_IOCTL_MAGIC, 53, \
@@ -1054,15 +1152,15 @@ enum btrfs_err_code {
 #define BTRFS_IOC_FILE_EXTENT_SAME _IOWR(BTRFS_IOCTL_MAGIC, 54, \
 					 struct btrfs_ioctl_same_args)
 #define BTRFS_IOC_GET_FEATURES _IOR(BTRFS_IOCTL_MAGIC, 57, \
-                                  struct btrfs_ioctl_feature_flags)
+				   struct btrfs_ioctl_feature_flags)
 #define BTRFS_IOC_SET_FEATURES _IOW(BTRFS_IOCTL_MAGIC, 57, \
-                                  struct btrfs_ioctl_feature_flags[2])
+				   struct btrfs_ioctl_feature_flags[2])
 #define BTRFS_IOC_GET_SUPPORTED_FEATURES _IOR(BTRFS_IOCTL_MAGIC, 57, \
-                                  struct btrfs_ioctl_feature_flags[3])
-#define BTRFS_IOC_RM_DEV_V2	_IOW(BTRFS_IOCTL_MAGIC, 58, \
+				   struct btrfs_ioctl_feature_flags[3])
+#define BTRFS_IOC_RM_DEV_V2 _IOW(BTRFS_IOCTL_MAGIC, 58, \
 				   struct btrfs_ioctl_vol_args_v2)
 #define BTRFS_IOC_LOGICAL_INO_V2 _IOWR(BTRFS_IOCTL_MAGIC, 59, \
-                                     struct btrfs_ioctl_logical_ino_args)
+					struct btrfs_ioctl_logical_ino_args)
 #define BTRFS_IOC_GET_SUBVOL_INFO _IOR(BTRFS_IOCTL_MAGIC, 60, \
 				struct btrfs_ioctl_get_subvol_info_args)
 #define BTRFS_IOC_GET_SUBVOL_ROOTREF _IOWR(BTRFS_IOCTL_MAGIC, 61, \
@@ -1070,7 +1168,7 @@ enum btrfs_err_code {
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
-				   struct btrfs_ioctl_vol_args_v2)
+				struct btrfs_ioctl_vol_args_v2)
 #define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
 				    struct btrfs_ioctl_encoded_io_args)
 #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
@@ -1080,4 +1178,4 @@ enum btrfs_err_code {
 }
 #endif
 
-#endif
+#endif /* _UAPI_LINUX_BTRFS_H */
diff --git a/mkfs/common.c b/mkfs/common.c
index 5238f006..40d07deb 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -38,7 +38,7 @@
 #include "common/device-utils.h"
 #include "common/open-utils.h"
 #include "mkfs/common.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static u64 reference_root_table[] = {
 	[MKFS_ROOT_TREE]	=	BTRFS_ROOT_TREE_OBJECTID,
diff --git a/tests/ioctl-test.c b/tests/ioctl-test.c
index a8a120ac..8452684a 100644
--- a/tests/ioctl-test.c
+++ b/tests/ioctl-test.c
@@ -18,7 +18,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
 
 #define LIST_32_COMPAT				\
diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 0ce008ab..e6faf7db 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -22,7 +22,7 @@
 #include "kernel-shared/transaction.h"
 #include "common/messages.h"
 #include "tune/tune.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string)
 {
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index f148b9e5..628a1bba 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -25,7 +25,7 @@
 #include "kernel-shared/volumes.h"
 #include "common/defs.h"
 #include "common/messages.h"
-#include "ioctl.h"
+#include "kernel-shared/uapi/btrfs.h"
 
 static int change_fsid_prepare(struct btrfs_fs_info *fs_info, uuid_t new_fsid)
 {
-- 
2.40.0

