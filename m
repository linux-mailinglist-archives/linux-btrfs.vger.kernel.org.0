Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C128E6A0246
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 06:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBWFLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 00:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFLL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 00:11:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199F38657;
        Wed, 22 Feb 2023 21:11:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6484734674;
        Thu, 23 Feb 2023 05:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677129068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sWu4x91YC0eUQ1UqiNEytf8mMuQdnUWnTxOpaGL5N6s=;
        b=koZ2hECHBmja3+mrfeR13qoaBtcN+QA/j/U3rfwOsn57+lA4Yn0hYiqq8KoVAhBP4PFiDQ
        2BElnJkKK8hFARtJWyZuUZT9oTpIIyFRZUZ/UPN9GJP8BDwTJ9+ldqcEfUdBDTonKjSCtM
        2Mq5zvmlKQUwS+/DHun1eZTOO+Tfjl8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 775AE13524;
        Thu, 23 Feb 2023 05:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGq3D2v19mMMGAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 23 Feb 2023 05:11:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test case for NODATASUM dev-replace
Date:   Thu, 23 Feb 2023 13:10:49 +0800
Message-Id: <20230223051049.30086-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.1
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

During my development on dev-replace, I made a mistake in RAID56
dev-replace code where it can lead to NODATASUM corruption.
Thankfully such corruption didn't reach upstream.

Inspired by such incident, here comes a new test case for btrfs
dev-replace, the new case would:

- Populate the filesystem with nodatasum mount option

- Run fssum to record the contents
  Since the test case only cares about data contents, here we don't
  include metadata like uid/gid/timestamp.

- Wipe one device

- Mount the fs with the missing device

- Verify the contents is still correct

- Replace the missing device

- Verify the contents is still correct again
  Before the verification, drop all cache to make sure the 2nd
  verification is reading from the disks.

For current kernels, the test case should pass as expected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/286     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/286.out |  2 ++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/btrfs/286
 create mode 100644 tests/btrfs/286.out

diff --git a/tests/btrfs/286 b/tests/btrfs/286
new file mode 100755
index 00000000..fb805256
--- /dev/null
+++ b/tests/btrfs/286
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 286
+#
+# Make sure btrfs dev-replace on missing device won't cause data corruption
+# for NODATASUM data.
+#
+. ./common/preamble
+_begin_fstest auto replace
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_command "$WIPEFS_PROG" wipefs
+_btrfs_get_profile_configs replace-missing
+_require_fssum
+_require_scratch_dev_pool 5
+_scratch_dev_pool_get 4
+_spare_dev_get
+
+workload()
+{
+	local profile=$1
+	local victim="$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')"
+
+	echo "=== Profile: $profile ===" >> $seqres.full
+	rm -f $tmp.fssum
+	_scratch_pool_mkfs "$profile" >> $seqres.full 2>&1
+
+	# Use nodatasum mount option, so all data won't have checksum.
+	_scratch_mount -o nodatasum
+
+	$FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT > /dev/null 2>&1
+	sync
+
+	# Generate fssum for later verification, here we only care
+	# about the file contents, thus we don't bother metadata at all.
+	$FSSUM_PROG -n -d -f -w $tmp.fssum $SCRATCH_MNT
+	_scratch_unmount
+
+	# Wipe devid 2
+	$WIPEFS_PROG -a $victim >> $seqres.full 2>&1
+
+	# Mount the fs with the victim device missing
+	_scratch_mount -o degraded,nodatasum
+
+	# Verify no data corruption first.
+	echo "=== Verify the contents before replace ===" >> $seqres.full
+	$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT >> $seqres.full 2>&1
+
+	# Replace the missing device
+	$BTRFS_UTIL_PROG replace start -Bf 2 $SPARE_DEV $SCRATCH_MNT >> $seqres.full
+
+	# Drop all cache to make sure later read are all from the disks
+	echo 3 > /proc/sys/vm/drop_caches
+
+	# Re-check the file contents
+	echo "=== Verify the contents after replace ===" >> $seqres.full
+	$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT >> $seqres.full 2>&1
+
+	_scratch_unmount
+}
+
+for t in "${_btrfs_profile_configs[@]}"; do
+	workload "$t"
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/286.out b/tests/btrfs/286.out
new file mode 100644
index 00000000..35c48006
--- /dev/null
+++ b/tests/btrfs/286.out
@@ -0,0 +1,2 @@
+QA output created by 286
+Silence is golden
-- 
2.39.0

