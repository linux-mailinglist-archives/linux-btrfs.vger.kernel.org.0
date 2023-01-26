Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7567D383
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjAZRuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAZRuV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 12:50:21 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C42227BC;
        Thu, 26 Jan 2023 09:50:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 59DE6320090D;
        Thu, 26 Jan 2023 12:50:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Jan 2023 12:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1674755417; x=1674841817; bh=zpXIwT2i+vaFAUVer68GMKd5M
        7OY3c+QZzlWdlPqYHc=; b=E67G15aZtjo9auJRJ6fqmNOgv7+m2CeFEgl3+ilJF
        JuDK1G+UfGmJO5WDuftcWpNoLHrultGYICe8O+rQtNzM21AxNNmm/IZNGc/pNXIi
        OLhjJgK9x3NS0Hn+X5KX9jLiGLW1A1uz2br/WMta6KSOJ0G5/heCbdZ1BG8VgrCP
        7yosQIh8JnLzwHeiMZNJ8Z0bPkRzwH5uHOXKQe4pVmpfMySazq2EOuFpFG6IO3hp
        yj2MGDF4bVGgGag6B6EWiOF1kUnd+PamKQ9qm/9ZgpyJElqZc9ys82cfsmnoczRE
        TIIBRyAcahuTBEUuY4pmhx/J+psncmP03Iyfi1N1+kLGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674755417; x=1674841817; bh=zpXIwT2i+vaFAUVer68GMKd5M7OY3c+QZzl
        WdlPqYHc=; b=eaO9J2X//CvFO+fR6tp/5t996B+U8SW/DKnnXJZ+asqGH0NcYlq
        ZVpECybEYxTUFLnbrLnZdjyMwUMQsBtbRX19Ny6cXv9CLHVkuCFZKb15XDOOJfof
        9tXpRa0jskVoauJOVZYDzCOWg7TVaqwpF3/9ItrQm9lCPmFC51fwG31CDJbMTgiz
        rRWJptY0a8NRW9HuU6m8qMIVKLYeuOR3qZVBStzGNB/2bsMJV33DPBe+u5IeLx0J
        kilG+H4Bh4OydxriXStkYsD7JUAjakMDQhSTqMLe5mzS4qrcDtfIu7MunG7sCM9f
        orqmD+uPNnkHCW8vGmpfublj47scFysCI2Q==
X-ME-Sender: <xms:Wb3SY4k6WNOQuY2m3flutV6LPcaL-hoK0B_i_atJnNkILmRygbQT5g>
    <xme:Wb3SY30eak0KcJivB5EkBNnv6285c2-xPqN2j0GblACNNTl6Z_WxJhKfykf03ruRT
    Mz1o_jZZHXrzhNUFMA>
X-ME-Received: <xmr:Wb3SY2qhL8Z2KMZpPub0n35TCgmtT0G2SAbKwnq5QZEbLWEEITHxK85m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Wb3SY0li6CuFsoXs_oe6H0v1X9FzMZ3R5HMgVOc_exYXSAcpYLI3EQ>
    <xmx:Wb3SY20zz58MboaxZyEJ9cnynTT8qGaCgjdPyHQZA7D4lP-zEWpTow>
    <xmx:Wb3SY7tvz6LsQaVy_vumEFpYdcnybLRQu35W6_FoIa1XnqRsh8D0pg>
    <xmx:Wb3SY78N5KSG8eg8FdGW8YkONBoBiogmbpzOgc5YPQpoJALxxK5BIA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 12:50:17 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v4] btrfs: test block group size class loading logic
Date:   Thu, 26 Jan 2023 09:50:16 -0800
Message-Id: <fa66499531a46105f295af0f29d9fc253f361d78.1674755349.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Changelog:
v4:
Fix dump typo in _fixed_by_kernel_commit (left out leading underscore
copy+pasting). Re-tested happy and sad case...

v3:
Re-add fixed_by_kernel_commit, but for the stats patch which is
required, but not a fix in the strictest sense.

v2:
Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
development tree, so the fix is getting rolled in to the original broken
commit. Modified the commit message to note the dependency on the new
sysfs counters.


 tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..2176c8e4
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
+_fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".
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

