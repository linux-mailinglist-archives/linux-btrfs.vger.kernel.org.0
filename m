Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8D165FD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBTOi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 09:38:59 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34807 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBTOi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 09:38:58 -0500
Received: by mail-qt1-f193.google.com with SMTP id l16so3015925qtq.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zeIdljRcyO+Pp7sjG8+tc44S5ZrtukhgpPowXc4pdhI=;
        b=T7YwBLXVQulyQS+kf24HW5UiSlVQQhYzo5Xrh1NZ4GI7Mxuzv1vfbWd7ROW968S6vy
         GVT/R8sts9CZ3WG/ONHuSJAzzcfBlmSK00Ci43/N+Q+joocmCHLNgviFYz5rAdxTXhnO
         XGyTXxoOp37dCBmM+c5iBRxr81LeE9KEHgiy/ZlJeHau2rKhxcBr7ErZ7quuyF71CV4l
         KIADH3tAg1rGug3W/JlnS802dI6PgwhfkQwgO1uCEGc8g0zAvUNZq9nCKNEpTPUMu9Oo
         mhj5ZgPSxJpGbVekwDmI9kbyJN1tu7IlazR6nBdlHAmz0w+gdkvXjvfjdkaj9ACOeeUI
         5U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zeIdljRcyO+Pp7sjG8+tc44S5ZrtukhgpPowXc4pdhI=;
        b=gEmjph5p/G7c/kXJP5j6QUosHu7ZK/jMPoJeMolS7d7hGuUvSpX89J+q8n2WEVgn5x
         D9QHowKWE2y8KRHmfu8G50i6DFsMa4rclzjY/99qWkzLIM4OzByPIq/WLJm7NFLLIU5n
         Py4W5e8ojw0EKJi+nwEEjEgPYi0zalbi6QY/K12drUZOJGK9O8VUrWCbuTNmy+6SyqeN
         ZZQmqlA3zHg3CNNcoiL7SRDcTnwQCSELfQ18NPur2QtNOiRQyjpjKiPM9wIOfsMlsXuc
         Q2nZ9OKS7SpUYo4ElDKc8aaM8S9reEiTvAJ+zBsy+0+0ob33CP3lrAxnYOghcOqNTa57
         YKFA==
X-Gm-Message-State: APjAAAVCTiLcnKOaAKzLm2xQl0JTidX++ediZCi4iqedZLpwGGEYYl5/
        +pxLiU0m5xQbHHOT0Acu0CM8RbcyxTQ=
X-Google-Smtp-Source: APXvYqzT5Z0dY6cia6yOUJQ7qHcbDI6kuCwN2KtkvDuZd0GSeTCegPI13CnF9yjhGp/6nsE/W489Cg==
X-Received: by 2002:aed:3e6d:: with SMTP id m42mr7411730qtf.187.1582209537187;
        Thu, 20 Feb 2020 06:38:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y26sm1909303qtc.94.2020.02.20.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:38:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: add a another gap extent testcase for btrfs
Date:   Thu, 20 Feb 2020 09:38:55 -0500
Message-Id: <20200220143855.3883650-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a testcase for a corner that I missed when trying to fix gap
extents for btrfs.  We would end up with gaps if we hole punched past
isize and then extended past the gap in a specific way.  This is a
simple reproducer to show the problem, and has been properly fixed by my
patches now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/204     | 85 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/204.out |  5 +++
 tests/btrfs/group   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100755 tests/btrfs/204
 create mode 100644 tests/btrfs/204.out

diff --git a/tests/btrfs/204 b/tests/btrfs/204
new file mode 100755
index 00000000..0d5c4bed
--- /dev/null
+++ b/tests/btrfs/204
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 204
+#
+# Validate that without no-holes we do not get a i_size that is after a gap in
+# the file extents on disk when punching a hole past i_size.  This is fixed by
+# the following patches
+#
+#	btrfs: use the file extent tree infrastructure
+#	btrfs: replace all uses of btrfs_ordered_update_i_size
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
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmlogwrites
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_log_writes
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
+
+# There's not a straightforward way to commit the transaction without also
+# flushing dirty pages, so shorten the commit interval to 1 so we're sure to get
+# a commit with our broken file
+_log_writes_mount -o commit=1
+
+# This creates a gap extent because fpunch doesn't insert hole extents past
+# i_size
+xfs_io -f -c "falloc -k 4k 8k" $SCRATCH_MNT/file
+xfs_io -f -c "fpunch 4k 4k" $SCRATCH_MNT/file
+
+# The pwrite extends the i_size to cover the gap extent, and then the truncate
+# sets the disk_i_size to 12k because it assumes everything was a-ok.
+xfs_io -f -c "pwrite 0 4k" $SCRATCH_MNT/file | _filter_xfs_io
+xfs_io -f -c "pwrite 0 8k" $SCRATCH_MNT/file | _filter_xfs_io
+xfs_io -f -c "truncate 12k" $SCRATCH_MNT/file
+
+# Wait for a transaction commit
+sleep 2
+
+_log_writes_unmount
+_log_writes_remove
+
+cur=$(_log_writes_find_next_fua 0)
+echo "cur=$cur" >> $seqres.full
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
+
+	# We only care about the fs consistency, so just run fsck, we don't have
+	# to mount the fs to validate it
+	_check_scratch_fs
+
+	cur=$(_log_writes_find_next_fua $(($cur + 1)))
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/204.out b/tests/btrfs/204.out
new file mode 100644
index 00000000..44c7c8ae
--- /dev/null
+++ b/tests/btrfs/204.out
@@ -0,0 +1,5 @@
+QA output created by 204
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8192/8192 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6acc6426..7a840177 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -206,3 +206,4 @@
 201 auto quick punch log
 202 auto quick subvol snapshot
 203 auto quick send clone
+204 auto quick log replay
-- 
2.24.1

