Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BB2AF6B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgKKQjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 11:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKQjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 11:39:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D853C0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:39:23 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so1243497pll.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CqEDL9GgQjQlLyajpvj6DCXIy4N69WFlawiWRoqOkE=;
        b=PZsrKWnQFo/kAa1nY/jOyuovHpzeI8FaS/enxhsaFp1pTvIU/6zjcPs92HhosWgNpW
         DohnQBprKE6GbTMv1NQqtyGf7O1fP47/cUfgwMZl3gaPGIjs95p5UevGmsZvLlwxRPKT
         gGt5UigQImYnTXndDPkLF2s+x8c8BvpILHtJv/RmBih2KQ3q/OudmQXW91C22dTbDKZK
         fhaa1UNV3FQynCzAbzc+Byl9DbjJYI5t9j6eC8D5jLl0EVHm7k/Hfkl2bB8zX9/aH3fA
         oR6sQGoZUVK7rw6xp1OFf+XU5wXBcYkR/DlMKw0bz9NZDOlVVAwdok4RRUQAbVY2thHG
         hlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CqEDL9GgQjQlLyajpvj6DCXIy4N69WFlawiWRoqOkE=;
        b=pVFc+Qqh+f6rUSJazYDITs6N9UtiAwz2FXbONQFbpF6BNZJwws9EhTv1Iu1zZqIFcc
         PieKvC2UWl4XFjsprEOQoqtGPKdCeCa6Jk3Mh4BywEEnTV9yoe+8HDGzwMvSsSN+w/hf
         ts155MKcTZlfC3V0PzhOAPBoH3dgtVOuMm45PYgfFsP9V4W9rVXUTb8W1Z/I7uz2Uz6E
         VQdBxzn01MJ4B4Csl0ksmCAy+gXgP7t4GUzVdSUzLyHe6TmrCkhmTMObysTMnIsXPcay
         gQRWDJtOkO1eatmCJegjn5WKXhrc2WSYffqy2eX0y8IU811A95D//eSMMXYmfqmeweDQ
         3FBw==
X-Gm-Message-State: AOAM532CTRiZPrBQi3m8BQ2wT3urDtsXyhonv/vsVu1qcBZrDZBf/slu
        5jJCatXLVNwXtW1ii7gu5Zk=
X-Google-Smtp-Source: ABdhPJx5NXqJUegfLhMR7GbVJVAr76IfZ6L94Dh6cW/LF6u5zZYOIPtRDMz/vVU4zJd+DwdfjfxpIg==
X-Received: by 2002:a17:90a:680e:: with SMTP id p14mr4874720pjj.34.1605112762914;
        Wed, 11 Nov 2020 08:39:22 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id y8sm3013533pge.22.2020.11.11.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:39:22 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2 2/2] btrfs-progs: device stats: add json output format
Date:   Wed, 11 Nov 2020 16:39:09 +0000
Message-Id: <20201111163909.3968-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111163909.3968-1-realwakka@gmail.com>
References: <20201111163909.3968-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add supports for json formatting, this patch changes hard coded printing
code to formatted print with output formatter. Json output would be
useful for other programs that parse output of the command. but it
changes the text format.

Example text format:

device:                 /dev/vdb
devid			1
write_io_errs:          0
read_io_errs:           0
flush_io_errs:          0
corruption_errs:        0
generation_errs:        0

Example json format:

{
  "__header": {
    "version": "1"
  },
  "device-stats": [
    {
      "device": "/dev/vdb",
      "devid": "1",
      "write_io_errs": "0",
      "read_io_errs": "0",
      "flush_io_errs": "0",
      "corruption_errs": "0",
      "generation_errs": "0"
    }
  ],
}

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - use json array for print
---
 cmds/device.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index d72881f8..8b8fc85c 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -36,6 +36,7 @@
 #include "common/path-utils.h"
 #include "common/device-utils.h"
 #include "common/device-scan.h"
+#include "common/format-output.h"
 #include "mkfs/common.h"
 
 static const char * const device_cmd_group_usage[] = {
@@ -459,6 +460,17 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(device_ready, "ready");
 
+static const struct rowspec device_stats_rowspec[] = {
+	{ .key = "device", .fmt = "%s", .out_text = "device", .out_json = "device" },
+	{ .key = "devid", .fmt = "%u", .out_text = "devid", .out_json = "devid" },
+	{ .key = "write_io_errs", .fmt = "%llu", .out_text = "write_io_errs", .out_json = "write_io_errs" },
+	{ .key = "read_io_errs", .fmt = "%llu", .out_text = "read_io_errs", .out_json = "read_io_errs" },
+	{ .key = "flush_io_errs", .fmt = "%llu", .out_text = "flush_io_errs", .out_json = "flush_io_errs" },
+	{ .key = "corruption_errs", .fmt = "%llu", .out_text = "corruption_errs", .out_json = "corruption_errs" },
+	{ .key = "generation_errs", .fmt = "%llu", .out_text = "generation_errs", .out_json = "generation_errs" },
+	ROWSPEC_END
+};
+
 static const char * const cmd_device_stats_usage[] = {
 	"btrfs device stats [options] <path>|<device>",
 	"Show device IO error statistics",
@@ -482,6 +494,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 	int check = 0;
 	__u64 flags = 0;
 	DIR *dirstream = NULL;
+	struct format_ctx fctx;
 
 	optind = 0;
 	while (1) {
@@ -530,6 +543,8 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		goto out;
 	}
 
+	fmt_start(&fctx, device_stats_rowspec, 24, 0);
+	fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
 	for (i = 0; i < fi_args.num_devices; i++) {
 		struct btrfs_ioctl_get_dev_stats args = {0};
 		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
@@ -548,6 +563,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 			err |= 1;
 		} else {
 			char *canonical_path;
+			char devid_str[32];
 			int j;
 			static const struct {
 				const char name[32];
@@ -574,31 +590,36 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 				snprintf(canonical_path, 32,
 					 "devid:%llu", args.devid);
 			}
+			snprintf(devid_str, 32, "%llu", args.devid);
+			fmt_print_start_object(&fctx);
+			fmt_print(&fctx, "device", canonical_path);
+			fmt_print(&fctx, "devid", di_args[i].devid);
 
 			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
 				/* We got fewer items than we know */
 				if (args.nr_items < dev_stats[j].num + 1)
 					continue;
-				printf("[%s].%-16s %llu\n", canonical_path,
-					dev_stats[j].name,
-					(unsigned long long)
-					 args.values[dev_stats[j].num]);
+
+				fmt_print(&fctx, dev_stats[j].name, args.values[dev_stats[j].num]);
 				if ((check == 1)
 				    && (args.values[dev_stats[j].num] > 0))
 					err |= 64;
 			}
-
+			fmt_print_end_object(&fctx);
 			free(canonical_path);
 		}
 	}
 
+	fmt_print_end_group(&fctx, "device-stats");
+	fmt_end(&fctx);
+
 out:
 	free(di_args);
 	close_file_or_dir(fdmnt, dirstream);
 
 	return err;
 }
-static DEFINE_SIMPLE_COMMAND(device_stats, "stats");
+static DEFINE_COMMAND_WITH_FLAGS(device_stats, "stats", CMD_FORMAT_JSON);
 
 static const char * const cmd_device_usage_usage[] = {
 	"btrfs device usage [options] <path> [<path>..]",
-- 
2.25.1

