Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F594723914
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjFFHc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjFFHcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 03:32:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C2118;
        Tue,  6 Jun 2023 00:32:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B56DC1FD63;
        Tue,  6 Jun 2023 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686036772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TTca/sPbbUfw2FLy3qyE8CN02PU1F/SvqpCiw53k+es=;
        b=EWSDDgg8Km3BkkIyRnSYdis5qfj9LuOuvSk6DwYtfmx4bq2dk2RxLLOT3yfFeUpeheRD9q
        jn0/WZpZQVdKKbmBwwBNBmxD6ue3hp/OtcRLe7Gf+Ovs6YlgbsIpMOgoDtu/CIud/Alff5
        fOvEiYyiXb1X/oQnSD3AgtEMOFe9jAk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAF9613519;
        Tue,  6 Jun 2023 07:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h+blKCPhfmShDwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 06 Jun 2023 07:32:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to verify the scrub error reports
Date:   Tue,  6 Jun 2023 15:32:33 +0800
Message-Id: <20230606073233.75900-1-wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

There is a regression in recent v6.4 cycle where a scrub rewrite changed
how we report errors, especially repairable errors.

Before the rewrite, we report the initial errors hit, and the amount of
repairable errors.
While after the rewrite, we no longer report the initial errors, but
only the number of repairable errors.

This behavior change is a regression, thus needs a test case to prevent
such problem from happening again.

The test case itself would:

- Create a btrfs using DUP data profile and 4K sector size

- Create a file with one 128K extent

- Corrupt the first mirror of that 128K extent

- Scrub and checks the detailed report
  Both corrected errors and csum errors should be 32.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/289     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/289.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/289
 create mode 100644 tests/btrfs/289.out

diff --git a/tests/btrfs/289 b/tests/btrfs/289
new file mode 100755
index 00000000..914b6280
--- /dev/null
+++ b/tests/btrfs/289
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 289
+#
+# Make sure btrfs-scrub reports errors correctly for repaired sectors.
+#
+. ./common/preamble
+_begin_fstest auto quick scrub repair
+
+# For filedefrag and all the filters
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_require_odirect
+# Overwriting data is forbidden on a zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+# The errors reported would be in the unit of sector, thus the number
+# is dependent on the sectorsize.
+_require_btrfs_support_sectorsize 4096
+
+# Create a single btrfs with DUP data profile, and create one 128K file.
+_scratch_mkfs -s 4k -d dup -b 1G >> $seqres.full 2>&1
+_scratch_mount
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" \
+	> /dev/null
+sync
+
+logical=$(_btrfs_get_first_logical "$SCRATCH_MNT/foobar")
+
+physical1=$(_btrfs_get_physical ${logical} 1)
+devpath1=$(_btrfs_get_device_path ${logical} 1)
+_scratch_unmount
+
+echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 128K" $devpath1 \
+	> /dev/null
+
+# Mount and do a scrub and compare the ouput
+_scratch_mount
+$BTRFS_UTIL_PROG scrub start -BR $SCRATCH_MNT >> $tmp.scrub_report 2>&1
+cat $tmp.scrub_report >> $seqres.full
+
+# Csum errors should be 128K/4K = 32
+csum_errors=$(grep "csum_errors" $tmp.scrub_report | awk '{print $2}')
+if [ $csum_errors -ne 32 ]; then
+	echo "csum_errors incorrect, expect 32 has $csum_errors"
+fi
+
+# And all errors should be repaired, thus corrected errors should also be 32. 
+corrected_errors=$(grep "corrected_errors" $tmp.scrub_report | awk '{print $2}')
+if [ $corrected_errors -ne 32 ]; then
+	echo "csum_errors incorrect, expect 32 has $corrected_errors"
+fi
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/289.out b/tests/btrfs/289.out
new file mode 100644
index 00000000..7d3b7f80
--- /dev/null
+++ b/tests/btrfs/289.out
@@ -0,0 +1,2 @@
+QA output created by 289
+Silence is golden
-- 
2.39.0

