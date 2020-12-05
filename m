Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B942CFDF3
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Dec 2020 19:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgLESue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Dec 2020 13:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLESuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Dec 2020 13:50:20 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B97C061A4F
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Dec 2020 10:49:40 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so5249828pjk.1
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Dec 2020 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBHcU+8KUGu6K7hKevI4GKGUvwv2tIUYJ+13bxKmZDo=;
        b=V4eaD+zKaWmA/L1qSqEWmoQJIL/hPhotTCt8quMok/xnFDQ2qTVa4t9D93k343Pw/Y
         wheMqq6tndZ/Pue91TFYvEU0O8Et1T42/VUa0uXE9SRffVIzLloCHuSgBarwjdDQVYoP
         ULy6UJL6fMxmeof4GfgA8SFU+ifVevOR/4GrtXMkIM25cAxdERl/MBgPRCspsSR34+/P
         XXOx6jyilf9e7QSM/ykWkUvP3LaImTFIpGGHOHCoxJmlgmW6OeJ+RxaWg87vMEXmcP+T
         vzcPY7O5qqCOxH7JAFCdtS3sSWQvRs1oIojju0R+GxeHHC+BZUlKAlYS+zKGM0fiQuCl
         X4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBHcU+8KUGu6K7hKevI4GKGUvwv2tIUYJ+13bxKmZDo=;
        b=bbbOhIj4aodV73suqb+hH5Rh8co48r7VIMTcDDOby8NgOlMXzx478MgPu8Q2vyPe0B
         jBmXgbxR7FVZqdCBvBcNjevwJVvmLOiEjKA5cAuHbDJgqb/lTLCkjs5HmTFVfQzLByiP
         pJ6XtNPSFfFcoIkDhj66YzesTSju9xSIL087Vt+G4xTsxRe+uJbnXBa/e5U+OoWtr4GM
         hST60sgc8YAwr3pEi09FX4kUu5IUs1OeDYvBxs0/u+/q+Dd12TpHEeb3rbNXdm0OzPsS
         daDfUJSpi9Vf1/TKNpHtsBl/WF346CURYQA1poRS4OOLt7cFsYIq0JDeG4yAYzkP8dYP
         OuTQ==
X-Gm-Message-State: AOAM5336o5EeePN8fbdw9bI7jXN3CCRYDOGS+p5vCt1nuACHzt0hYbYR
        lpCTjaaDBRHShWGkhTYumIsteeF0sw02mA==
X-Google-Smtp-Source: ABdhPJzzNcYz5SNL/T8mRz2TCwdz2DZB6aEgWwWYbysWEYQDhEyEIAVh8WnyllhjRq8NW4zEKvdCCA==
X-Received: by 2002:a17:90a:fb0d:: with SMTP id it13mr9600733pjb.176.1607194180186;
        Sat, 05 Dec 2020 10:49:40 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id z11sm6009261pjn.5.2020.12.05.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 10:49:39 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has mq-deadline
Date:   Sat,  5 Dec 2020 18:49:29 +0000
Message-Id: <20201205184929.22412-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Warn if scurb stared on a device that has mq-deadline as io-scheduler
and point documentation. mq-deadline doesn't work with ionice value and
it results performance loss. This warning helps users figure out the
situation. This patch implements the function that gets io-scheduler
from sysfs and check when scrub stars with the function.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/scrub.c          |  8 ++++++++
 common/device-utils.c | 28 ++++++++++++++++++++++++++++
 common/device-utils.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index e96dc998..1932b097 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -40,6 +40,7 @@
 #include "kernel-shared/ctree.h"
 #include "ioctl.h"
 #include "common/utils.h"
+#include "common/device-utils.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/disk-io.h"
 
@@ -1188,6 +1189,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	DIR *dirstream = NULL;
 	int force = 0;
 	int nothing_to_resume = 0;
+	char scheduler_name[256];
 
 	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
 		switch (c) {
@@ -1314,6 +1316,12 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	for (i = 0; i < fi_args.num_devices; ++i) {
 		devid = di_args[i].devid;
+		if (!btrfs_io_scheduler((char*)di_args[i].path, scheduler_name, 256))
+			if (!strcmp(scheduler_name, "mq-deadline"))
+				warning_on(!do_quiet,
+					   "ionice doesn't work with current "
+					   "mq-deadline scheduler "
+					   "(see btrfs-scrub(8) manpage)");
 		ret = pthread_mutex_init(&sp[i].progress_mutex, NULL);
 		if (ret) {
 			errno = ret;
diff --git a/common/device-utils.c b/common/device-utils.c
index c860b946..3cd5ca4a 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -252,3 +252,31 @@ u64 get_partition_size(const char *dev)
 	return result;
 }
 
+int btrfs_io_scheduler(const char *dev, char *scheduler, int max_len)
+{
+	char path[PATH_MAX];
+	char names[256];
+	FILE *file;
+	char fmt[20];
+	char *this_char, *save_ptr;
+
+	snprintf(path, PATH_MAX, "/sys/block/%s/queue/scheduler",
+		 basename(dev));
+	if ((file = fopen(path, "r"))) {
+		if (fgets(names, 255, file)) {
+			for (this_char = strtok_r(names, " ", &save_ptr);
+			     this_char != NULL;
+			     this_char = strtok_r(NULL, " ", &save_ptr)) {
+				snprintf(fmt, 20, "[%%%i[a-z-]", max_len - 1);
+				if (sscanf(this_char, fmt, scheduler)) {
+					fclose(file);
+					return 0;
+				}
+			}
+
+		}
+		fclose(file);
+	}
+
+	return -1;
+}
diff --git a/common/device-utils.h b/common/device-utils.h
index 70d19cae..bd892d54 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -29,5 +29,6 @@ u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags);
+int btrfs_io_scheduler(const char *dev, char *scheduler, int max_len);
 
 #endif
-- 
2.25.1

