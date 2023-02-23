Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA666A0EF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjBWSB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWSB5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 13:01:57 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA931521DF;
        Thu, 23 Feb 2023 10:01:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 530243200960;
        Thu, 23 Feb 2023 13:01:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Feb 2023 13:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1677175312; x=1677261712; bh=YHokDfrQry9StCfPSq9ngfwCz
        n3onGNjHyeQD1AMtiw=; b=m7lKC+vrWKSqXHPCtFMNTU9w9WL3m3dxd6BrEAt3b
        HhgafCQ4E9VKdVkod/9PNaIzAQ3eKB5TiIZnwAK0SKefPkzPtAGlqxwp3CTgLxFv
        5qZ1rSKBqm6eWIYNQ5u0FiHGwfJGnyrmIlXLaFvGMYxTfSlK+HK5ImC4Bmgkachp
        cyO5V+O2K0PGz8JkI/Z2RN0Q50bl7j+FQkRn9O6n65d7sbBC+epOtjXpF5d5zp8g
        bD7YdTiIqVw9cWpl1VQU+snX6TD7Dd9KUalLBFdm2mmok9V/OCOlD6LVBhP22u9v
        WpqXB/yBReWy2PvZGrO+CznT8w/KmahJJzKt3vgSY6PzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677175312; x=1677261712; bh=YHokDfrQry9StCfPSq9ngfwCzn3onGNjHye
        QD1AMtiw=; b=nyDbBP5BHeRrecAaJNK4C3WYzOayTZi3egkl9Kk5Kd3wbz7k6+C
        Z58wMTEqXRzzqTdeDMTCE+fkCC/HNzBjkcbc7UVn2ECAOZlX/ujjUe1k7UolIDI3
        EMEH6d1RLmBs92esB71moQCdyD12GOVdSoAkiOorNiMtn+KZv0xfkO7FLZ0E+gAW
        Lg8KN7epeS84ugZwzNxivYnHSBjzD6LZvtFPWPgheNVbjVN7ByTLwKMsWwEaXxED
        Ar+oUpt4cCSlMix7+uzCQoCMlxf9sgmsmqZ1EjzRKePB614NOV2NoTOdFIhvAaq0
        K40mkBReMDNjEDmuYx36tybcQauHrgYFuag==
X-ME-Sender: <xms:EKr3YxJdUguHlStBoZ525JcNLX7Sw1DRL9BdsiyU0njERT7CI9SQDA>
    <xme:EKr3Y9LoPYJXEh1OxzeT-q3QVKYLfq9cbObFV4c4f7vdJakBYY3Nc6mMNl1ZaKxND
    6AHcYvqNAtOAu7xUOQ>
X-ME-Received: <xmr:EKr3Y5slgcghnYMLtaVITYWct4aayg7-qsP1t9ytIE302RIzQiKjJvtO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:EKr3YyaxjcC3SSLyKnk4yozZEwPBPuXqsOdVQHlJm3QtYWzQ4gl1yw>
    <xmx:EKr3Y4ZVyMhHmytAI2E9baBKj56p-cbhq4Gw5XEv3ccuOj3FocQhlQ>
    <xmx:EKr3Y2BqkQbJkup56vTNfMMug2U_-42amDjBssLbJLytIwZdR1B-4A>
    <xmx:EKr3Yzx7HyOjoKrpBwQgZy7jAICmoTrMwtfE-x108POoya5ly16vQQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 13:01:52 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] generic: add test for direct io partial writes
Date:   Thu, 23 Feb 2023 10:01:51 -0800
Message-Id: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs recently had a bug where a direct io partial write resulted in a
hole in the file. Add a new generic test which creates a 2MiB file,
mmaps it, touches the first byte, then does an O_DIRECT write of the
mmapped buffer into a new file. This should result in the mapped pages
being a mix of in and out of page cache and thus a partial write, for
filesystems using iomap and IOMAP_DIO_PARTIAL.

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- hide fd in prep_mmap_buffer, we weren't closing it in main
- get rid of unneeded filters/cleanup in test script
- make pwrite pattern explicit
- send random mmapped char to /dev/null
- gate _fixed_by_kernel_commit by FSTYP
- remove extra sync after writing file
- use $seq in test filenames

 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/708     | 37 +++++++++++++++++++
 tests/generic/708.out |  2 ++
 5 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 src/dio-buf-fault.c
 create mode 100755 tests/generic/708
 create mode 100644 tests/generic/708.out

diff --git a/.gitignore b/.gitignore
index cfff8f85..644290f0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@ tags
 /src/deduperace
 /src/detached_mounts_propagation
 /src/devzero
+/src/dio-buf-fault
 /src/dio-interleaved
 /src/dio-invalidate-cache
 /src/dirhash_collide
diff --git a/src/Makefile b/src/Makefile
index a574f7bd..24cd4747 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino
+	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/dio-buf-fault.c b/src/dio-buf-fault.c
new file mode 100644
index 00000000..911c3e1f
--- /dev/null
+++ b/src/dio-buf-fault.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
+#endif
+
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <err.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/*
+ * mmap a source file, then do a direct write of that mmapped region to a
+ * destination file.
+ */
+
+int prep_mmap_buffer(char *src_filename, void **addr)
+{
+	struct stat st;
+	int fd;
+	int ret;
+
+	fd = open(src_filename, O_RDWR, 0666);
+	if (fd == -1)
+		err(1, "failed to open %s", src_filename);
+
+	ret = fstat(fd, &st);
+	if (ret)
+		err(1, "failed to stat %d", fd);
+
+	*addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (*addr == MAP_FAILED)
+		err(1, "failed to mmap %d", fd);
+
+	return st.st_size;
+}
+
+int do_dio(char *dst_filename, void *buf, size_t sz)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(dst_filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
+	if (fd == -1)
+		err(1, "failed to open %s", dst_filename);
+	while (sz) {
+		ret = write(fd, buf, sz);
+		if (ret < 0) {
+			if (errno == -EINTR)
+				continue;
+			else
+				err(1, "failed to write %lu bytes to %d", sz, fd);
+		} else if (ret == 0) {
+			break;
+		}
+		buf += ret;
+		sz -= ret;
+	}
+	return sz;
+}
+
+int main(int argc, char *argv[]) {
+	size_t sz;
+	void *buf = NULL;
+	char c;
+
+	if (argc != 3)
+		errx(1, "no in and out file name arguments given");
+	sz = prep_mmap_buffer(argv[1], &buf);
+
+	/* touch the first page of the mapping to bring it into cache */
+	c = ((char *)buf)[0];
+	printf("%u\n", c);
+
+	do_dio(argv[2], buf, sz);
+}
diff --git a/tests/generic/708 b/tests/generic/708
new file mode 100755
index 00000000..1f0843c7
--- /dev/null
+++ b/tests/generic/708
@@ -0,0 +1,37 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 708
+#
+# Test iomap direct_io partial writes.
+#
+# Create a reasonably large file, then run a program which mmaps it,
+# touches the first page, then dio writes it to a second file. This
+# can result in a page fault reading from the mmapped dio write buffer and
+# thus the iomap direct_io partial write codepath.
+#
+. ./common/preamble
+_begin_fstest quick auto
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program dio-buf-fault
+src=$TEST_DIR/dio-buf-fault-$seq.src
+dst=$TEST_DIR/dio-buf-fault-$seq.dst
+
+rm -rf "$src" "$dst"
+
+echo "Silence is golden"
+
+$XFS_IO_PROG -fc "pwrite -q -S 0xcd 0 $((2 * 1024 * 1024))" $src
+$here/src/dio-buf-fault $src $dst > /dev/null || _fail "failed doing the dio copy"
+diff $src $dst
+
+# success, all done
+status=$?
+exit
diff --git a/tests/generic/708.out b/tests/generic/708.out
new file mode 100644
index 00000000..33c478ad
--- /dev/null
+++ b/tests/generic/708.out
@@ -0,0 +1,2 @@
+QA output created by 708
+Silence is golden
-- 
2.39.1

