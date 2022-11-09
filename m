Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1DB622389
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 06:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKIFrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 00:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIFro (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 00:47:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739121DF3A;
        Tue,  8 Nov 2022 21:47:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1E2C1F37F;
        Wed,  9 Nov 2022 05:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667972861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r7TCDm9fjp93B4cfyQyiwpeid2KNi7OLMiTe9FQ3Rz8=;
        b=k4HungjjkENk+BQRaHP/K2oaBqyWu86VKJ2zfNAIj5shAkhwjoFpWNtven2UHLyMvPXoMa
        GTQnYFvseP6az3ljZjTNEa95lyqL5z+JN2yeuPzaEX4Fbm7LtBuEC0WtAe5MaOx4WqVmM8
        xBt8Ue3wsjwuvO9+mRPusBMw3otYL0s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF5BC1376E;
        Wed,  9 Nov 2022 05:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LiRaIfw+a2MNAgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 09 Nov 2022 05:47:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: add a regression test case to make sure scrub can detect errors
Date:   Wed,  9 Nov 2022 13:47:23 +0800
Message-Id: <20221109054723.38635-1-wqu@suse.com>
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
Changelog:
v2:
- Remove include for common/btrfs
  Which is included by default.

- Add comment for why including common/filter
  Needed by _btrfs_get_*() helpers.

- Migrated to btrfs/278
  Which is the latest result by "./new btrfs" on for-next branch.

- Add "-s 4k" for _scratch_mkfs
  To support systems with larger page sizes.

- Remove comments from the template
---
 tests/btrfs/281     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/281.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/btrfs/281
 create mode 100644 tests/btrfs/281.out

diff --git a/tests/btrfs/281 b/tests/btrfs/281
new file mode 100755
index 00000000..69b5ac02
--- /dev/null
+++ b/tests/btrfs/281
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
+# larger block size for data extent scrub"), which makes btrfs scrub unable
+# to detect corruption if it's not the first sector of an data extent.
+#
+
+. ./common/preamble
+_begin_fstest auto quick scrub
+
+# For _btrfs_get_*() helpers which needs filtering.
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+
+# Need to use 4K as sector size
+_require_btrfs_support_sectorsize 4096
+_require_scratch
+
+_scratch_mkfs -s 4k >> $seqres.full
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
diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
new file mode 100644
index 00000000..3678e27f
--- /dev/null
+++ b/tests/btrfs/281.out
@@ -0,0 +1,2 @@
+QA output created by 281
+Silence is golden
-- 
2.38.0

