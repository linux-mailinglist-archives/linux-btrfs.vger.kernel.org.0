Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9142424B277
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHTJa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 05:30:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:32860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgHTJaK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03CCEAC82;
        Thu, 20 Aug 2020 09:30:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs/205: Ignore output of chattr command
Date:   Thu, 20 Aug 2020 12:30:06 +0300
Message-Id: <20200820093006.26458-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With newer kernels, containing upstream commit f37c563bab42 ("btrfs:
add missing check for nocow and compression inode flags") chattr would
produce an error :

  /usr/bin/chattr: Invalid argument while setting flags on /media/scratch/foo1

That's due to the aforementioned commit making the checks stricter. This
is not critical for the purpose of the test so it can be safely
ignored.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/205 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 66355678f7d2..ab4261488ebe 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -48,7 +48,7 @@ run_tests()
     # extent. It has a file size of 128K.
     echo "Creating file foo1"
     touch $SCRATCH_MNT/foo1
-    $CHATTR_PROG +c $SCRATCH_MNT/foo1
+    $CHATTR_PROG +c $SCRATCH_MNT/foo1 > /dev/null 2>&1
     $XFS_IO_PROG -c "pwrite -S 0xab 0 4K" \
 		 -c "fsync" \
 		 -c "pwrite -S 0xab 4K 124K" \
-- 
2.17.1

