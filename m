Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA00841C50
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 08:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbfFLGhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 02:37:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:55602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730957AbfFLGhL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 02:37:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 849A1AC40
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:37:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: Introduce "rescue=" mount option
Date:   Wed, 12 Jun 2019 14:36:56 +0800
Message-Id: <20190612063657.21063-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612063657.21063-1-wqu@suse.com>
References: <20190612063657.21063-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new "rescue=" mount option for all those mount
options for data recovery.

Different rescue sub options are seperated by ':'. E.g
"ro,rescue=no_log_replay:use_backup_root".
(The original plan is to use ';', but ';' needs to be escaped/quoted,
or it will be interpreted by bash)

The following mount options are converted to "rescue=", old mount
options are deprecated but still available for compatibility purpose:

- usebackuproot
  Now it's "rescue=use_backup_root"

- nologreplay
  Now it's "rescue=no_log_replay"

The new underscore is here to make the option more readable and make
spell check happier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 64f20725615a..4512f25dcf69 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -310,7 +310,6 @@ enum {
 	Opt_datasum, Opt_nodatasum,
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
-	Opt_nologreplay,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
 	Opt_skip_balance,
@@ -323,7 +322,6 @@ enum {
 	Opt_subvolid,
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
-	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
 
 	/* Deprecated options */
@@ -341,6 +339,8 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	/* Rescue options */
+	Opt_rescue, Opt_usebackuproot, Opt_nologreplay,
 	Opt_err,
 };
 
@@ -401,6 +401,7 @@ static const match_table_t tokens = {
 	{Opt_check_integrity_print_mask, "check_int_print_mask=%u"},
 	{Opt_enospc_debug, "enospc_debug"},
 	{Opt_noenospc_debug, "noenospc_debug"},
+	{Opt_rescue, "rescue=%s"},
 #ifdef CONFIG_BTRFS_DEBUG
 	{Opt_fragment_data, "fragment=data"},
 	{Opt_fragment_metadata, "fragment=metadata"},
@@ -412,6 +413,55 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
+static const match_table_t rescue_tokens = {
+	{Opt_usebackuproot, "use_backup_root"},
+	{Opt_nologreplay, "no_log_replay"},
+	{Opt_err, NULL},
+};
+
+static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
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
+		token = match_token(p, rescue_tokens, args);
+		switch (token){
+		case Opt_usebackuproot:
+			btrfs_info(info,
+				   "trying to use backup root at mount time");
+			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
+			break;
+		case Opt_nologreplay:
+			btrfs_set_and_info(info, NOLOGREPLAY,
+					   "disabling log replay at mount time");
+			break;
+		case Opt_err:
+			btrfs_info(info, "unrecognized rescue option '%s'", p);
+			ret = -EINVAL;
+			goto out;
+		default:
+			break;
+		}
+
+	}
+out:
+	kfree(orig);
+	return ret;
+}
+
 /*
  * Regular mount options parser.  Everything that is needed only when
  * reading in a new superblock is parsed here.
@@ -667,6 +717,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 					     "enabling tree log");
 			break;
 		case Opt_nologreplay:
+			btrfs_warn(info,
+	"'nologreplay' is deprecated, use 'rescue=no_log_replay' instead");
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
@@ -755,6 +807,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 					     "disabling auto defrag");
 			break;
 		case Opt_usebackuproot:
+			btrfs_warn(info,
+	"'usebackuproot' is deprecated, use 'rescue=use_backup_root' instead");
 			btrfs_info(info,
 				   "trying to use backup root at mount time");
 			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
@@ -841,6 +895,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_rescue:
+			ret = parse_rescue_options(info, args[0].from);
+			if (ret < 0)
+				goto out;
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -1307,7 +1366,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
-		seq_puts(seq, ",nologreplay");
+		seq_puts(seq, ",rescue=no_log_replay");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD))
-- 
2.22.0

