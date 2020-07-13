Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D333721E19F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGMUqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 16:46:44 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45055 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgGMUqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 16:46:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 461152D4;
        Mon, 13 Jul 2020 16:46:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 Jul 2020 16:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=EOmoiXZKCAQPL
        seT9dr+0WPHIkyyqJ2JROTopggfEBg=; b=HjFMH0VRuFlwVClsAOjhAiIOy9zvz
        QooSE87KeIL2T/0f6d8L6G4P1rEp9LFhDLIVyEYJXfJYOlZXehetrOX/IH+w6QJr
        cdBX0LACspPZTEXBVFlC9I8X5HxyVR2VyZ9nNnPlmP3vbwdxD3WlnciNldufKfKJ
        GkP+MmYej5XyFIaubL8nHCn4MPe2a/GjBzRIpnHDomQbT3MZF8LvvVYKgarlvBTO
        ZUERgxXE/DSqGKZw4KkJc+WB+8rG8fVqhBHvMaCxbsZSr/EwNHhAQ9xYz1PZrWVe
        KiQePtBelBqmZrFMa5lC4DX0rs0R2neK1t6bbxd14Kg/yVnfQHcrSXqlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EOmoiXZKCAQPLseT9dr+0WPHIkyyqJ2JROTopggfEBg=; b=WMlvXkbf
        aJwukRd2VFHgJy3hj+k/ZnCqbaLaJeW10H87wA0bnvH/iIacldsjrv65tZenhpKc
        bw2Na8iXGt9rmQ58LKnT/S7JT07Ct+GgbD1fSSrxnoLMw/r0RINt30mvIQHXOsOe
        gfMgMGXJ4YRRZOoLpXViFL7jAj7z1a9yo0wnUG81qW4NCaDCzoUIr4wS++g06+jj
        evGuzL4bwxtKInzOsulWkp9V36b0Bu+Q5Z2Un0LQ9ghJnWGuCiLkPsThh4EJHszl
        hoD2GUYlGd855PT47WmhymL1kbrQ9MlKmVzYFEGGPy7aQaCvDyhEG9OSwDdGUSuG
        P3jYG0OLXkZUgA==
X-ME-Sender: <xms:MsgMX-QIhzv_NMfjBq2eRAWfyFMrVm5dOS-dDfKM_ArU80PjuPGx9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MsgMXzy9ody7qIEN8PdB86cAfZijLLChsxd3JPBY9itLcngSO_7mrw>
    <xmx:MsgMX73SkbMDF547o5Y36ZY42OcB3YvSwWPv2H0rCI2TnB1MMpLUtA>
    <xmx:MsgMX6D0i-n5gtJv3qt-A9xxbbrbYhf1jaDQ0K4xTwugRAJYMdsbKw>
    <xmx:MsgMX5fb0fIOhsqX5jukiRid030TNP1frqfhy32cxWGUFS9TnsOcwg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 19D5D306005F;
        Mon, 13 Jul 2020 16:46:42 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] generic: add a test for umount racing mount
Date:   Mon, 13 Jul 2020 13:46:39 -0700
Message-Id: <20200713204639.1271794-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200712113741.GW1938@dhcp-12-102.nay.redhat.com>
References: <20200712113741.GW1938@dhcp-12-102.nay.redhat.com>
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
 tests/generic/603     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/603.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 56 insertions(+)
 create mode 100755 tests/generic/603
 create mode 100644 tests/generic/603.out

diff --git a/tests/generic/603 b/tests/generic/603
new file mode 100755
index 00000000..8e9a80e6
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
+	dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
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

