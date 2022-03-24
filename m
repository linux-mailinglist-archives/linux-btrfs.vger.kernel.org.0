Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A44E5DD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 05:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiCXEYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 00:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiCXEYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 00:24:23 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB8939E1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 21:22:51 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D24B0C01C; Thu, 24 Mar 2022 05:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648095768; bh=PikuAEz284XlxHdAeNrBghBTq0h5ckDRlWGDSfkkeBQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VCAjyM+KxYEJ18aPUfUP4uS1+Bo/H4wtZBVZeXo/GFKXNsicdxlgvys5z3IsNfoyV
         PnRnKNkKxWA66dVILcu9iLjj0j6eoCOqz4/thYJ1eI2IW8FcQA+kXFiPvk9RMnlomf
         N41q8remjoC3XzuTJ5QXA/v0klvktWoh8zsQLBUlW16+dMPEsy5NLOg/ZUO4BALAzQ
         m7MAy/pqo+m6nCJtruXOU5WnFlIrMBAcaNEy2x94B997QTAzrbPdxotEUp+yedzeL6
         ZDPJFqBtLSLwnMFYKbHpYlNDnIwCITH8lbmesWDMaaPcEof1zP8LYPiyS9cV1NM/ix
         J7UK9egOZTX5Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5AE9BC009;
        Thu, 24 Mar 2022 05:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1648095767; bh=PikuAEz284XlxHdAeNrBghBTq0h5ckDRlWGDSfkkeBQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DSoeS9hzyrqVJRA5bF3HQXZn58gvF5ZDG++l2fsSck2WrNQdpHIfLz5o9Skwj3m1W
         n5puwZ1te5DhMxOhNEzUdx+XeHBHn+oIa4X5FGx0VxzwAETSdN/zA9TV6GUOgM2lzn
         OWxVHp/dblnteiwYkzT+woQhpD0uDUTU2Jf9J3DJxegsfCHSUd2UazVDR21JgY/Yf+
         kf2nL5LpXvRFWK01uhFNZmVnGDvkSsGxc6j8nmKevR7Cbrc04t1/lQaf32OwdYlgPd
         b+FFwxDyHPASw6OBzV/jt9KjJEaXwjZh1YVaC3If/Mjha24Lf0JNcnBFuf3454iZG1
         4nzbe8v4mtSlg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d6fcb166;
        Thu, 24 Mar 2022 04:22:42 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [RFC PATCH] btrfs-progs: prop: add datacow inode property
Date:   Thu, 24 Mar 2022 13:22:35 +0900
Message-Id: <20220324042235.1483914-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

The btrfs property documentation states that it is an unified and
user-friendly method to tune btrfs properties instead of chattr,
so let's add something for datacow as well.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
- I've sent it on github[1] first as there were other PRs, I'll close it
there if this gets a reply 
[1] https://github.com/kdave/btrfs-progs/pull/454 

- naming: I wasn't sure whether to name it datacow with yes/no, or making it
"nodatacow" with true/false (readonly uses true/false so it might make more
sense to use the later), I've picked datacow to avoid double-negation for
ease of understanding but happy to change it to anything

- documentation: I got a bit confused with the rst and asciidoc file, as
things got "converted" to rst recently but the asciidoc file didn't get
removed. Should I have updated both?

Documentation/btrfs-man5.asciidoc          |  2 +-
 Documentation/btrfs-property.rst           |  3 +
 Documentation/ch-swapfile.rst              |  2 +-
 cmds/property.c                            | 67 ++++++++++++++++++++++
 tests/cli-tests/017-btrfs-property/test.sh | 25 ++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100755 tests/cli-tests/017-btrfs-property/test.sh

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index dd296fac6fec..a2ed7eb582d9 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -712,7 +712,7 @@ To create and activate a swapfile run the following commands:
 
 --------------------
 # truncate -s 0 swapfile
-# chattr +C swapfile
+# btrfs property set swapfile datacow no
 # fallocate -l 2G swapfile
 # chmod 0600 swapfile
 # mkswap swapfile
diff --git a/Documentation/btrfs-property.rst b/Documentation/btrfs-property.rst
index 5896faa2b2e2..600f6e60d255 100644
--- a/Documentation/btrfs-property.rst
+++ b/Documentation/btrfs-property.rst
@@ -48,6 +48,9 @@ get [-t <type>] <object> [<name>]
         compression
                 compression algorithm set for an inode, possible values: *lzo*, *zlib*, *zstd*.
                 To disable compression use "" (empty string), *no* or *none*.
+        datacow
+                copy on write flag for an inode: *no* or *yes*.
+                This is the same as ``chattr``/``lsattr`` *+C* flag.
 
 list [-t <type>] <object>
         Lists available properties with their descriptions for the given object.
diff --git a/Documentation/ch-swapfile.rst b/Documentation/ch-swapfile.rst
index 9d121bc5c569..f682e868632a 100644
--- a/Documentation/ch-swapfile.rst
+++ b/Documentation/ch-swapfile.rst
@@ -36,7 +36,7 @@ To create and activate a swapfile run the following commands:
 .. code-block:: bash
 
         # truncate -s 0 swapfile
-        # chattr +C swapfile
+        # btrfs property set swapfile datacow no
         # fallocate -l 2G swapfile
         # chmod 0600 swapfile
         # mkswap swapfile
diff --git a/cmds/property.c b/cmds/property.c
index b3ccc0ff69b0..de9fde9e09e2 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -24,6 +24,7 @@
 #include <sys/xattr.h>
 #include <uuid/uuid.h>
 #include <btrfsutil.h>
+#include <linux/fs.h>
 #include "cmds/commands.h"
 #include "cmds/props.h"
 #include "kernel-shared/ctree.h"
@@ -232,6 +233,65 @@ static int prop_compression(enum prop_object_type type,
 	return ret;
 }
 
+static int prop_datacow(enum prop_object_type type,
+			const char *object,
+			const char *name,
+			const char *value,
+			bool force)
+{
+	int ret;
+	ssize_t sret;
+	int fd = -1;
+	DIR *dirstream = NULL;
+	//int open_flags = value ? O_RDWR : O_RDONLY;
+	int open_flags = O_RDONLY;
+	int attr;
+
+	fd = open_file_or_dir3(object, &dirstream, open_flags);
+	if (fd == -1) {
+		ret = -errno;
+		error("failed to open %s: %m", object);
+		goto out;
+	}
+
+	sret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+	if (sret < 0) {
+		ret = -errno;
+		error("failed to get attr flags on %s: %m", object);
+		goto out;
+	}
+
+	if (value) {
+		if (strcmp(value, "no") == 0) {
+			attr |= FS_NOCOW_FL;
+		} else if (strcmp(value, "yes") == 0) {
+			attr &= ~FS_NOCOW_FL;
+		} else {
+			ret = -EINVAL;
+			error("datacow value must be yes or no");
+			goto out;
+		}
+
+		sret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
+		if (sret < 0) {
+			ret = -errno;
+			error("failed to set nocow flag on %s: %m",
+			      object);
+			goto out;
+		}
+	} else {
+		fprintf(stdout, "datacow=%s\n",
+			attr & FS_NOCOW_FL ? "no" : "yes");
+	}
+
+	ret = 0;
+out:
+	if (fd >= 0)
+		close_file_or_dir(fd, dirstream);
+
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{
 		.name ="ro",
@@ -254,6 +314,13 @@ const struct prop_handler prop_handlers[] = {
 		.types = prop_object_inode,
 		.handler = prop_compression
 	},
+	{
+		.name = "datacow",
+		.desc = "copy on write status of a file",
+		.read_only = 0,
+		.types = prop_object_inode,
+		.handler = prop_datacow
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
 
diff --git a/tests/cli-tests/017-btrfs-property/test.sh b/tests/cli-tests/017-btrfs-property/test.sh
new file mode 100755
index 000000000000..1da3eda4cd3a
--- /dev/null
+++ b/tests/cli-tests/017-btrfs-property/test.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# test btrfs property commands
+
+source "$TEST_TOP/common"
+
+# compare with lsattr to make sure
+check_global_prereq lsattr
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+run_check $SUDO_HELPER touch "$TEST_MNT/file"
+run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/file" datacow no
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" property get "$TEST_MNT/file" datacow |
+	grep -q "datacow=no" || _fail "datacow wasn't no"
+run_check_stdout $SUDO_HELPER lsattr "$TEST_MNT/file" |
+	grep -q -- "C.* " || _fail "lsattr didn't agree NOCOW flag is set"
+run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/file" datacow yes
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" property get "$TEST_MNT/file" datacow |
+	grep -q "datacow=yes" || _fail "datacow wasn't yes"
+
+run_check_umount_test_dev
-- 
2.35.1

