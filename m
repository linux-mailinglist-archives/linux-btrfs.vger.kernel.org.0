Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E243282A64
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Oct 2020 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgJDL0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 07:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDL0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Oct 2020 07:26:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DBC0613CE
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Oct 2020 04:26:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so3905116pgl.6
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Oct 2020 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwqTfYg0qoxvowD6xBBL+rAXZVXGM8RVqM0qbL+pD04=;
        b=WjnC+iOfQTrfoHKvneINRYmvr96g51UxLfdYwb25n0Y6UJG2tCKTFZz8Nfw8ELF0K3
         UbfXeDblgD8XC5V9kkMNGFeYyTjoXizJTbYyuu0XSMKU5ei4UNf60PeegFt8yK4SktWm
         aI9BZzgTOa/QtreKwBdpOPqTCvgprWUUH2v8sDUF636Xhg/13CyI+ufkTmmc+WtHxCqm
         bEUraMVh/ResrPaP3PLq9etxc0s02fIMj26I6d9r1iZQ4MSpqvwvshnJJ/1eVYiCWRZJ
         EgK+EePZ8B6w2FC5HDhzDfj6Rp8+ffkmq3bpqtxw2etOcBWojug3xlcx+gbP7JGudZMr
         ukpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwqTfYg0qoxvowD6xBBL+rAXZVXGM8RVqM0qbL+pD04=;
        b=j15MCoao6YvngjPdBl84MN4NCR6tVrkUxyhgayQMqtGp/MrlsYpIZh/dGUg+X67hon
         7vmPuccJy6idEFegLVtQhoRw598kkPQ+x+tLyjX3pPQfVHAC/DjraBW3ak93SPVtUDrH
         giYZyFBYIjXR9bSMWfVU1WVv19W+dskBYR59thOhWe2N3WVUwWckhlpD5lKhfkGCMwfk
         MAXkzRlijSESPEM1GAwhBsdsa62uLJmQWQ8Gpc/rHKiYq4v01Q5GitGrhSKOXpX88THd
         CaU5wx5AqYBiAGS7QGgyiQaoi6sm9U7zCEtXFwuJZRbPnzq2ZsKpDD5zJWnR2XkITghA
         Qw5Q==
X-Gm-Message-State: AOAM530uK4uM1SWfZpSKGW7jS/LApx5SdKXXRs70oegsctK+zrlqc7au
        Jq648032drRXu+zGAaqzki4=
X-Google-Smtp-Source: ABdhPJzbdT2dz4WcP5JTza+mAAo8UrRlWHZInz7YWFkVq7BTJd/tNd/acBQjKAxmmQw8z3LLDyY+bg==
X-Received: by 2002:aa7:9492:0:b029:152:545f:90d with SMTP id z18-20020aa794920000b0290152545f090dmr4923483pfk.9.1601810767775;
        Sun, 04 Oct 2020 04:26:07 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id j8sm8579059pfr.121.2020.10.04.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:26:07 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: device stats: add json output format
Date:   Sun,  4 Oct 2020 11:25:57 +0000
Message-Id: <20201004112557.5568-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
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
  "device-stats": {
    "/dev/vdb": {
      "device": "/dev/vdb",
      "write_io_errs": "0",
      "read_io_errs": "0",
      "flush_io_errs": "0",
      "corruption_errs": "0",
      "generation_errs": "0"
    }
  },
}

Cc: David Sterba <dsterba@suse.cz>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - use output formatter
---
 cmds/device.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index d72881f8..91b45d9f 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -36,6 +36,7 @@
 #include "common/path-utils.h"
 #include "common/device-utils.h"
 #include "common/device-scan.h"
+#include "common/format-output.h"
 #include "mkfs/common.h"
 
 static const char * const device_cmd_group_usage[] = {
@@ -459,6 +460,16 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(device_ready, "ready");
 
+static const struct rowspec device_stats_rowspec[] = {
+	{ .key = "device", .fmt = "%s", .out_text = "device", .out_json = "device" },
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
@@ -482,6 +493,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 	int check = 0;
 	__u64 flags = 0;
 	DIR *dirstream = NULL;
+	struct format_ctx fctx;
 
 	optind = 0;
 	while (1) {
@@ -530,6 +542,8 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		goto out;
 	}
 
+	fmt_start(&fctx, device_stats_rowspec, 24, 0);
+	fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_MAP);
 	for (i = 0; i < fi_args.num_devices; i++) {
 		struct btrfs_ioctl_get_dev_stats args = {0};
 		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
@@ -574,31 +588,34 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 				snprintf(canonical_path, 32,
 					 "devid:%llu", args.devid);
 			}
+			fmt_print_start_group(&fctx, canonical_path, JSON_TYPE_MAP);
+			fmt_print(&fctx, "device", canonical_path);
 
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
+			fmt_print_end_group(&fctx, "device");
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

