Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8242AC9DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKJAwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 19:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 19:52:33 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE00C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 16:52:33 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id f21so5596613plr.5
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 16:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1MAvxQb8trSX9JVVWhH0b+jPztbJGrHaEUYsvSv4Ms=;
        b=aSctJ/9pAxLv3lCfLhmvxFipRIjvJX4s5IHxVK83Q0+fwjeieVE0GJMsqG1b7z39bI
         onXNe0z7Z6s0l2Y5z5M4jsHbKoe4i090Pvyd7QwA5EmCMChL8UCRgeuRDGjO+lCvOoBo
         TjdOv/d/eZV6RZ9iw2fI56reV021T4JbEn24JZ6d098x/czEan8Ftw5zV+5Smp+AlcNt
         pC9tbgA0OZMz9FgmhKgvV46aBDrRAhFBSy323WEtfJbtBX3TBMDTh0qKx1Qgb5WRLj18
         glXYGk/qVYzxC8P/B16vG95RDMqcvGv3iU9+YomsOkjVhCBE3Sg+sR+qP+VUlaGCsoK6
         4Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D1MAvxQb8trSX9JVVWhH0b+jPztbJGrHaEUYsvSv4Ms=;
        b=ezGp/Pj012qPmS7k7KULFnGRyQzLSkGqmgr2TbVUlUkpZXptqD2ciBXH2Qi8PHCC4v
         hhrkNYCjQSziGHWyR8izCoNZB6YjXNE0gCHIPnCBz0d3yX/SHgIlkLc0k48Mtj69CrXG
         //w9Swbt49Hcag8TP9W24yT/oIhOqsF1KnZFuCxcjBaPCu1kOv4DibVEjOOMrQkHyHYI
         9rITxX2qmNeczKcxbZzWiFxcJk+rCLfkFcIfuE/Qz5LvfAdRtwOfs5Sxu/XRDLarqGYt
         7h/xdegPjaDdYY8GJlIPuZ1OPssYc0NmtshIK820mixQkeVw9COOEaziHMLIjiNme7pc
         OOJg==
X-Gm-Message-State: AOAM531mUrGsspf0kyxSUmD+VdkJ22FI8YS3DUFOPQ8PFJBT3hM7N2Dr
        r8Q3PflHE6hW6YuaVv7E5P8=
X-Google-Smtp-Source: ABdhPJzDj5xPlCwTeHhMk9J1wC/hPaDFVz7u3IrGQcKpiHuc5X9zpOxJLbj7D+fl5gtwv8e4VWERDQ==
X-Received: by 2002:a17:902:6ac1:b029:d6:c43e:a42d with SMTP id i1-20020a1709026ac1b02900d6c43ea42dmr14461159plt.21.1604969552960;
        Mon, 09 Nov 2020 16:52:32 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id z5sm12017274pfn.76.2020.11.09.16.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:52:32 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: filesystem usage: add avail info from statfs()
Date:   Tue, 10 Nov 2020 00:52:21 +0000
Message-Id: <20201110005221.9323-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dd available space information from statfs(). This can be different from
'Free (estimated)' in some cases. This patch provide more information
about filesystem usage like below. and update document for this.

Overall:
    Device size:                   5.00GiB
    Device allocated:              1.02GiB
    Device unallocated:            3.98GiB
    Device missing:                  0.00B
    Used:                         88.00KiB
    Free (estimated):              4.48GiB      (min: 2.49GiB)
    Avail:                         4.48GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              832.00KiB      (used: 0.00B)
    Multiple profiles:                  no

Issue: #306
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 Documentation/btrfs-filesystem.asciidoc |  3 +++
 cmds/filesystem-usage.c                 | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/btrfs-filesystem.asciidoc b/Documentation/btrfs-filesystem.asciidoc
index 6a5561ed..18623afe 100644
--- a/Documentation/btrfs-filesystem.asciidoc
+++ b/Documentation/btrfs-filesystem.asciidoc
@@ -276,6 +276,7 @@ Overall:
     Device missing:                  0.00B
     Used:                          1.14TiB
     Free (estimated):            692.57GiB      (min: 692.57GiB)
+    Avail:                       692.57GiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
@@ -295,6 +296,8 @@ including the reserved space
 data, including currently allocated space and estimating the usage of the
 unallocated space based on the block group profiles, the 'min' is the lower bound
 of the estimate in case multiple profiles are present
+* 'Avail' -- the amount of space available for data. it's get by statfs() system
+call that can be different from 'Free (estimated)' in some cases
 * 'Data ratio' -- ratio of total space for data including redundancy or parity to
 the effectively usable data space, eg. single is 1.0, RAID1 is 2.0 and for RAID5/6
 it depends on the number of devices
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index ab60d769..ed743a61 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -19,6 +19,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/vfs.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <getopt.h>
@@ -430,6 +431,7 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	u64 free_min = 0;
 	double max_data_ratio = 1.0;
 	int mixed = 0;
+	struct statfs statfs_buf;
 
 	sargs = load_space_info(fd, path);
 	if (!sargs) {
@@ -556,6 +558,12 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	if (unit_mode != UNITS_HUMAN)
 		width = 18;
 
+	ret = statfs(path, &statfs_buf);
+	if (ret) {
+		warning("cannot get space info with statfs() on '%s': %m", path);
+		ret = 0;
+	}
+
 	printf("Overall:\n");
 
 	printf("    Device size:\t\t%*s\n", width,
@@ -572,6 +580,8 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		width,
 		pretty_size_mode(free_estimated, unit_mode));
 	printf("min: %s)\n", pretty_size_mode(free_min, unit_mode));
+	printf("    Avail:\t\t\t%*s\n", width,
+		pretty_size_mode(statfs_buf.f_bavail * statfs_buf.f_bsize, unit_mode));
 	printf("    Data ratio:\t\t\t%*.2f\n",
 		width, data_ratio);
 	printf("    Metadata ratio:\t\t%*.2f\n",
-- 
2.25.1

