Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78022D7B62
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390313AbgLKQtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 11:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbgLKQtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 11:49:12 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADBC0613D3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 08:48:32 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 143so1391618pge.10
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yGCGivgifVgvTEe67Vi7PlCOMWnEr3G5AYWPCOdUhQ=;
        b=rio5MV5a/6A1Hzb2vStQHh2+LM/HMLkwE1ijXNd1WaL4NYOfRy6u0qBurD+LkX9yPi
         2ySfiSw5ZBvL6sX6jCVhHn8WcWRhuUVS2vWD5Qap6TWhntNY9TMUcHNIvzqM/N8/yzfQ
         jXCDhxL7umHhZDFuRC6efzvG1R7dgEQlplv64cZugNhbaFtC3OSRrWR4oOtsKDJau84W
         dGMITKipHt/Nup6zDOShgb2LHK+FJcShMY5nXh9BNhFwftNtxWXjg7zgqjIdP3KA5xYC
         SfUu2jnLUqXELflDDDy0YWE9Ai91Rroaw4s544Af3vdfWo8z6SRG7A8lvCDe/XeE2poQ
         tEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yGCGivgifVgvTEe67Vi7PlCOMWnEr3G5AYWPCOdUhQ=;
        b=O5GAckN0smSt86ZeiWzkcI9wsoTR7M3rSAkXQgM0T58V8iJZ3ct6OjPSUHShB6MW0S
         M+E0tnncOYa7wyNb6vYFUt1raYrzPQNr97kR1m02vTDxTDTHqLwT4cI50FOEkHPv3JjJ
         ZhdobIbXnCj0bi+mwuHs1q7/2TC89rcZLX9hYrOMVEGdAhRhGoGkJ8NKxfH+BYBuA7p3
         soBuojv+bEq3nKGL+rwDpZYDK5cbnLi+fipjhjFSuRWiZvcsOyeEqTZpnu/b2FoINXov
         oavG7Rc2+qsD9jeKhC1UgWYuase6BoOEXwCU01nzTwuq8wASUAqWxquWyyHyG8DxQXnb
         ydyQ==
X-Gm-Message-State: AOAM532kVe6X1eyj41SoNPKf9ToTocHda9BitxM9Ksp9Kneuf5bThQHZ
        zkuIFhJpY0uoOTQCspBQDcUP09bBKkkTug==
X-Google-Smtp-Source: ABdhPJyRvjT0o8cp7H2UbBINpomeRC+JtGsc9PRmzgSvN/oco7Wwic3kiEedxq10XAAryIVYasT8WA==
X-Received: by 2002:a63:943:: with SMTP id 64mr12785652pgj.80.1607705311739;
        Fri, 11 Dec 2020 08:48:31 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id z20sm10353713pjq.16.2020.12.11.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 08:48:31 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v3 2/2] btrfs-progs: device stats: add json output format
Date:   Fri, 11 Dec 2020 16:48:12 +0000
Message-Id: <20201211164812.459012-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211164812.459012-1-realwakka@gmail.com>
References: <20201211164812.459012-1-realwakka@gmail.com>
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
v3:
 - use fmt_print_start_group with NULL name
---
 cmds/device.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index d72881f8..204e834b 100644
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
+			fmt_print_start_group(&fctx, NULL, JSON_TYPE_MAP);
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
+			fmt_print_end_group(&fctx, NULL);
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

