Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13372246775
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHQNkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 09:40:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgHQNka (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 09:40:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC89FB1D7;
        Mon, 17 Aug 2020 13:40:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs/024: Remove no longer valid test
Date:   Mon, 17 Aug 2020 16:40:26 +0300
Message-Id: <20200817134026.15453-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817103718.10239-1-nborisov@suse.com>
References: <20200817103718.10239-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel commit "btrfs: add missing check for nocow and compression inode
flags" invalidates the "file compressed, fs mounted with nodatacow"
mode due to doing more rigorous flags validation, just remove the test.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Also remove the output

 tests/btrfs/024     | 7 -------
 tests/btrfs/024.out | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/tests/btrfs/024 b/tests/btrfs/024
index 0c2ffd7389ab..bcb9048da636 100755
--- a/tests/btrfs/024
+++ b/tests/btrfs/024
@@ -42,13 +42,6 @@ __workout()
 	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $work_file | _filter_xfs_io
 }

-echo "*** test nodatacow"
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount "-o nodatacow"
-__workout
-_scratch_unmount
-_check_scratch_fs
-
 echo "*** test compress=no"
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount "-o compress=no"
diff --git a/tests/btrfs/024.out b/tests/btrfs/024.out
index 7eacb0aca674..33c4f49366fd 100644
--- a/tests/btrfs/024.out
+++ b/tests/btrfs/024.out
@@ -1,7 +1,4 @@
 QA output created by 024
-*** test nodatacow
-wrote 1048576/1048576 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** test compress=no
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
--
2.17.1

