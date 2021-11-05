Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23759446694
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhKEQC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhKEQC1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 12:02:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DAFC061714;
        Fri,  5 Nov 2021 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dWAKzwL4gFmQQYp+iU6yFg3aFWLfXPbBVt1K+FrJLi4=; b=DNf0g2+q1im7BVIFpoOPDmc/H/
        NDmV9v4gaEd/E0xDnBeJnySzOGhRpLyx45rfKH2wCh1mK77VT4a6Ui+SESQ1ydETnZ7l2aSti0IpR
        uR4+kDUHxWvovzlHZaUv+H1iy51DGdh9vCROGYWfYpvbODGkAu1C+kbu2R0hzWi5ssvgSS+DjhDKi
        /cKlC4SPPkl2Jt7mWH1J7gytll2x/TGaHyDq55iRbXrcue2SK+39XCA0yK/9BUv6eTaMbklHj+6IO
        vy9F2ChZ0T6f5WzyXfdVDn9qQo1SDfLWFp1epL2IBofHPICMEXCW0VoS09mxB0PZO3WP/mjCjpmmv
        d7AOzM/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj1d5-00BrvF-OV; Fri, 05 Nov 2021 15:59:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, fdmanana@gmail.com, nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] common/btrfs: source module file and remove duplicates
Date:   Fri,  5 Nov 2021 08:59:47 -0700
Message-Id: <20211105155947.2828825-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/249 fails with:

QA output created by 249
./common/btrfs: line 425: _require_loadable_fs_module: command not found
./common/btrfs: line 432: _reload_fs_module: command not found
ERROR: not a btrfs filesystem: /media/scratch

This is because the test is failing to source common/module.
Fix this by sourcing common/module in the btrfs common file.

While it it remove duplication of sourcing this file from other
tests in btrfs so that this is only done once in one place.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/btrfs    | 2 ++
 tests/btrfs/124 | 1 -
 tests/btrfs/125 | 1 -
 tests/btrfs/163 | 1 -
 tests/btrfs/164 | 3 ---
 tests/btrfs/219 | 1 -
 tests/btrfs/225 | 1 -
 tests/btrfs/242 | 1 -
 8 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 5d938c19..2eab4b29 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -2,6 +2,8 @@
 # Common btrfs specific functions
 #
 
+. common/module
+
 _btrfs_get_subvolid()
 {
 	mnt=$1
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 5c05ffae..8771a3c1 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -35,7 +35,6 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
-. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index e46b194d..b6a28f5c 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -34,7 +34,6 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
-. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 76553831..1dc081f1 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -27,7 +27,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 . ./common/filter.btrfs
-. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 59a9c90e..3e69b35f 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -20,9 +20,6 @@ _cleanup()
 	_btrfs_rescan_devices
 }
 
-# Import common functions.
-. ./common/module
-
 # real QA test starts here
 
 # Modify as appropriate.
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 1cd5daae..528175b8 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -35,7 +35,6 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
-. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index ce1818db..408c03d2 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -25,7 +25,6 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
-. ./common/module
 
 # real QA test starts here
 
diff --git a/tests/btrfs/242 b/tests/btrfs/242
index e1c102ae..6ce62081 100755
--- a/tests/btrfs/242
+++ b/tests/btrfs/242
@@ -13,7 +13,6 @@ _begin_fstest auto quick volume trim
 
 # Import common functions.
 . ./common/filter
-. ./common/module
 
 # real QA test starts here
 _supported_fs btrfs
-- 
2.33.0

