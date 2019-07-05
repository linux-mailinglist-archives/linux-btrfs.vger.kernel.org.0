Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE360171
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfGEH1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfGEH1J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 03:27:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFD5DAFCB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 07:27:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: mkfs-tests: Skip 010-minimal-size if we can't mount with 4k sector size
Date:   Fri,  5 Jul 2019 15:26:49 +0800
Message-Id: <20190705072651.25150-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190705072651.25150-1-wqu@suse.com>
References: <20190705072651.25150-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Test case 010-minimal-size fails on aarch64 with 64K page size:
      [TEST/mkfs]   010-minimal-size
  failed: /home/adam/btrfs-progs/mkfs.btrfs -f -n 4k -m single -d single /home/adam/btrfs-progs/tests//test.img
  test failed for case 010-minimal-size
  make: *** [Makefile:361: test-mkfs] Error 1

[CAUSE]
Mkfs.btrfs defaults to page size as sector size. However this test uses
4k, 16k, 32K and 64K as node size. 4K node size will conflict with 64K
sector size.

[FIX]
- Specify sector size 4K manually
  So at least no conflict at mkfs time.

- Skip the test case if kernel can't mount with 4k sector size
  So once we add such support, the test can be automatically re-enabled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/010-minimal-size/test.sh | 41 ++++++++++++-----------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tests/mkfs-tests/010-minimal-size/test.sh b/tests/mkfs-tests/010-minimal-size/test.sh
index 8480e4c5ae23..b49fad63e519 100755
--- a/tests/mkfs-tests/010-minimal-size/test.sh
+++ b/tests/mkfs-tests/010-minimal-size/test.sh
@@ -5,6 +5,7 @@ source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
 check_prereq btrfs
+check_prereq_mount_with_sectorsize 4096
 
 setup_root_helper
 
@@ -24,20 +25,20 @@ do_test()
 	run_check_umount_test_dev
 }
 
-do_test -n 4k	-m single	-d single
-do_test -n 4k	-m single	-d dup
-do_test -n 4k	-m dup		-d single
-do_test -n 4k	-m dup		-d dup
+do_test -s 4k	-n 4k	-m single	-d single
+do_test -s 4k	-n 4k	-m single	-d dup
+do_test -s 4k	-n 4k	-m dup		-d single
+do_test -s 4k	-n 4k	-m dup		-d dup
 
-do_test -n 8k	-m single	-d single
-do_test -n 8k	-m single	-d dup
-do_test -n 8k	-m dup		-d single
-do_test -n 8k	-m dup		-d dup
+do_test -s 4k	-n 8k	-m single	-d single
+do_test -s 4k	-n 8k	-m single	-d dup
+do_test -s 4k	-n 8k	-m dup		-d single
+do_test -s 4k	-n 8k	-m dup		-d dup
 
-do_test -n 16k	-m single	-d single
-do_test -n 16k	-m single	-d dup
-do_test -n 16k	-m dup		-d single
-do_test -n 16k	-m dup		-d dup
+do_test -s 4k	-n 16k	-m single	-d single
+do_test -s 4k	-n 16k	-m single	-d dup
+do_test -s 4k	-n 16k	-m dup		-d single
+do_test -s 4k	-n 16k	-m dup		-d dup
 
 # Temporary: disable the following tests as they fail inside travis but run
 # fine otherwise. This is probably caused by kernel version, 4.4 fails and 4.14
@@ -52,12 +53,12 @@ if [ "$TRAVIS" = true ]; then
 	exit 0
 fi
 
-do_test -n 32k	-m single	-d single
-do_test -n 32k	-m single	-d dup
-do_test -n 32k	-m dup		-d single
-do_test -n 32k	-m dup		-d dup
+do_test -s 4k	-n 32k	-m single	-d single
+do_test -s 4k	-n 32k	-m single	-d dup
+do_test -s 4k	-n 32k	-m dup		-d single
+do_test -s 4k	-n 32k	-m dup		-d dup
 
-do_test -n 64k	-m single	-d single
-do_test -n 64k	-m single	-d dup
-do_test -n 64k	-m dup		-d single
-do_test -n 64k	-m dup		-d dup
+do_test -s 4k	-n 64k	-m single	-d single
+do_test -s 4k	-n 64k	-m single	-d dup
+do_test -s 4k	-n 64k	-m dup		-d single
+do_test -s 4k	-n 64k	-m dup		-d dup
-- 
2.22.0

