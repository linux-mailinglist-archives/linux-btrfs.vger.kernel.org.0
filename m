Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B76E8A3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 08:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjDTGQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 02:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDTGQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 02:16:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414346A5
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 23:16:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B14B51FDB3;
        Thu, 20 Apr 2023 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681971411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IJuEWh/C2zNC1JNHYEwKRGjlXVG4Co1bFHngwmRrgHg=;
        b=U/s3XEeHOGXEGUApdGARmlFXnQhE/OucTwY2hWdiR62oaaVUNi8zJg5c+zxaM8bXH9stqr
        sBsywxHRLHhTRaM7botd2IJcrBquPLBtHA22L5GnkuYLbBNRmmbHIQLG3Qyi76BFxLAUi8
        /1vpdMRkm9zvBPU2OT7jwdORqW3oXiw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD1B71333C;
        Thu, 20 Apr 2023 06:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpFPKtLYQGRWJwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 20 Apr 2023 06:16:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Torstein Eide <torsteine@gmail.com>
Subject: [PATCH v2] btrfs-progs: logical-resolve: fix the subvolume path resolution
Date:   Thu, 20 Apr 2023 14:16:33 +0800
Message-Id: <7ccf52d35fdcdf743a254f3c93065f9334d878f8.1681971385.git.wqu@suse.com>
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
that, and added a new check on the behavior if executed on
none-top-level subvolumes.

Reported-by: Torstein Eide <torsteine@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Completely remove the find_mount_fsroot() infrastructure
  To me, trying to locate another mount point other than the specified
  path, is a question that no one asked.

- Added a new check on "inspect logical-resolve" if executed on
  none-top-level subvolume
---
 Documentation/btrfs-inspect-internal.rst      |   3 +
 cmds/inspect.c                                |  53 ++---
 common/utils.c                                | 209 ------------------
 .../test.sh                                   |  27 +--
 4 files changed, 27 insertions(+), 265 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.rst b/Documentation/btrfs-inspect-internal.rst
index 4265fab68ed3..69da468aec10 100644
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
index 20f433b9199f..1215c3731d5e 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -167,6 +167,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	char *path_ptr;
 	DIR *dirstream = NULL;
 	u64 flags = 0;
+	u64 rootid;
 	unsigned long request = BTRFS_IOC_LOGICAL_INO;
 
 	optind = 0;
@@ -216,6 +217,24 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
+	/*
+	 * For logical-resolve, we want the mount point to be top level
+	 * subvolume (5), so that we can access all subvolumes.
+	 */
+	ret = lookup_path_rootid(fd, &rootid);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to determine if \"%s\" is the top-level subvolume: %m",
+		      argv[optind + 1]);
+		goto out;
+	}
+	if (rootid != BTRFS_FS_TREE_OBJECTID) {
+		error("\"%s\" is not the top-level subvolume, has %llu want %llu",
+		      argv[optind + 1], rootid, BTRFS_FS_TREE_OBJECTID);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = ioctl(fd, request, &loi);
 	if (ret < 0) {
 		error("logical ino ioctl: %m");
@@ -258,39 +277,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
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
diff --git a/common/utils.c b/common/utils.c
index 2c359dcf220f..f702bf04bb1c 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -424,47 +424,12 @@ struct mnt_entry {
 	const char *options2;
 };
 
-/*
- * Find first occurrence of up an option string (as "option=") in @options,
- * separated by comma. Return allocated string as "option=value"
- */
-static char *find_option(const char *options, const char *option)
-{
-	char *tmp, *ret;
-
-	tmp = strstr(options, option);
-	if (!tmp)
-		return NULL;
-	ret = strdup(tmp);
-	tmp = ret;
-	while (*tmp && *tmp != ',')
-		tmp++;
-	*tmp = 0;
-	return ret;
-}
-
 /* Match whitespace separator */
 static bool is_sep(char c)
 {
 	return c == ' ' || c == '\t';
 }
 
-/* Advance @line skipping over all non-separator chars */
-static void skip_nonsep(char **line)
-{
-	while (**line && !is_sep(**line))
-		(*line)++;
-}
-
-/* Advance @line skipping over all separator chars, setting them to nul char */
-static void skip_sep(char **line)
-{
-	while (**line && is_sep(**line)) {
-		**line = 0;
-		(*line)++;
-	}
-}
-
 static bool isoctal(char c)
 {
 	return '0' <= c && c <= '7';
@@ -528,180 +493,6 @@ char *read_path(char **line)
 	return ret;
 }
 
-/*
- * Parse a line from /proc/pid/mountinfo
- * Example:
-
-272 265 0:49 /subvol /mnt/path rw,noatime shared:145 - btrfs /dev/sda1 rw,subvolid=5598,subvol=/subvol
-0   1   2    3      4          5          6          7 8     9         10
-
- * Fields related to paths and options are parsed, @line is changed in place,
- * separators are replaced by nul char, paths could be unmangled.
- */
-static void parse_mntinfo_line(char *line, struct mnt_entry *ent)
-{
-	/* Skip 0 */
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Skip 1 */
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Skip 2 */
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Read 3 */
-	ent->root = read_path(&line);
-	skip_sep(&line);
-	/* Read 4 */
-	ent->path = read_path(&line);
-	skip_sep(&line);
-	/* Read 5 */
-	ent->options1 = line;
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Skip 6 */
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Skip 7 */
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Read 8 */
-	ent->fstype = line;
-	skip_nonsep(&line);
-	skip_sep(&line);
-	/* Read 9 */
-	ent->device = read_path(&line);
-	skip_sep(&line);
-	/* Read 10 */
-	ent->options2 = line;
-	skip_nonsep(&line);
-	skip_sep(&line);
-}
-
-/*
- * Compare the subvolume passed with the pathname of the directory mounted in
- * btrfs. The pathname inside btrfs is different from getmnt and friends, since
- * it can detect bind mounts to content from the inside of the original mount.
- *
- * Example:
- *   # mount -o subvol=/vol /dev/sda2 /mnt
- *   # mount --bind /mnt/dir2 /othermnt
- *
- *   # mounts
- *   ...
- *   /dev/sda2 on /mnt type btrfs (ro,relatime,ssd,space_cache,subvolid=256,subvol=/vol)
- *   /dev/sda2 on /othermnt type btrfs (ro,relatime,ssd,space_cache,subvolid=256,subvol=/vol)
- *
- *   # cat /proc/self/mountinfo
- *
- *   38 30 0:32 /vol /mnt ro,relatime - btrfs /dev/sda2 ro,ssd,space_cache,subvolid=256,subvol=/vol
- *   37 29 0:32 /vol/dir2 /othermnt ro,relatime - btrfs /dev/sda2 ro,ssd,space_cache,subvolid=256,subvol=/vol
- *
- * If we try to find a mount point only using subvol and subvolid from mount
- * options we would get mislead to believe that /othermnt has the same content
- * as /mnt.
- *
- * But, using mountinfo, we have the pathaname _inside_ the filesystem, so we
- * can filter out the mount points with bind mounts which have different content
- * from the original mounts, in this case the mount point with id 37.
- */
-int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount)
-{
-	FILE *mnt;
-	char *buf = NULL;
-	int bs = 4096;
-	int line = 0;
-	int ret = 0;
-	bool found = false;
-
-	mnt = fopen("/proc/self/mountinfo", "r");
-	if (!mnt)
-		return -1;
-
-	buf = malloc(bs);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	do {
-		int ch;
-
-		ch = fgetc(mnt);
-		if (ch == -1)
-			break;
-
-		if (ch == '\n') {
-			struct mnt_entry ent;
-			char *opt;
-			const char *value;
-
-			buf[line] = 0;
-			parse_mntinfo_line(buf, &ent);
-
-			/* Skip unrelated mounts */
-			if (strcmp(ent.fstype, "btrfs") != 0)
-				goto nextline;
-			if (strlen(ent.root) != strlen(subvol))
-				goto nextline;
-			if (strcmp(ent.root, subvol) != 0)
-				goto nextline;
-
-			/*
-			 * Match subvolume by id found in mountinfo and
-			 * requested by the caller
-			 */
-			opt = find_option(ent.options2, "subvolid=");
-			if (!opt)
-				goto nextline;
-			value = opt + strlen("subvolid=");
-			if (strcmp(value, subvolid) != 0) {
-				free(opt);
-				goto nextline;
-			}
-			free(opt);
-
-			/*
-			 * First match is in most cases the original mount, not
-			 * a bind mount. In case there are no further bind
-			 * mounts, return what we found in @mount.  Any
-			 * following mount that matches by path and subvolume
-			 * id is a bind mount and we return the original mount.
-			 */
-			if (found)
-				goto out;
-			found = true;
-			*mount = strdup(ent.path);
-			ret = 0;
-			goto nextline;
-		}
-		/*
-		 * Grow buffer if needed, there are 3 paths up to PATH_MAX and
-		 * mount options are limited by page size. Often the overall
-		 * line length does not exceed 256.
-		 */
-		if (line >= bs) {
-			char *tmp;
-
-			bs += 4096;
-			tmp = realloc(buf, bs);
-			if (!tmp) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			buf = tmp;
-		}
-		buf[line++] = ch;
-		continue;
-nextline:
-		line = 0;
-	} while (1);
-out:
-	free(buf);
-	fclose(mnt);
-	return ret;
-}
-
 /*
  * return 0 if a btrfs mount point is found
  * return 1 if a mount point is found but not btrfs
diff --git a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
index 0ef90e93fafb..f60e346fbcc0 100755
--- a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
+++ b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
@@ -51,34 +51,15 @@ run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1/subvol1
 
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
 run_check_umount_test_dev
 
-run_check $SUDO_HELPER mount -o subvol="/@/vol1/subvol1" "$TEST_DEV" "$TEST_MNT"
-for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$subvol1id" "$TEST_DEV" |
-		awk '/disk byte/ { print $5 }'); do
-	check_logical_offset_filename "$offset"
-done
-
+# Make sure we error out if the target path is not a top-level subvolume
+run_check_mount_test_dev -o subvol="@/vol1"
+run_mustfail "logical-resolve should fail if the path is not a top-level subvolume" \
+	$SUDO_HELPER "$TOP/btrfs" inspect-internal logical-resolve 4096 "$TEST_MNT"
 run_check_umount_test_dev
-- 
2.39.2

