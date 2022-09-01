Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F485A9CC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiIAQMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIAQMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 12:12:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71735FAFA;
        Thu,  1 Sep 2022 09:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F38861F5F;
        Thu,  1 Sep 2022 16:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D358AC433D6;
        Thu,  1 Sep 2022 16:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048736;
        bh=fWZ+1qx2XuUAqtV+FmX36fLrfY6F8b1fwxK/mZxj8+I=;
        h=From:To:Cc:Subject:Date:From;
        b=cPfCsNGjaP6zJALpgeOFL56R4Vi17xtdscNC0mdkTMB/obSgK6E8AEsOP+K3oCaMt
         2MPgG5Xw9jrtUEdB/nzacrC6m7a8TXZMPP7n5f1Re31ToKmey/GMKdwTguPthL+89F
         HZQ7Ccpg5uYEI4qJU5A4r8eR1c7pgLblD/Pe+blFV5BOj3uFBcn3rtRDZnPIlKLeVx
         KLwFoNlGdCBWgPg/C4k6ZnfSSNmynZa1jPhT069gZLJGzpbgyanlH9vSdmJeWNsCkh
         wdzfGqrqHPT0VZAaaP3Xx8zEIKpXKoi4dvTjWccbQ3srx1S+rnP6lmIwQmdr5snRcv
         hcIsbLEHs1u/Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test that we can not delete a subvolume with an active swap file
Date:   Thu,  1 Sep 2022 17:12:11 +0100
Message-Id: <e34bd1b1693a135444c3618e9e16ac8a91f595a3.1662048448.git.fdmanana@suse.com>
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
 tests/btrfs/274     | 51 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/274.out |  6 ++++++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/btrfs/274
 create mode 100644 tests/btrfs/274.out

diff --git a/tests/btrfs/274 b/tests/btrfs/274
new file mode 100755
index 00000000..0309c118
--- /dev/null
+++ b/tests/btrfs/274
@@ -0,0 +1,51 @@
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
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
+swap_file="$SCRATCH_MNT/subvol/swap"
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

