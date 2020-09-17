Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD126D4BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIQHaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 03:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIQH36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 03:29:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D1C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 00:29:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so817524pjb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CiN7JqYoYAguLjj/UB4CXnDQ8pCulXOClAYeKFYFPR0=;
        b=jS567hlhVyUo7WUscvREmGq/ZclvzpN/5dWHP4S/5KXz0WffOlmS2YJtpr0fSL3EcW
         QlNbtU83aRKHVfZ0yHFbmiTVBPAGn0QsPej22ALBT9fI3ArQQOooozaAtRUMrZXTg09C
         F3OZo6OexNIos4hm3sfiYRjS/97YjtLq4VoehsA0xPQWiGBHgPHNNYd4PVzT01XNfUjs
         k58UKRQ8usr/TYPXg9zdE9DmKiovAPrwl4LOMGE1tF3iHMNUk1lD97ROYw8LlZ4M1QXG
         VXeHSp/G0OiG7unJ+x4E/bB5rr9X+nQBW6ZfsC5FtNlOv+T+03RjKa3SPt8AfJgoFR0C
         Bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CiN7JqYoYAguLjj/UB4CXnDQ8pCulXOClAYeKFYFPR0=;
        b=mriGbF4WRNyypvAYT1oaYrlpuokodhNWRsWDJooAbPjKG5l2uBNnPE5Tx2j40Fs3bJ
         tPOV1GEkO+D27sOtmYT/HzIIzN2p63aTcIQtLMNxQyTe9Vrw5OUC6yTfctV7KUP01KK3
         ZlGeDw65VQDicFnJF0HbPPXdMoK5k+ZL1Po3CTuiCPAH7Ea/4zlLOyG4/EUU98mBTQ8g
         xm4hMlQU98Hubb8p0znVmWM90AxnQRwie4leF3chqsNxgoVcfGF2zSMMXhP47EeRDdvI
         bgyy44QnygpV3qUZ/X+Rl9s8re8C8BDXEoZp3RUCgiF/6RbOmfS3m5zeD7vJ5/G7pu3o
         e58w==
X-Gm-Message-State: AOAM533morTb/tM0m0quo7NUXfIwce5C2zkYkVCEbS9a5kOkxS/J/Sy+
        Dh1xdpw+s0sECvi0ZYu7ksTufWhnhtw3KA==
X-Google-Smtp-Source: ABdhPJzBSY2b9KKogmjkeZNjAS9tDcVQgeOv1+udNFPQ61HPmZiAr6m1SyN9KEjCJWOH4KFU/jevGg==
X-Received: by 2002:a17:90b:245:: with SMTP id fz5mr7034961pjb.131.1600327796795;
        Thu, 17 Sep 2020 00:29:56 -0700 (PDT)
Received: from localhost.localdomain ([211.249.70.230])
        by smtp.gmail.com with ESMTPSA id y5sm19122048pge.62.2020.09.17.00.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:29:56 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: Support json format in device stats
Date:   Thu, 17 Sep 2020 07:29:47 +0000
Message-Id: <20200917072948.3354-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch supports the feature that printing device stats in json
format. So textcollector like prometheus can parse the output easier.
This patch implements option for json format and print in json when
the option enabled.

This patch implements enhancement for this issue.
https://github.com/kdave/btrfs-progs/issues/291

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/device.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index d72881f8..3e4bf837 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -467,6 +467,7 @@ static const char * const cmd_device_stats_usage[] = {
 	"",
 	"-c|--check             return non-zero if any stat counter is not zero",
 	"-z|--reset             show current stats and reset values to zero",
+	"-j|--json              show stats in json format",
 	NULL
 };
 
@@ -482,6 +483,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 	int check = 0;
 	__u64 flags = 0;
 	DIR *dirstream = NULL;
+	bool json = 0;
 
 	optind = 0;
 	while (1) {
@@ -489,6 +491,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		static const struct option long_options[] = {
 			{"check", no_argument, NULL, 'c'},
 			{"reset", no_argument, NULL, 'z'},
+			{"json", no_argument, NULL, 'j'},
 			{NULL, 0, NULL, 0}
 		};
 
@@ -503,6 +506,9 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		case 'z':
 			flags = BTRFS_DEV_STATS_RESET;
 			break;
+		case 'j':
+			json = 1;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -574,18 +580,34 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 				snprintf(canonical_path, 32,
 					 "devid:%llu", args.devid);
 			}
-
-			for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
-				/* We got fewer items than we know */
-				if (args.nr_items < dev_stats[j].num + 1)
-					continue;
-				printf("[%s].%-16s %llu\n", canonical_path,
-					dev_stats[j].name,
-					(unsigned long long)
-					 args.values[dev_stats[j].num]);
-				if ((check == 1)
-				    && (args.values[dev_stats[j].num] > 0))
-					err |= 64;
+			if (json) {
+				printf("{\n\t\"device\" : \"%s\",\n", canonical_path);
+				for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
+					/* We got fewer items than we know */
+					if (args.nr_items < dev_stats[j].num + 1)
+						continue;
+					printf("\t\"%s\" : %llu,\n",
+						dev_stats[j].name,
+						(unsigned long long)
+						 args.values[dev_stats[j].num]);
+					if ((check == 1)
+					    && (args.values[dev_stats[j].num] > 0))
+						err |= 64;
+				}
+				printf("}\n");
+			} else {
+				for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
+					/* We got fewer items than we know */
+					if (args.nr_items < dev_stats[j].num + 1)
+						continue;
+					printf("[%s].%-16s %llu\n", canonical_path,
+						dev_stats[j].name,
+						(unsigned long long)
+						 args.values[dev_stats[j].num]);
+					if ((check == 1)
+					    && (args.values[dev_stats[j].num] > 0))
+						err |= 64;
+				}
 			}
 
 			free(canonical_path);
-- 
2.17.1

