Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57632B55E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 01:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKQA63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 19:58:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54357 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgKQA61 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 19:58:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EEB35C01D0;
        Mon, 16 Nov 2020 19:58:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 16 Nov 2020 19:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=tM4pqtPlDGOu9WOZXS7HqavVyL
        qfD3mGmsf3hR2KCew=; b=JBa9qN18G+AssWfVT0GVOecZ2I0VZ+1hkHkLf5V0nW
        BmaQxV5slZ09iBt19V74Ypr2IGrlRhbnfEZyYwj04RaXPk3oYA10TuU+aulBXw5+
        WTjuptZor84VlCdkACqfdBOGgoJl7oQVihFTsd94fm2lo0gvdwtzKV4z13Uu3OPq
        GYTUC63/t1Te03hoDxC1O4fIx62rsiSOgWg0UTd2wPHwCCk/5jinAEo+crw2gsqx
        Fh3s1c3HVT3NHWpI4HzMCwwlWrV0xcGJvQpeRRDiPwL92jH8SoHM6yALP/8e8Y7F
        A+1YDtvSoEzt4xe+w/TjqPlKHed/wxA65bstunNEjmJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tM4pqtPlDGOu9WOZX
        S7HqavVyLqfD3mGmsf3hR2KCew=; b=LhrJVNc73qqd5OQLK+UA51WmSXbcLS3FR
        AFgwbI+V3z15FIZWsVxwzcAOf7Z7SbRW/EfSxxTRhcL9oHfGkbQd6572sdqn5aBw
        7lr64rDQ9pHiRaul9R90UV5J9Qn3K8u4Z+3O0CZdKP3uXFBA3ZvWTs6DIXenTWBr
        xvq1a9cnLNzUV281l5pwaJn9yrodqGHjf3ugr91YjapHor1qQUcHpZ8oYDTkM+jp
        Th8uArKiKJzT/OB0WtLtqqygSaUJoyxKmz5PcHzBxM4V8etT5zbowI+jmyhC2NGa
        Rjw/ivO+FKFNC+U3Yn92ozIjEEWJmtiq2rmE2LKtRN5yUNXVaxQPQ==
X-ME-Sender: <xms:MCCzX3ztIeSZkgBQDTeQCI6o4oNrqdxuErUxfxTu_qbyJ6JOQLy6iA>
    <xme:MCCzX_ShFVztarD3o5oBxxzJBijzhYi3s0cNU5vIqlJaQOPScjNquNaMGzU01jbS7
    t77HIawJd7rDrIxhhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeeghedugfeugfeufeffveekffelueejleehffeuvdetgf
    eiveehuddvvdetvdeuheenucffohhmrghinhepuggrthgrrdhfohhonecukfhppeduieef
    rdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MCCzXxWFB4Hk9SGUJiCiPZTMtdRfN_4lkAvL-rKh-5zjtLzZnk6-1A>
    <xmx:MCCzXxj0A9zw2kaxZ-06iVaPqOc-_TG6u7rYOcgvejdnN1K9kteFBA>
    <xmx:MCCzX5BCYE0RS4Q9vX7zUvuzapc2_5BFCxTFXzespFRzPEn6Xz-6fA>
    <xmx:MSCzX0-faLInEBl5XbIaHOWw421ZutCdBlG8wFMyJzdqOzfXkx-Eaw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 674D93280063;
        Mon, 16 Nov 2020 19:58:24 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: receive: fix btrfs_mount_root substring bug
Date:   Mon, 16 Nov 2020 16:58:20 -0800
Message-Id: <8f5cec45ff013e9967f3261676e5ff41d340305e.1605572809.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current mount detection code in btrfs receive is not quite perfect.
For example, suppose /tmp is mounted as a tmpfs. In that case,
btrfs receive /tmp2 will find /tmp as the longest mount that matches a
prefix of /tmp2 and blow up because it is not a btrfs filesystem, even
if /tmp2 is just a directory in / mounted as btrfs.

Fix this by replacing the substring check with a dirname recursion to
only check the directories in the path of the dir, rather than every
substring.

Add a new test for this case.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/path-utils.c                          | 32 +++++++++++++++++
 common/path-utils.h                          |  1 +
 common/utils.c                               |  5 ++-
 tests/misc-tests/042-recv-mount-type/test.sh | 36 ++++++++++++++++++++
 4 files changed, 71 insertions(+), 3 deletions(-)
 create mode 100755 tests/misc-tests/042-recv-mount-type/test.sh

diff --git a/common/path-utils.c b/common/path-utils.c
index 175da572..ee479cc7 100644
--- a/common/path-utils.c
+++ b/common/path-utils.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <errno.h>
 #include <ctype.h>
+#include <libgen.h>
 #include "common/path-utils.h"
 
 /*
@@ -374,6 +375,37 @@ int path_is_dir(const char *path)
 	return !!S_ISDIR(st.st_mode);
 }
 
+/*
+ * Test if a path is recursively contained in parent
+ * Assumes parent and path are null terminated absolute paths
+ * Returns:
+ *   0 - path not contained in parent
+ *   1 - path contained in parent
+ * < 0 - error
+ * e.g. (/, /foo) -> 1
+ *      (/foo, /) -> 0
+ *      (/foo, /foo/bar/baz) -> 1
+ */
+int path_is_in_dir(const char *parent, const char *path)
+{
+	char *tmp = strdup(path);
+	char *curr_dir = tmp;
+	int ret;
+
+	while (strcmp(parent, curr_dir) != 0) {
+		if (strcmp(curr_dir, "/") == 0) {
+			ret = 0;
+			goto out;
+		}
+		curr_dir = dirname(curr_dir);
+	}
+	ret = 1;
+
+out:
+	free(tmp);
+	return ret;
+}
+
 /*
  * Copy a path argument from SRC to DEST and check the SRC length if it's at
  * most PATH_MAX and fits into DEST. DESTLEN is supposed to be exact size of
diff --git a/common/path-utils.h b/common/path-utils.h
index 0cabcb7d..8e9ddadf 100644
--- a/common/path-utils.h
+++ b/common/path-utils.h
@@ -35,6 +35,7 @@ int path_is_reg_file(const char *path);
 int path_is_dir(const char *path);
 int is_same_loop_file(const char *a, const char *b);
 int path_is_reg_or_block_device(const char *filename);
+int path_is_in_dir(const char *parent, const char *path);
 
 int test_issubvolname(const char *name);
 
diff --git a/common/utils.c b/common/utils.c
index c47ce29b..9bf28cc6 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1267,9 +1267,8 @@ int find_mount_root(const char *path, char **mount_root)
 		return -errno;
 
 	while ((ent = getmntent(mnttab))) {
-		len = strlen(ent->mnt_dir);
-		if (strncmp(ent->mnt_dir, path, len) == 0) {
-			/* match found and use the latest match */
+		if (path_is_in_dir(ent->mnt_dir, path)) {
+			len = strlen(ent->mnt_dir);
 			if (longest_matchlen <= len) {
 				free(longest_match);
 				longest_matchlen = len;
diff --git a/tests/misc-tests/042-recv-mount-type/test.sh b/tests/misc-tests/042-recv-mount-type/test.sh
new file mode 100755
index 00000000..a30742a8
--- /dev/null
+++ b/tests/misc-tests/042-recv-mount-type/test.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+#
+# Test some scenarios around the mount point we do receive onto.
+# Should fail in a non-btrfs filesystem, but succeed if a non btrfs
+# filesystem is the longest mounted substring of the target, but not
+# the actual containing mount.
+#
+# This is a regression test for
+# "btrfs-progs: receive: fix btrfs_mount_root substring bug"
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
+cd "$TEST_MNT"
+run_check $SUDO_HELPER mkdir "foo" "foobar"
+run_check $SUDO_HELPER mount -t tmpfs tmpfs "foo"
+run_check $SUDO_HELPER mkdir "foo/bar"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "subvol"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "subvol" "snap"
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "snap"
+run_mustfail "no receive on tmpfs" $SUDO_HELPER "$TOP/btrfs" receive -f send.data "./foo"
+run_mustfail "no receive on tmpfs" $SUDO_HELPER "$TOP/btrfs" receive -f send.data "./foo/bar"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "./foobar"
+run_check_umount_test_dev "foo"
+
+cd ..
+run_check_umount_test_dev
-- 
2.24.1

