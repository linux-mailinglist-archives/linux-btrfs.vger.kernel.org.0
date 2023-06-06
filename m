Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C29D724033
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjFFK4k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjFFK4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:56:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738A30C5;
        Tue,  6 Jun 2023 03:52:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 663F21FD69;
        Tue,  6 Jun 2023 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686048738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wZj3O+PDmozWYaAuwiAm5tSKvqhIKJS3EmCxqqvSL+E=;
        b=K5vh3cUUAVo20gtH3VO9YhelRkP4cXOIu+wHlLmEee0/s2OSF6EOEv0+bLzs+QDISDFuq8
        UFYHMpuLAKfLRjBGq4r6J3maW6l6c6Zcp5FWgDxQgYgXjVLbxF0sZSC9Wt9LGsuwAGMxw2
        53kk0PzUzvbYCIEL8gy5xn8QWAdnhT0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A3A513776;
        Tue,  6 Jun 2023 10:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Od+aFeEPf2SgAwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 06 Jun 2023 10:52:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: add a test case to verify read-only scrub
Date:   Tue,  6 Jun 2023 18:52:00 +0800
Message-Id: <20230606105200.129464-1-wqu@suse.com>
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

There is a regression on btrfs read-only scrub behavior.

The commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
scrub_stripe infrastructure") makes btrfs scrub to ignore the read-only
flag completely, causing scrub to always fix the corruption.

This test case would create an fs with repairable corruptions, then run
a read-only scrub, and finally to make sure the corruption is not
repaired.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add _fixed_by_kernel_commit

- Reduce the golden output
  Instead of the first 512 bytes, the first 16 bytes are more than
  enough.

- Better golden output
  Add two more steps explaining what the test is doing.

- Output the offset for the file operation inside the fs
  The offset is fixed, no need to use _filter_xfs_io_offset.

- Remove the confusing comments on common/filter
---
 tests/btrfs/288     | 70 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/288.out |  9 ++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/btrfs/288
 create mode 100644 tests/btrfs/288.out

diff --git a/tests/btrfs/288 b/tests/btrfs/288
new file mode 100755
index 00000000..52245895
--- /dev/null
+++ b/tests/btrfs/288
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 288
+#
+# Make sure btrfs-scrub respects the read-only flag.
+#
+. ./common/preamble
+_begin_fstest auto repair quick volume scrub
+
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch_dev_pool 2
+
+
+_require_odirect
+# Overwriting data is forbidden on a zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: scrub: respect the read-only flag during repair"
+
+_scratch_dev_pool_get 2
+
+# Step 1, create a raid btrfs with one 128K file
+echo "step 1......mkfs.btrfs"
+_scratch_pool_mkfs -d raid1 -b 1G >> $seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
+	_filter_xfs_io
+
+# Step 2, corrupt one mirror so we can still repair the fs.
+echo "step 2......corrupt one mirror"
+# ensure btrfs-map-logical sees the tree updates
+sync
+
+logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
+
+physical1=$(_btrfs_get_physical ${logical} 1)
+devpath1=$(_btrfs_get_device_path ${logical} 1)
+
+_scratch_unmount
+
+echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 64K" $devpath1 \
+	> /dev/null
+
+# Step 3, do a read-only scrub, which should not fix the corruption.
+echo "step 3......do a read-only scrub"
+_scratch_mount -o ro
+$BTRFS_UTIL_PROG scrub start -BRrd $SCRATCH_MNT >> $seqres.full 2>&1
+_scratch_unmount
+
+# Step 4, make sure the corruption is still there
+echo "step 4......verify the corruption is not repaired"
+echo "  the first 16 bytes of the extent at mirror 1:"
+$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
+	_filter_xfs_io_offset
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
new file mode 100644
index 00000000..452bdc67
--- /dev/null
+++ b/tests/btrfs/288.out
@@ -0,0 +1,9 @@
+QA output created by 288
+step 1......mkfs.btrfs
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+step 2......corrupt one mirror
+step 3......do a read-only scrub
+step 4......verify the corruption is not repaired
+  the first 16 bytes of the extent at mirror 1:
+XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ................
-- 
2.39.0

