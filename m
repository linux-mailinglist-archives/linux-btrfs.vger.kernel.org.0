Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB2B736B74
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjFTMAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFTMA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 08:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AF1B6;
        Tue, 20 Jun 2023 05:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31778611FE;
        Tue, 20 Jun 2023 12:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCB0C433C8;
        Tue, 20 Jun 2023 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687262427;
        bh=cA2K/1oDav/F9sytL35qDUC0P5YyRXAcyRhzqm2EtLU=;
        h=From:To:Cc:Subject:Date:From;
        b=byzV6d3WgGFCzSbdpT2ptGvCI4rD4Rp2xARibLnAVnYpOGeGqKZmr+Gn1t79e9IS4
         7UiSkflIoouozOOztQXuNjdjfIbwmzDGZm60mkh3EAlj8E/yNVl7LUrEXPUxfsfNHc
         gHYVyqe1ajG/O5aTEgDCWIfI/Qg6+5aYYo4rMJOOY2PYpzHMKLC3z4kdna0phkkDPy
         AZqB+CyJ8hEOsPR8PgQnpIcZMrDpy8qn08A98yRWn/nfhmaahK+Pm79jwivbP4sZ6K
         CHt+Z+fKtuvtiBqiURyegfXhRtxmx3iSCa151inC7n/hXX0xSNvjuV5szg7MHJFE11
         5AWh8kbwTzWyA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test activating swapfile in the presence of snapshots
Date:   Tue, 20 Jun 2023 13:00:21 +0100
Message-Id: <5417083e8e23a1553f428608d02a07aae21b9e53.1687262391.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a subvolume with a non-active swap file, we can not
activate it if there are any snapshots. Also test that after all the
snapshots are removed, we will be able to activate the swapfile.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/292     | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out | 17 +++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

diff --git a/tests/btrfs/292 b/tests/btrfs/292
new file mode 100755
index 00000000..06638f83
--- /dev/null
+++ b/tests/btrfs/292
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 292
+#
+# Test that if we have a subvolume with a non-active swap file, we can not
+# activate it if there are any snapshots. Also test that after all the snapshots
+# are removed, we will be able to activate the swapfile.
+#
+. ./common/preamble
+_begin_fstest auto quick swap snapshot
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
+_fixed_by_kernel_commit deccae40e4b3 \
+	"btrfs: can_nocow_file_extent should pass down args->strict from callers"
+_require_scratch_swapfile
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+swap_file="$SCRATCH_MNT/swapfile"
+_format_swapfile $swap_file $(($(get_page_size) * 64)) >> $seqres.full
+
+echo "Creating first snapshot..."
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_scratch
+echo "Creating second snapshot..."
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_scratch
+
+echo "Activating swap file... (should fail due to snapshots)"
+_swapon_file $swap_file 2>&1 | _filter_scratch
+
+echo "Deleting first snapshot..."
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap1 | _filter_scratch
+
+# We deleted the snapshot and committed the transaction used to delete it (-c),
+# but all its extents are actually only deleted in the background, by the cleaner
+# kthread. So remount, which wakes up the cleaner kthread, with a commit interval
+# of 1 second and sleep for 1.1 seconds - after this we are guaranteed all
+# extents of the snapshot were deleted.
+echo "Remounting and waiting for cleaner thread to remove the first snapshot..."
+_scratch_remount commit=1
+sleep 1.2
+
+echo "Activating swap file... (should fail due to snapshot)"
+_swapon_file $swap_file 2>&1 | _filter_scratch
+
+echo "Deleting second snapshot..."
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap2 | _filter_scratch
+
+echo "Remounting and waiting for cleaner thread to remove the second snapshot..."
+_scratch_remount commit=1
+sleep 1.2
+
+# No more snapshots, we should be able to activate the swap file.
+echo "Activating swap file..."
+_swapon_file $swap_file
+echo "Disabling swap file..."
+swapoff $swap_file
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
new file mode 100644
index 00000000..77b0cde5
--- /dev/null
+++ b/tests/btrfs/292.out
@@ -0,0 +1,17 @@
+QA output created by 292
+Creating first snapshot...
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Creating second snapshot...
+Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Activating swap file... (should fail due to snapshots)
+swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
+Deleting first snapshot...
+Delete subvolume (commit): 'SCRATCH_MNT/snap1'
+Remounting and waiting for cleaner thread to remove the first snapshot...
+Activating swap file... (should fail due to snapshot)
+swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
+Deleting second snapshot...
+Delete subvolume (commit): 'SCRATCH_MNT/snap2'
+Remounting and waiting for cleaner thread to remove the second snapshot...
+Activating swap file...
+Disabling swap file...
-- 
2.34.1

