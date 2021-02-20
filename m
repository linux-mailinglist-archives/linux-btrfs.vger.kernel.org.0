Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A854320561
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 13:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBTMmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTMmF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 07:42:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BAC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 04:41:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o38so7119755pgm.9
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sosnsSjoXZtnDgtppH14BiFM2pfTaYPWs4x8NCQefts=;
        b=RKdMlebIhqdBkOT19djPyv6O+4I0fUWRtE2n1aC9G7DCKjOhlzsk46rGRxtzsCFe0N
         dUXwNF5tN3OiVSinm5uLjTn5G6qtckO6I4IrsXiOxxHwl7i2aHyjw8vinJ67lLq4QOfj
         V/rNhRKSNAUQuzACRWwHjWy4Env3BK+6/AHULcmdRkVhI/6uae4YTBtkgRm1T3QjBUL5
         Hb4EzaYPb0Rk9YcPtAhDfXFGL8knodiNvfNrjxJniq1aNmgBZoL5mGrE4rga3Ijao82o
         zm5zSd5et/MJYRfhBSr0f9tTlc7cnJ3obT8SGlcKOYB0NytW/4Dc/0ci3WO5G7WP1vzt
         UO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sosnsSjoXZtnDgtppH14BiFM2pfTaYPWs4x8NCQefts=;
        b=rvjoh8w3v/zEOzPBubzpwtGl6WuEJvixGeR7htW+MX/Prx70+44pJVXfjg8MWeswmp
         rAfGQfpMoZPn8u2JYmBjBlhaR2P8mLOMZR4r9Sc1kjWHa5nx8tO8Jv4Ew9WPovCcJtLx
         3HRsG6XuNau1YLlXPTM5mh3axMV/OSxp0WMdIUsBxaESxECb3bSmB8kdvlxOFa7PUEkL
         0u9e8pQ88xwbqfdvlst04hfLJZZLikwexd1+WdHsV5IJxYFk3kFcrdbTni3rnJeSjjpy
         i1fn8HNoNXzRzd9C6OMdVCBea7Efh23QlZlo2B4teWtnt+Efl6nefkLe1yjk2BbKc5I7
         mdcw==
X-Gm-Message-State: AOAM533VI6TjfSbEXA3TD+604ILUOdN0l2xH6X+HRxOCN4r+6dGCh5AW
        LdJQxadBz8CmV/QmZtV/+9DQMCOV3XTjAg==
X-Google-Smtp-Source: ABdhPJzSJpQmvNarvTXpHIvdgmoyF/qSognbcYeJypfREOfsYtlH2IPt9S1CxjOf93r1kZMCvB/ifA==
X-Received: by 2002:a65:5b43:: with SMTP id y3mr12672966pgr.415.1613824885118;
        Sat, 20 Feb 2021 04:41:25 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id np7sm11158224pjb.10.2021.02.20.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:41:24 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v4] btrfs-progs: filesystem-resize: make output more readable
Date:   Sat, 20 Feb 2021 12:41:17 +0000
Message-Id: <20210220124117.11444-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch make output of filesystem-resize command more readable and
give detail information for users. This patch provides more information
about filesystem like below.

Before:
Resize '/mnt' of '1:-1G'

After:
Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
  - print more detailed error
  - covers all the possibilities format provides
v3:
  - use snprintf than strcpy for safety
  - add diff variable for code readability
v4:
  - fix bugs for argument that has no devid
---
 cmds/filesystem.c | 120 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 0d23daf4..7ddf5880 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -28,6 +28,7 @@
 #include <linux/limits.h>
 #include <linux/version.h>
 #include <getopt.h>
+#include <limits.h>
 
 #include <btrfsutil.h>
 
@@ -1074,6 +1075,117 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
+static int check_resize_args(const char *amount, const char *path) {
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	int ret, i, dev_idx = -1;
+	u64 devid = 1;
+	const char *res_str = NULL;
+	char *devstr = NULL, *sizestr = NULL;
+	u64 new_size = 0, old_size = 0, diff = 0;
+	int mod = 0;
+	char amount_dup[BTRFS_VOL_NAME_MAX];
+
+	ret = get_fs_info(path, &fi_args, &di_args);
+
+	if (ret) {
+		error("unable to retrieve fs info");
+		return 1;
+	}
+
+	if (!fi_args.num_devices) {
+		error("no devices found");
+		free(di_args);
+		return 1;
+	}
+
+	ret = snprintf(amount_dup, BTRFS_VOL_NAME_MAX, "%s", amount);
+	if (strlen(amount) != ret) {
+		error("newsize argument is too long");
+		free(di_args);
+		return 1;
+	}
+
+	sizestr = amount_dup;
+	devstr = strchr(sizestr, ':');
+	if (devstr) {
+		sizestr = devstr + 1;
+		*devstr = '\0';
+		devstr = amount_dup;
+
+		errno = 0;
+		devid = strtoull(devstr, NULL, 10);
+
+		if (errno) {
+			error("failed to parse devid %s", devstr);
+			free(di_args);
+			return 1;
+		}
+	}
+
+	dev_idx = -1;
+	for(i = 0; i < fi_args.num_devices; i++) {
+		if (di_args[i].devid == devid) {
+			dev_idx = i;
+			break;
+		}
+	}
+
+	if (dev_idx < 0) {
+		error("cannot find devid : %lld", devid);
+		free(di_args);
+		return 1;
+	}
+
+	if (!strcmp(sizestr, "max")) {
+		res_str = "max";
+	}
+	else {
+		if (sizestr[0] == '-') {
+			mod = -1;
+			sizestr++;
+		} else if (sizestr[0] == '+') {
+			mod = 1;
+			sizestr++;
+		}
+		diff = parse_size_from_string(sizestr);
+		if (!diff) {
+			error("failed to parse size %s", sizestr);
+			free(di_args);
+			return 1;
+		}
+		old_size = di_args[dev_idx].total_bytes;
+
+		if (mod < 0) {
+			if (diff > old_size) {
+				error("current size is %s which is smaller than %s",
+				      pretty_size_mode(old_size, UNITS_DEFAULT),
+				      pretty_size_mode(diff, UNITS_DEFAULT));
+				free(di_args);
+				return 1;
+			}
+			new_size = old_size - diff;
+		} else if (mod > 0) {
+			if (diff > ULLONG_MAX - old_size) {
+				error("increasing %s is out of range",
+				      pretty_size_mode(diff, UNITS_DEFAULT));
+				free(di_args);
+				return 1;
+			}
+			new_size = old_size + diff;
+		}
+		new_size = round_down(new_size, fi_args.sectorsize);
+		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
+	}
+
+	printf("Resize device id %lld (%s) from %s to %s\n", devid, di_args[dev_idx].path,
+		pretty_size_mode(di_args[dev_idx].total_bytes, UNITS_DEFAULT),
+		res_str);
+
+	free(di_args);
+	return 0;
+}
+
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 				 int argc, char **argv)
 {
@@ -1134,7 +1246,13 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	printf("Resize '%s' of '%s'\n", path, amount);
+	ret = check_resize_args(amount, path);
+	if (ret != 0) {
+		close_file_or_dir(fd, dirstream);
+		return 1;
+	}
+
+
 	memset(&args, 0, sizeof(args));
 	strncpy_null(args.name, amount);
 	res = ioctl(fd, BTRFS_IOC_RESIZE, &args);
-- 
2.25.1

