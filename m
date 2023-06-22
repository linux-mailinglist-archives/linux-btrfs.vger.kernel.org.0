Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BCB7397AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 08:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjFVG41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 02:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjFVGz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 02:55:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81C2126;
        Wed, 21 Jun 2023 23:55:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31D16203A2;
        Thu, 22 Jun 2023 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687416897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=D7yd+RpD1Wf6TYYppsZ9uVGX3bE4q3eY/oNCWo4fhys=;
        b=L7sdLeQwdRXJl0fU0IHk+c0AZ03Jj7d33ei8LqN66JAGUxz2d24pzvWNHT03dUMnfqmQps
        e8JtcX17YPDkhvlNxTEGzzegY5FMSxXlrVh61EA0Rktfv6yu3QX2cBrycoUdrDi3erVtfo
        pZYfgm05JTOAZvTiz/lXBtulaik4mAE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 546D3132BE;
        Thu, 22 Jun 2023 06:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oi4rCEDwk2RuWQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 22 Jun 2023 06:54:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to verify the write behavior of large RAID5 data chunks
Date:   Thu, 22 Jun 2023 14:54:38 +0800
Message-ID: <20230622065438.86402-1-wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a recent regression during v6.4 merge window, that a u32 left
shift overflow can cause problems with large data chunks (over 4G)
sized.

This is especially nasty for RAID56, which can lead to ASSERT() during
regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.

This is the regression test case for it.

Unlike btrfs/292, btrfs doesn't support trim inside RAID56 chunks, thus
the workflow is simplified:

- Create a RAID5 or RAID6 data chunk during mkfs

- Fill the fs with 5G data and sync
  For unpatched kernel, the sync would crash the kernel.

- Make sure everything is fine

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/293     | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/293.out |  2 ++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/btrfs/293
 create mode 100644 tests/btrfs/293.out

diff --git a/tests/btrfs/293 b/tests/btrfs/293
new file mode 100755
index 00000000..68312682
--- /dev/null
+++ b/tests/btrfs/293
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 293
+#
+# Test btrfs write behavior with large RAID56 chunks (size beyond 4G).
+#
+. ./common/preamble
+_begin_fstest auto raid volume
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_dev_pool 8
+_fixed_by_kernel_commit a7299a18a179 \
+	"btrfs: fix u32 overflows when left shifting @stripe_nr"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: use a dedicated helper to convert stripe_nr to offset"
+
+_scratch_dev_pool_get 8
+
+datasize=$((5 * 1024 * 1024 * 1024))
+
+
+workload()
+{
+	local data_profile=$1
+
+	_scratch_pool_mkfs -m raid1 -d $data_profile >> $seqres.full 2>&1
+	_scratch_mount
+	$XFS_IO_PROG -f -c "pwrite -b 1m 0 $datasize" $SCRATCH_MNT/foobar > /dev/null
+
+	# Unpatched kernel would trigger an ASSERT() or crash at writeback.
+	sync
+
+	echo "=== With initial 5G data written ($data_profile) ===" >> $seqres.full
+	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+	_scratch_unmount
+
+	# Make sure we haven't corrupted anything.
+	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		_scratch_dev_pool_put
+		_fail "data corruption detected after initial data filling"
+	fi
+}
+
+# Make sure each device has at least 2G.
+# Btrfs has a limits on per-device stripe length of 1G.
+# Double that so that we can ensure a RAID6 data chunk with 6G size.
+for i in $SCRATCH_DEV_POOL; do
+	devsize=$(blockdev --getsize64 "$i")
+	if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
+		_scratch_dev_pool_put
+		_notrun "device $i is too small, need at least 2G"
+	fi
+done
+
+workload raid5
+workload raid6
+
+_scratch_dev_pool_put
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
new file mode 100644
index 00000000..076fc056
--- /dev/null
+++ b/tests/btrfs/293.out
@@ -0,0 +1,2 @@
+QA output created by 293
+Silence is golden
-- 
2.39.0

