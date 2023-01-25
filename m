Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C467C019
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 23:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjAYWnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 17:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjAYWnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 17:43:12 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915193F4;
        Wed, 25 Jan 2023 14:43:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1138D5C053F;
        Wed, 25 Jan 2023 17:43:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Jan 2023 17:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674686591; x=1674772991; bh=0IO/GIMPFXig6kNvOxbki0PKM
        EmBoJp/ITuVT3/Rjqw=; b=RI4roIqU8gcYdQVNnW54LQ91QDfqAJzADVcclQRXg
        lW8PariOxBFl7QklUuNDm//D/XOx0bg12bkCdndjnK9VNAaYE5No3NdPYrYFtO8i
        0uC7sBHJubVX8D1heucA62vRbsoqU9ZEEVEYg4n1Sb/RWq/ASFpxgXfdpn7PvbuC
        SR7gabnp5iETRPmNHS3dtBJ28xiwJOYJmB6IfI2A0TqNkwGi5IPehg7hvImCZMUo
        g+6+3ExdGRl43ASGlBmaFIuou/mp6IBzQXHa2x6gpH2ddRVg/2cAds843KNRR/ZS
        BqAA+DviFlpNhQ+K2P0JCk1bc3op6YakcLk3QZbypVlkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674686591; x=1674772991; bh=0IO/GIMPFXig6kNvOxbki0PKMEmBoJp/ITu
        VT3/Rjqw=; b=mSHHl4eOntPo3sUvg1jYgYXAqctOziqwBMjLDC3s5i+9kRP8+kH
        tT58hlFFrfQ/nKgB2Lodun+tzRTyeHaDVqOt3T145uU5joCvcZ4/EL16GRJXVXUq
        YdnoHdzZ1f4jykACCxU7gynIXtsTyKb/NShyBLEYXMDHrR9LgmuKYmNJXfIKOVBi
        Yj2By70QhEcXWe2cNkJiHc2c7JbDnh9bDBf06XjGzNcgWcNHsa6bOP0k86zpXEbL
        wt0ivMyQI46T0SkN+vf8J4/0PCI5kWYMj6x7LsoyXeUco/c6242YwyGsjq8vMsJX
        AKPa/20vGkhX+zhjapMFtBAyKgwuzklbbYw==
X-ME-Sender: <xms:frDRYwc03_jJjlonTNzSD0lJ1l89WiDDEds-gVAIxFob4njH558VIA>
    <xme:frDRYyONMdCGdd4z_8o_SMaO8bUlvKcVISOkXi7-Tmyh3oyBF7JUEnwUxwiYKsC1v
    Ex17wLSweGAo6p3oUs>
X-ME-Received: <xmr:frDRYxjiipcGY6udcoNugvttaWCpIxTv01g92ceYzAuC9C9hG5N0MgfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:frDRY19AR9C1UCFFg6xfCm1CAkdkSSwZnMwH5Zqdek22nHm79Pq5og>
    <xmx:frDRY8uGA6hydFAr9_3RZap_0TBwXmKEqoPkulXXhJyG6CE55DRBxg>
    <xmx:frDRY8FipYKAHFNPmCd-LIHgve_aeje6AaLHDXzruNbT0tfZ6b-R-Q>
    <xmx:f7DRY5VYPIRlBtlr35x9NuqHMfuTFkUxnpcqM4q_uvDyt_C36olO8Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 17:43:10 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: test block group size class loading logic
Date:   Wed, 25 Jan 2023 14:43:09 -0800
Message-Id: <4ea6df6e4f96b6e6101a16a1c94fc967d54558c7.1674686506.git.boris@bur.io>
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
btrfs: add size class stats to sysfs

Signed-off-by: Boris Burkov <boris@bur.io>
---
v2: drop the fixed_by_kernel_commit since the fix is not out past the
btrfs development tree, so the fix is getting rolled in to the original
broken commit. Modified the commit message to note the dependency on the
new sysfs counters.

 tests/btrfs/283     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..b3614786
--- /dev/null
+++ b/tests/btrfs/283
@@ -0,0 +1,49 @@
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

