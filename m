Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75AD580BB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiGZGaN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 02:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiGZGaK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 02:30:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC8CB04;
        Mon, 25 Jul 2022 23:30:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5C61F9F4;
        Tue, 26 Jul 2022 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658817007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wyIFENh/lgbdz46LqgCNfOwRjvgNTYiO+Y785v9zlwM=;
        b=JrQ2Y6N41dn9E0jKIsqGB3qZexvd/e0Xz5ERgYjkeKmjuBoKtOfQIBu3EeaPFfQT8GhZFx
        f9APnTUCNFoI8m12C1zHe1qhmGxAVJEF/d1eKgBj/lL7OdFMw16deIvHZx3f4S1xSeSTR5
        Q7P0YdDcV7zgvDapH0/emdGuOvz2jeQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D4A813A7C;
        Tue, 26 Jul 2022 06:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FgZjCu6J32LOUQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 26 Jul 2022 06:30:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: add test case to make sure btrfs can handle one corrupted device
Date:   Tue, 26 Jul 2022 14:29:48 +0800
Message-Id: <20220726062948.56315-1-wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case will verify that btrfs can handle one corrupted device
without affecting the consistency of the filesystem.

Unlike a missing device, one corrupted device can return garbage to the fs,
thus btrfs has to utilize its data/metadata checksum to verify which
data is correct.

The test case will:

- Create a small fs
  Mostly to speedup the test

- Fill the fs with a regular file

- Use fsstress to create some contents

- Save the fssum for later verification

- Corrupt one device with garbage but keep the primary superblock
  untouched

- Run fssum verification

- Run scrub to fix the fs

- Run scrub again to make sure the fs is fine

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/261     | 94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out |  2 +
 2 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/261
 create mode 100644 tests/btrfs/261.out

diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..15218e28
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 261
+#
+# Make sure btrfs raid profiles can handling one corrupted device
+# without affecting the consistency of the fs.
+#
+. ./common/preamble
+_begin_fstest raid
+
+. ./common/filter
+. ./common/populate
+
+_supported_fs btrfs
+_require_scratch_dev_pool 4
+_require_fssum
+
+prepare_fs()
+{
+	local profile=$1
+
+	# We don't want too large fs which can take too long to populate
+	# And the extra redirection of stderr is to avoid the RAID56 warning
+	# message to polluate the golden output
+	_scratch_pool_mkfs -m $profile -d $profile -b 1G >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		echo "mkfs $mkfs_opts failed"
+		return
+	fi
+
+	# Disable compression, as compressed read repair is known to have problems
+	_scratch_mount -o compress=no
+
+	# Fill some part of the fs first
+	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /dev/null 2>&1
+
+	# Then use fsstress to generate some extra contents.
+	# Disable setattr related operations, as it may set NODATACOW which will
+	# not allow us to use btrfs checksum to verify the content.
+	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
+	sync
+
+	# Save the fssum of this fs
+	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
+	$BTRFS_UTIL_PROG fi show $SCRATCH_MNT >> $seqres.full
+	_scratch_unmount
+}
+
+workload()
+{
+	local target=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+	local profile=$1
+	local num_devs=$2
+
+	_scratch_dev_pool_get $num_devs
+	echo "=== Testing profile $profile ===" >> $seqres.full
+	rm -f -- $tmp.saved_fssum
+	prepare_fs $profile
+
+	# Corrupt the target device, only keep the superblock.
+	$XFS_IO_PROG -c "pwrite 1M 1023M" $target > /dev/null 2>&1
+
+	_scratch_mount
+
+	# All content should be fine
+	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
+
+	# Scrub to fix the fs, this is known to report various correctable
+	# errors
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
+
+	# Make sure above scrub fixed the fs
+	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
+	if [ $? -ne 0 ]; then
+		echo "scrub failed to fix the fs for profile $profile"
+	fi
+	_scratch_unmount
+	_scratch_dev_pool_put
+}
+
+workload raid1 2
+workload raid1c3 3
+workload raid1c4 4
+workload raid10 4
+workload raid5 3
+workload raid6 4
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100644
index 00000000..679ddc0f
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,2 @@
+QA output created by 261
+Silence is golden
-- 
2.36.1

