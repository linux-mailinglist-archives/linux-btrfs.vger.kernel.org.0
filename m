Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7AE149E4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgA0CrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:23 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:41431 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CrX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:23 -0500
Received: by mail-qk1-f172.google.com with SMTP id s187so8265452qke.8
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Slwdzsq8Gdqll49vleBRs/CnCEz67npALxWW2ArsCA=;
        b=n0ezzwIJBUtlRDs+WAQ4Oj7FQgFiA0jvBgf4ChnB1Ed3n7biVZSNTiNbud5EyiPo+Q
         4CJcWE9/QHr9kRlA1rUT3sDRfMk6ck9ZNM1kv54LMfEKoQGrKhTMbYmNzJG6LrVKWcal
         o4SRPMaQGu0fd5RU932HG++qs6TnmyMhbMetbw2p2blZabssSRyVXhpV5MolljgkrI54
         X+PXj5FR/5nZ+MFcwcGpzUDPlChtb1HhVrh1WvJqthxTKOzuQ/Uwl41vZlq4r4mJw/5a
         B6DIlEcTSAzy3oe9HrmO1sU65wOLaZs+DIoG96hcG0wq7fntGHCWJDo/haT8JI9+6oYq
         /02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Slwdzsq8Gdqll49vleBRs/CnCEz67npALxWW2ArsCA=;
        b=VW/GHHUKk9DII3sMapgFKx2PWxE1GXsc2d+mDhXlLPEN9AhH7eErE8Bd3gC4qKZvFi
         cP4laD9hs1v71zftqNMKHUX+gg1OmFdJLfqhNKG2ae4weugO2wPUlVTgOBFYteddDq+Y
         knq/M73EtTYUgaagS20V6StFrV5gb/DM/zQB+uzE1wsz0bBMKZaV0Xz2dqN19U9a2Ap3
         WvzRhQlz+6cmT3g5XnqROOmLFTeHx/yw/fTVMsQPczOe3FaYD74f2yHXIcqvevbxJtmm
         Zf5j0oiG1U90NmPEo8iKBjDzzblvWcHMJDkXRirDxFsdSOUJZ3x3jxAaCNOXvEg7cWtm
         aVGg==
X-Gm-Message-State: APjAAAWT8EHugs715P0KFC3G8XkrmOB/tJO6aiBovs3BJYg66Q83FWbN
        MlvSyYZ1Ws2j+J1JMGL+2KE=
X-Google-Smtp-Source: APXvYqzABoV0SczrskbgEVV62R7+AiWjxpIUyV/ZGi16oqhTVMMficwi648XlufbmUHmUu6F7+hm1Q==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr14583923qkc.193.1580093241778;
        Sun, 26 Jan 2020 18:47:21 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id c184sm8643337qke.118.2020.01.26.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:21 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 4/5] cmds: subvolume: Add --subvolid argument to subvol_delete
Date:   Sun, 26 Jan 2020 23:49:53 -0300
Message-Id: <20200127024954.16916-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127024954.16916-1-marcos.souza.org@gmail.com>
References: <20200127024954.16916-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This can be used when a system has a file system mounted from a
subvolume, rather than the root file system, like below:

/
|- @subvol1
|- @subvol2
\- @subvol_default

If only @subvol_default is mounted, we have no path to reach
@subvol1 and @subvol2, thus no way to delete them.
This patch introduces a new argument to specify the subvolume id of the
subvolume/snapshot to be deleted.

Fixes: #152
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/btrfs-subvolume.asciidoc        |  8 ++-
 cmds/subvolume.c                              | 53 ++++++++++++++++---
 tests/misc-tests/038-delete-subvolume/test.sh | 40 ++++++++++++++
 3 files changed, 94 insertions(+), 7 deletions(-)
 create mode 100755 tests/misc-tests/038-delete-subvolume/test.sh

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
index 6c0af2f8..9ebfcdfe 100644
--- a/Documentation/btrfs-subvolume.asciidoc
+++ b/Documentation/btrfs-subvolume.asciidoc
@@ -59,12 +59,15 @@ directory.
 Add the newly created subvolume to a qgroup. This option can be given multiple
 times.
 
-*delete* [options] <subvolume> [<subvolume>...]::
+*delete* [options] <[<subvolume> [<subvolume>...]] | [-s|--subvolid <subvolid> <path>]>::
 Delete the subvolume(s) from the filesystem.
 +
 If <subvolume> is not a subvolume, btrfs returns an error but continues if
 there are more arguments to process.
 +
+If --subvolid if used, <path> must point to a btrfs filesystem. See `btrfs
+subvolume list` how to get the subvolume id.
++
 The corresponding directory is removed instantly but the data blocks are
 removed later in the background. The command returns immediately. See `btrfs
 subvolume sync` how to wait until the subvolume gets completely removed.
@@ -84,6 +87,9 @@ wait for transaction commit after deleting each subvolume.
 +
 -v|--verbose::::
 verbose output of operations.
++
+-s|--subvolid::::
+subvolume id of the to be removed subvolume from <path>
 
 *find-new* <subvolume> <last_gen>::
 List the recently modified files in a subvolume, after <last_gen> generation.
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79b..074fc11c 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -222,7 +222,8 @@ static int wait_for_commit(int fd)
 }
 
 static const char * const cmd_subvol_delete_usage[] = {
-	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]",
+	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]\n"
+	"btrfs subvolume delete [options] -s|--subvolid <subvolid> <path>",
 	"Delete subvolume(s)",
 	"Delete subvolumes from the filesystem. The corresponding directory",
 	"is removed instantly but the data blocks are removed later.",
@@ -234,6 +235,7 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-c|--commit-after      wait for transaction commit at the end of the operation",
 	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
 	"-v|--verbose           verbose output of operations",
+	"-s|--subvolid          subvolume id of the to be removed subvolume",
 	NULL
 };
 
@@ -246,12 +248,14 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	char	*dname, *vname, *cpath;
 	char	*dupdname = NULL;
 	char	*dupvname = NULL;
-	char	*path;
+	char	*path = NULL;
 	DIR	*dirstream = NULL;
 	int verbose = 0;
 	int commit_mode = 0;
 	u8 fsid[BTRFS_FSID_SIZE];
+	u64 subvolid = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
+	char full_volpath[BTRFS_SUBVOL_NAME_MAX];
 	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { NULL, };
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
 	enum btrfs_util_error err;
@@ -262,11 +266,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 		static const struct option long_options[] = {
 			{"commit-after", no_argument, NULL, 'c'},
 			{"commit-each", no_argument, NULL, 'C'},
+			{"subvolid", required_argument, NULL, 's'},
 			{"verbose", no_argument, NULL, 'v'},
 			{NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "cCv", long_options, NULL);
+		c = getopt_long(argc, argv, "cCvs:", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -280,6 +285,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 		case 'v':
 			verbose++;
 			break;
+		case 's':
+			subvolid = arg_strtou64(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -288,6 +296,10 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
+	/* when using --subvolid, ensure that we have only one argument */
+	if (subvolid > 0 && check_argc_exact(argc - optind, 1))
+		return 1;
+
 	if (verbose > 0) {
 		printf("Transaction commit: %s\n",
 			!commit_mode ? "none (default)" :
@@ -296,6 +308,23 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 
 	cnt = optind;
 
+	/* check the following syntax: subvolume delete --subvolid <subvolid> <path> */
+	if (subvolid > 0) {
+		char *subvol;
+
+		path = argv[cnt];
+		err = btrfs_util_subvolume_path(path, subvolid, &subvol);
+		if (err) {
+			error_btrfs_util(err);
+			ret = 1;
+			goto out;
+		}
+
+		/* build new volpath using the volume name found */
+		sprintf(full_volpath, "%s/%s", path, subvol);
+		free(subvol);
+	}
+
 again:
 	path = argv[cnt];
 
@@ -318,17 +347,29 @@ again:
 	vname = basename(dupvname);
 	free(cpath);
 
+	/* when subvolid is passed, <path> will point to the mount point */
+	if (subvolid > 0)
+		dname = dupvname;
+
 	fd = btrfs_open_dir(dname, &dirstream, 1);
 	if (fd < 0) {
 		ret = 1;
 		goto out;
 	}
 
-	printf("Delete subvolume (%s): '%s/%s'\n",
+	printf("Delete subvolume (%s): ",
 		commit_mode == COMMIT_EACH || (commit_mode == COMMIT_AFTER && cnt + 1 == argc)
-		? "commit" : "no-commit", dname, vname);
+		? "commit" : "no-commit");
+
+	if (subvolid == 0)
+		printf("'%s/%s'\n", dname, vname);
+	else
+		printf("'%s'\n", full_volpath);
 
-	err = btrfs_util_delete_subvolume_fd(fd, vname, 0);
+	if (subvolid == 0)
+		err = btrfs_util_delete_subvolume_fd(fd, vname, 0);
+	else
+		err = btrfs_util_delete_subvolume_by_id_fd(fd, subvolid);
 	if (err) {
 		error_btrfs_util(err);
 		ret = 1;
diff --git a/tests/misc-tests/038-delete-subvolume/test.sh b/tests/misc-tests/038-delete-subvolume/test.sh
new file mode 100755
index 00000000..d81ae120
--- /dev/null
+++ b/tests/misc-tests/038-delete-subvolume/test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# test btrfs subvolume delete --subvolid <volid> <path>
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT"/mysubvol1
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT"/mysubvol2
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT"/mysubvol3
+
+# subvolid expected failures
+run_mustfail "subvolume delete --subvolid expects an integer" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid aaa "$TEST_MNT"
+
+run_mustfail "subvolume delete --subvolid with invalid unexisting subvolume" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 999 "$TEST_MNT"
+
+run_mustfail "subvolume delete --subvolid expects only one extra argument: the mountpoint" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 256 "$TEST_MNT" "$TEST_MNT"
+
+# delete the recently created subvol using the subvolid
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 256 "$TEST_MNT"
+
+run_check_umount_test_dev
+
+run_check_mount_test_dev -o subvol=mysubvol2
+# when mounted the subvolume mysubvol3, mysubvol2 is not reachable by the
+# current mount point, but "subvolume delete --subvolid " should be able to
+# delete it
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --subvolid 258 "$TEST_MNT"
+
+run_check_umount_test_dev
-- 
2.24.0

