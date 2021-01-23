Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879F301672
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 16:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbhAWPiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAWPiK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 10:38:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF6C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 07:37:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so5938260pgj.4
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY2nbFUMEoXXEZKyW5DUEpoetDMhD3z83rNyILdTGfg=;
        b=dZE9Ny9X5bJgqkovMQ/Rmdo7zjLKOJT4H+GMgIhr7N6D/G7ef/ZWGvFU+KnYHpR51G
         sbpJKWpBa1gLJ5rqrvvjms8ak4HCsu/tSvDS+hiuTxEPdMFjt//Mk/LTC2xui+D2Br06
         EYaX9WEZE9h01dyBQXBfHhMgUKJl8sp626kB6J35/d0rcgaFOmUZ5RtZKCMxSa84sqAT
         sFXsYDSpf/tVhRs7a1JQmyM5hkiKvfYvDpYMZIh3uUB0XHl6fotQ23wPHWWPuedjaqcA
         LdRDg4Itv6zLJYgOu2QNj4CioZv+MY4W2gltZ493exSDiItEz/taIjp7BEBQIWOKYj2B
         4KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WY2nbFUMEoXXEZKyW5DUEpoetDMhD3z83rNyILdTGfg=;
        b=sYIvEGHd2IzXRYVo5L1FG/aORkoc9Y/EvwMnWfe5W9FmU6kt/4rzgFZKSX24xq8FHk
         eYJaliyWMSrB529JIJ+raeJuyQ0kRyEUJSWPad7KfoKwW+tDZV22VHu0jTPKzsj2qXYC
         vkybbCrVfpQ84ecsj1EAU4ofhEeIxCRmJKAUyPmey/7D5LWZ8Tjy3iG3neYLUSmjCkmi
         v/Hio+yqS+0yAP0+zbIprDhOQe9j0HRxj6CRE+M316UxzlAzsBSDfyDtJXv0MRx8g3y+
         HFCvJfcvMLgQdkdguv4XPmxvyfX631G/UTbMM/tig//pUFVN6FIqz/X4Drg4gjLioL/i
         wP/Q==
X-Gm-Message-State: AOAM532oPq5iBnscfZf7HWxnUd9L9vQEwoTpcR6AKInKXJBeMMFxQWjB
        4vCJsJN6giJ60e2RIq8LXCnlwKvE/L9hTQ==
X-Google-Smtp-Source: ABdhPJySXfZTDbhERvvvBFL+7hAjRGSmCbTn6GKkIIznVIXfkK2YXurHv8xh5rndUTmhTFKQ1qknmw==
X-Received: by 2002:a63:f211:: with SMTP id v17mr10154432pgh.321.1611416250336;
        Sat, 23 Jan 2021 07:37:30 -0800 (PST)
Received: from localhost.localdomain ([59.11.254.164])
        by smtp.gmail.com with ESMTPSA id r194sm11875937pfr.168.2021.01.23.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:37:29 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: filesystem-resize: make output more readable
Date:   Sat, 23 Jan 2021 15:37:20 +0000
Message-Id: <20210123153720.4294-1-realwakka@gmail.com>
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
---
 cmds/filesystem.c | 112 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index ba2e5928..cec3f380 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -28,6 +28,7 @@
 #include <linux/limits.h>
 #include <linux/version.h>
 #include <getopt.h>
+#include <limits.h>
 
 #include <btrfsutil.h>
 
@@ -1074,6 +1075,109 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
+static int check_resize_args(const char *amount, const char *path) {
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	int ret, i, devid = 0, dev_idx = -1;
+	const char *res_str = NULL;
+	char *devstr = NULL, *sizestr = NULL;
+	u64 new_size = 0, old_size = 0;
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
+	strcpy(amount_dup, amount);
+	devstr = strchr(amount_dup, ':');
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
+		error("cannot find devid : %d", devid);
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
+		new_size = parse_size(sizestr);
+		if (!new_size) {
+			error("failed to parse size %s", sizestr);
+			free(di_args);
+			return 1;
+		}
+		old_size = di_args[dev_idx].total_bytes;
+
+		if (mod < 0) {
+			if (new_size > old_size) {
+				error("current size is %s which is smaller than %s",
+				      pretty_size_mode(old_size, UNITS_DEFAULT),
+				      pretty_size_mode(new_size, UNITS_DEFAULT));
+				free(di_args);
+				return 1;
+			}
+			new_size = old_size - new_size;
+		} else if (mod > 0) {
+			if (new_size > ULLONG_MAX - old_size) {
+				error("increasing %s is out of range",
+				      pretty_size_mode(new_size, UNITS_DEFAULT));
+				free(di_args);
+				return 1;
+			}
+			new_size = old_size + new_size;
+		}
+		new_size = round_down(new_size, fi_args.sectorsize);
+		res_str = pretty_size_mode(new_size, UNITS_DEFAULT);
+	}
+
+	printf("Resize device id %d (%s) from %s to %s\n", devid, di_args[dev_idx].path,
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
@@ -1139,7 +1243,13 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	printf("Resize '%s' of '%s'\n", path, amount);
+	ret = check_resize_args(path, amount);
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

