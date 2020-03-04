Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB0178C44
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 09:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgCDIJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 03:09:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:51464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDIJv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 03:09:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6365B19D
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 08:09:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 1/2] btrfs: Introduce "rescue=" mount option
Date:   Wed,  4 Mar 2020 16:09:40 +0800
Message-Id: <20200304080941.50774-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304080941.50774-1-wqu@suse.com>
References: <20200304080941.50774-1-wqu@suse.com>
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
index 7932d8d07cff..6a2521781bb7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -317,7 +317,6 @@ enum {
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
 	Opt_discard_mode,
-	Opt_nologreplay,
 	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
@@ -331,9 +330,13 @@ enum {
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
@@ -381,7 +384,6 @@ static const match_table_t tokens = {
 	{Opt_discard, "discard"},
 	{Opt_discard_mode, "discard=%s"},
 	{Opt_nodiscard, "nodiscard"},
-	{Opt_nologreplay, "nologreplay"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
 	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
@@ -399,9 +401,13 @@ static const match_table_t tokens = {
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
@@ -424,6 +430,55 @@ static const match_table_t tokens = {
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
@@ -680,6 +735,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 		case Opt_norecovery:
 		case Opt_nologreplay:
+			btrfs_warn(info,
+	"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
@@ -782,10 +839,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -872,6 +930,11 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_rescue:
+			ret = parse_rescue_options(info, args[0].from);
+			if (ret < 0)
+				goto out;
+			break;
 		case Opt_err:
 			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -1342,7 +1405,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, NOTREELOG))
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
-		seq_puts(seq, ",nologreplay");
+		seq_puts(seq, ",rescue=nologreplay");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
-- 
2.25.1

