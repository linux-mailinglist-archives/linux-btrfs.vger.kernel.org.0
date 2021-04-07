Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20183575A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbhDGUNo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 16:13:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38727 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349014AbhDGUNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Apr 2021 16:13:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 5B7EB13DA;
        Wed,  7 Apr 2021 16:13:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Apr 2021 16:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=dgSlF3Se2yLQI5q0Esm5yNoWWP
        4S3D7Vjj9HQO0hVTc=; b=CyZcPkaPeK8YhEEtb1mcmJzK44G8PBCvco+14fa+h7
        stUYM6V+Cz9Zv0JItUOptc4reFmUAj/HovOuENIRjyqV8tQhAmyw13jeoROKYxqI
        t0nfuz8LBLrNQn9PwrR+JWqtr+LEqBP2ZRQg9JLMtxD9S1KSOvsBCS46gbjcKub/
        AAzjamLqaXAX0O3sCTuaXhZMCmzNsOKw7clgHVyYpnTvUCH5BCcNvorDuymjpXUh
        jEwX6rEDT5oh/HOrnut2WzF+H5GxK9QxRLQaqpLEH3meuOlv9JqI9RmakgMWVkeR
        P+MDP1wFQhIrdsr2m9RBCR7C2POC6Ywujgl+VAh2j+yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dgSlF3Se2yLQI5q0Esm5yNoWWP4S3D7Vjj9HQO0hVTc=; b=BYp4vbuT
        thF8H3gR08lYO51gHE7N40Il7T1UGtpvZpgvGFAxj4iqP2hDG934Cd3GNr9MOS36
        I+p8g/0bvKK3yFmgNj077kprzh8e8ZpJyxU8u5TqQAYAzGP3GYbY6DZDlllrdKPB
        qa7uqSSStr2aUoFHmtz6kpUdD+bFHMWUEiXi0yK+0bZdI4nUFixoEm/IsOgLMcer
        eF8wcxDIofHhTWLsRlCcRBY8RNWASIz53qbZRkWKfyqS5FkQrVCVecsqTb9yjZ/P
        oHxWV/vgMVJhS88oHMdJ2n4Ks0DSVPL7qDsqk3r7D/MKf+lTixTtuxOg77Lq0V+h
        OrBsx66wOgNiyw==
X-ME-Sender: <xms:aBJuYLXo4zAG6wQabjHthpOdIWgBhr1_uC7yeC34qZ2ZG44av9FKcA>
    <xme:aBJuYDs0ihvRGDxgy0UDHqlXcQmH905I8cZ7ER7frN8OF-ZNnwZz-5jmNtaZIbaqy
    3XfAKCAth8t_uke59I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ffgffgkeekveevgeduffeuvdevtdekvedtledvfeduleelgeevteelkedvhfeikeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdejrdehfedrvdehfedrjeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhs
    segsuhhrrdhioh
X-ME-Proxy: <xmx:aBJuYPVI_KL13oXnqSN3H4hCMaQYxaM_cKK8tj5zv4HR516m3bcweA>
    <xmx:aBJuYOnuASrWUmeIOPeRB5yspEaALrYjKdag3tMdAARphfgvmD_LFw>
    <xmx:aBJuYAYdLlqPgr5vAtzm0NIP-hg6gULWsOvS4TzKJr5Q3RRek3uC1g>
    <xmx:aBJuYIl30NY3Y99CAyvY-uHp7B0ARNs5xdvKFLtTiKEY2nxQcQ6-WA>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1755924005A;
        Wed,  7 Apr 2021 16:13:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
Subject: [PATCH v3] generic: test fiemap offsets and < 512 byte ranges
Date:   Wed,  7 Apr 2021 13:13:26 -0700
Message-Id: <c2f49fdead29fd7eb979b83028eb9fcf56d2457c.1617826068.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407161046.GY1670408@magnolia>
References: <20210407161046.GY1670408@magnolia>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs trims fiemap extents to the inputted offset, which leads to
inconsistent results for most inputs, and downright bizarre outputs like
[7..6] when the trimmed extent is at the end of an extent and shorter
than 512 bytes.

The test writes out one extent of the file system's block size and tries
fiemaps at various offsets. It expects that all the fiemaps return the
full single extent.

I ran it under the following fs, block size combinations:
ext2: 1024, 2048, 4096
ext3: 1024, 2048, 4096
ext4: 1024, 2048, 4096
xfs: 512, 1024, 2048, 4096
f2fs: 4096
btrfs: 4096

This test is fixed for btrfs by:
btrfs: return whole extents in fiemap
(https://lore.kernel.org/linux-btrfs/274e5bcebdb05a8969fc300b4802f33da2fbf218.1617746680.git.boris@bur.io/)

Signed-off-by: Boris Burkov <boris@bur.io>
---
v3: make the block size more generic, use test dev instead of scratch,
cleanup style issues.
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
index 00000000..a5ef369a
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
+	rm -f $fiemap_file
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
+_require_xfs_io_command "fiemap"
+
+rm -f $seqres.full
+
+fiemap_file=$TEST_DIR/foo.$$
+
+do_fiemap() {
+	off=$1
+	len=$2
+	echo $off $len >> $seqres.full
+	$XFS_IO_PROG -c "fiemap $off $len" $fiemap_file | tee -a $seqres.full
+}
+
+check_fiemap() {
+	off=$1
+	len=$2
+	actual=$(do_fiemap $off $len)
+	[ "$actual" == "$expected" ] || _fail "unexpected fiemap on $off $len"
+}
+
+# write a file with one extent
+block_size=$(_get_block_size $TEST_DIR)
+$XFS_IO_PROG -f -s -c "pwrite -S 0xcf 0 $block_size" $fiemap_file >/dev/null
+
+# since the exact extent location is unpredictable especially when
+# varying file systems, just test that they are all equal, which is
+# what we really expect.
+expected=$(do_fiemap)
+
+mid=$((block_size / 2))
+almost=$((block_size - 5))
+past=$((block_size + 1))
+
+check_fiemap 0 $mid
+check_fiemap 0 $block_size
+check_fiemap 0 $past
+check_fiemap $mid $almost
+check_fiemap $mid $block_size
+check_fiemap $mid $past
+check_fiemap $almost 5
+check_fiemap $almost 6
+
+# fiemap output explicitly deals in 512 byte increments,
+# so exercise some cases where len is 512.
+# Naturally, some of these can't work if block size is 512.
+one_short=$((block_size - 512))
+check_fiemap 0 512
+check_fiemap $one_short 512
+check_fiemap $almost 512
+
+_test_unmount
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

