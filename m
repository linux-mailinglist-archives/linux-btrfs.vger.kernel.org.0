Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25831FDC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSRTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSRTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 12:19:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB0C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 09:18:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t11so4995631pgu.8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJroQcxQ3Kk82KLHVTLAfrhs9I2RuY7LydEmhVg+Ny4=;
        b=J7Qd1jrJvWQrZ8VSgbtAfhkqDuOYJWGYja66xtNMMHXOnqHH8kZqhCTYUJQCC1nsa3
         q7sndtYjsYEpwwD42+Pdxku2ILUgjmDoEYGSTG1LqjR7Ic8V3QJWVvps5yaxm4mm7ePN
         iKc6Yb7xanwJfCuUMi+/SjRBdCjpivYUNIdYxOr9XBIdqe5AKW5EG+aPIdqyICFI/Di8
         cyIib/rDNbb3hq7cetsy6e0kddyygDzTGa9zQIpGjAvdvsrr0QYhv9hD7HEFwpJPFbD7
         lJ3y6nxijl25r1DE9s9s7lO1d95kdp3AI6jX6Q9ckoP/FhRb/Yh6QaDtoYF64sjfDELU
         Yp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJroQcxQ3Kk82KLHVTLAfrhs9I2RuY7LydEmhVg+Ny4=;
        b=DeE9hEs7kBnnx2tqNcqBn26hmo6C1nKQgYumwhl0zZyZMxAX/2pAZYIWVKq5XnjkLi
         JNt42andsrx25ilF4GE53E6zEvSwnAX4Zj0Pn3HTEgwsYjKjWGqZQbHVJL88TesPU2lT
         UQCbzUqH0Qd9F4vKSh7Vw0+GGFndI515nONaTmXT666IIAhXMQ6FjrYejE3+zWZaNLL5
         nnVZSKwlmSv9c4DmtnCha9R64TPgnINYgFl7FnAzspbptJsE29W9sdZiHXqIznxOqvOx
         k02T68kIoAlgE7ibDjZoEUEJoQJrvwe56darMTy1A2aptPxkBPBsJq8AoU/ZVRRsuICc
         6Ebg==
X-Gm-Message-State: AOAM533Ydeh8/T5/lJyZV1wKdFkJiw9qUBtSjZLGLDNsm3Nu2UtyJW2B
        vOAUTSqlAS3R6d6oKbZOQ1NFqr3lBBzS8g==
X-Google-Smtp-Source: ABdhPJyBfuSy64b8kazZLlO40enRpHhWcmgQiIMVdVlYOgGONxi/986m6zWEax3ViiaoVT5uF3nBQg==
X-Received: by 2002:a65:53ca:: with SMTP id z10mr9385369pgr.271.1613755109620;
        Fri, 19 Feb 2021 09:18:29 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id h6sm9792631pfv.84.2021.02.19.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:18:29 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3] btrfs-progs: filesystem-resize: make output more readable
Date:   Fri, 19 Feb 2021 17:18:18 +0000
Message-Id: <20210219171818.10170-1-realwakka@gmail.com>
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
---
 cmds/filesystem.c | 119 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 0d23daf4..faa06a52 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -28,6 +28,7 @@
 #include <linux/limits.h>
 #include <linux/version.h>
 #include <getopt.h>
+#include <limits.h>
 
 #include <btrfsutil.h>
 
@@ -1074,6 +1075,116 @@ static const char * const cmd_filesystem_resize_usage[] = {
 	NULL
 };
 
+static int check_resize_args(const char *amount, const char *path) {
+	struct btrfs_ioctl_fs_info_args fi_args;
+	struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	int ret, i, dev_idx = -1;
+	u64 devid = 0;
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
@@ -1134,7 +1245,13 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
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

