Return-Path: <linux-btrfs+bounces-1120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0181C338
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EA91C2201F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 02:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6815A7;
	Fri, 22 Dec 2023 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YfJBa7YW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0882EB8;
	Fri, 22 Dec 2023 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703213798; x=1734749798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xP20O8+JqbnE/XKB+Y2whoHfVBuh589Bwc6cVHL5Ysk=;
  b=YfJBa7YWY2i/9r3EsOt2fsTfV1HtRCfzcaGEv0ATUfj19mfvJJgmWa17
   JF3HPWm3rtAuPIkuUUsxFoZH3A3KxfpcoD6cs6n1IkxtQefCjdcdKS1tm
   Y0RRJmIh/+3QWwzbKMBTTcIpztXZLZVVcqPrQuWq7ql1e2SSsjTadq4bS
   Rd+z4ksatSSq9YL9R0mlyXSOR0sm1nTBIT14NBAlnvPLG/URaJ/HEj5l2
   vnAoDq92YPV35/17t1P1vfj8yJK6M44dJlaPmozuXqWCxF1/8KyarRhWb
   YUarJ8U/Yeb4pIqwEuFzi57mVhugtBIVRit/p8mSlIKWm9iJ1MrltrsXB
   Q==;
X-CSE-ConnectionGUID: O83zrGqFQIiDjPjpjmkhMQ==
X-CSE-MsgGUID: IK9LbvOHTlKKw4kkrf+ucg==
X-IronPort-AV: E=Sophos;i="6.04,294,1695657600"; 
   d="scan'208";a="5466067"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2023 10:56:31 +0800
IronPort-SDR: TkZjJlEKTBuDm315BziHtU8d6ciwllFKTWNddvNv2cnuRUvGht5UjvCM5CbeNMYDPKBGcgyoWZ
 JW1ze63Pp2aw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2023 18:07:13 -0800
IronPort-SDR: GrqgyqZeCBtN/EOYM2ScIfuT+Jr77fRUtLfTYioNrUclMH7qbxTQ/8vxQiNDE8JN9n9/JA3ulY
 lklF4eVu3fag==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.95])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Dec 2023 18:56:31 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: btrfs: use proper filter for subvolume deletion
Date: Fri, 22 Dec 2023 11:56:22 +0900
Message-ID: <727fc0e695846a43830bdfc2d6757d6edc2d6878.1703213691.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test cases btrfs/208, 233, 276 does not use _filter_btrfs_subvol_delete()
to process "btrfs subvolume delete" command's output. So, the following
diff occurs even with a previous fix.

btrfs/208       - output mismatch (see /host/btrfs/208.out.bad)
    --- tests/btrfs/208.out     2023-12-22 02:09:18.000000000 +0000
    +++ /host/btrfs/208.out.bad 2023-12-22 02:21:40.697036486 +0000
    @@ -6,12 +6,12 @@
     subvol1
     subvol2
     subvol3
    -Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
    +Delete subvolume 256 (no-commit): 'SCRATCH_MNT/subvol1'
     After deleting one subvolume:
     subvol2
    ...

Let them use the filter and fix the output accordingly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/208     | 2 +-
 tests/btrfs/208.out | 6 +++---
 tests/btrfs/233     | 3 ++-
 tests/btrfs/233.out | 4 ++--
 tests/btrfs/276     | 3 ++-
 tests/btrfs/276.out | 2 +-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/208 b/tests/btrfs/208
index 909f9fa40803..d58803e2f801 100755
--- a/tests/btrfs/208
+++ b/tests/btrfs/208
@@ -28,7 +28,7 @@ _delete_and_list()
 	local msg="$2"
 
 	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
-	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
+	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_btrfs_subvol_delete
 
 	echo "$msg"
 	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
diff --git a/tests/btrfs/208.out b/tests/btrfs/208.out
index 9b660699a4b2..dc5761ba1c87 100644
--- a/tests/btrfs/208.out
+++ b/tests/btrfs/208.out
@@ -6,12 +6,12 @@ Current subvolume ids:
 subvol1
 subvol2
 subvol3
-Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
+Delete subvolume 'SCRATCH_MNT/subvol1'
 After deleting one subvolume:
 subvol2
 subvol3
-Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
+Delete subvolume 'SCRATCH_MNT/subvol3'
 Last remaining subvolume:
 subvol2
-Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
+Delete subvolume 'SCRATCH_MNT/subvol2'
 All subvolumes removed.
diff --git a/tests/btrfs/233 b/tests/btrfs/233
index 2b94a9c6befe..f2c1eba090be 100755
--- a/tests/btrfs/233
+++ b/tests/btrfs/233
@@ -21,6 +21,7 @@ _cleanup()
 
 # Import common functions.
 . ./common/filter
+. ./common/filter.btrfs
 . ./common/dmflakey
 
 # real QA test starts here
@@ -77,7 +78,7 @@ create_subvol_with_orphan()
 	# open, delete the subvolume, then 'sync' to durably persist the orphan
 	# item for the subvolume.
 	exec 73< $SCRATCH_MNT/testsv/foobar
-	$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/testsv | _filter_scratch
+	$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/testsv | _filter_btrfs_subvol_delete
 	sync
 
 	# Now silently drop writes on the device, close the file descriptor and
diff --git a/tests/btrfs/233.out b/tests/btrfs/233.out
index 492e959d895c..2754e900834e 100644
--- a/tests/btrfs/233.out
+++ b/tests/btrfs/233.out
@@ -1,5 +1,5 @@
 QA output created by 233
 Create subvolume 'SCRATCH_MNT/testsv'
-Delete subvolume (no-commit): 'SCRATCH_MNT/testsv'
+Delete subvolume 'SCRATCH_MNT/testsv'
 Create subvolume 'SCRATCH_MNT/testsv'
-Delete subvolume (no-commit): 'SCRATCH_MNT/testsv'
+Delete subvolume 'SCRATCH_MNT/testsv'
diff --git a/tests/btrfs/276 b/tests/btrfs/276
index 6470a2f6e62e..f15f20824350 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -12,6 +12,7 @@
 _begin_fstest auto snapshot fiemap remount
 
 . ./common/filter
+. ./common/filter.btrfs
 . ./common/attr
 
 _supported_fs btrfs
@@ -130,7 +131,7 @@ echo "Number of non-shared extents in range [512K, 512K + 64K): $(count_not_shar
 echo "Number of non-shared extents in range [249M, 249M + 64K): $(count_not_shared_extents 249M 64K)"
 
 # Now delete the snapshot.
-$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap | _filter_btrfs_subvol_delete
 
 # We deleted the snapshot and committed the transaction used to delete it (-c),
 # but all its extents (both metadata and data) are actually only deleted in the
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 197d8edc62ac..352e06b4d4b2 100644
--- a/tests/btrfs/276.out
+++ b/tests/btrfs/276.out
@@ -10,5 +10,5 @@ Number of non-shared extents in the whole file: 2
 Number of shared extents in the whole file: 1998
 Number of non-shared extents in range [512K, 512K + 64K): 1
 Number of non-shared extents in range [249M, 249M + 64K): 1
-Delete subvolume (commit): 'SCRATCH_MNT/snap'
+Delete subvolume 'SCRATCH_MNT/snap'
 Number of non-shared extents in the whole file: 2000
-- 
2.43.0


