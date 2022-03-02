Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6774CA2E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiCBLNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 06:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCBLNN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 06:13:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75400F45;
        Wed,  2 Mar 2022 03:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815D961778;
        Wed,  2 Mar 2022 11:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2CC004E1;
        Wed,  2 Mar 2022 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646219547;
        bh=skhphHZ0bF9qW6dVL/iqfew+kSqJHgCS/eY+3ZwZplM=;
        h=From:To:Cc:Subject:Date:From;
        b=Nkb/LptGY/Bo1EhuKzJ8jwkO6VzXutiAI3790owl81nVrHtCLOxDhybZmztTde4i+
         aHDNpIwlCGjn549ZSJccYDcEiS1XjctFI284cNAq1+wJ530zlPkK/t9hIuP0YwwnOW
         o5A10dj5k4/F9Bp1wSBSF8LVTscSvY6CCrG+bX/+6LKdOmenwqgGZMadgZ5e/nDEFG
         hGrici8BoyRJmqlBIahqu36W8NTZhuo1gzWPM4cUvzulXtviovIXxNNMHQL4SV1eiL
         zVvEuyZN1jaNhwobslsCRCvxProxhJvOl0g0lDTGVDs+LgPldrfX+lD8R+qT+nx60q
         5Du9T9BqSbEDg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: add a test for reading multiple extents with io_uring
Date:   Wed,  2 Mar 2022 11:12:19 +0000
Message-Id: <2f4b119ea888a91aabbe8026ced165ab0fe38139.1646219188.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test doing a read, with io_uring, over a file range that includes multiple
extents. The read operation triggers page faults when accessing all pages
of the read buffer except for the pages corresponding to the first extent.
We want to check that the operation results in reading all the extents and
that it returns the correct data.

This is motivated by an issue found with MariaDB when using io_uring and
running on btrfs. There's a patch for btrfs to address the issue and it
has the following subject:

 "btrfs: fallback to blocking mode when doing async dio over multiple extents"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore             |   1 +
 src/uring_read_fault.c | 150 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/676      |  41 +++++++++++
 tests/generic/676.out  |   2 +
 4 files changed, 194 insertions(+)
 create mode 100644 src/uring_read_fault.c
 create mode 100755 tests/generic/676
 create mode 100644 tests/generic/676.out

diff --git a/.gitignore b/.gitignore
index ba0c572b..a5309d52 100644
--- a/.gitignore
+++ b/.gitignore
@@ -168,6 +168,7 @@ tags
 /src/truncfile
 /src/unwritten_mmap
 /src/unwritten_sync
+/src/uring_read_fault
 /src/usemem
 /src/writemod
 /src/writev_on_pagefault
diff --git a/src/uring_read_fault.c b/src/uring_read_fault.c
new file mode 100644
index 00000000..9fb86c47
--- /dev/null
+++ b/src/uring_read_fault.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+ */
+
+/*
+ * Create a file with 4 extents, each with a size matching the page size.
+ * Then allocate a buffer to read all extents with io_uring, using O_DIRECT and
+ * IOCB_NOWAIT. Before doing the read with io_uring, access the first page of
+ * the read buffer to fault it in, so that during the read we only trigger page
+ * faults when accessing the other pages (mapping to 2nd, 3rd and 4th extents).
+ */
+
+/* Get the O_DIRECT definition. */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <liburing.h>
+
+int main(int argc, char *argv[])
+{
+	struct io_uring ring;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct iovec iovec;
+	int fd;
+	long pagesize;
+	void *write_buf;
+	void *read_buf;
+	ssize_t ret;
+	int i;
+
+	if (argc != 2) {
+		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
+	if (fd == -1) {
+		fprintf(stderr, "Failed to create file %s: %s (errno %d)\n",
+			argv[1], strerror(errno), errno);
+		return 1;
+	}
+
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	if (pagesize == -1) {
+		fprintf(stderr, "Failed to get page size: %s (errno %d)\n",
+			strerror(errno), errno);
+		return 1;
+	}
+
+	ret = posix_memalign(&write_buf, pagesize, 4 * pagesize);
+	if (ret) {
+		fprintf(stderr, "Failed to allocate write buffer\n");
+		return 1;
+	}
+
+	memset(write_buf, 0xab, pagesize);
+	memset(write_buf + pagesize, 0xcd, pagesize);
+	memset(write_buf + 2 * pagesize, 0xef, pagesize);
+	memset(write_buf + 3 * pagesize, 0x73, pagesize);
+
+	/* Create the 4 extents, each with a size matching page size. */
+	for (i = 0; i < 4; i++) {
+		ret = pwrite(fd, write_buf + i * pagesize, pagesize,
+			     i * pagesize);
+		if (ret != pagesize) {
+			fprintf(stderr,
+				"Write failure, ret = %ld errno %d (%s)\n",
+				ret, errno, strerror(errno));
+			return 1;
+		}
+		ret = fsync(fd);
+		if (ret != 0) {
+			fprintf(stderr, "Fsync failure: %s (errno %d)\n",
+				strerror(errno), errno);
+			return 1;
+		}
+	}
+
+	close(fd);
+	fd = open(argv[1], O_RDONLY | O_DIRECT);
+	if (fd == -1) {
+		fprintf(stderr,
+			"Failed to open file %s: %s (errno %d)",
+			argv[1], strerror(errno), errno);
+		return 1;
+	}
+
+	ret = posix_memalign(&read_buf, pagesize, 4 * pagesize);
+	if (ret) {
+		fprintf(stderr, "Failed to allocate read buffer\n");
+		return 1;
+	}
+
+	/*
+	 * Fault in only the first page of the read buffer.
+	 * We want to trigger a page fault for the 2nd page of the read buffer
+	 * during the read operation with io_uring (O_DIRECT and IOCB_NOWAIT).
+	 */
+	memset(read_buf, 0, 1);
+
+	ret = io_uring_queue_init(1, &ring, 0);
+	if (ret != 0) {
+		fprintf(stderr, "Failed to creating io_uring queue\n");
+		return 1;
+	}
+
+	sqe = io_uring_get_sqe(&ring);
+	if (!sqe) {
+		fprintf(stderr, "Failed to get io_uring sqe\n");
+		return 1;
+	}
+
+	iovec.iov_base = read_buf;
+	iovec.iov_len = 4 * pagesize;
+	io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
+
+	ret = io_uring_submit_and_wait(&ring, 1);
+	if (ret != 1) {
+		fprintf(stderr, "Failed at io_uring_submit_and_wait()\n");
+		return 1;
+	}
+
+	ret = io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		fprintf(stderr, "Failed at io_uring_wait_cqe()\n");
+		return 1;
+	}
+
+	if (cqe->res != (4 * pagesize))
+		fprintf(stderr, "Unexpected cqe->res, got %d expected %ld\n",
+			cqe->res, 4 * pagesize);
+
+	if (memcmp(read_buf, write_buf, 4 * pagesize) != 0)
+		fprintf(stderr,
+			"Unexpected mismatch between read and write buffers\n");
+
+	io_uring_cqe_seen(&ring, cqe);
+	io_uring_queue_exit(&ring);
+
+	return 0;
+}
diff --git a/tests/generic/676 b/tests/generic/676
new file mode 100755
index 00000000..0472c9c2
--- /dev/null
+++ b/tests/generic/676
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 676
+#
+# Test doing a read, with io_uring, over a file range that includes multiple
+# extents. The read operation triggers page faults when accessing all pages of
+# the read buffer except for the pages corresponding to the first extent.
+# Then verify that the operation results in reading all the extents and returns
+# the correct data.
+#
+. ./common/preamble
+_begin_fstest auto quick io_uring
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -f $TEST_DIR/uring_read_fault.tmp
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_odirect
+_require_io_uring
+_require_test_program uring_read_fault
+
+$here/src/uring_read_fault $TEST_DIR/uring_read_fault.tmp
+
+echo "Silence is golden"
+
+status=$?
+exit
diff --git a/tests/generic/676.out b/tests/generic/676.out
new file mode 100644
index 00000000..d305660f
--- /dev/null
+++ b/tests/generic/676.out
@@ -0,0 +1,2 @@
+QA output created by 676
+Silence is golden
-- 
2.33.0

