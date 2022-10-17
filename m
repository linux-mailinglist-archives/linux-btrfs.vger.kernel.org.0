Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCEA600956
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJQIx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJQIxr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 04:53:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFC51432;
        Mon, 17 Oct 2022 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665996811; x=1697532811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LAONLYRjo7/1/uQIlGes6cYkpVzymdDrWR+LAqv5L1Q=;
  b=qgGBI3OZC1Cc16mOJEDwstTBm0goaQUN6lh0pkXNe+PIPQJqVA6rE45a
   0KeQ7LpJNYU0uQSq7yvffQLZAkyzRFtk7jYR8jlbq0yguvAAihBTYOJsz
   xkDfLWjX3RPbLYR0VixtrkUliC9KlOPygonzvLxY1/Hhl5rVy+i6I4EI3
   jT/Bnbq9xDyBRjG8GRz05KEi2A2SHPgn5W8TpbWfHEvmOkTSUK29VLxK5
   xrIufcdAAq3encXTAlDTFAb/LO9302pKYs+5i5TkogHzRh7XvszyyLHqz
   22Ma+/Q7n9RLHg0MmnAGuCKw4P+g5f/hUwvDhI1lXfim91+m4QIESLnIG
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212326792"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 16:53:25 +0800
IronPort-SDR: aC6O7N1PxzmjPtewjuTusuM6n9SI4SyweGa2BBBHK0pK8kyLUD6pE4A2vaCf+fCDE9MjSugv43
 gEpgjVw2CXt9OQMGREnrOfYEqsgHa0uzllqUXphJHXXQU1ZbMO/bCE0ssdWxqfHOSgSv0jKyLx
 ZcdL9sXC6p+7qdKGKm64alCxJyT7foH73Ty+i1NTqGDs8IKQcj5sFVy4WDqq2eYVJI1lRoFOV7
 nz9SL73fvUn/0LrYrzzVgkQN8QQETWB2vPXxzYcF5XD1LaaNBnu8x8x29t+mxHA2Ez+ABZ5agR
 pVDxfzWaSKgbgv7ilpsPrxcU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 01:07:19 -0700
IronPort-SDR: LeWC79a/eFzSjUPPkBEKbI4SOfi4IkK2O+bJfKbYv2yF1AOKPHw+TuCVAyv4moAO8SzML5ANbj
 l4M0Ghj3RzGb7ghhcnkcf7DZE206AV0g8rA5b24btPgvzZGvLrxuICVMOMvEGywPo4CHl5VNsI
 iglfQHcWliPA2yC3cpvODiZ/ig6TpinqQVeYSc1SZLnkcewKmtoKJ6B1xOfQ+zohRUHw9YK9tD
 r6LjpwfDZoJg0vVZsVpEE5lqb+kYqVBR6FoSLIBGqERxdCQGDtQav/lKEZTfTF9M/TGtoUSkNq
 MRI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 01:53:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] fstests: add btrfs tests exercising raid to the raid group
Date:   Mon, 17 Oct 2022 01:53:17 -0700
Message-Id: <20221017085317.96172-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several tests for btrfs exercise the raid code, but are not added to the
raid group. Most of these tests pull in raid via
'_btrfs_get_profile_configs()'.

Other tests have a '_require_btrfs_fs_feature raid56' which also pulls in
raid, but are not added to the raid group.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/027 | 2 +-
 tests/btrfs/060 | 2 +-
 tests/btrfs/061 | 2 +-
 tests/btrfs/062 | 2 +-
 tests/btrfs/063 | 2 +-
 tests/btrfs/064 | 2 +-
 tests/btrfs/065 | 2 +-
 tests/btrfs/066 | 2 +-
 tests/btrfs/067 | 2 +-
 tests/btrfs/068 | 2 +-
 tests/btrfs/069 | 2 +-
 tests/btrfs/070 | 2 +-
 tests/btrfs/071 | 2 +-
 tests/btrfs/072 | 2 +-
 tests/btrfs/073 | 2 +-
 tests/btrfs/074 | 2 +-
 tests/btrfs/125 | 2 +-
 tests/btrfs/148 | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 46c14b9c1c1f..b6d049dec3b3 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -7,7 +7,7 @@
 # Test replace of a missing device on various data and metadata profiles.
 #
 . ./common/preamble
-_begin_fstest auto replace volume
+_begin_fstest auto replace volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 26db8a9bee20..cdf41074096a 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -8,7 +8,7 @@
 # with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance subvol
+_begin_fstest auto balance subvol raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index 55f5625b5490..0a3b2d766f9c 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance scrub
+_begin_fstest auto balance scrub raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 47b0b9373f33..467177a1ffe8 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance defrag compress
+_begin_fstest auto balance defrag compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index c96390b9315c..0a023ded65da 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -8,7 +8,7 @@
 # simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance remount compress
+_begin_fstest auto balance remount compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 741161889150..e34713c7ee00 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -10,7 +10,7 @@
 # run simultaneously. One of them is expected to fail when the other is running.
 
 . ./common/preamble
-_begin_fstest auto balance replace volume
+_begin_fstest auto balance replace volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index 4ebf93267a59..ab5febef8410 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol replace volume
+_begin_fstest auto subvol replace volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index 8d12af616d89..9f3899385400 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol scrub
+_begin_fstest auto subvol scrub raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 44803f9faf7f..de056969dd8a 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol defrag compress
+_begin_fstest auto subvol defrag compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index e03a4891ec89..cd10a87d2f26 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -9,7 +9,7 @@
 # in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol remount compress
+_begin_fstest auto subvol remount compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 6e798a2e5061..5f5b098452af 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace scrub volume
+_begin_fstest auto replace scrub volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index dcf978b36b0c..9f2f8d55d265 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace defrag compress volume
+_begin_fstest auto replace defrag compress volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index cd1de2642a96..e65871902b46 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -8,7 +8,7 @@
 # algorithms simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace remount compress volume
+_begin_fstest auto replace remount compress volume raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index bcb0ea2546a6..423b087f9821 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto scrub defrag compress
+_begin_fstest auto scrub defrag compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index 26c5deb6c2a2..27b67198451e 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -8,7 +8,7 @@
 # simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto scrub remount compress
+_begin_fstest auto scrub remount compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index dc26d8c02497..3f254ab7d310 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -8,7 +8,7 @@
 # simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto defrag remount compress
+_begin_fstest auto defrag remount compress raid
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index b58f2aa282bd..51526f745c84 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -22,7 +22,7 @@
 # Verify if all three checkpoints match
 #
 . ./common/preamble
-_begin_fstest replace volume balance
+_begin_fstest replace volume balance raid
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 510e46dc0826..7bd122e0b08f 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -7,7 +7,7 @@
 # Test that direct IO writes work on RAID5 and RAID6 filesystems.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw raid
 
 # Import common functions.
 . ./common/filter
-- 
2.37.3

