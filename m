Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468874324A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF3Bgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 21:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF3Bgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 21:36:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1612974;
        Thu, 29 Jun 2023 18:36:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 113042184D;
        Fri, 30 Jun 2023 01:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688088992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NasBFd233rL1f8aXcJhqQNFQEcZ+GdRjh/S0vo4oVVQ=;
        b=OkvehaNCyO4NrFuTosKWwr1VHDfw7Tyjj1ceUbv5376wcCE5HLOK4Q/Pe3jOOotLMonCLv
        noOUYYFIBb8/WaEZSKYMjgM+dLalXvnFr865xNx9VXTOAlUx4/Q6WhBGBi4CtHshAYQ5D3
        Qm3ILJTo6vLNyIGxSAmVSZE8/wrbyR0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5152B138F8;
        Fri, 30 Jun 2023 01:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 49Q9CZ8xnmQ/MAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 30 Jun 2023 01:36:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to make sure scrub can repair parity corruption
Date:   Fri, 30 Jun 2023 09:36:14 +0800
Message-ID: <20230630013614.56667-1-wqu@suse.com>
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

There is a kernel regression caused by commit 75b470332965 ("btrfs:
raid56: migrate recovery and scrub recovery path to use error_bitmap"),
which leads to scrub not repairing corrupted parity stripes.

So here we add a test case to verify the P/Q stripe scrub behavior by:

- Create a RAID5 or RAID6 btrfs with minimal amount of devices
  This means 2 devices for RAID5, and 3 devices for RAID6.
  This would result the parity stripe to be a mirror of the only data
  stripe.

  And since we have control of the content of data stripes, the content
  of the P stripe is also fixed.

- Create an 64K file
  The file would cover one data stripe.

- Corrupt the P stripe

- Scrub the fs
  If scrub is working, the P stripe would be repaired.

  Unfortunately scrub can not report any P/Q corruption, limited by its
  reporting structure.
  So we can not use the return value of scrub to determine if we
  repaired anything.

- Verify the content of the P stripe

- Use "btrfs check --check-data-csum" to double check

By above steps, we can verify if the P stripe is properly fixed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/294     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/294.out |  2 ++
 2 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/294
 create mode 100644 tests/btrfs/294.out

diff --git a/tests/btrfs/294 b/tests/btrfs/294
new file mode 100755
index 00000000..97b85988
--- /dev/null
+++ b/tests/btrfs/294
@@ -0,0 +1,86 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 294
+#
+# Make sure btrfs scrub can fix parity stripe corruption
+#
+. ./common/preamble
+_begin_fstest auto quick raid scrub
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_odirect
+_require_non_zoned_device "${SCRATCH_DEV}"
+_require_scratch_dev_pool 3
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: raid56: always verify the P/Q contents for scrub"
+
+workload()
+{
+	local profile=$1
+	local nr_devs=$2
+
+	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
+	_scratch_dev_pool_get $nr_devs
+
+	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
+	# Disable space cache to prevent v1 space cache affecting
+	# the result.
+	_scratch_mount -o nospace_cache
+
+	# Create one 64K extent which would cover one data stripe.
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
+		"$SCRATCH_MNT/foobar" > /dev/null
+	sync
+
+	# Corrupt the P/Q stripe
+	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
+
+	# The 2nd copy is pointed to P stripe directly.
+	physical_p=$(_btrfs_get_physical ${logical} 2)
+	devpath_p=$(_btrfs_get_device_path ${logical} 2)
+
+	_scratch_unmount
+
+	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
+		>> $seqres.full
+	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
+		> /dev/null
+
+	# Do a scrub to try repair the P stripe.
+	_scratch_mount -o nospace_cache
+	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
+	_scratch_unmount
+
+	# Verify the repaired content directly
+	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
+	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
+
+	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full
+	echo $output >> $seqres.full
+	
+	if [ "$output" != "$expect" ]; then
+		echo "Unexpected parity content"
+		echo "has:"
+		echo "$output"
+		echo "expect"
+		echo "$expect"
+	fi
+
+	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
+	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		echo "Error detected after the scrub"
+	fi
+	_scratch_dev_pool_put
+}
+
+workload raid5 2
+workload raid6 3
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/294.out b/tests/btrfs/294.out
new file mode 100644
index 00000000..c09531de
--- /dev/null
+++ b/tests/btrfs/294.out
@@ -0,0 +1,2 @@
+QA output created by 294
+Silence is golden
-- 
2.39.0

