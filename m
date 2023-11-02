Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301597DEC52
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbjKBFeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbjKBFeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:34:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60808112
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:34:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CB75219EB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698903252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZG8+05kUznsBYroCuFJkKDlDBYg/QUqMeLa9e5YTpc=;
        b=iC4dHHEz1MJv7tAvZdAyneOeY8tIRX6s/is16QzSwYEW6m8h994TPexrd74dk3+mtMPy9f
        q+s7d1fmStp94Iuui5R9m7qMxFGN8BsmuNSNlxN7glWPzwmEfBq/FTEEfw3H1yv974rIfv
        jby4FC6JGPwLLos25JP3dkWAjzGMHuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4512A13460
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UOCHAdM0Q2U/AwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 05:34:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: subvolume create: accept multiple arguments
Date:   Thu,  2 Nov 2023 16:03:49 +1030
Message-ID: <be37e892c490b496cd2a01dcc49df974233dd0b7.1698903010.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698903010.git.wqu@suse.com>
References: <cover.1698903010.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch would make "btrfs subvolume create" to accept multiple
arguments, just like "mkdir".

The existing options like "-i <qgroupid>" and "-p" would all be applied
to all subvolume(s).

If one destination failed, the command would return 1, while still retry
the remaining destinations.

Issue: #695
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-subvolume.rst |  11 ++-
 cmds/subvolume.c                  | 150 +++++++++++++++++-------------
 2 files changed, 92 insertions(+), 69 deletions(-)

diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
index 6da00be8dc86..8b434475337b 100644
--- a/Documentation/btrfs-subvolume.rst
+++ b/Documentation/btrfs-subvolume.rst
@@ -49,12 +49,19 @@ do not affect the files in the original subvolume.
 SUBCOMMAND
 -----------
 
-create [options] [<dest>/]<name>
-        Create a subvolume *name* in *dest*.
+create [options] [<dest>/]<name> [[<dest2>/]<name2>] ...
+        Create subvolume(s) at the destination(s).
 
         If *dest* is not given, subvolume *name* will be created in the current
         directory.
 
+	If multiple desinations are given, then the options are applied to all
+	subvolumes.
+
+	If failure happened for any of the destinations, the command would
+	still retry the remaining destinations, but would return 1 to indicate
+	the failure.
+
         ``Options``
 
         -i <qgroupid>
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index bccc4968dad3..7decaa1eb828 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -114,81 +114,38 @@ static const char * const subvolume_cmd_group_usage[] = {
 };
 
 static const char * const cmd_subvolume_create_usage[] = {
-	"btrfs subvolume create [options] [<dest>/]<name>",
-	"Create a subvolume",
-	"Create a subvolume <name> in <dest>.  If <dest> is not given",
+	"btrfs subvolume create [options] [<dest>/]<name> [[<dest2>/]<name2>] ...",
+	"Create subvolume(s)",
+	"Create subvolume(s) at specified destination.  If <dest> is not given",
 	"subvolume <name> will be created in the current directory.",
 	"",
-	OPTLINE("-i <qgroupid>", "add the newly created subvolume to a qgroup. This option can be given multiple times."),
+	OPTLINE("-i <qgroupid>", "add the newly created subvolume(s) to a qgroup. This option can be given multiple times."),
 	OPTLINE("-p|--parents", "create any missing parent directories for each argument (like mkdir -p)"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
-static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **argv)
+static int create_one_subvolume(const char *dst,
+				struct btrfs_qgroup_inherit *inherit,
+				bool create_parents)
 {
-	int	retval, res, len;
+	int	ret;
+	int	len;
 	int	fddst = -1;
 	char	*dupname = NULL;
 	char	*dupdir = NULL;
 	char	*newname;
 	char	*dstdir;
-	char	*dst;
-	struct btrfs_qgroup_inherit *inherit = NULL;
 	DIR	*dirstream = NULL;
-	bool create_parents = false;
 
-	optind = 0;
-	while (1) {
-		int c;
-		static const struct option long_options[] = {
-			{ "parents", no_argument, NULL, 'p' },
-			{ NULL, 0, NULL, 0 }
-		};
-
-		c = getopt_long(argc, argv, "i:p", long_options, NULL);
-		if (c < 0)
-			break;
-
-		switch (c) {
-		case 'c':
-			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
-		case 'i':
-			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
-			if (res) {
-				retval = res;
-				goto out;
-			}
-			break;
-		case 'p':
-			create_parents = true;
-			break;
-		default:
-			usage_unknown_option(cmd, argv);
-		}
-	}
-
-	if (check_argc_exact(argc - optind, 1)) {
-		retval = 1;
-		goto out;
-	}
-
-	dst = argv[optind];
-
-	retval = 1;	/* failure */
-	res = path_is_dir(dst);
-	if (res < 0 && res != -ENOENT) {
-		errno = -res;
+	ret = path_is_dir(dst);
+	if (ret < 0 && ret != -ENOENT) {
+		errno = -ret;
 		error("cannot access %s: %m", dst);
 		goto out;
 	}
-	if (res >= 0) {
+	if (ret >= 0) {
 		error("target path already exists: %s", dst);
 		goto out;
 	}
@@ -230,15 +187,15 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 		token = strtok(dstdir_dup, "/");
 		while (token) {
 			strcat(p, token);
-			res = path_is_dir(p);
-			if (res == -ENOENT) {
-				res = mkdir(p, 0777);
-				if (res < 0) {
+			ret = path_is_dir(p);
+			if (ret == -ENOENT) {
+				ret = mkdir(p, 0777);
+				if (ret < 0) {
 					error("failed to create directory %s: %m", p);
 					goto out;
 				}
-			} else if (res <= 0) {
-				errno = res;
+			} else if (ret <= 0) {
+				errno = ret ;
 				error("failed to check directory %s before creation: %m", p);
 				goto out;
 			}
@@ -261,28 +218,87 @@ static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **a
 		args.size = btrfs_qgroup_inherit_size(inherit);
 		args.qgroup_inherit = inherit;
 
-		res = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
+		ret = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
 	} else {
 		struct btrfs_ioctl_vol_args	args;
 
 		memset(&args, 0, sizeof(args));
 		strncpy_null(args.name, newname);
 
-		res = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE, &args);
+		ret = ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE, &args);
 	}
 
-	if (res < 0) {
+	if (ret < 0) {
 		error("cannot create subvolume: %m");
 		goto out;
 	}
 
-	retval = 0;	/* success */
 out:
 	close_file_or_dir(fddst, dirstream);
-	free(inherit);
 	free(dupname);
 	free(dupdir);
 
+	return ret;
+}
+static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc, char **argv)
+{
+	int	retval, res;
+	struct btrfs_qgroup_inherit *inherit = NULL;
+	bool has_error = false;
+	bool create_parents = false;
+
+	optind = 0;
+	while (1) {
+		int c;
+		static const struct option long_options[] = {
+			{ "parents", no_argument, NULL, 'p' },
+			{ NULL, 0, NULL, 0 }
+		};
+
+		c = getopt_long(argc, argv, "i:p", long_options, NULL);
+		if (c < 0)
+			break;
+
+		switch (c) {
+		case 'c':
+			res = btrfs_qgroup_inherit_add_copy(&inherit, optarg, 0);
+			if (res) {
+				retval = res;
+				goto out;
+			}
+			break;
+		case 'i':
+			res = btrfs_qgroup_inherit_add_group(&inherit, optarg);
+			if (res) {
+				retval = res;
+				goto out;
+			}
+			break;
+		case 'p':
+			create_parents = true;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
+		}
+	}
+
+	if (check_argc_min(argc - optind, 1)) {
+		retval = 1;
+		goto out;
+	}
+
+	retval = 1;
+
+	for (int i = optind; i < argc; i++) {
+		res = create_one_subvolume(argv[i], inherit, create_parents);
+		if (res < 0)
+			has_error = true;
+	}
+	if (!has_error)
+		retval = 0;
+out:
+	free(inherit);
+
 	return retval;
 }
 static DEFINE_SIMPLE_COMMAND(subvolume_create, "create");
-- 
2.42.0

