Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8067A226EAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGTTGB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 15:06:01 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45757 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbgGTTGB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 15:06:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E5B95C01AE;
        Mon, 20 Jul 2020 15:06:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Jul 2020 15:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=9CiNHec0Wkun/
        FlGIJXgJ/90ww716s7zNfWl5nn+b/c=; b=pjYrifwPb8waKNon70/T+boAQPAWk
        G7dp0ErZxRYQz2QEGsJwBnJGpJkyidz4/LhKES82jWPTF+sxULbRc4BXxou9+r4l
        gF3f65e+MpsYcYOB1C95F1GloTUigOuYRD5wsqguP+lh0AjPfZ747tFLh4mDOmKW
        BO4tjomDN99VlP+PuYYfxpfFJCQVVrU2WUdFxn7nN5y1Ujjr8V+93dR7ABIjdd2w
        irwnsxD/HEDoTzw5xTwVIMnJySTuZAusBly+x/puqSfTEpRXC2mICqphUMeoUQ03
        hN/ZtFSwueDgjvBir15Jj4gA13OrbWOphXjn/yVRcIyGHlKbRkGX1K/KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9CiNHec0Wkun/FlGIJXgJ/90ww716s7zNfWl5nn+b/c=; b=SBkqaecq
        MmkZO3txEQYeo0I8609IkBQjHNhUpW3amxafGx2vbURF1yDQJFXEqIxCEi/ziTeH
        Fzb4iIW2LVICQ1XXofvX7l8pARH9qe0Ug/w47qUZzaI8CHhRxWmkHx0+quUTFtTc
        TB+HlSYAPhPXeEYlPCuHuBhX1uy/0aHt29ACmC2jrfVysi0EsQhBPqTCoYsj3YEq
        7xanTXTIM/OfJVdjHpq44HVB4TQEpWfP9K2vO5PhHSPuOdvjn9F4f64PmuLDCNYX
        E8ZmpEJLgt0e1+fmZodZduWif15KtoRuu1dfq3XCzIJo7uRGAzaNl4qgC8DGFH79
        H6TsLOXIYblqXQ==
X-ME-Sender: <xms:F-sVX0N6HmpV3WI80aO90Ct9TG7mY3YcOoxOpS6o46KyYgpywyZebw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:F-sVX69cjKg7V1k0gAV-ZR-1w-3VrojBlImIgCuokV0CPw7D8m2Z5Q>
    <xmx:F-sVX7QIvQlxR0ZBrywR8v336hjegja1Lsp8vDKl_eXOZCsv8JQbzg>
    <xmx:F-sVX8vYIV4LthXvwEmEVezAlD2Lqmx2t3gftdj5Txf8d9AAyeAI5g>
    <xmx:GOsVX2rWt22GwIulOywUUKdMmd1ey2WfbUudQ3SKkmsLFRa4k5MbrA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7CDFC3280059;
        Mon, 20 Jul 2020 15:05:59 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4] generic: add a test for umount racing mount
Date:   Mon, 20 Jul 2020 12:05:56 -0700
Message-Id: <20200720190556.3292884-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200719171853.GE2557159@desktop>
References: <20200719171853.GE2557159@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if dirtying many inodes (which can delay umount) then
unmounting and quickly mounting again causes the mount to fail.

A race, which breaks the test in btrfs, is fixed by the patch:
"btrfs: fix mount failure caused by race with umount"

Signed-off-by: Boris Burkov <boris@bur.io>
---
- dd to XFS_IO_PROG
- 1M writes to 4k writes

 tests/generic/603     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/603.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 56 insertions(+)
 create mode 100755 tests/generic/603
 create mode 100644 tests/generic/603.out

diff --git a/tests/generic/603 b/tests/generic/603
new file mode 100755
index 00000000..90f0d1d3
--- /dev/null
+++ b/tests/generic/603
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook  All Rights Reserved.
+#
+# FS QA Test 603
+#
+# Evicting dirty inodes can take a long time during umount.
+# Check that a new mount racing with such a delayed umount succeeds.
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
+_supported_os Linux
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+for i in $(seq 0 500)
+do
+	$XFS_IO_PROG -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null 2>&1
+done
+_scratch_unmount &
+_scratch_mount
+wait
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/603.out b/tests/generic/603.out
new file mode 100644
index 00000000..6810da89
--- /dev/null
+++ b/tests/generic/603.out
@@ -0,0 +1,2 @@
+QA output created by 603
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31..c0ace35b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -605,3 +605,4 @@
 600 auto quick quota
 601 auto quick quota
 602 auto quick encrypt
+603 auto quick
-- 
2.24.1

