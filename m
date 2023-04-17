Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630BD6E4472
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDQJup (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjDQJu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 05:50:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECC193E0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 02:49:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 665251F38D;
        Mon, 17 Apr 2023 09:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681724909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8OcPHwMiVu67a3dEQn2ZtslAhkS+2aL8o3z7nkRzRz4=;
        b=uS0dWWUY4KZWYRV5o1I9BmYAbXEW/F4Xb0K29cuzoePOrzB329XUb6Qajy7YRV8qh70uOT
        VhrK8Z9I0Aov28IH2HN3tytu57a+HiI7gdYbsJUuMFy3UOASTKsWOesvgQrzckyDEAYGzC
        nvD46+MsPNVIumcXo3E8VpdRyLW/M3M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F1DA13319;
        Mon, 17 Apr 2023 09:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 04zvAewVPWQPbwAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 17 Apr 2023 09:48:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Torstein Eide <torsteine@gmail.com>
Subject: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path resolution
Date:   Mon, 17 Apr 2023 17:48:10 +0800
Message-Id: <20230417094810.42214-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that "btrfs inspect logical-resolve" can not even
handle any file inside non-top-level subvolumes:

 # mkfs.btrfs $dev
 # mount $dev $mnt
 # btrfs subvol create $mnt/subv1
 # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
 # sync
 # btrfs inspect logical-resolve 13631488 $mnt
 inode 257 subvol subv1 could not be accessed: not mounted

This means the command "btrfs inspect logical-resolve" is almost useless
for resolving logical bytenr to files.

[CAUSE]
"btrfs inspect logical-resolve" firstly resolve the logical bytenr to
root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
to the subvolume.

Then to handle cases where the subvolume is already mounted somewhere
else, we call find_mount_fsroot().

But if that target subvolume is not yet mounted, we just error out, even
if the @path is the top-level subvolume, and we have already know the
path to the subvolume.

[FIX]
Instead of doing unnecessary subvolume mount point check, just require
the @path to be the mount point of the top-level subvolume.

So that we can access all subvolumes without mounting each one.

Now the command works as expected:

 # ./btrfs inspect logical-resolve 13631488 $mnt
 /mnt/btrfs/subv1/file

And since we're changing the behavior of "logical-resolve" (to a more
user-friendly one), we have to update the test case misc/042 to reflect
that.

Reported-by: Torstein Eide <torsteine@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-inspect-internal.rst      |  3 ++
 cmds/inspect.c                                | 54 ++++++++-----------
 .../test.sh                                   | 25 ---------
 3 files changed, 24 insertions(+), 58 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
index 4265fab6..69da468a 100644
--- a/Documentation/btrfs-inspect-internal.rst
+++ b/Documentation/btrfs-inspect-internal.rst
@@ -149,6 +149,9 @@ logical-resolve [-Pvo] [-s <bufsize>] <logical> <path>
 
         resolve paths to all files at given *logical* address in the linear filesystem space
 
+        User should make sure *path* is the mount point of the top-level
+        subvolume (subvolid 5).
+
         ``Options``
 
         -P
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 20f433b9..dc0e587f 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -158,6 +158,9 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
+	const char *top_subvol = "/";
+	const char *top_subvolid = "5";
+	char *mounted = NULL;
 	bool getpath = true;
 	int bytes_left;
 	struct btrfs_ioctl_logical_ino_args loi = { 0 };
@@ -216,6 +219,23 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
+	/*
+	 * For logical-resolve, we want the mount point to be top level
+	 * subvolume (5), so that we can access all subvolumes.
+	 */
+	ret = find_mount_fsroot(top_subvol, top_subvolid, &mounted);
+	if (ret) {
+		error("failed to parse mountinfo");
+		goto out;
+	}
+	if (!mounted) {
+		ret = -ENOENT;
+		error("mount point \"%s\" is not the top-level subvolume",
+		      argv[optind + 1]);
+		goto out;
+	}
+	free(mounted);
+
 	ret = ioctl(fd, request, &loi);
 	if (ret < 0) {
 		error("logical ino ioctl: %m");
@@ -258,39 +278,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 				path_fd = fd;
 				strncpy(mount_path, full_path, PATH_MAX);
 			} else {
-				char *mounted = NULL;
-				char subvol[PATH_MAX];
-				char subvolid[PATH_MAX];
-
-				/*
-				 * btrfs_subvolid_resolve returns the full
-				 * path to the subvolume pointed by root, but the
-				 * subvolume can be mounted in a directory name
-				 * different from the subvolume name. In this
-				 * case we need to find the correct mount point
-				 * using same subvolume path and subvol id found
-				 * before.
-				 */
-
-				snprintf(subvol, PATH_MAX, "/%s", name);
-				snprintf(subvolid, PATH_MAX, "%llu", root);
-
-				ret = find_mount_fsroot(subvol, subvolid, &mounted);
-
-				if (ret) {
-					error("failed to parse mountinfo");
-					goto out;
-				}
-
-				if (!mounted) {
-					printf(
-			"inode %llu subvol %s could not be accessed: not mounted\n",
-						inum, name);
-					continue;
-				}
-
-				strncpy(mount_path, mounted, PATH_MAX);
-				free(mounted);
+				snprintf(mount_path, PATH_MAX, "%s%s", full_path, name);
 
 				path_fd = btrfs_open_dir(mount_path, &dirs, 1);
 				if (path_fd < 0) {
diff --git a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
index 2ba7331e..d20d5f74 100755
--- a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
+++ b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
@@ -51,34 +51,9 @@ run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1/subvol1
 
 run_check "$TOP/btrfs" filesystem sync "$TEST_MNT"
 
-run_check_umount_test_dev
-
-run_check $SUDO_HELPER mount -o subvol=/@/vol1 "$TEST_DEV" "$TEST_MNT"
-# Create a bind mount to vol1. logical-resolve should avoid bind mounts,
-# otherwise the test will fail
-run_check $SUDO_HELPER mkdir -p "$TEST_MNT/dir"
-run_check mkdir -p mnt2
-run_check $SUDO_HELPER mount --bind "$TEST_MNT/dir" mnt2
-# Create another bind mount to confuse logical-resolve even more.
-# logical-resolve can return the original mount or mnt3, both are valid
-run_check mkdir -p mnt3
-run_check $SUDO_HELPER mount --bind "$TEST_MNT" mnt3
-
 for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$vol1id" "$TEST_DEV" |
 		awk '/disk byte/ { print $5 }'); do
 	check_logical_offset_filename "$offset"
 done
 
-run_check_umount_test_dev mnt3
-run_check rmdir -- mnt3
-run_check_umount_test_dev mnt2
-run_check rmdir -- mnt2
-run_check_umount_test_dev
-
-run_check $SUDO_HELPER mount -o subvol="/@/vol1/subvol1" "$TEST_DEV" "$TEST_MNT"
-for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$subvol1id" "$TEST_DEV" |
-		awk '/disk byte/ { print $5 }'); do
-	check_logical_offset_filename "$offset"
-done
-
 run_check_umount_test_dev
-- 
2.39.0

