Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9311B737EB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjFUIm1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjFUImB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 04:42:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827119BE;
        Wed, 21 Jun 2023 01:40:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2880D219E7;
        Wed, 21 Jun 2023 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687336850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kk5OqaxieKtUZyJpt3rbrBoJlC4EoCHReAjHcy1NKe4=;
        b=YFrTOKR0XrigrbVryJ/0nr2ydnQySpzFkNnctOML5/E5yDTf9TLg0WAZ1w7j76M3GqOT8P
        5d0vwUlhONTRQIxq9DcwWq+XNxBd8mITk4npgIM47r/pxSo4gyEwxtQ0N+AsFIUD9ma5qD
        Up92vqvOVbvwqOiMliNyAsTakCXDnC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A0A9134B1;
        Wed, 21 Jun 2023 08:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g+2SBZG3kmRdWQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 21 Jun 2023 08:40:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v3] btrfs: add test case to verify the behavior with large RAID0 data chunks
Date:   Wed, 21 Jun 2023 16:40:31 +0800
Message-ID: <20230621084031.209727-1-wqu@suse.com>
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
Changelog:
v2:
- Add requirement for fstrim and batched discard support
- Add some comments on why it's safe as long as each device is larger
  than 2G
- Use nodiscard mount option to increase the possibility of
  crash/corruption
  Newer kernel go with async discard by default and has extra trim cache
  to avoid duplicated trim commands.
  Disable such discard behavior so that fstrim can always trigger the
  bug.

v3:
- Use the merged fix commit in _fixed_by_kernel_commit
- Add the missing _scratch_dev_pool_put() calls before _fail()/_notrun()
- Fix the spell and grammar of a comment
- Update the error message if we detected a corruption after fstrim
- Use $XFS_IO_PROG instead of direct xfs_io calls
---
 tests/btrfs/292     | 91 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |  2 +
 2 files changed, 93 insertions(+)
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

diff --git a/tests/btrfs/292 b/tests/btrfs/292
new file mode 100755
index 00000000..32a7c3c5
--- /dev/null
+++ b/tests/btrfs/292
@@ -0,0 +1,91 @@
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
+_require_fstrim
+_fixed_by_kernel_commit a7299a18a179 \
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
+# Double that so that we can ensure a RAID0 data chunk with 6G size.
+for i in $SCRATCH_DEV_POOL; do
+	devsize=$(blockdev --getsize64 "$i")
+	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
+		_scratch_dev_pool_put
+		_notrun "device $i is too small, need at least 2G"
+	fi
+done
+
+_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
+
+# We disable async/sync auto discard, so that btrfs won't try to
+# cache the discard result which can cause unexpected skip for some trim range.
+_scratch_mount -o nodiscard
+_require_batched_discard $SCRATCH_MNT
+
+# Fill the data chunk with 5G data.
+for (( i = 0; i < $nr_files; i++ )); do
+	$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $filesize" \
+		$SCRATCH_MNT/file_$i > /dev/null
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
+	_scratch_dev_pool_put
+	_fail "data corruption detected after initial data filling"
+fi
+
+_scratch_mount -o nodiscard
+# Delete half of the data, and do discard
+rm -rf - "$SCRATCH_MNT/*[02468]"
+sync
+$FSTRIM_PROG $SCRATCH_MNT
+
+echo "=== With 2.5G data trimmed ===" >> $seqres.full
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+_scratch_unmount
+
+# Make sure fstrim doesn't corrupt anything.
+$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	_scratch_dev_pool_put
+	_fail "data corruption detected after running fstrim"
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

