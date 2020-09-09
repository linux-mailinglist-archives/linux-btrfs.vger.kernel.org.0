Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33583262FDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIIMgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbgIIMdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 08:33:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730FDC061796
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 05:25:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so2182703qka.5
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfJxjDAGjdSzKmvRj2MKkPQ7AT5kXs2pJZmkfjikZ8A=;
        b=DxO7U4/y2fB3CZDJG2zXeLV6KEB5M8+yOydL7lx0XY4okJeVejCHCpo+JGcDcTHFl8
         3ryj5L0qlXRAq8RWo7Tzdhi/fcu70m+SS08vWO6dlrnKtBz1h/EroTHczxn6PMxmHjiL
         KM5WY5oZCVmzhtQ/4tKmlx7lyMkLDpVm2hXvX3z0MSREAA1yyNzHPjVpdQlaD45vEyGW
         ojVfYocJIeaTYUCtMbb1kizdWgshKIMG3x+Bc0zLq3ti1S3FghujO7HmWKGW1OnkOf9l
         xo9EYuVRw7YoR0nNc3IzHxA/vIKI1iHju1gIFpcjRFDOVbQLHTIa3CMODPjByAaJmXiF
         BiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfJxjDAGjdSzKmvRj2MKkPQ7AT5kXs2pJZmkfjikZ8A=;
        b=PIVjnleCLnKqo29lHJlfF8Pli5TyQbrddVuugwC8Luhr4cXUkekvvJWy9qiNTN6Y+W
         SDRj0GQpit/HV+dSwb+lXXMk1tTOqc/6pVLGwya2g3HThLFojblWNAssy050B6eqJgnY
         oW88LgJDQy4qptWreUXYXItZJz+FpiBQljQ9S2Tj44YuFraI1P6jcUbPonApjwYwkAOw
         MbAlfx/5EkoEJJR/pDWxfULJorYF5sQWxZyxzUsxueHqe0a3F60ilGwl6Br1huOgSI/r
         Cx28D7Hbz+jL8cCrq5Ok4ygqs0R3HDatezSA7Q79FoEZ8uBvRtYFuJH7GhAiC1Z3g7lt
         OM/w==
X-Gm-Message-State: AOAM531kkOMwhxwmu3rLMqNRi1vXe1wDfs6yhGH35cogU0AQgEZ3NmXo
        be3xL7iCh784772z8NkG164LhNYYkp2VmE4B
X-Google-Smtp-Source: ABdhPJx3lWYI+Mtm0gdHReTZ28XRS8IqpE2iMZU5g7R+OvhGuA/MsGfvWCZkoOe5V/3Fa4sBouYKIw==
X-Received: by 2002:a37:2713:: with SMTP id n19mr3008358qkn.497.1599654353728;
        Wed, 09 Sep 2020 05:25:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 206sm2235341qkk.27.2020.09.09.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 05:25:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH][v2] fstests: btrfs/219 add a test to test -o rescue=all
Date:   Wed,  9 Sep 2020 08:25:51 -0400
Message-Id: <36b3a0eafee6f43d489bf8fcfe5a1ac13a9f896a.1599654294.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new mount option makes sure we can still mount the file system if
any of the core roots are corrupted.  This test corrupts each of these
roots and validates that it can still mount the fs and read the file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Sent the actual intended patch this time.

 tests/btrfs/219     | 99 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out | 30 ++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 130 insertions(+)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 00000000..c6abc111
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,99 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 219
+#
+# A test to exercise the various failure scenarios for -o rescue=all.  This is
+# mainly a regression test for
+#
+#   btrfs: introduce rescue=all
+#
+# We simply corrupt a bunch of core roots and validate that it works the way we
+# expect it to.
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
+_generate_fs()
+{
+	# We need single so we don't just read the duplicates
+	_scratch_mkfs -m single -d single > $seqres.full 2>&1
+	_scratch_mount
+	$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo | \
+		_filter_xfs_io
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	_scratch_unmount
+}
+
+_clear_root()
+{
+	# Grab the bytenr for the root by dumping the tree roots, clearing up to
+	# the key so our first column is the bytenr.  With a normal device with
+	# single should mean that physical == logical
+	local bytenr=$($BTRFS_UTIL_PROG inspect-internal dump-tree -r \
+		$SCRATCH_DEV | grep "$1" | sed 's/.*) //g'| \
+		awk '{ print $1 }')
+	dd if=/dev/zero of=$SCRATCH_DEV bs=1 seek=$bytenr count=4096 | \
+		_filter_dd
+}
+
+_test_failure()
+{
+	_try_scratch_mount $* > /dev/null 2>&1
+	[ $? -eq 0 ] && _fail "We should have failed to mount"
+}
+
+_test_success()
+{
+	_generate_fs
+	_clear_root "$1"
+	_test_failure
+	_scratch_mount -o rescue=all,ro
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	_scratch_unmount
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_mountopt "rescue=all,ro"
+
+# Test with the roots that should definitely pass
+_test_success "extent tree"
+_test_success "checksum tree"
+_test_success "uuid tree"
+_test_success "data reloc"
+
+# Now test the roots that will definitely fail
+_generate_fs
+_clear_root "fs tree"
+_test_failure -o rescue=all,ro
+
+# We have to re-mkfs the fs because otherwise the post-test fsck will blow up
+_scratch_mkfs > /dev/null 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 00000000..9a6d43c4
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,30 @@
+QA output created by 219
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+4096+0 records in
+4096+0 records out
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+4096+0 records in
+4096+0 records out
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+4096+0 records in
+4096+0 records out
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+4096+0 records in
+4096+0 records out
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
+4096+0 records in
+4096+0 records out
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d..f4dbfafb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -221,3 +221,4 @@
 216 auto quick seed
 217 auto quick trim dangerous
 218 auto quick volume
+219 auto quick
-- 
2.26.2

