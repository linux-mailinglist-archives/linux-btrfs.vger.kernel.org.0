Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7058693DDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 06:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBMF06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 00:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBMF04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 00:26:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8CEB5D
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 21:26:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9B3133B40
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676266013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4dNMj6kamWED0n4e1HTPwvpgYmXXBkJyEm8KsvVO/g=;
        b=PO01cm+gPa26aHi1J5QoITLZ/byw8HN7kFQe1QmsGUNaBd3JbBJIFym+s8oNpo1kyS0KgA
        y+ogqmLNNQocUUW0Kk2ENksiZWXTtg6v6JWinigbIzuxckpm+WHiLB6ZhtYIYKxRgOPUDE
        HrX4EWed3ZBLTFye5ciUjGG5DhmJfPU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B97C13A1F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6DO0NBzK6WOAbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:26:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: make usage() call to properly return an exit value
Date:   Mon, 13 Feb 2023 13:26:32 +0800
Message-Id: <6a9278ecf44e28fbb97a069ae13d5bab5506e55d.1676265837.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676265837.git.wqu@suse.com>
References: <cover.1676265837.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Currently cli/009 test case failed with different exit number:

  ====== RUN CHECK /home/adam/btrfs-progs/btrfstune --help
  usage: btrfstune [options] device
  [...]
  failed: /home/adam/btrfs-progs/btrfstune --help
  test failed for case 009-btrfstune

[CAUSE]
In tune/main.c, we have the following call on usage():

  static void print_usage(int ret)
  {
	usage(&tune_cmd);
	exit(ret);
  }

However usage() itself would always call exit(1):

  void usage(const struct cmd_struct *cmd)
  {
	usage_command_usagestr(cmd->usagestr, NULL, 0, true, true);
	exit(1);
  }

This makes prevents any caller of usage() to modify its exit number.

[FIX]
Add a new argument @ret for print_usage(), so we can properly return 0
for -h/--help usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 4 ++--
 cmds/device.c         | 4 ++--
 cmds/filesystem.c     | 2 +-
 cmds/qgroup.c         | 2 +-
 cmds/quota.c          | 4 ++--
 cmds/receive.c        | 4 ++--
 cmds/restore.c        | 4 ++--
 cmds/subvolume-list.c | 2 +-
 cmds/subvolume.c      | 2 +-
 common/help.c         | 6 +++---
 common/help.h         | 2 +-
 image/main.c          | 3 +--
 mkfs/main.c           | 3 +--
 tune/main.c           | 3 +--
 14 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/check/main.c b/check/main.c
index 899d8bd88e2a..38e44eae6ef6 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10075,7 +10075,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				break;
 			case '?':
 			case 'h':
-				usage(cmd);
+				usage(cmd, 0);
 			case GETOPT_VAL_REPAIR:
 				printf("enabling repair mode\n");
 				opt_check_repair = 1;
@@ -10130,7 +10130,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (check_argc_exact(argc - optind, 1))
-		usage(cmd);
+		usage(cmd, 1);
 
 	if (g_task_ctx.progress_enabled) {
 		g_task_ctx.tp = TASK_NOTHING;
diff --git a/cmds/device.c b/cmds/device.c
index 69fe3fb3b9a8..555ee13724d5 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -440,10 +440,10 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 	devstart = optind;
 
 	if (all && forget)
-		usage(cmd);
+		usage(cmd, 1);
 
 	if (all && check_argc_max(argc - optind, 1))
-		usage(cmd);
+		usage(cmd, 1);
 
 	if (all || argc - optind == 0) {
 		if (forget) {
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index b189d7cb706d..bfcf7d1bcaf0 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -752,7 +752,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
 	if (argc > optind) {
 		search = argv[optind];
 		if (*search == 0)
-			usage(cmd);
+			usage(cmd, 1);
 		type = check_arg_type(search);
 
 		/*
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index d58d9a91cb25..7389b386fc05 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -2136,7 +2136,7 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 		args.qgroupid = parse_qgroupid_or_path(argv[optind + 1]);
 		path = argv[optind + 2];
 	} else
-		usage(cmd);
+		usage(cmd, 1);
 
 	fd = btrfs_open_dir(path, &dirstream, 1);
 	if (fd < 0)
diff --git a/cmds/quota.c b/cmds/quota.c
index d11b0aaf8cbd..9ae614ea1231 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -79,7 +79,7 @@ static int cmd_quota_enable(const struct cmd_struct *cmd, int argc, char **argv)
 	ret = quota_ctl(BTRFS_QUOTA_CTL_ENABLE, argc, argv);
 
 	if (ret < 0)
-		usage(cmd);
+		usage(cmd, 1);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(quota_enable, "enable");
@@ -100,7 +100,7 @@ static int cmd_quota_disable(const struct cmd_struct *cmd,
 	ret = quota_ctl(BTRFS_QUOTA_CTL_DISABLE, argc, argv);
 
 	if (ret < 0)
-		usage(cmd);
+		usage(cmd, 1);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(quota_disable, "disable");
diff --git a/cmds/receive.c b/cmds/receive.c
index 1d623ae3ce90..8d5f8721850e 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1762,9 +1762,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (dump && check_argc_exact(argc - optind, 0))
-		usage(cmd);
+		usage(cmd, 1);
 	if (!dump && check_argc_exact(argc - optind, 1))
-		usage(cmd);
+		usage(cmd, 1);
 
 	tomnt = argv[optind];
 
diff --git a/cmds/restore.c b/cmds/restore.c
index 19df6be2f539..85b98d502ac3 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1481,9 +1481,9 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (!list_roots && check_argc_min(argc - optind, 2))
-		usage(cmd);
+		usage(cmd, 1);
 	else if (list_roots && check_argc_min(argc - optind, 1))
-		usage(cmd);
+		usage(cmd, 1);
 
 	if (fs_location && root_objectid) {
 		error("can't use -f and -r at the same time");
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 3de167f95685..c94245070540 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -1645,7 +1645,7 @@ out:
 	if (comparer_set)
 		free(comparer_set);
 	if (uerr)
-		usage(cmd);
+		usage(cmd, 1);
 	return !!ret;
 }
 DEFINE_SIMPLE_COMMAND(subvolume_list, "list");
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 50aac4034db4..e194ded54b3b 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1299,7 +1299,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	if (by_rootid && by_uuid) {
 		error(
 		"options --rootid and --uuid cannot be used at the same time");
-		usage(cmd);
+		usage(cmd, 1);
 	}
 
 	fullpath = realpath(argv[optind], NULL);
diff --git a/common/help.c b/common/help.c
index 8145df9e5781..0e50ba1dad53 100644
--- a/common/help.c
+++ b/common/help.c
@@ -105,7 +105,7 @@ void clean_args_no_options(const struct cmd_struct *cmd, int argc, char *argv[])
 		switch (c) {
 		default:
 			if (cmd->usagestr)
-				usage(cmd);
+				usage(cmd, 1);
 		}
 	}
 }
@@ -380,10 +380,10 @@ void usage_unknown_option(const struct cmd_struct *cmd, char **argv)
 }
 
 __attribute__((noreturn))
-void usage(const struct cmd_struct *cmd)
+void usage(const struct cmd_struct *cmd, int ret)
 {
 	usage_command_usagestr(cmd->usagestr, NULL, 0, true, true);
-	exit(1);
+	exit(ret);
 }
 
 static void usage_command_group_internal(const struct cmd_group *grp, bool full,
diff --git a/common/help.h b/common/help.h
index 02286847e13a..9375ab6e32b1 100644
--- a/common/help.h
+++ b/common/help.h
@@ -103,7 +103,7 @@ __attribute__((noreturn))
 void usage_unknown_option(const struct cmd_struct *cmd, char **argv);
 
 __attribute__((noreturn))
-void usage(const struct cmd_struct *cmd);
+void usage(const struct cmd_struct *cmd, int ret);
 void usage_command(const struct cmd_struct *cmd, bool full, bool err);
 void usage_command_group(const struct cmd_group *grp, bool all, bool err);
 void usage_command_group_short(const struct cmd_group *grp);
diff --git a/image/main.c b/image/main.c
index 65aa3b30b182..3e7a34533716 100644
--- a/image/main.c
+++ b/image/main.c
@@ -3053,8 +3053,7 @@ static const struct cmd_struct image_cmd = {
 
 static void print_usage(int ret)
 {
-	usage(&image_cmd);
-	exit(ret);
+	usage(&image_cmd, ret);
 }
 
 int BOX_MAIN(image)(int argc, char *argv[])
diff --git a/mkfs/main.c b/mkfs/main.c
index 341ba4089484..da123ee4455d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -448,8 +448,7 @@ static const struct cmd_struct mkfs_cmd = {
 
 static void print_usage(int ret)
 {
-	usage(&mkfs_cmd);
-	exit(ret);
+	usage(&mkfs_cmd, ret);
 }
 
 static int zero_output_file(int out_fd, u64 size)
diff --git a/tune/main.c b/tune/main.c
index acfc126286d0..79b676972b50 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -95,8 +95,7 @@ static const struct cmd_struct tune_cmd = {
 
 static void print_usage(int ret)
 {
-	usage(&tune_cmd);
-	exit(ret);
+	usage(&tune_cmd, ret);
 }
 
 int BOX_MAIN(btrfstune)(int argc, char *argv[])
-- 
2.39.1

