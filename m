Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F6B7378D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 03:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjFUBva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 21:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBv3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 21:51:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56A172C;
        Tue, 20 Jun 2023 18:51:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9CE81F88C;
        Wed, 21 Jun 2023 01:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687312285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gK0aH+iGPs+N2oFCLZtJA/ih2vgvBB5Ni6G2icAc8LY=;
        b=B4yMaQCmfJ8OR6DXzVT9QRCrv2zlpxFEeilfrTrptPtcXzDFmH/cA7p2eb06Ad/ukexLmc
        u6uGVmiUtd464vx9VXJT1IcRnoStuDZE/6oZ0nnrZWNQ1/4rZYw9P4Z3XAX7ibmAYiFN0T
        ANqIuuTOrIobxswMPZChOwT/sFI9AM0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DACC4134B1;
        Wed, 21 Jun 2023 01:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GpwBKJxXkmTOTQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 21 Jun 2023 01:51:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test case to verify the behavior with large RAID0 data chunks
Date:   Wed, 21 Jun 2023 09:51:07 +0800
Message-ID: <20230621015107.88931-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a recent regression during v6.4 merge window, that a u32 left
shift overflow can cause problems with large data chunks (over 4G
sized).

This is the regression test case for it.

The test case itself would:

- Create a RAID0 chunk with a single 6G data chunk
  This requires at least 6 devices from SCRATCH_DEV_POOL, and each
  should be larger than 2G.

- Fill the fs with 5G data

- Make sure everything is fine
  Including the data csums.

- Delete half of the data

- Do a fstrim
  This would lead to out-of-boundary trim if the kernel is not patched.

- Make sure everything is fine again
  If not patched, we may have corrupted data due to the bad fstrim
  above.

For now, this test case only checks the behavior for RAID0.
As for RAID10, we need 12 devices, which is out-of-reach for a lot of
test envionrments.

For RAID56, they would have a different test case, as they don't support
discard inside the RAID56 chunks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/292     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |  2 ++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

diff --git a/tests/btrfs/292 b/tests/btrfs/292
new file mode 100755
index 00000000..d1e31603
--- /dev/null
+++ b/tests/btrfs/292
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 292
+#
+# Test btrfs behavior with large chunks (size beyond 4G) for basic read-write
+# and discard.
+# This test focus on RAID0.
+#
+. ./common/preamble
+_begin_fstest auto raid volume trim
+
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_dev_pool 6
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix u32 overflows when left shifting @stripe_nr"
+
+_scratch_dev_pool_get 6
+
+
+datasize=$((5 * 1024 * 1024 * 1024))
+filesize=$((8 * 1024 * 1024))
+nr_files=$(($datasize / $filesize))
+
+# Make sure each device has at least 2G.
+# Btrfs has a limits on per-device stripe length of 1G.
+# Double that so that we can ensure a data chunk with 6G size.
+
+for i in $SCRATCH_DEV_POOL; do
+	devsize=$(blockdev --getsize64 "$i")
+	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
+		_notrun "device $i is too small, need at least 2G"
+	fi
+done
+
+_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
+_scratch_mount
+
+# Fill the data chunk with 5G data.
+for (( i = 0; i < $nr_files; i++ )); do
+	xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize" $SCRATCH_MNT/file_$i > /dev/null
+done
+sync
+echo "=== With initial 5G data written ===" >> $seqres.full
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+
+_scratch_unmount
+
+# Make sure we haven't corrupted anything.
+$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	_fail "data corruption detected after initial data filling"
+fi
+
+_scratch_mount
+# Delete half of the data, and do discard
+rm -rf - "$SCRATCH_MNT/*[02468]"
+sync
+$FSTRIM_PROG $SCRATCH_MNT
+
+echo "=== With 2.5G data trimmed ===" >> $seqres.full
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+_scratch_unmount
+
+# Make sure fstrim didn't corrupte anything.
+$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	_fail "data corruption detected after initial data filling"
+fi
+
+_scratch_dev_pool_put
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
new file mode 100644
index 00000000..627309d3
--- /dev/null
+++ b/tests/btrfs/292.out
@@ -0,0 +1,2 @@
+QA output created by 292
+Silence is golden
-- 
2.39.0

