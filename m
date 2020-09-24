Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C782770C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgIXMTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 08:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgIXMTN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 08:19:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600949952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9LE9r8pLqgG2N0ROqlMv3weqd2YWcEsxLWV3dT+q/ZI=;
        b=MonfHWOP96dKgLtySYoEMIlGkDu7Nu4Xo2fTY7teC3dfe6DHi0+a8aDSL6C9neau8AfOMv
        Qr9rrPkhjIZ9RZXwAfEGFlpfAdQIvbfHkX4ptBvaXEgMV45jpRHYyEjKCStiWlSAW7HTmw
        QcfnbXuQq5U8io/klLUgKixI4sA1Fpk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04F2AAEA2;
        Thu, 24 Sep 2020 12:19:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs/163: Fix recently broken test
Date:   Thu, 24 Sep 2020 15:19:10 +0300
Message-Id: <20200924121910.22477-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Upstream commit "btrfs: fix replace of seed device" broke btrfs/163 as
it disallowed replacing the seed device. Update the test to account for
this change in behavior.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

That commit still hasn't landed into upstream master but it's in misc-next hence
I discovered the failures. I guess this is really a heads up and will have to be
resubmitted when the commit is sent for upstream inclusion.

 tests/btrfs/163     | 13 +++++--------
 tests/btrfs/163.out |  4 ----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 24c725afb6b9..7140c1874165 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -4,7 +4,7 @@
 #
 # FS QA Test 163
 #
-# Test case to verify that a seed device can be replaced
+# Test case to verify that a seed device cannot be replaced
 #  Create a seed device
 #  Create a sprout device
 #  Remount RW
@@ -68,14 +68,11 @@ add_sprout()

 replace_seed()
 {
-	_run_btrfs_util_prog replace start -fB $dev_seed $dev_replace_tgt $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
-	_scratch_unmount
-	run_check _mount $dev_replace_tgt $SCRATCH_MNT
-	echo -- sprout --
-	od -x $SCRATCH_MNT/foobar
+	$BTRFS_UTIL_PROG replace start -fB $dev_seed $dev_replace_tgt $SCRATCH_MNT &> /dev/null
+	if [ $? -ne 1 ]; then
+		_fail "replace should have failed"
+	fi
 	_scratch_unmount
-
 }

 seed_is_mountable()
diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
index 91f6f5b6f48a..7890612fc630 100644
--- a/tests/btrfs/163.out
+++ b/tests/btrfs/163.out
@@ -3,7 +3,3 @@ QA output created by 163
 0000000 abab abab abab abab abab abab abab abab
 *
 20000000
--- sprout --
-0000000 abab abab abab abab abab abab abab abab
-*
-20000000
--
2.17.1

