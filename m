Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FB151C66
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 15:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBDOiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 09:38:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44928 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgBDOiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 09:38:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so18052152qkb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UCMkonT7Vd3ETCvM77HXTXnAy5YoDZ075AHY2GGCbU=;
        b=MPm4HEgDDG0lDuhSudsLPDRPxDLcN7nKPwrRcYAJP2NwgwgOeeac+7GQXWYUUS7q+t
         /alLIqxnVfl3xNL7HFY0wEbA9a/Kjppfr6BeGn7SXXkh8J01/LFd7xQ1xT5p5RmLxAnV
         1HaEbpLPf5Ouz2zi/UVMcO10GOgNA6FLe0941fvUkF6otQDe2klgUsgTPpFG2Pgn3cq3
         cIeHfBSymOIqPIdQVMpPuwWv6pa6n7cso6mR40xyrsBmGKqMPGnKphREdm8huBFH6M72
         mEBmFTYUZWiVmRT2pt1gI9A5/lNmc2GwBVuKrV4uriyHKLwHcnRrkEzxZKnIiejyYu8l
         lt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UCMkonT7Vd3ETCvM77HXTXnAy5YoDZ075AHY2GGCbU=;
        b=jBPc548P6LOnqMBnDAAd2F7PznfguspPNkS65ddqwG0ytAAk6caPjzmbpbJZ+iJOQe
         W/eCdbA4HdBe2uVygk2kBks8WhS0hwpbth5+r+2jGBInCDZewBq0NImUigsDI+G1kSpZ
         2AlbpASleUmG/LdU3bT1B11u7eEZV9yPp9zcG7NULBrZAl9emMulyXIApQ+axT1YYJ7m
         Sl1IZ6AmZDcAZScIZtliOgA78DgkP5bVRLIbH180KbiTeZydMwHmGTNcpt68lXJB8U9h
         F+B8i4CGiP2xUguLGBBeV5q5r2AO0UB8LArZif4EsI9f4bjBIA2pWL4UH2JHpsrWEtho
         Cakw==
X-Gm-Message-State: APjAAAU2fBWRx3CgAdx7i78m+5o2AtBWiWO0NgyhwSun5XUCh57CWoCc
        j7mzeM75m4fjX6Lw+kFazYgKBQ==
X-Google-Smtp-Source: APXvYqz2DyiiExpJC9uJtKJmaw3bS0mMcWpIywZgRrj/7pkXYxbHZqtrwMfTnR8oD/nfch/AMTBexA==
X-Received: by 2002:a05:620a:999:: with SMTP id x25mr28222350qkx.87.1580827081125;
        Tue, 04 Feb 2020 06:38:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 184sm11027091qkl.81.2020.02.04.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:38:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH][v2] xfstest: add a test for the btrfs file extent gap issue
Date:   Tue,  4 Feb 2020 09:37:59 -0500
Message-Id: <20200204143759.697376-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a test to validate that we're not adjusting up i_size before we
have the appropriate file extents on disk.  We had a problem where
i_size would be adjusted up without a contiguous range of file extents,
which isn't ok without a special option enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- adjusted the commit interval time to make the test shorter
- adjusted the write range so we didn't get tripped up by btrfs's delalloc
  behavior
- integrated all of Filipe's suggestions

 tests/btrfs/172     | 76 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  3 ++
 tests/btrfs/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/btrfs/172
 create mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
new file mode 100755
index 00000000..cae5f623
--- /dev/null
+++ b/tests/btrfs/172
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 172
+#
+# Validate that without no-holes we do not get an i_size that is after a gap in
+# the file extents on disk.  This is fixed by the following patches
+#
+#     btrfs: use the file extent tree infrastructure
+#     btrfs: replace all uses of btrfs_ordered_update_i_size
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_log_writes
+_require_xfs_io_command "sync_range"
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
+
+# There's not a straightforward way to commit the transaction without also
+# flushing dirty pages, so shorten the commit interval to 1 so we're sure to get
+# a commit with our broken file
+_log_writes_mount -o commit=1
+
+$XFS_IO_PROG -f -c "pwrite 0 5m" $SCRATCH_MNT/file | _filter_xfs_io
+$XFS_IO_PROG -f -c "sync_range -abw 4m 1m" $SCRATCH_MNT/file | _filter_xfs_io
+
+# Now wait for a transaction commit to happen, wait 2x just to be super sure
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
diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
new file mode 100644
index 00000000..45051739
--- /dev/null
+++ b/tests/btrfs/172.out
@@ -0,0 +1,3 @@
+QA output created by 172
+wrote 5242880/5242880 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 4b64bf8b..53cb3451 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,6 +174,7 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
+172 auto quick log replay
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap volume
-- 
2.24.1

