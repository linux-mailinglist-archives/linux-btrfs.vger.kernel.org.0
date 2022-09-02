Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9415AAB6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiIBJbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiIBJan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20044E62E;
        Fri,  2 Sep 2022 02:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F7AE61BBA;
        Fri,  2 Sep 2022 09:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1D4C433D6;
        Fri,  2 Sep 2022 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662111041;
        bh=Bh9FHDBNwHPp/BxUYYcvt3nGhxk1gOj+ynGQSWWRg2c=;
        h=From:To:Cc:Subject:Date:From;
        b=iAJ0cxC4se7PTUeRWeKb+bnYZdtvZAL5GBXgQSFaOEynr3xl+akxADJd4EwnHVjmV
         o5lWFze/H2UBL+mzxtxs4MA6lOqfQ14TOyFTNHX32j5qTZetl6B7hzxLhwaOG82dFf
         zU27LcH50sHYcgWaV5HVW8nmRgMQdg3TiSW/YkqvEdnsKHgqXPC6NjFge3NEHtd8NV
         ZN34JSIEBh8+MHz63+YECq7kdYbaJjVU1fMo43AYE8pFRw+gjcNIa4xXgVQNrHPD4k
         r8RO4M+j3OMNNUoQsaLHp9OKh7/yJxb78Z/RJBT3eqR827XzKC8PZk0+ipQUnexaT6
         OoWHkPa6znCWg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test that we can not delete a subvolume with an active swap file
Date:   Fri,  2 Sep 2022 10:30:32 +0100
Message-Id: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Verify that we can not delete a subvolume that has an active swap file,
and that after disabling the swap file, we can delete it.

This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
subvol with swapfile from being deleted"), which landed in kernel 5.18.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Add _cleanup() override to make sure swapfile is disabled in case
    the test is interrupted.

 tests/btrfs/274     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/274.out |  6 +++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/btrfs/274
 create mode 100644 tests/btrfs/274.out

diff --git a/tests/btrfs/274 b/tests/btrfs/274
new file mode 100755
index 00000000..c0594e25
--- /dev/null
+++ b/tests/btrfs/274
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 274
+#
+# Test that we can not delete a subvolume that has an active swap file.
+#
+. ./common/preamble
+_begin_fstest auto quick swap subvol
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	test -n "$swap_file" && swapoff $swap_file &> /dev/null
+}
+
+. ./common/filter
+
+_supported_fs btrfs
+_fixed_by_kernel_commit 60021bd754c6ca \
+    "btrfs: prevent subvol with swapfile from being deleted"
+_require_scratch_swapfile
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+swap_file="$SCRATCH_MNT/subvol/swap"
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
+
+echo "Creating and activating swap file..."
+_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
+_swapon_file $swap_file
+
+echo "Attempting to delete subvolume with swap file enabled..."
+# Output differs with different btrfs-progs versions and some display multiple
+# lines on failure like this for example:
+#
+#   ERROR: Could not destroy subvolume/snapshot: Operation not permitted
+#   WARNING: deletion failed with EPERM, send may be in progress
+#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1/subvol'
+#
+# So just redirect all output to the .full file and check the command's exit
+# status instead.
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 && \
+    echo "subvolume deletion successful, expected failure!"
+
+echo "Disabling swap file..."
+swapoff $swap_file
+
+echo "Attempting to delete subvolume after disabling swap file..."
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 || \
+   echo "subvolume deletion failure, expected success!"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
new file mode 100644
index 00000000..66e0de25
--- /dev/null
+++ b/tests/btrfs/274.out
@@ -0,0 +1,6 @@
+QA output created by 274
+Create subvolume 'SCRATCH_MNT/subvol'
+Creating and activating swap file...
+Attempting to delete subvolume with swap file enabled...
+Disabling swap file...
+Attempting to delete subvolume after disabling swap file...
-- 
2.35.1

