Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB99355F1D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 00:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhDFWyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 18:54:45 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38885 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232452AbhDFWyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 18:54:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 25DDA12A7;
        Tue,  6 Apr 2021 18:54:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Apr 2021 18:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=NFz6EKopRKTB1f3i19S6aRXcWo
        d1iIZOhWJTcdjzUII=; b=TFOAnPh0y7n8MzRr6H20L4uscosb0Jbk3nBCXx7vOd
        tGHQ9aVo4Qpr6gdd3prnXwCUgBV1MugRTQiHH7uE9tPjk8CBcCga5lXmNPc5FfVe
        /MzrHJiWzDHudl2BL/HbVn8JgRIcCuECBQ5COYtyFYCypR2aR7NQNNUelsW/qFrP
        auo9Ldc6DVy7acUbbJlspo1zIOH5OOaO89MbsTlZO7owUS8OyRfMTqLhhK6kXWZL
        4w8hDYxI+H2wfsCqKioq3EBsYpsV5eUq4EzMgHY+cyG+jJSJ8SyNBKOiptioSuRI
        WyqDX7V0GtjrVnXJf8l+9Cu9/5qIVLTQsS10XNh7mx1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NFz6EKopRKTB1f3i19S6aRXcWod1iIZOhWJTcdjzUII=; b=J7nigOMT
        UviPSoi0BrTknoPiezuDyuaBTbtPCwlTkBA1xSEjhD1uVl2cHk767VOeDKrHzHjK
        TfzmCRHxxfYklnNfvqHK8qAjrr/dc8F3EEQfBoRZG4kDhUJt8Y90hi/R/vnYbQVg
        DFnTX1iuAJ1j+0btHYpemTHRQC8AQ0UkgAMPwz1suKXyqHOFJVua7Iq2dGgyg0qn
        NUr5oDZ/+D3wWwfPrBo1p5EPeZlIJM37cknFRXzG6od6wNchP+grEkiqUoLuGB+s
        388VAiWGxyc2rqkLRBlNe4ewWOhKGHEMnaJ8ke/p9wA9dwimxfvK6WU8b4aboT2r
        SU75KKwzuu4wNA==
X-ME-Sender: <xms:p-ZsYCSlDmDVxq9t-dI4wQ5m8bjctnCsm4K1QYuwB5Pl2bRxgJ7y5g>
    <xme:p-ZsYHzEwMtnfgvxabbDzmH6Iy_3An_aQPBcT28hiXFhtEAgdOOtmnZLe6Zdl-RiN
    XDXD4MoE4WWctbdq4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeffgffgkeekveevgeduffeuvdevtdekvedtledvfe
    duleelgeevteelkedvhfeikeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhp
    pedvtdejrdehfedrvdehfedrjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:p-ZsYP1oS5PBiSai0vO9oO9NwKNxBT3-53rV2oby0tJNshNaNou02A>
    <xmx:p-ZsYOBtjut8i0s-4bCGC2ZAxUSdVe9MqixwyjTpoCCTeO368KHeHA>
    <xmx:p-ZsYLjMHwnK_R40tYoHLITWZ6W6j3YzdNiBzajjck8BDTot5ugZQQ>
    <xmx:p-ZsYLLIy0rlmBohqxcet4akwLMXA1EnS-LaN8M4W85hm3D5m3je2Q>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58D0B108005F;
        Tue,  6 Apr 2021 18:54:31 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] generic: test fiemap offsets and < 512 byte ranges
Date:   Tue,  6 Apr 2021 15:54:29 -0700
Message-Id: <189e96b6dfccc54ec44879456488977c95b3efda.1617749523.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4098b7c2a597f2f6d624ce1b3f2741a381c588b7.1617749158.git.boris@bur.io>
References: <4098b7c2a597f2f6d624ce1b3f2741a381c588b7.1617749158.git.boris@bur.io>
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

--
v2: fill out copyright and test description

---
 tests/generic/623     | 94 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/623.out |  2 +
 tests/generic/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/generic/623
 create mode 100644 tests/generic/623.out

diff --git a/tests/generic/623 b/tests/generic/623
new file mode 100755
index 00000000..85ef68f6
--- /dev/null
+++ b/tests/generic/623
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Facebook.  All Rights Reserved.
+#
+# FS QA Test 623
+#
+# Test fiemaps with offsets into small parts of extents.
+# Expect to get the whole extent, anyway.
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

