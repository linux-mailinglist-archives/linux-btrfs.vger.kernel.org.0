Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBB67BF84
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 23:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAYWDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAYWDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 17:03:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E94608D;
        Wed, 25 Jan 2023 14:03:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ED3E5C047F;
        Wed, 25 Jan 2023 17:03:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 17:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674684194; x=1674770594; bh=7tJNz6Sz0IXyW6vautvaD/HNm
        ADeLucsnW6kfhveJ6g=; b=arXkpKrz+yn2DsFmUBdTscsMuiMSGBpbcd8OCY7+H
        PbimijxBIQ8fW3bQPSK2j9zDNBPl8cZs9GHRhKUEWEtbDshNPKpbhXwgRgQ6Foj5
        /rqZkNAuW1WdkH2YLZiQrCzVqVj1AoD9Y6Mo0r8TSdxBMIdLgkLuTHhZd9nkKTD5
        cLuGmw+tpezL3AKSV9X2jLvZYp3iXJln20EFIlI96QUs+MbUoroH1PLOEQ6N3iQG
        99K8A5zKmKez0mhoDfNvCw1xMYia+Evyh2Xki55vajbMnqn1zwruex8gzv2QGbYm
        tnbsY2hKNRlO38qcqlCJ5i89dBgnPSx1v0rNGLodjoCcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674684194; x=1674770594; bh=7tJNz6Sz0IXyW6vautvaD/HNmADeLucsnW6
        kfhveJ6g=; b=MKfIY6xxdvA+V7+3Zy7wtE+sIgXvjw8/srBy7/KMYULyW6PeodV
        wmUs14uhk7xvmRO7DXHe++7Vw2S9/FO5ShVvdRUs9qc+zR/8lCQdahtbeEMoH0OG
        lAIVza8KTZ8j4ukFGaV3RVOXTFtoF0Gea0zaCfvDLSR+0VQkzFhfTZo1U+vv+U8j
        cckF1UwDsREXBwo/93juxWOWPfXjOxzzIGBRlCDjabdDWr4QnvjMIUTuDiHY15Gv
        QpEwh8ZVVVyYX6TCspz+NUsl+8jwVglcWUtW1zDYvm+7zfd7p0NvdA8TrbbxL5P+
        zpNmx5Z5M8fAYkUc4A5bWZUVKDLCBY5mvHw==
X-ME-Sender: <xms:IqfRYwzBJlr72s8D9cgLXOYzPrYJeQROfkuVCsQ6X_0Zw157R-SlZg>
    <xme:IqfRY0QW99qDTR_ViuIr2bgD2CJUVfbnsOTasdOpPiL-zoOvkqOLbtiXIUU5w5Cfp
    7Sd1rYPTqqZYSbq-wk>
X-ME-Received: <xmr:IqfRYyXrRa9-t3BVaBnOG3cUxZ_po0QL7oLxbuaGs5l1-7OdkrJj54Tz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:IqfRY-jIB5NwktK9sHX056LwggP2MsooBXNh81wuVmEa0A9fnqbgyA>
    <xmx:IqfRYyC_9DqndF1eq_fTvBthU6EURrH8ghhCtCiKpHzWBlSW60j5og>
    <xmx:IqfRY_K8UnBmsKCT4dm6FkdF_agfIlaOPDycivibVCknOYjekr4Z0w>
    <xmx:IqfRYz4JqAa5ht3Y-jNEIoLMDiPt4gldUBNrYXDd8XIaDmHs6kycQg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 17:03:13 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] btrfs: test block group size class loading logic
Date:   Wed, 25 Jan 2023 14:03:12 -0800
Message-Id: <6f1788a52cea8d1028844d4815eb03ad666d675f.1674684147.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new test which checks that size classes in freshly loaded block
groups after a cycle mount match size classes before going down

Depends on the kernel patch:
btrfs: fix size class loading logic

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..cdd7bcc5
--- /dev/null
+++ b/tests/btrfs/283
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 283
+#
+# Test that mounting a btrfs filesystem properly loads block group size classes.
+#
+. ./common/preamble
+_begin_fstest auto quick mount
+_fixed_by_kernel_commit XXXXXXXX "btrfs: fix size class loading logic"
+
+sysfs_size_classes() {
+	local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
+	cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
+}
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_fs_sysfs
+
+f="$SCRATCH_MNT/f"
+small=$((16 * 1024))
+medium=$((1024 * 1024))
+large=$((16 * 1024 * 1024))
+
+_scratch_mkfs >/dev/null
+_scratch_mount
+# Write files with extents in each size class
+$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
+$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
+$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
+# Sync to force the extent allocation
+sync
+pre=$(sysfs_size_classes)
+
+# cycle mount to drop the block group cache
+_scratch_cycle_mount
+
+# Another write causes us to actually load the block groups
+$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
+sync
+
+post=$(sysfs_size_classes)
+diff <(echo $pre) <(echo $post)
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
new file mode 100644
index 00000000..efb2c583
--- /dev/null
+++ b/tests/btrfs/283.out
@@ -0,0 +1,2 @@
+QA output created by 283
+Silence is golden
-- 
2.39.1

