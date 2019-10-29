Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33319E90DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 21:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ2UiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 16:38:05 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35448 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfJ2UiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 16:38:05 -0400
Received: by mail-pl1-f179.google.com with SMTP id x6so4210682pln.2
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2019 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F42ZX3ixXQwhI9/yG3RDye1SGX91bhLKOCE2FxCq53Q=;
        b=olZa3ESVlUDS2pOD+xPd2f+QRhjimXDsGNwp7RpQ93/VUfYVHL+170CruBxXzvzBkx
         aoRbxhPwc77VWRCfAfqjTC3T2GjtyXg/C5J7wgXzIZ11Pz9LMcJzhq4qLIwNUxt2qklm
         QqP1CoZlVXYeBe3zZR1VTbMjYf2UKyz3+CozqVcTViw+GEStwrjcCb3Wwmb7cXEB2ZsB
         uwxRJnuVMBevny7vqIqRJjDHAmkbf1/89We8RXwgt11fqIlRQDQAow6NZHH6eqioNm6E
         5mm3+LDqv6UK0YoP8Rl+2rH2QzjvS/0irNBTRQjl4LQq6l1xx9Jbo39vTjwX1aoa1GnB
         cPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F42ZX3ixXQwhI9/yG3RDye1SGX91bhLKOCE2FxCq53Q=;
        b=WhM1Kd8mIVcAYcp+RUTNe17+6CLMz78OmPs8gcLeRdQDs8oiVSQwQ+Cd/7gw3pX4pU
         hRj0MEYi5G8NkivxUNsfmWgykZhd04CLbeaCGij7vaongvo5bbOd1GLPtfO29j9WyNRw
         zYlDoVkUJWHy7XgSJ4yAT5Whf+yugwjfB+we3ghByoj2myFwQ6+VSs4BDxWDvaMaOFte
         QqNPX8x1eUBoqP4sAzwu4GrCyAMUwhAg1+VoPeUVanRiKhQh1K/zzZpXroyUO8JVtMh1
         FRRpPsnHxGFdkAIZYFw1XShJFm+Uz0JdpG0gUvEvw7327SXJ9v7hf63sHxLkzh2bL8S8
         sTAg==
X-Gm-Message-State: APjAAAUZtS7SaivtO/khmqPZ0xUVfasbiZa19w8OXroNjAE7ISXZgRvQ
        i1qxiW0qQt9cvLYVOBZcBfNHY5Tw
X-Google-Smtp-Source: APXvYqwyeCpHchP3elY7IvF1R2/YAikwA/zDwAwiRANY+0E0VWv+krrhCY9YD601UIpqdw//Yx1MSA==
X-Received: by 2002:a17:902:d887:: with SMTP id b7mr586069plz.301.1572381482653;
        Tue, 29 Oct 2019 13:38:02 -0700 (PDT)
Received: from ifrit.prv.suse.net (200.146.53.106.dynamic.dialup.gvt.net.br. [200.146.53.106])
        by smtp.gmail.com with ESMTPSA id o123sm15373319pfg.161.2019.10.29.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:38:01 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com,
        anand.jain@oracle.com
Subject: [PATCH v2] btrfs-progs: subvolume: Implement delete --subvolid <path>
Date:   Tue, 29 Oct 2019 17:40:13 -0300
Message-Id: <20191029204013.27644-1-marcos.souza.org@gmail.com>
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

 Changes since v1:
 * Break the usage message into different lines:
 usage: btrfs subvolume delete [options] <subvolume> [<subvolume>...]
       btrfs subvolume delete [options] -s|--subvolid <subvolid> <path>
 ...
 (suggested by David Sterba)
 * Changed subvol to subvolid in a comment of cmd_subvol_delete (suggested By
    AnandJain)
 * Changed the documentation/btrfs-subvolume to show both formats of subvolume delete in the
 * same line, following what other commands already do:
   *delete* [options] <[<subvolume> [<subvolume>...]] | [-s|--subvolid <subvolid> <path>]>::

 Documentation/btrfs-subvolume.asciidoc        |  8 +++-
 cmds/subvolume.c                              | 41 +++++++++++++++++--
 tests/misc-tests/038-delete-subvolume/test.sh | 30 ++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)
 create mode 100755 tests/misc-tests/038-delete-subvolume/test.sh

diff --git a/Documentation/btrfs-subvolume.asciidoc b/Documentation/btrfs-subvolume.asciidoc
index 49c72e89..3e2d91f4 100644
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
index 7a5fd79b..768a8b54 100644
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
 
+	/* check the following syntax: subvolume delete --subvolid <subvolid> <path> */
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

