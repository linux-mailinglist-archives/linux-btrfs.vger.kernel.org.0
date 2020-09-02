Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0126E25AE3A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBPAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgIBPAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:00:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D49C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 08:00:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv8so2326139qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGAeuA8lGcUc4Weh6RzBvKVGlB3/l6ZXN5HWfTSGw1s=;
        b=07A/9RTp76H0uiKie/hDb02SDxnNwVPK4izddURlqVwwk2d6/5g8IEsXUtsg2C9L7u
         POoiALW+HVkC4v9uVMwl3kCKDUJnqGmM3wl2JwnYWhc9YPbLD9uhHlZ8AZxtnBq7O3X3
         zXsSkZ3mNvZfJfxyLeGEo8ZYF8dDvqAX52VpL/KM3u31mNn6B/zmo1OqvaGaB+D9Ch0X
         YnunUbDH7NTCoIjy9XqgpX6Y8qBwTvbA2scDhs7JTzqSxJ71Z44CEvWLSeXc1iFjcKP5
         24sulcuzeAux3K4nZyvhgdosJoo0134SfWnmyFkiPnzSq4RedFtm0MhiKaccOc6gVjHE
         cyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGAeuA8lGcUc4Weh6RzBvKVGlB3/l6ZXN5HWfTSGw1s=;
        b=ANbiKXBoH9J9NKYMl9rU1AmtLzWDE587bIjv8tjR0p9x5GrRaGVm2F7u675r45ZgfD
         gpNPvpmr1YXwK+EHViRDy+2HozGxTSBSylVurH/gOD69Z/KNfnEzEKHLVEHIiD+qezj/
         FABD2mNNys2IEzNg3NmVwEgLkm9lrjK9Or/EWPJ7ICin5fpr4KOJtSggusMGTSc9kisJ
         tSNjAk1H4N3qLV7XPwhCmLA84u6xFOtI1SCtQ/ZyVHWDu6vfthVxD0dN6nVvVEfv0kU8
         ViA69Ns38SvgpjY/8iDgrGiYES4mjJLEqph/IVxSK879QtpLlOGZKJxsRbhfjjDfTGUw
         0UMQ==
X-Gm-Message-State: AOAM530ovHfeEL9b6ExVYtwlbyMlKb8nX1WXyZ/ud6daKVGwzfOE0reL
        CzJFugzw/4Na5/5sb9lbiy0usksjqNqMVHVuKOA=
X-Google-Smtp-Source: ABdhPJxXCKRiAw2SU2FB4rChTy4Upbcv67Ja3AyqkNABJfp0MAnxfVvHfJM/Ya2STH0TW1/b21n0RQ==
X-Received: by 2002:a05:6214:a61:: with SMTP id ef1mr7311770qvb.115.1599058847124;
        Wed, 02 Sep 2020 08:00:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 64sm5109832qko.117.2020.09.02.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:00:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Date:   Wed,  2 Sep 2020 11:00:45 -0400
Message-Id: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We had a problem recently where btrfs would deadlock with
O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
iomap.  This was only caught by chance with aiostress, because weirdly
we don't actually test this particular configuration anywhere in
xfstests.  Fix this by adding a basic test that just does
O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
with Btrfs, which would have been helpful in finding this issue before
the patches were merged.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .gitignore                      |  1 +
 src/aio-dio-regress/dio-dsync.c | 61 +++++++++++++++++++++++++++++++++
 tests/generic/609               | 44 ++++++++++++++++++++++++
 tests/generic/group             |  1 +
 4 files changed, 107 insertions(+)
 create mode 100644 src/aio-dio-regress/dio-dsync.c
 create mode 100755 tests/generic/609

diff --git a/.gitignore b/.gitignore
index 5f5c4a0f..07c8014b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -175,6 +175,7 @@
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
+/src/aio-dio-regress/dio-dsync
 /src/log-writes/replay-log
 /src/perf/*.pyc
 
diff --git a/src/aio-dio-regress/dio-dsync.c b/src/aio-dio-regress/dio-dsync.c
new file mode 100644
index 00000000..53cda9ac
--- /dev/null
+++ b/src/aio-dio-regress/dio-dsync.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-newer
+/*
+ * Copyright (c) 2020 Facebook.
+ * All Rights Reserved.
+ *
+ * Do some O_DIRECT writes with O_DSYNC to exercise this path.
+ */
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+
+int main(int argc, char **argv)
+{
+	struct stat st;
+	char *buf;
+	ssize_t ret;
+	int fd, i;
+	int bufsize;
+
+	if (argc != 2) {
+		printf("Usage: %s filename\n", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_DIRECT | O_RDWR | O_TRUNC | O_CREAT | O_DSYNC,
+		  0644);
+	if (fd < 0) {
+		perror(argv[1]);
+		return 1;
+	}
+
+	if (fstat(fd, &st)) {
+		perror(argv[1]);
+		return 1;
+	}
+	bufsize = st.st_blksize * 10;
+
+	ret = posix_memalign((void **)&buf, st.st_blksize, bufsize);
+	if (ret) {
+		errno = ret;
+		perror("allocating buffer");
+		return 1;
+	}
+
+	memset(buf, 'a', bufsize);
+	for (i = 0; i < 10; i++) {
+		ret = write(fd, buf, bufsize);
+		if (ret < 0) {
+			perror("writing");
+			return 1;
+		}
+	}
+	free(buf);
+	close(fd);
+	return 0;
+}
diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..8a888eb9
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,44 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
+#
+# FS QA Test 609
+#
+# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic test to
+# exercise O_DSYNC so any unsuspecting file systems will get lockdep warnings if
+# they're locking isn't compatible.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -rf $TEST_DIR/file
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_aiodio dio-dsync
+
+$AIO_TEST $TEST_DIR/file
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..ae2567a0 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick
-- 
2.26.2

