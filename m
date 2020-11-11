Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565252AF5F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgKKQOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKQOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 11:14:41 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19DC0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:14:40 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m13so1714852pgl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jvRQYBjeTF3y3FIciKuHYVuuFBkpyDjd42ORP46q0U=;
        b=CvKy5TrFs/d0cAfi3dP65SyctTycquhENf1phrC/JqEbwrSMltAP4eG3nKpPCnKmTY
         hjwXXRLMEH/CbjI5yJ7bCaxlr/Xcz/AuLvsXQ5MCuwOILQIGNBqgfMUGCA5WHyfbG5Rh
         84Ak+zFPNPS66wxz7Mfu4HG5e5TRDjmECj+BEZc4JWXni9AOoZHS5n+RVHgAIDRNrE1b
         FJs04x0yWTmkVVK4p9HAKGLmU4fQgK1f713UjHZXrBppbqmOCHjLmjslS2zpNoPRGjMT
         KDo4vj4+n8RTQbM0aVDQokzEP/wpuZFkpbCEEZ7h4MYIj3e2No2+3vXeP7O4KCqdzN0F
         RSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jvRQYBjeTF3y3FIciKuHYVuuFBkpyDjd42ORP46q0U=;
        b=h4WMO+yoKdxuXU5wJZrLLsTONx90UporZrF+1rLY7VIhSKqiIMVjoRa/cAKeh6F8Zl
         bax8hr0d0aIwTWWiBrWOio7m2/RI3RqprMwtT6uxeajXb/VvaeaLNCeVBhvhzsfn5Cnd
         L5LW/4LgZ4PI2BG2WncnLw7Tpco/3dhB/tQytsxAwPV0cwq+a7TNoG4bQGy6pA+r8CqV
         ZJTm4nXWdtA4eZmXmYnrxBEHl9xqUYXfxCz3+7Kp6QfAEiiCKQzWB6ROilPjBdMGAduX
         qYM/AgyMWKADH4uDADt3g0GakWf6+cij3JCUOy8MRV/h1Ztbp0PTITA0POuaWS0nRcU5
         T1Lw==
X-Gm-Message-State: AOAM530Spr0jZ5eSjwD+eJeZh+/ky82PI35731KfuJRNH7WAyA4lPjlF
        j3Qr46hKrZ+VAIGb+uTSA7NoRt3KPJFwpA==
X-Google-Smtp-Source: ABdhPJzX/cBVB91ul46+Z85HkES1sz3TaVtrXe41/5L2hEt3elNST5Kg//SVhYKSVhhbY80hFCcx4w==
X-Received: by 2002:a63:f951:: with SMTP id q17mr2444329pgk.199.1605111280081;
        Wed, 11 Nov 2020 08:14:40 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id k5sm2926618pjs.14.2020.11.11.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:14:39 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH 2/2] btrfs-progs: device stats: add json output format
Date:   Wed, 11 Nov 2020 16:14:07 +0000
Message-Id: <20201111161406.3104-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111161406.3104-1-realwakka@gmail.com>
References: <20201111161406.3104-1-realwakka@gmail.com>
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

