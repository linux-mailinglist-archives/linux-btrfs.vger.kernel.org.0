Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422B4E75C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfJ1QDK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 12:03:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfJ1QDK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 12:03:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id f19so7142677pgn.13
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nz4oK71Z5fQy3VBcsmoahNdYfyJpQ2EbKH25LBi1tw=;
        b=nvVH1S0ZtnmXKc+yaBW0mbwyT6xBjjsXz0hqC4/Gnl7EQK9XyL2xDKX3IZbPtwF4gi
         +ejX5YH9QvBPTwP2YlBlzee/hVPMLWPi7ZqixoK8l1OhcofEyrOlx0IVUuk7FXAgNI/B
         qn/Y3Qk9lJ4uwqLTjAVBbXwAkf96ubNWFShCiOs6Ib299XfKLXAPgZLCNPnV4JHI2LdT
         lyBbPM7+oGpovO/PgfEeB5hsEytvrnPP9l3EKYG2Upi+Hj9Jd1AobtVFlMZBlYClXd3L
         N13BlqCndDLCst0ZvK/b7CNEAXMeNjFOMtPSTZfoSkD+D1yak9uzlu2IAPvMQ1rsBpVs
         3bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3nz4oK71Z5fQy3VBcsmoahNdYfyJpQ2EbKH25LBi1tw=;
        b=jVuws57WhiM/jn9PSpnhat9Ej2m/OWPMtPXeTaEr9Krj6ngqAgRNYPikRrF+nFrvKU
         7xI4IZXl+7Lu4RjQFGzDTLWNO4eVszJbc2u0i7iSapZ0b7JyW6JT/CbxbJMttLyLW/Ae
         ItbSNt1ZK69ciugmEABbMRj71MgTYB2B4Zghsgg7/r6lMuhYmPuofXCIqBmjIlt1mRU5
         6fwiKOWZzV+tP0QytowTI6XbShkWL8s5tSGtTmR6nq5MpuDNj6pjy7EEg8JMFD0bFbuY
         N/abdxMV16Ho5V+fsKcDUOnxwwXFkd0C8tUhdclQ0Q2q99NrSpKaD0riVCgEMbM96MSX
         G4GQ==
X-Gm-Message-State: APjAAAUj9ILN+PxKZ3Cbgwb5/5uUtR6011qzUje4DuOoC8uk3zZby/o1
        A2FBGPcs67MgqGvetLdifPt6gC2kG4w=
X-Google-Smtp-Source: APXvYqy0WODmltDZJfL2qy+sUKEnu5Il11virk5Xsy9VNsG1iu/s65WqMdgcRStRLqcUqkcKV+9fqQ==
X-Received: by 2002:a17:90a:6d64:: with SMTP id z91mr32428pjj.44.1572278588461;
        Mon, 28 Oct 2019 09:03:08 -0700 (PDT)
Received: from ifrit.prv.suse.net (200.146.53.106.dynamic.dialup.gvt.net.br. [200.146.53.106])
        by smtp.gmail.com with ESMTPSA id l62sm11635251pfl.167.2019.10.28.09.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:03:07 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH devel] btrfs-progs: subvolume: Implement delete --subvolid <path>
Date:   Mon, 28 Oct 2019 13:05:06 -0300
Message-Id: <20191028160506.22245-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

With this patch a user can delete a subvolume from a btrfs using only
the subvolume id in the format

btrfs subvolume delete --subvolid <volid> <path>

Fixes: #152

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/btrfs-subvolume.asciidoc        | 10 ++++-
 cmds/subvolume.c                              | 39 +++++++++++++++++--
 tests/misc-tests/038-delete-subvolume/test.sh | 30 ++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)
 create mode 100755 tests/misc-tests/038-delete-subvolume/test.sh

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
index 49c72e89..9492fc19 100644
--- a/Documentation/btrfs-subvolume.asciidoc
+++ b/Documentation/btrfs-subvolume.asciidoc
@@ -59,12 +59,17 @@ directory.
 Add the newly created subvolume to a qgroup. This option can be given multiple
 times.
 
-*delete* [options] <subvolume> [<subvolume>...]::
+*delete* [options] <subvolume> [<subvolume>...]
+
+*delete* [options] [--subvolid <subvolid> <path>]::
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
@@ -84,6 +89,9 @@ wait for transaction commit after deleting each subvolume.
 +
 -v|--verbose::::
 verbose output of operations.
++
+-s|--subvolid::::
+subvolume id of the to be removed subvolume from <path>
 
 *find-new* <subvolume> <last_gen>::
 List the recently modified files in a subvolume, after <last_gen> generation.
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79b..df75f82d 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -223,6 +223,7 @@ static int wait_for_commit(int fd)
 
 static const char * const cmd_subvol_delete_usage[] = {
 	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]",
+	"btrfs subvolume delete [options] [--subvolid <subvolid> <path>]",
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
 
@@ -246,11 +248,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	char	*dname, *vname, *cpath;
 	char	*dupdname = NULL;
 	char	*dupvname = NULL;
-	char	*path;
+	char	*path = NULL;
 	DIR	*dirstream = NULL;
 	int verbose = 0;
 	int commit_mode = 0;
 	u8 fsid[BTRFS_FSID_SIZE];
+	u64 objectid = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	struct seen_fsid *seen_fsid_hash[SEEN_FSID_HASH_SIZE] = { NULL, };
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
@@ -262,11 +265,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
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
 
@@ -280,6 +284,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 		case 'v':
 			verbose++;
 			break;
+		case 's':
+			objectid = arg_strtou64(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -288,6 +295,10 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
+	/* when using --subvolid, ensure that we have only one argument */
+	if (objectid > 0 && check_argc_exact(argc - optind, 1))
+		return 1;
+
 	if (verbose > 0) {
 		printf("Transaction commit: %s\n",
 			!commit_mode ? "none (default)" :
@@ -296,8 +307,30 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 
 	cnt = optind;
 
+	/* check the following syntax: subvolume delete --subvolid <volid> <path> */
+	if (objectid > 0) {
+		char *subvol, full_volpath[BTRFS_SUBVOL_NAME_MAX];
+
+		path = argv[cnt];
+		err = btrfs_util_subvolume_path(path, objectid, &subvol);
+		if (err) {
+			error_btrfs_util(err);
+			ret = 1;
+			goto out;
+		}
+
+		/* build new volpath using the volume name found */
+		sprintf(full_volpath, "%s/%s", path, subvol);
+		free(subvol);
+
+		/* update path to the built path from the subvol id */
+		path = full_volpath;
+	}
+
 again:
-	path = argv[cnt];
+	/* if subvolid is used, path will already be populated */
+	if (objectid == 0)
+		path = argv[cnt];
 
 	err = btrfs_util_is_subvolume(path);
 	if (err) {
diff --git a/tests/misc-tests/038-delete-subvolume/test.sh b/tests/misc-tests/038-delete-subvolume/test.sh
new file mode 100755
index 00000000..9137e0d3
--- /dev/null
+++ b/tests/misc-tests/038-delete-subvolume/test.sh
@@ -0,0 +1,30 @@
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
-- 
2.23.0

