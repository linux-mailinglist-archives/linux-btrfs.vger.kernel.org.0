Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7618668F00
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 08:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjAMHWQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 02:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjAMHVy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 02:21:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A808E1146F;
        Thu, 12 Jan 2023 23:07:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E13325D4E1;
        Fri, 13 Jan 2023 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673593631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1mMwPrZY1lLdjaau5p58OiAkx4G1i0V+9Cp2lyxzEZQ=;
        b=ND64Aiy6ENsDOAprSfdYHBX5JXETKtBgwamYkkfUBAstgXtqjQkuDbD48ab2JLD1rqThfi
        2jhO15EzxJet9VHT62bKY0lspqrDG491blJ997mwxPR2uD0VjlvXCnHyTG1Nl0e8y8tWKj
        +8YTikEA6VEroPaTV6eeMJWD7caFtGM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12C891358A;
        Fri, 13 Jan 2023 07:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CO/DMx4DwWNoMAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 13 Jan 2023 07:07:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to verify that per-fs features directory gets updated
Date:   Fri, 13 Jan 2023 15:06:53 +0800
Message-Id: <20230113070653.44512-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although btrfs has a per-fs feature directory, it's not properly
refreshed after new features are enabled.

We had some attempts to do that properly, like commit 14e46e04958d
("btrfs: synchronize incompat feature bits with sysfs files").
But unfortunately that commit get later reverted as some call sites is
not safe to update sysfs files.

Now we have a new patch to properly refresh that per-fs features
directory, titled "btrfs: update fs features sysfs directory asynchronously".

So it's time to add a test case for it. The test case itself is pretty
straightforward:

- Make a very basic 3 disks btrfs
  Only using the very basic profiles (DUP/SINGLE) so that even older
  mkfs.btrfs can support.

- Make sure per-fs features directory doesn't contain "raid1c34" file

- Balance the metadata to RAID1C3 profile

- Verify the per-fs features directory contains "raid1c34" feature file

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/283     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/283.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/btrfs/283
 create mode 100644 tests/btrfs/283.out

diff --git a/tests/btrfs/283 b/tests/btrfs/283
new file mode 100755
index 00000000..6c431273
--- /dev/null
+++ b/tests/btrfs/283
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 283
+#
+# Make sure that per-fs features sysfs interface get properly updated
+# when a new feature is added.
+#
+. ./common/preamble
+_begin_fstest auto quick balance
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+
+# We need the global features support
+_require_btrfs_fs_sysfs
+
+global_features="/sys/fs/btrfs/features"
+# Make sure we have support RAID1C34 first
+if [ ! -f "${global_features}/raid1c34" ]; then
+	_notrun "no RAID1C34 support"
+fi
+
+_scratch_dev_pool_get 3
+
+# Go the very basic profile first, so that even older progs can support it.
+_scratch_pool_mkfs -m dup -d single >>$seqres.full 2>&1
+
+_scratch_mount
+uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
+per_fs_features="/sys/fs/btrfs/${uuid}/features"
+
+# First we need per-fs features directory
+if [ ! -d "${per_fs_features}" ]; then
+	_notrun "no per-fs features sysfs directory"
+fi
+
+# Make sure the per-fs features doesn't include raid1c34
+if [ -f "${per_fs_features}/raid1c34" ]; then
+	_fail "raid1c34 feature found unexpectedly"
+fi
+
+# Balance to RAID1C3
+$BTRFS_UTIL_PROG balance start -mconvert=raid1c3 "$SCRATCH_MNT" >> $seqres.full
+
+# Check if the per-fs features directory contains raid1c34 now
+# Make sure the per-fs features doesn't include raid1c34
+if [ ! -f "${per_fs_features}/raid1c34" ]; then
+	_fail "raid1c34 feature not found"
+fi
+
+echo "Silence is golden"
+
+_scratch_unmount
+_scratch_dev_pool_put
+
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
2.39.0

