Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4714922C5F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXNMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 09:12:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgGXNMy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 09:12:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 834E0B016;
        Fri, 24 Jul 2020 13:13:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     guan@eryu.me
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs/162: Stop using device mount option
Date:   Fri, 24 Jul 2020 16:12:50 +0300
Message-Id: <20200724131250.3377-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs is clever enough to figure out which devices constitute the sprout
fs even without specifying them explicitly with -o device. Additionally,
explicitly settings the devices via -o device reduces coverage of the
test since it didn't detect breakage a local change introduced. Without
-o device instead this breakage was detected.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/162 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/162 b/tests/btrfs/162
index 7f119be057b7..ff3c50b1be54 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -69,11 +69,10 @@ create_sprout_seed()
 
 create_next_sprout()
 {
-	run_check _mount -o device=$dev_seed $dev_sprout_seed $SCRATCH_MNT
+	run_check _mount $dev_sprout_seed $SCRATCH_MNT
 	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
 	_scratch_unmount
-	run_check _mount -o device=$dev_seed,device=$dev_sprout_seed \
-		$dev_sprout $SCRATCH_MNT
+	run_check _mount $dev_sprout $SCRATCH_MNT
 	echo -- sprout --
 	od -x $SCRATCH_MNT/foobar
 }
-- 
2.17.1

