Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E261E7BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKFXyJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 18:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKFXyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 18:54:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF6BB850;
        Sun,  6 Nov 2022 15:54:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6EF11F91B;
        Sun,  6 Nov 2022 23:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667778846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b9UcyMo3LiUER9tMmSUxrQ06Q7pH0IMo7qg6f2paMrQ=;
        b=CHE1vsdXX56PMuu3rBT26axG7CHMEnCUjL4E7aBMV2q6MBVTtibyZa7ersPGcrNzgnZMme
        cpVaTeRLN2m5D/shFspcb4KMqcPItYgcuzON5bQ2GxKej1SViAJMWq9fq4cHpYy/+ed+EZ
        mv+7ZGfe2zuP8oJj/hYy6FxVx/WGv3o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7B95132E7;
        Sun,  6 Nov 2022 23:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5SJEHx1JaGMWTQAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 06 Nov 2022 23:54:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a regression test case to make sure scrub can detect errors
Date:   Mon,  7 Nov 2022 07:53:48 +0800
Message-Id: <20221106235348.9732-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
from detecting corruption (thus no repair either).

The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
larger block size for data extent scrub").

The new test case will:

- Create a data extent with 2 sectors
- Corrupt the second sector of above data extent
- Scrub to make sure we detect the corruption

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/278.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/278
 create mode 100644 tests/btrfs/278.out

diff --git a/tests/btrfs/278 b/tests/btrfs/278
new file mode 100755
index 00000000..ebbf207a
--- /dev/null
+++ b/tests/btrfs/278
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 278
+#
+# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
+# larger block size for data extent scrub"), which makes btrfs scrub unable
+# to detect corruption if it's not the first sector of an data extent.
+#
+. ./common/preamble
+_begin_fstest auto quick scrub
+
+# Import common functions.
+. ./common/filter
+. ./common/btrfs
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+
+# Need to use 4K as sector size
+_require_btrfs_support_sectorsize 4096
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+# Create a data extent with 2 sectors
+$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
+sync
+
+first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
+echo "logical of the first sector: $first_logical" >> $seqres.full
+
+second_logical=$(( $first_logical + 4096 ))
+echo "logical of the second sector: $second_logical" >> $seqres.full
+
+second_physical=$(_btrfs_get_physical $second_logical 1)
+echo "physical of the second sector: $second_physical" >> $seqres.full
+
+second_dev=$(_btrfs_get_device_path $second_logical 1)
+echo "device of the second sector: $second_dev" >> $seqres.full
+
+_scratch_unmount
+
+# Corrupt the second sector of the data extent.
+$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
+_scratch_mount
+
+# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
+# it will output an error message.
+$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
+cat $tmp.output >> $seqres.full
+_scratch_unmount
+
+if ! grep -q "csum=1" $tmp.output; then
+	echo "Scrub failed to detect corruption"
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
new file mode 100644
index 00000000..b4c4a95d
--- /dev/null
+++ b/tests/btrfs/278.out
@@ -0,0 +1,2 @@
+QA output created by 278
+Silence is golden
-- 
2.38.0

