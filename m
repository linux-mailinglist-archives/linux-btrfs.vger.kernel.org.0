Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A96355EF1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 00:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbhDFWrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 18:47:42 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46379 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244004AbhDFWrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 18:47:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 661F210E3;
        Tue,  6 Apr 2021 18:47:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Apr 2021 18:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=koOpnUI4zoASW6tmircG99CZu6
        PhNp7RuzkNLmJubaY=; b=tSnwfnFAKyZl9wFaT9oM5DWNSTn57E9vPlrGc6A96C
        aDb+oMOw6SxcmrELreVhnloDs+b79zEQHgw/7EkGNk2zvMuEYm02hx26F/YE5CoC
        S1DPiaKAri2ENFCNsWKBextVRrUnoEGphM5J/r7xAs/o7i3AunLMWBO/2PmVCM/j
        SdxL3dJbd+jcsIqv3VK/8JM6s8W5KoT5tJoJ/L0rAMpGi0RB3uDm9MJvc8SjYdUf
        n5jundL9z8JRK1cOreje7kh7JKwFsUEpr/sYpCIHTTcH7N7PL1otdk832bnXyz2W
        L6uMztDlKdAeFjCYqhrzLNi3MgMTooXJVf8FWKrvYn7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=koOpnUI4zoASW6tmi
        rcG99CZu6PhNp7RuzkNLmJubaY=; b=VUHNXAdDTDkiW4XwZ/Y8JQ2up99XXhg7G
        3klX26LSKaM5eVp0mNL+OxWYnMpx8l9RWbkhGEuFsksuHuFqvVZGC1yJe4dvtzCA
        5mjhsaz9/reK5idDcB7kFRdkXf/st7z7yHDF99aEh/1BhCRgQuT25HD5WL9bAqgU
        uv4jVPLqWXZMfIuJy7Y1yoWSfMCXw83hN7DX7t15t3gHp4LJSlS0FK2cJNG6aSzH
        fpGaguwUKS95/fov3j1roJKQmvyQGPZredfkEywCr/tfjSBCUq9t/VbKtwvRwGr8
        yKL11EF+Pd0+h2j0j2tznwCsSDEPRdBXYAyGioPaMnWkIhuhMnnUA==
X-ME-Sender: <xms:BOVsYA666009W0mObxkBcImjFvj1jI_azzb4__LszaWLuJ3WSB4JfQ>
    <xme:BOVsYB7oZOfRfrWjHZsp7xl0_bYocz0n1iJWk_5ajtGGnOOpO4vQGAckqN3erLcY5
    cuDqKwlu1Np3yEq4jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejiedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeeiledtfffhhfdvtdefgedvieetleeijeejiedthfefge
    ekheevheekjeelkeegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedv
    tdejrdehfedrvdehfedrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:BOVsYPcgiiXlTJ0Lv3ApAM59Z1WM9H0u1Z5lgnvzOZgO_bHv3Czhrg>
    <xmx:BOVsYFJfBfCv23kE4Rz83H9X3JNP0NMoy5GV3grf57mx2NPthE5IhA>
    <xmx:BOVsYEIGyT1bgZPEzqRGHtXjwYAj6TY3pkWGVzTUi1h9wOd_aDBT5A>
    <xmx:BeVsYOzFR_bN7e1g23wVDcs9TcS6N4IqFBUtcYjAXscnoDNMQI_ClQ>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97AC3240065;
        Tue,  6 Apr 2021 18:47:32 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] generic: test fiemap offsets and < 512 byte ranges
Date:   Tue,  6 Apr 2021 15:47:31 -0700
Message-Id: <4098b7c2a597f2f6d624ce1b3f2741a381c588b7.1617749158.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs trims fiemap extents to the inputted offset, which leads to
inconsistent results for most inputs, and downright bizarre outputs like
[7..6] when the trimmed extent is at the end of an extent and shorter
than 512 bytes.

This test covers a bunch of cases like that and ensures that file
systems always return the full extent without trimming it.

I also ran it under ext2, ext3, ext4, f2fs, and xfs successfully, but I
suppose it's no guarantee that every file system will store a 4k synced
write in a single extent. For that reason, this might be a bit fragile.

This test is fixed for btrfs by:
btrfs: return whole extents in fiemap
(https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/generic/623     | 93 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/623.out |  2 +
 tests/generic/group   |  1 +
 3 files changed, 96 insertions(+)
 create mode 100755 tests/generic/623
 create mode 100644 tests/generic/623.out

diff --git a/tests/generic/623 b/tests/generic/623
new file mode 100755
index 00000000..d399c9f0
--- /dev/null
+++ b/tests/generic/623
@@ -0,0 +1,93 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 623
+#
+# what am I here for?
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_test
+_require_scratch
+_require_xfs_io_command "fiemap"
+
+rm -f $seqres.full
+
+_do_fiemap() {
+	off=$1
+	len=$2
+	$XFS_IO_PROG -c "fiemap $off $len" $SCRATCH_MNT/foo
+}
+
+_check_fiemap() {
+	off=$1
+	len=$2
+	actual=$(_do_fiemap $off $len | tee -a $seqres.full)
+	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
+}
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# write a file with one extent
+$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 4K" $SCRATCH_MNT/foo >/dev/null
+
+# since the exact extent location is unpredictable especially when
+# varying file systems, just test that they are all equal, which is
+# what we really expect.
+expected=$(_do_fiemap)
+
+# start to mid-extent
+_check_fiemap 0 2048
+# start to end
+_check_fiemap 0 4096
+# start to past-end
+_check_fiemap 0 4097
+# mid-extent to mid-extent
+_check_fiemap 1024 2048
+# mid-extent to end
+_check_fiemap 2048 4096
+# mid-extent to past-end
+_check_fiemap 2048 4097
+
+# to end; len < 512
+_check_fiemap 4091 5
+# to end; len == 512
+_check_fiemap 3584 512
+# past end; len < 512
+_check_fiemap 4091 500
+# past end; len == 512
+_check_fiemap 4091 512
+
+_scratch_unmount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/623.out b/tests/generic/623.out
new file mode 100644
index 00000000..6f774f19
--- /dev/null
+++ b/tests/generic/623.out
@@ -0,0 +1,2 @@
+QA output created by 623
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index b10fdea4..39e02383 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -625,3 +625,4 @@
 620 auto mount quick
 621 auto quick encrypt
 622 auto shutdown metadata atime
+623 auto quick
-- 
2.30.2

