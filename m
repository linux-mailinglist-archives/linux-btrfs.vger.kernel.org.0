Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DB504D51
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiDRH5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiDRH5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:57:13 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ADD18E0B;
        Mon, 18 Apr 2022 00:54:34 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650268473; bh=Jz2eMMQAhnbNGZNxPFQoSbgYpFPjCnIQgOWtoVcPH+M=;
        h=From:To:Cc:Subject:Date;
        b=dbx0NHdyGLboJvr9v48gzOrULFc5bslqfnQ1Xa8GqZiGAeRjoGvz0xoHrs0unNWn5
         vQZ3aus1D+7VIdvUMGNK6IK9ynx3rFM7K8eKtccAa0JFUjfE/eoX2VXLuXYBaoSK/y
         QBClJUUUW60uluxqyRGwOK+g0/EAuBoiH3eRtErY=
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        nborisov@suse.com, fdmanana@kernel.org, dsterba@suse.com
Cc:     shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] fstests: btrfs: test setting compression via xattr on nodatacow files
Date:   Mon, 18 Apr 2022 15:54:30 +0800
Message-Id: <20220418075430.484158-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Compression and nodatacow are mutually exclusive. Besides ioctl, there
is another way to setting compression via xattrs, and shouldn't produce
invalid combinations.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 tests/btrfs/264     | 76 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/264.out | 15 +++++++++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/btrfs/264
 create mode 100644 tests/btrfs/264.out

diff --git a/tests/btrfs/264 b/tests/btrfs/264
new file mode 100755
index 000000000000..42bfcd4f93a0
--- /dev/null
+++ b/tests/btrfs/264
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Synology Inc. All Rights Reserved.
+#
+# FS QA Test No. 264
+#
+# Compression and nodatacow are mutually exclusive. Besides ioctl, there
+# is another way to setting compression via xattrs, and shouldn't produce
+# invalid combinations.
+#
+# To prevent mix any compression-related options with nodatacow, FS_NOCOMP_FL
+# is also rejected by ioctl as well as FS_COMPR_FL on nodatacow files. To
+# align with it, no and none are also unacceptable in this test.
+#
+# The regression is fixed by a patch with the following subject:
+#   btrfs: do not allow compression on nodatacow files
+#
+. ./common/preamble
+_begin_fstest auto quick compress attr
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_chattr C
+_require_chattr c
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+#
+# DATACOW
+#
+test_file="$SCRATCH_MNT/foo"
+touch "$test_file"
+$CHATTR_PROG -C "$test_file"
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+
+$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+
+
+#
+# NODATACOW
+#
+test_file="$SCRATCH_MNT/bar"
+touch "$test_file"
+$CHATTR_PROG +C "$test_file"
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+
+# all valid compression type are not allowed on nodatacow files
+$SETFATTR_PROG -n "btrfs.compression" -v zlib "$test_file" |& _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v lzo  "$test_file" |& _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v zstd "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+
+# no/none are also not allowed on nodatacow files
+$SETFATTR_PROG -n "btrfs.compression" -v no   "$test_file" |& _filter_scratch
+$SETFATTR_PROG -n "btrfs.compression" -v none "$test_file" |& _filter_scratch
+$LSATTR_PROG -l "$test_file" | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
new file mode 100644
index 000000000000..82c551411411
--- /dev/null
+++ b/tests/btrfs/264.out
@@ -0,0 +1,15 @@
+QA output created by 264
+SCRATCH_MNT/foo ---
+SCRATCH_MNT/foo Compression_Requested
+SCRATCH_MNT/foo ---
+SCRATCH_MNT/foo Compression_Requested
+SCRATCH_MNT/foo ---
+SCRATCH_MNT/foo Compression_Requested
+SCRATCH_MNT/bar No_COW
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+SCRATCH_MNT/bar No_COW
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+SCRATCH_MNT/bar No_COW
-- 
2.34.1

