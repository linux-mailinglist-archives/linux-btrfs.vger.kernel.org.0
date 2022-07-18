Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40015780DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 13:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiGRLes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGRLeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 07:34:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B82D1ADA9
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 04:34:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 661DD33A63;
        Mon, 18 Jul 2022 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658144081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51nYkYEvdKJbYTXk2TM97GBM/9AMhnz3yM01+5TIcPo=;
        b=tgG2dZ1YBeNeA0Ih+/9usTrZ4yElM7G+NaCVD43XilL4WdVi5isxWdEjdafVh229pjrinR
        Kg63DL6gWYSW0R2m+Occ0jIl2BW0LsWvnkRBCafb2wd55xpWZCSOmmslts2met5j3rb7E8
        wCdZmL6APpYlVeQeIWhYx3lyaBifaNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33D4813754;
        Mon, 18 Jul 2022 11:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHzmCVFF1WJsbAAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 18 Jul 2022 11:34:41 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: add support for tabular format for device stats
Date:   Mon, 18 Jul 2022 14:34:39 +0300
Message-Id: <20220718113439.2997247-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718113439.2997247-1-nborisov@suse.com>
References: <20220718113439.2997247-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support for the -T switch to 'device stats" command such that
executing 'btrfs device stats -T' produces:

Id Path     Write errors Read errors Flush errors Corruption errors Generation errors
-- -------- ------------ ----------- ------------ ----------------- -----------------
 1 /dev/vdc            0           0            0                 0                 0
 2 /dev/vdd            0           0            0                 0                 0

Link: https://lore.kernel.org/linux-btrfs/d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds/device.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index feffe9184726..926fbbd64615 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -27,6 +27,7 @@
 #include "kerncompat.h"
 #include "kernel-shared/ctree.h"
 #include "ioctl.h"
+#include "common/string-table.h"
 #include "common/utils.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/zoned.h"
@@ -572,6 +573,7 @@ static const char * const cmd_device_stats_usage[] = {
 	"",
 	"-c|--check             return non-zero if any stat counter is not zero",
 	"-z|--reset             show current stats and reset values to zero",
+	"-T                     show current stats in tabular format",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_FORMAT,
 	NULL
@@ -642,17 +644,75 @@ static int _print_device_stat_string(struct format_ctx *fctx,
 	return err;
 }

+
+static int _print_device_stat_tabular(struct string_table *table, int row,
+		struct btrfs_ioctl_get_dev_stats *args, char *path, bool check)
+{
+	char *canonical_path = path_canonicalize(path);
+	int j;
+	int err = 0;
+	static const struct {
+		const char name[32];
+		enum btrfs_dev_stat_values stat_idx;
+	} dev_stats[] = {
+		{ "write_io_errs", BTRFS_DEV_STAT_WRITE_ERRS },
+		{ "read_io_errs", BTRFS_DEV_STAT_READ_ERRS },
+		{ "flush_io_errs", BTRFS_DEV_STAT_FLUSH_ERRS },
+		{ "corruption_errs", BTRFS_DEV_STAT_CORRUPTION_ERRS },
+		{ "generation_errs", BTRFS_DEV_STAT_GENERATION_ERRS },
+	};
+
+	/* skip header + --- line */
+	row += 2;
+
+	/* No path when device is missing. */
+	if (!canonical_path) {
+		canonical_path = malloc(32);
+
+		if (!canonical_path) {
+			error("not enough memory for path buffer");
+			return -ENOMEM;
+		}
+
+		snprintf(canonical_path, 32, "devid:%llu", args->devid);
+	}
+	table_printf(table, 0, row, ">%llu", args->devid);
+	table_printf(table, 1, row, ">%s", canonical_path);
+	free(canonical_path);
+
+	for (j = 0; j < ARRAY_SIZE(dev_stats); j++) {
+		enum btrfs_dev_stat_values stat_idx = dev_stats[j].stat_idx;
+		/* We got fewer items than we know */
+		if (args->nr_items < stat_idx + 1)
+			continue;
+
+	table_printf(table, 2, row, ">%llu", args->values[stat_idx]);
+	table_printf(table, 3, row, ">%llu", args->values[stat_idx]);
+	table_printf(table, 4, row, ">%llu", args->values[stat_idx]);
+	table_printf(table, 5, row, ">%llu", args->values[stat_idx]);
+	table_printf(table, 6, row, ">%llu", args->values[stat_idx]);
+
+	if (check && (args->values[stat_idx] > 0))
+		err |= 64;
+	}
+
+	return err;
+}
+
 static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	char *dev_path;
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args *di_args = NULL;
+	struct string_table *table = NULL;
 	int ret;
 	int fdmnt;
 	int i;
 	int err = 0;
 	bool check = false;
+	bool free_table = false;
 	__u64 flags = 0;
+	bool tabular = false;
 	DIR *dirstream = NULL;
 	struct format_ctx fctx;

@@ -665,7 +725,7 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 			{NULL, 0, NULL, 0}
 		};

-		c = getopt_long(argc, argv, "cz", long_options, NULL);
+		c = getopt_long(argc, argv, "Tcz", long_options, NULL);
 		if (c < 0)
 			break;

@@ -676,6 +736,9 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		case 'z':
 			flags = BTRFS_DEV_STATS_RESET;
 			break;
+		case 'T':
+			tabular = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -703,11 +766,35 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		goto out;
 	}

-	fmt_start(&fctx, device_stats_rowspec, 24, 0);
-	fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
+	if (tabular) {
+		/*
+		 * cols = Id/Path/write/read/flush/corruption/generation
+		 * rows = num devices + 2 (header and ---- line)
+		 */
+		table = table_create(7, fi_args.num_devices + 2);
+		if (!table) {
+			error("not enough memory");
+			goto out;
+		}
+		free_table = true;
+		table_printf(table, 0,0, "<Id");
+		table_printf(table, 1,0, "<Path");
+		table_printf(table, 2,0, "<Write errors");
+		table_printf(table, 3,0, "<Read errors");
+		table_printf(table, 4,0, "<Flush errors");
+		table_printf(table, 5,0, "<Corruption errors");
+		table_printf(table, 6,0, "<Generation errors");
+		for (i = 0; i < 7; i++)
+			table_printf(table, i, 1, "*-");
+	} else {
+		fmt_start(&fctx, device_stats_rowspec, 24, 0);
+		fmt_print_start_group(&fctx, "device-stats", JSON_TYPE_ARRAY);
+	}
+
 	for (i = 0; i < fi_args.num_devices; i++) {
 		struct btrfs_ioctl_get_dev_stats args = {0};
 		char path[BTRFS_DEVICE_PATH_NAME_MAX + 1];
+		int err2;

 		strncpy(path, (char *)di_args[i].path,
 			BTRFS_DEVICE_PATH_NAME_MAX);
@@ -724,7 +811,11 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 			goto out;
 		}

-		int err2 = _print_device_stat_string(&fctx, &args, path, check);
+		if (tabular)
+			err2 = _print_device_stat_tabular(table, i, &args, path, check);
+		else
+			err2 = _print_device_stat_string(&fctx, &args, path, check);
+
 		if (err2) {
 			if (err2 < 0) {
 				err = err2;
@@ -734,12 +825,18 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}

-	fmt_print_end_group(&fctx, "device-stats");
-	fmt_end(&fctx);
+	if (tabular) {
+		table_dump(table);
+	} else {
+		fmt_print_end_group(&fctx, "device-stats");
+		fmt_end(&fctx);
+	}

 out:
 	free(di_args);
 	close_file_or_dir(fdmnt, dirstream);
+	if (free_table)
+		table_free(table);

 	return err;
 }
--
2.17.1

