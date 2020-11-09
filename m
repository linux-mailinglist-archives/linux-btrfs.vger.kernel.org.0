Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9712ABF47
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgKIO7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbgKIO7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 09:59:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FAC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 06:59:35 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so5779484pfd.7
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 06:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7z42VTO0grs5Czso2kCQMWuDTiKZ+4KAjFfBr/8Zyz8=;
        b=vKFtIuw/osUMAXniSU4GEMh1K4WE1WFv/8Df2QMAjqyvWzpR/v7QTkIQcxgqBK62m9
         J6tMO7pw09Vag8zrhpIpOBT5mREacZNQQpwP9wvlDAx6ecx81TET4XISIVdfOLckUp2Z
         Nmvbt+zbGtYBj/FTbUbGCUQnGK2iALAugUlE+qKXSsrX+SGQX4Skrfgv2kUj4RYRJiqa
         4xNG3tnRhr3MkHF98h43d8S5DvFnG8AlaARZbhP4t1JBv481rlwypzjlLmq4SMeKVQQF
         bbVzxgYX5HQjMtIMmiMpg0oddlYo5bFgB8P3TWONexJQxmu0KLZMKugkyAbPvcQ007WC
         1dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7z42VTO0grs5Czso2kCQMWuDTiKZ+4KAjFfBr/8Zyz8=;
        b=kF/e2qWOCg4lsoQqFMDgV9T/U2o7RbdePhYYbhjV8Tz6C+Oob9A1RoehM+c+XdDx+S
         LNVPJLINKcazL/MRBdtS5Q+rHLuU8TRoFU1XP+q3Af807Qs4fS7vRK1V12G0tlBMDLjP
         YjjLmCio7tYTOWku5+wrgFCBTCQyUPRyJdjAAVHqra8sE3s3VQbxAjFEG493ejmmGUj/
         Q2Hw/mwWHu3NDexl1/hOh+mOZ3konfnYFxBdZN39takXKIQJfKFeFWKWtgh4p5eZ7Zzp
         20kxquU0lGiCBA/HIoFtK5MrUCRmjGvf1jJib8yrdPpS0Rf9Y1Fp9mu0tnhHpBcpD3ps
         0Zvw==
X-Gm-Message-State: AOAM533JDco1uLyux+Mffb2NXXL9MYW3kdO5QCoiIfInDffayJlozKgI
        2khUTaXSrN4DbIIbWIsIPU0=
X-Google-Smtp-Source: ABdhPJwFnSYkTX9WdTq5XH/Yofpk9XctCXN/O7v85qvcP7efut1mA0IyP92QxX4s3LZll8QAaV6OJg==
X-Received: by 2002:a17:90b:1081:: with SMTP id gj1mr13394483pjb.15.1604933975498;
        Mon, 09 Nov 2020 06:59:35 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id h14sm11933332pfr.32.2020.11.09.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:59:34 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: filesystem usage: add avail info from statfs()
Date:   Mon,  9 Nov 2020 14:59:23 +0000
Message-Id: <20201109145923.14167-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add available space information from statfs(). This can be different from
'Free (estimated)' in some cases. This patch provide more information about
filesystem usage.

Issue: #306
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem-usage.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index ab60d769..c17e26c3 100644
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
@@ -556,6 +558,13 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	if (unit_mode != UNITS_HUMAN)
 		width = 18;
 
+	ret = statfs(path, &statfs_buf);
+	if (ret) {
+		error("cannot get space info with statfs() on '%s': %m", path);
+		ret = 1;
+		goto exit;
+	}
+
 	printf("Overall:\n");
 
 	printf("    Device size:\t\t%*s\n", width,
@@ -572,6 +581,8 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		width,
 		pretty_size_mode(free_estimated, unit_mode));
 	printf("min: %s)\n", pretty_size_mode(free_min, unit_mode));
+	printf("    Avail:\t\t\t%*s\n", width,
+		pretty_size_mode(statfs_buf.f_bavail * statfs_buf.f_bsize, unit_mode));
 	printf("    Data ratio:\t\t\t%*.2f\n",
 		width, data_ratio);
 	printf("    Metadata ratio:\t\t%*.2f\n",
-- 
2.17.1

