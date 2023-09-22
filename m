Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1F7AA72C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjIVCzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjIVCzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 22:55:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C30192
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 19:55:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 408F91F37E
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695351343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9y3371NOXMIbJxYGCBM46U2wHtIx8SLHsgdcIvoS7HY=;
        b=Vji8Os2vuele36oY0QuJr+XxvuJm7JuKYQmleyDbaAzse9fXSv/2mHgVU95ega5AgjIMlW
        NGS5Bz23YLvGtSVAHdZN7GDyYMuYlqZnLdtCtFGKv/WEIdHMuWps1ElL0D7Xx+CaoiuxEf
        MLZ+9UNqJdaImTUj7PJa+3fDTuSdPqE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6361E13438
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UCqrBy4CDWV6LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:55:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: introduce "abort=super" mount option
Date:   Fri, 22 Sep 2023 12:25:20 +0930
Message-ID: <65c603a8c60f997a8b23b86a275d46ee39636284.1695350405.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695350405.git.wqu@suse.com>
References: <cover.1695350405.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs would only report error when the primary super block
writeback failed.
If the backup ones failed to be written, we still continue and just
output a warning.

This is fine but sometimes such warning is an early indication of bigger
problems.
For developers and other critical missions, we may want the filesystem
to be more noisy by abort the current transaction for those situations.

This patch would introduce the mount option group "abort=", and
introduce the first sub option: "super".
This new option would make btrfs to abort and mark the fs read-only if
any super block failed to be written back.

This is different from the existing code by:

- We do not ignore backup super blocks write failure

- We do not accept any super writeback failure for any device
  Currently we allow "num_devices - 1" devices to have super block
  writeback failure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 12 +++++++
 fs/btrfs/fs.h      |  1 +
 fs/btrfs/super.c   | 84 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc577b3c53f6..5a85b517a031 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3758,6 +3758,8 @@ static int write_dev_supers(struct btrfs_device *device,
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
+	if (btrfs_test_opt(fs_info, ABORT_SUPER))
+		max_mirrors = 1;
 
 	shash->tfm = fs_info->csum_shash;
 
@@ -3849,6 +3851,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
+	if (btrfs_test_opt(device->fs_info, ABORT_SUPER))
+		max_mirrors = 1;
 
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
@@ -3895,6 +3899,12 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 			  device->devid);
 		return -1;
 	}
+	if (errors >= i) {
+		btrfs_err(device->fs_info,
+			  "error writing super blocks to device %llu",
+			  device->devid);
+		return -1;
+	}
 
 	return errors < i ? 0 : -1;
 }
@@ -4058,6 +4068,8 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	head = &fs_info->fs_devices->devices;
 	max_errors = btrfs_super_num_devices(fs_info->super_copy) - 1;
+	if (btrfs_test_opt(fs_info, ABORT_SUPER))
+		max_errors = 0;
 
 	if (do_barriers) {
 		ret = barrier_all_devices(fs_info);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cec28d6b20bc..4fc0afcf1ef2 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -188,6 +188,7 @@ enum {
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1ULL << 27),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1ULL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1ULL << 29),
+	BTRFS_MOUNT_ABORT_SUPER			= (1ULL << 30),
 };
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5c6054f0552b..41ab8c6e3fab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -125,6 +125,11 @@ enum {
 	Opt_ignoredatacsums,
 	Opt_rescue_all,
 
+	/* Extra abort options. */
+	Opt_abort,
+	Opt_abort_super,
+	Opt_abort_all,
+
 	/* Deprecated options */
 	Opt_recovery,
 	Opt_inode_cache, Opt_noinode_cache,
@@ -187,8 +192,12 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
 
+	/* Abort options */
+	{Opt_abort, "abort=%s"},
+
 	/* Rescue options */
 	{Opt_rescue, "rescue=%s"},
+
 	/* Deprecated, with alias rescue=nologreplay */
 	{Opt_nologreplay, "nologreplay"},
 	/* Deprecated, with alias rescue=usebackuproot */
@@ -222,6 +231,12 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+static const match_table_t abort_tokens = {
+	{Opt_abort_super, "super"},
+	{Opt_abort_all, "all"},
+	{Opt_err, NULL},
+};
+
 static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 			    const char *opt_name)
 {
@@ -233,6 +248,48 @@ static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
 	return false;
 }
 
+static int parse_abort_options(struct btrfs_fs_info *info, const char *options)
+{
+	char *opts;
+	char *orig;
+	char *p;
+	substring_t args[MAX_OPT_ARGS];
+	int ret = 0;
+
+	opts = kstrdup(options, GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	orig = opts;
+
+	while ((p = strsep(&opts, ":")) != NULL) {
+		int token;
+
+		if (!*p)
+			continue;
+		token = match_token(p, abort_tokens, args);
+		switch (token) {
+		case Opt_abort_super:
+			btrfs_set_and_info(info, ABORT_SUPER,
+				"will abort if any super block write back failed");
+			break;
+		case Opt_abort_all:
+			btrfs_info(info, "enabling all abort options");
+			btrfs_set_and_info(info, ABORT_SUPER,
+				"will abort if any super block write back failed");
+			break;
+		case Opt_err:
+			btrfs_info(info, "unrecognized abort option '%s'", p);
+			ret = -EINVAL;
+			goto out;
+		default:
+			break;
+		}
+	}
+out:
+	kfree(orig);
+	return ret;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -736,6 +793,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			}
 			info->commit_interval = intarg;
 			break;
+		case Opt_abort:
+			ret = parse_abort_options(info, args[0].from);
+			if (ret < 0) {
+				btrfs_err(info, "unrecognized abort value %s",
+					  args[0].from);
+				goto out;
+			}
+			break;
 		case Opt_rescue:
 			ret = parse_rescue_options(info, args[0].from);
 			if (ret < 0) {
@@ -1191,12 +1256,19 @@ static void print_rescue_option(struct seq_file *seq, const char *s, bool *print
 	*printed = true;
 }
 
+static void print_abort_option(struct seq_file *seq, const char *s, bool *printed)
+{
+	seq_printf(seq, "%s%s", (*printed) ? ":" : ",abort=", s);
+	*printed = true;
+}
+
 static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
 	const char *subvol_name;
-	bool printed = false;
+	bool rescue_printed = false;
+	bool abort_printed = false;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1229,13 +1301,15 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
-		print_rescue_option(seq, "nologreplay", &printed);
+		print_rescue_option(seq, "nologreplay", &rescue_printed);
 	if (btrfs_test_opt(info, USEBACKUPROOT))
-		print_rescue_option(seq, "usebackuproot", &printed);
+		print_rescue_option(seq, "usebackuproot", &rescue_printed);
 	if (btrfs_test_opt(info, IGNOREBADROOTS))
-		print_rescue_option(seq, "ignorebadroots", &printed);
+		print_rescue_option(seq, "ignorebadroots", &rescue_printed);
 	if (btrfs_test_opt(info, IGNOREDATACSUMS))
-		print_rescue_option(seq, "ignoredatacsums", &printed);
+		print_rescue_option(seq, "ignoredatacsums", &rescue_printed);
+	if (btrfs_test_opt(info, ABORT_SUPER))
+		print_abort_option(seq, "super", &abort_printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.42.0

