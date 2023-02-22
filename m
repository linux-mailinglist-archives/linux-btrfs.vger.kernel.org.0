Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB07269FC3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBVTal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 14:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBVTaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 14:30:39 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E23B870;
        Wed, 22 Feb 2023 11:30:25 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1AB6D320098F;
        Wed, 22 Feb 2023 14:30:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 Feb 2023 14:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1677094222; x=1677180622; bh=Cok6V7PpqtuP+ZrhjHhdb60D4
        9rv6NE+aBCw7ipGCnc=; b=A50TPbuyNVXZMIbbVrZKQvlyJp4t/B2rTDaKJ4ifl
        2jiNrVpXjrXe7LGxVuxfe1fY3gITgbv9J1Tkq611juxcvqJqUaNuH2a5H2+Yn7LX
        2lFETEm6dHYQQGlAs3OpYaW0v0r/4BCbVfUs/OId8q0I7BwwNrEK2b6UgPS8nOP4
        ZSD2cBLLBc44oPKZE8LjgAmOM1X5zkl4rMU+YqDs0MKbiuALC9zuCYYrkbBm6Bh5
        NhKUtQaEPoRLc1wCCdG3+/5QqqQRXwBPkQJaI90b2IIojpzeT2ap7OsdxKtW5AND
        6rlYgbWg87Me4n+DOVsPgAAx0/f8qzBFSRuG/azmLhzPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677094222; x=1677180622; bh=Cok6V7PpqtuP+ZrhjHhdb60D49rv6NE+aBC
        w7ipGCnc=; b=PpFmu+h4KuvXQrF9LJrXX9mvpT5kdlndJ0xjugjIoUoQL3q7ORF
        VeTwTbo4GDYwtFGRDMsLEEFNf16bHyLHmFrCHi5gF28i08u1788ryJj/qlmo2LbW
        R7k1k9Tbl48YAxBkT3sFUnSlxoO6/y9iMSSocqGNT+rcoQhQE68nQXIKqDXnBaZJ
        yUm2rPNRTt23Q+Ziol3SsBkcCiEfa4tEi4I+7401PLcL4Cky0o5YVw0xwFxMLYDu
        JA2H3s3wc+dP2+9cQmbfpL+9N79xQFeQ1ImaP5AX0zx3ucwZn4q+pjKxsYC1CX/0
        iSq6DvpNq/WeW3TjVdfXt8jIY+al2TqFfTw==
X-ME-Sender: <xms:Tm32Y1zgBD0kRYLm427kqEXNhebSLVObQBmBoYdoYI3RTX3g6VHSBQ>
    <xme:Tm32Y1RLbEHt0HS81OXE43phryXGE-V-lyZ8YQgUCLl8WIbZAg4HihWy9YaOYvclP
    lOpS3fPXPF27iK98D0>
X-ME-Received: <xmr:Tm32Y_XimWelWTfn3YZjMlxFxefTesyJ6IWDTHsjCAOuXm5zVFyMGyWD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Tm32Y3gsLVPyrAJk6GayNPVHNDZAaMeVwjbRA8NDDwwtUUMezyt4dw>
    <xmx:Tm32Y3CDE0vso15ClaYoScVMGvzE4gCfOLxV-wddHMHvxHzQ1RhbBg>
    <xmx:Tm32YwIzjEt9mKN8TwW4OMm73Dlb0kWJ0yVJpSGHe8sqY_V6yTIcnA>
    <xmx:Tm32Y85OINg4eEiF96k44xuHcVNFgqNidQh6_oQgYL8yIWKtGBWUHg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 14:30:22 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] generic: add test for direct io partial writes
Date:   Wed, 22 Feb 2023 11:30:20 -0800
Message-Id: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
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
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/708     | 48 +++++++++++++++++++++++++
 tests/generic/708.out |  2 ++
 5 files changed, 135 insertions(+), 1 deletion(-)
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
index 00000000..36ff6710
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
+int prep_mmap_buffer(char *src_filename, int *fd, void **addr)
+{
+	struct stat st;
+	int ret;
+
+	*fd = open(src_filename, O_RDWR, 0666);
+	if (*fd == -1)
+		err(1, "failed to open %s", src_filename);
+
+	ret = fstat(*fd, &st);
+	if (ret)
+		err(1, "failed to stat %d", *fd);
+
+	*addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, *fd, 0);
+	if (*addr == MAP_FAILED)
+		err(1, "failed to mmap %d", *fd);
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
+	int fd;
+	void *buf = NULL;
+	char c;
+
+	if (argc != 3)
+		errx(1, "no in and out file name arguments given");
+	sz = prep_mmap_buffer(argv[1], &fd, &buf);
+
+	/* touch the first page of the mapping to bring it into cache */
+	c = ((char *)buf)[0];
+	printf("%u\n", c);
+
+	do_dio(argv[2], buf, sz);
+}
diff --git a/tests/generic/708 b/tests/generic/708
new file mode 100755
index 00000000..ff2e162b
--- /dev/null
+++ b/tests/generic/708
@@ -0,0 +1,48 @@
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
+# thus the iompap direct_io partial write codepath.
+#
+. ./common/preamble
+_begin_fstest quick auto
+_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
+
+# Override the default cleanup function.
+_cleanup()
+{
+ 	cd /
+ 	rm -r -f $tmp.*
+	rm -f $TEST_DIR/dio-buf-fault.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program dio-buf-fault
+src=$TEST_DIR/dio-buf-fault.src
+dst=$TEST_DIR/dio-buf-fault.dst
+
+echo "Silence is golden"
+
+$XFS_IO_PROG -fc "pwrite -q 0 $((2 * 1024 * 1024))" $src
+sync
+$here/src/dio-buf-fault $src $dst >> $seqres.full || _fail "failed doing the dio copy"
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

