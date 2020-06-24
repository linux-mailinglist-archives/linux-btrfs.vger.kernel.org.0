Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC62072A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 13:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbgFXLzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 07:55:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403793AbgFXLzt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 07:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3F99AED7;
        Wed, 24 Jun 2020 11:55:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jiachen YANG <farseerfc@gmail.com>
Subject: [PATCH 2/2] btrfs-progs: tests/convert: Add test case to make sure we won't allocate dev extents beyond device boundary
Date:   Wed, 24 Jun 2020 19:55:27 +0800
Message-Id: <20200624115527.855816-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624115527.855816-1-wqu@suse.com>
References: <20200624115527.855816-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test case to check if the converted fs has device extent beyond
boundary.

The disk layout of source ext4 fs needs some extents to make them
allocated at the very end of the fs.
The script is from the original reporter.

Also, since the existing convert tests always uses 512M as device size,
which is not suitable for this test case, make it to grab the existing
device size to co-operate with this test case.

Reported-by: Jiachen YANG <farseerfc@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common.convert                         | 14 ++++++++-
 tests/convert-tests/017-fs-near-full/test.sh | 30 ++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100755 tests/convert-tests/017-fs-near-full/test.sh

diff --git a/tests/common.convert b/tests/common.convert
index f24ceb0d6a64..0c918387758d 100644
--- a/tests/common.convert
+++ b/tests/common.convert
@@ -53,6 +53,16 @@ convert_test_preamble() {
 	echo "creating test image with: $@" >> "$RESULTS"
 }
 
+get_test_file_size() {
+	local path="$1"
+	local ret
+
+	ret=$(ls -l "$path" | cut -f5 -d\ )
+	if [ -z $ret ]; then
+		ret=512M
+	fi
+	echo $ret
+}
 #  prepare TEST_DEV before conversion, create filesystem and mount it, image
 #  size is 512MB
 #  $1: type of the filesystem
@@ -61,14 +71,16 @@ convert_test_prep_fs() {
 	local fstype
 	local force
 	local mountopts
+	local oldsize
 
 	fstype="$1"
 	shift
+	oldsize=$(get_test_file_size "$TEST_DEV")
 	# TEST_DEV not removed as the file might have special permissions, eg.
 	# when test image is on NFS and would not be writable for root
 	run_check truncate -s 0 "$TEST_DEV"
 	# 256MB is the smallest acceptable btrfs image.
-	run_check truncate -s 512M "$TEST_DEV"
+	run_check truncate -s $oldsize "$TEST_DEV"
 	force=
 	mountopts=
 	case "$fstype" in
diff --git a/tests/convert-tests/017-fs-near-full/test.sh b/tests/convert-tests/017-fs-near-full/test.sh
new file mode 100755
index 000000000000..9459729ee87f
--- /dev/null
+++ b/tests/convert-tests/017-fs-near-full/test.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# Check if btrfs-convert creates fs with dev extents boundary device boundary
+
+source "$TEST_TOP/common"
+source "$TEST_TOP/common.convert"
+
+setup_root_helper
+prepare_test_dev 1G
+check_prereq btrfs-convert
+check_global_prereq mke2fs
+check_global_prereq fallocate
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+
+# Use up 800MiB first
+for i in $(seq 1 4); do
+	run_check $SUDO_HELPER fallocate -l 200M "$TEST_MNT/file$i"
+done
+
+# Then add 5MiB for above files. These 5 MiB will be allocated near the very
+# end of the fs, to confuse btrfs-convert
+for i in $(seq 1 4); do
+	run_check $SUDO_HELPER fallocate -l 205M "$TEST_MNT/file$i"
+done
+
+run_check_umount_test_dev
+
+# convert_test_do_convert() will call btrfs check, which should expose any
+# invalid inline extent with too large size
+convert_test_do_convert
-- 
2.27.0

