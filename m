Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91306AB259
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 08:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbfIFGRo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 02:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387865AbfIFGRn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 02:17:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6C2EAEB3
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2019 06:17:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/2] btrfs: Introduce "rescue=" mount option
Date:   Fri,  6 Sep 2019 14:17:33 +0800
Message-Id: <20190906061734.21704-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906061734.21704-1-wqu@suse.com>
References: <20190906061734.21704-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces a new "rescue=" mount option group for all those
mount options for data recovery.

Different rescue sub options are seperated by ':'. E.g
"ro,rescue=nologreplay:usebackuproot".
(The original plan is to use ';', but ';' needs to be escaped/quoted,
or it will be interpreted by bash)

And obviously, user can specify rescue options one by one like:
"ro,rescue=nologreplay,rescue=usebackuproot"

The following mount options are converted to "rescue=", old mount
options are deprecated but still available for compatibility purpose:

- usebackuproot
  Now it's "rescue=usebackuproot"

- nologreplay
  Now it's "rescue=nologreplay"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 79 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 78de9d5d80c6..13907a6d2a87 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -311,7 +311,6 @@ enum {
 	Opt_datasum, Opt_nodatasum,
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
-	Opt_nologreplay,
 	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
@@ -325,9 +324,13 @@ enum {
 	Opt_subvolid,
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
-	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
 
+	/* Rescue options */
+	Opt_rescue,
+	Opt_usebackuproot,
+	Opt_nologreplay,
+
 	/* Deprecated options */
 	Opt_alloc_start,
 	Opt_recovery,
@@ -374,7 +377,6 @@ static const match_table_t tokens = {
 	{Opt_nodefrag, "noautodefrag"},
 	{Opt_discard, "discard"},
 	{Opt_nodiscard, "nodiscard"},
-	{Opt_nologreplay, "nologreplay"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
 	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
@@ -392,9 +394,13 @@ static const match_table_t tokens = {
 	{Opt_thread_pool, "thread_pool=%u"},
 	{Opt_treelog, "treelog"},
 	{Opt_notreelog, "notreelog"},
-	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
 
+	/* Recovery options */
+	{Opt_rescue, "rescue=%s"},
+	{Opt_nologreplay, "nologreplay"},
+	{Opt_usebackuproot, "usebackuproot"},
+
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
 	{Opt_recovery, "recovery"},
@@ -417,6 +423,55 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
+static const match_table_t rescue_tokens = {
+	{Opt_usebackuproot, "usebackuproot"},
+	{Opt_nologreplay, "nologreplay"},
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
@@ -673,6 +728,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		case Opt_norecovery:
 		case Opt_nologreplay:
+			btrfs_warn(info,
+	"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
@@ -761,10 +818,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 					     "disabling auto defrag");
 			break;
 		case Opt_recovery:
-			btrfs_warn(info,
-				   "'recovery' is deprecated, use 'usebackuproot' instead");
-			/* fall through */
 		case Opt_usebackuproot:
+			btrfs_warn(info,
+		"'%s' is deprecated, use 'rescue=usebackuproot' instead",
+				   token == Opt_recovery ? "recovery" :
+				   "usebackuproot");
 			btrfs_info(info,
 				   "trying to use backup root at mount time");
 			btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
@@ -851,6 +909,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -1317,7 +1380,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
-		seq_puts(seq, ",nologreplay");
+		seq_puts(seq, ",rescue=no_log_replay");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD))
-- 
2.23.0

