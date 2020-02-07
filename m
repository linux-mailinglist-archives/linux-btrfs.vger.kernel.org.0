Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1676D155820
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGNIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:08:22 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35016 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGNIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:08:21 -0500
Received: by mail-wr1-f50.google.com with SMTP id w12so2637064wrt.2
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RF7CTbxe3wTGDO81FYmYJaZf7ib8iNKVbtQJzwKFGmM=;
        b=AcN/OD/KIqfC3xS9S2FFeFQADfKFfnhmkwj/Q92832Zu6ztzwLxupSgZ6WQhm+ms+9
         107C9/T55GU/LLlb3VNsd1N1FxWng7tt1mCoVvBdvb2CUtN663b8S1musuRRB9wcKqQQ
         Sv+U0p+StfkPZ336J/gDjfg6M3OuwBtogf3fL2ei5jXVLFLJKlvGUlksG/7ez/Y8zexi
         y7lAjEfeuxu/qi/6/NcCq2Y115Oi3wtZdHD997m42fyks6lVKF4UWFWUXqA6TrvnmtP2
         E76Ly5OsakEFgbnixkNTyvi+Cb9R8kz1nPHY5OxnaHLPdQtLwfedYEXzBNDfRugsDsby
         53wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF7CTbxe3wTGDO81FYmYJaZf7ib8iNKVbtQJzwKFGmM=;
        b=hhtb4pTHdN2+a4gW44CF7nRkXL62Rficim++8yg84yq7O06O8DCnuylUNcVvTiL1vU
         QFHNaT10GB0PJXF4169vnHr3JEQ1cfqg6Tga7Z0oOBAO8wo6/rG9lz11g3E+EvWhyJv3
         jmP6lB9xbOC0VVmfm1W2muHRWi9fkLk8W/Fp9CGIAuyHSzv92VvExoPfyQnQCApUaRO+
         ogruhvxcFy6JBtbwC7MjgRlx66ukcO2uCtL/VgI059vewN6te0+PDdX7aXg3TULTj3OS
         x64M2aDK55s0tw3WbCFGguE768h8LYH7CCgRxG1aXx8lnez9sxtR+eOrgJsR3pRu5J2i
         Hh2A==
X-Gm-Message-State: APjAAAUfTDu8M5nyDwjU16wzxzaM5bJvevaXKcGoRzEkYm/cit1OrSMz
        fdk2RLS+CknziLc3rNfkN4hV4Ufs
X-Google-Smtp-Source: APXvYqxVyfC/UnMkbvIuzAy3uSsZq0JxhNAMVfwl5AfYoQ+EVSK4xryViG5UPnxwjyJfrwTr9vNv6g==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr4660173wrs.395.1581080898807;
        Fri, 07 Feb 2020 05:08:18 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id n1sm3260702wrw.52.2020.02.07.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:08:18 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 4/4] cmds: subvolume: Add --subvolid argument to subvol_delete
Date:   Fri,  7 Feb 2020 10:10:28 -0300
Message-Id: <20200207131028.9977-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207131028.9977-1-marcos.souza.org@gmail.com>
References: <20200207131028.9977-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If only @subvol_default is mounted, we have no path to reach
@subvol1 and @subvol2, thus no way to delete them. Current subvolume
delete ioctl takes a file handler point as argument, and if
@subvol_default is mounted, we can't reach @subvol1 and @subvol2 from
the same mount point.

This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTORY_V2
to delete subvolume using subvolid.

Now, we can use this new ioctl specifying the subvolume id and refer to
the same mount point. It's doesn't matter which subvolume was mounted,
since we can reach to the desired one using the subvolume id, and then
delete it.

Now "subvolume delete" receives a new argument --subvolid, which will
contain the subvolume the user wants to delete.

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

