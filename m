Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A9150D832
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 06:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiDYEZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 00:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbiDYEZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 00:25:34 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3D18E20;
        Sun, 24 Apr 2022 21:22:30 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1650860549; bh=+yV5Rt5WXhW6BEhpy/tbcgIFt1lLIIjou6qKbrAZOd8=;
        h=From:To:Cc:Subject:Date;
        b=Y75XfYfpIEtvIdZqr1VSAKDLE3GCXwp1Jlr7io3xbbQP3d9JWt6/YS8xj4sSaejWk
         ocKducEDSgs+bgiw8IUTN66mMpFue4DH51dPyRx1LaxdBsu4vCe1QMAdDss3XgKZIA
         wHHx0wF7vMmoZO4f4WbGa0IOLKkcP+ia79Y6blek=
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        nborisov@suse.com, fdmanana@kernel.org, dsterba@suse.com
Cc:     kernel@cccheng.net, shepjeng@gmail.com,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH v2] fstests: btrfs: test setting compression via xattr on nodatacow files
Date:   Mon, 25 Apr 2022 12:22:26 +0800
Message-Id: <20220425042226.302953-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 tests/btrfs/264     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/264.out | 11 ++++++
 2 files changed, 101 insertions(+)
 create mode 100755 tests/btrfs/264
 create mode 100644 tests/btrfs/264.out

diff --git a/tests/btrfs/264 b/tests/btrfs/264
new file mode 100755
index 00000000..bb11116c
--- /dev/null
+++ b/tests/btrfs/264
@@ -0,0 +1,90 @@
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
+_require_attrs
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+set_compression() # $1: filename, $2: alg
+{
+	[ -f "$1" ] || return
+	$SETFATTR_PROG -n "btrfs.compression" -v "$2" "$1" |& _filter_scratch
+}
+
+# FS_NOCOMP_FL bit isn't recognized by chattr/lsattr before e2fsprogs 1.46.2
+# In order to make this test available with an older version, we wrap the output
+# of lsattr to distinguish FS_COMP_FL and FS_NOCOMP_FL
+check_compression() # $1: filename
+{
+	$LSATTR_PROG -l "$1" | grep -q "Compression_Requested"
+
+	if [ $? -eq 0 ]; then
+		echo "$1: Compression is set" | _filter_scratch
+	else
+		echo "$1: Compression is not set" | _filter_scratch
+	fi
+}
+
+#
+# DATACOW
+#
+test_file="$SCRATCH_MNT/foo"
+touch "$test_file"
+$CHATTR_PROG -C "$test_file"
+
+set_compression "$test_file" zlib
+check_compression "$test_file"
+set_compression "$test_file" no
+check_compression "$test_file"
+set_compression "$test_file" lzo
+check_compression "$test_file"
+set_compression "$test_file" none
+check_compression "$test_file"
+set_compression "$test_file" zstd
+check_compression "$test_file"
+
+#
+# NODATACOW
+#
+test_file="$SCRATCH_MNT/bar"
+touch "$test_file"
+$CHATTR_PROG +C "$test_file"
+
+# all valid compression type are not allowed on nodatacow files
+set_compression "$test_file" zlib
+set_compression "$test_file" lzo
+set_compression "$test_file" zstd
+
+# no/none are also not allowed on nodatacow files
+set_compression "$test_file" no
+set_compression "$test_file" none
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/264.out b/tests/btrfs/264.out
new file mode 100644
index 00000000..7dd36054
--- /dev/null
+++ b/tests/btrfs/264.out
@@ -0,0 +1,11 @@
+QA output created by 264
+SCRATCH_MNT/foo: Compression is set
+SCRATCH_MNT/foo: Compression is not set
+SCRATCH_MNT/foo: Compression is set
+SCRATCH_MNT/foo: Compression is not set
+SCRATCH_MNT/foo: Compression is set
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
+setfattr: SCRATCH_MNT/bar: Invalid argument
-- 
2.25.1

