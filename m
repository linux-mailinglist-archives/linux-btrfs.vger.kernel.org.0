Return-Path: <linux-btrfs+bounces-5640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A979033D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A83290289
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC775172769;
	Tue, 11 Jun 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aslgnYCO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71C6138
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091307; cv=none; b=HHF6Y9qoupuPv5Xg8TxrfwYAcqej81MNcwjXLihYNQYPqMIDpwRqTJdBKx9XKLB3omz+q0RpJVCQ17DZHI+2qkWQsG9jpdJVtE/JNUp9mqh67VPan06kYORHI5C+wGuWT07o/kE569yuPLVf+85vYslNCTXLEb0rQskSARcn94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091307; c=relaxed/simple;
	bh=uuKzvEmLrj0R7UKffO2SVZQZsqNfMJO6UaFGOmEAZ8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBOQsFWgkUKQkARNS1+kXxYZ2WFtmOzoQ7CFg3QHE3xvisy+IF5uLMOldo669LRau0J6AfZgnXKd/hIPisj3uAjEGJxBLAjf4aaL9UWe/2SYBFTTR2sXjMPim0bz/Wpwt+l8VjrOCJqSZHg7yfPtbCtXGriJ1p2OG8fAz1iVfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aslgnYCO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AN2DOU001936;
	Tue, 11 Jun 2024 07:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=LKw29enKaNJ4gV
	duXpbdKV/g7BQISrKS7n/XxkKBiYc=; b=aslgnYCOQg/WLg/yMkv0BV04WsSKZQ
	i70YCXvFYRFcCdVJ5xrIQ3/UWSi472T15GuOSzyHbnegCZUW/B/6R3NYWbqJj3Oa
	2KfsmSEXzkEqP9+GHSpBc+G13iFYProXBnGOalCWflRXoU+lz4+SHsIZdV7JZ4SD
	jit2FdlTVNsq+iZPt3p4W2eILTYThQp5n9YMQ4I5NiJ4gwDX9o6KtFdv4VND0isc
	WrmWKbpR39Y86D5A9ub5z1BcNx81QvxKuvNjAz1+JpNBbbuHd0YXhk0LUlKqUaE2
	cPfQvEypadAc7HbTFHVTfRR3JCXrb0sTIjSJgY+Fg+fSqbt6j8izacew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1947m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:35:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B60GJO020366;
	Tue, 11 Jun 2024 07:35:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncau40en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:35:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45B7YxHa017744;
	Tue, 11 Jun 2024 07:34:59 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yncau40e3-1;
	Tue, 11 Jun 2024 07:34:59 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
Subject: [PATCH v2] btrfs-progs: tests: add convert test case for block number overflow
Date: Tue, 11 Jun 2024 07:34:43 +0000
Message-Id: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_03,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110056
X-Proofpoint-GUID: Y4H-6qz0q7jVEBF_nXcX04zZULQ2uO6N
X-Proofpoint-ORIG-GUID: Y4H-6qz0q7jVEBF_nXcX04zZULQ2uO6N

This test case will test whether btrfs-convert can handle ext4
filesystems that are largerthan or equal to 16TiB.

At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or
corrupts fs if 64 bit block numbers are not supported.

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 .../018-fs-size-overflow/test.sh              | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/convert-tests/018-fs-size-overflow/test.sh b/tests/convert-tests/018-fs-size-overflow/test.sh
index 1c2860fa..202e9039 100755
--- a/tests/convert-tests/018-fs-size-overflow/test.sh
+++ b/tests/convert-tests/018-fs-size-overflow/test.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# Check if btrfs-convert can handle an ext4 fs whose size is 64G.
-# That fs size could trigger a multiply overflow and screw up free space
+# Check if btrfs-convert can handle an ext4 fs whose size is 64G and 16T.
+# These fs sizes could trigger overflows and screw up free space
 # calculation
 
 source "$TEST_TOP/common" || exit
@@ -10,11 +10,17 @@ check_prereq btrfs-convert
 check_global_prereq mke2fs
 
 setup_root_helper
-prepare_test_dev 64g
 
-convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
-run_check_umount_test_dev
+for size in '64g' '16t'; do
+	prepare_test_dev $size
 
-# Unpatched btrfs-convert would fail half way due to corrupted free space
-# cache tree
-convert_test_do_convert
+	convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+	run_check_umount_test_dev
+
+	# Unpatched btrfs-convert would fail half way due to corrupted
+	# free space cache tree
+	convert_test_do_convert
+
+	run_check_mount_test_dev
+	run_check_umount_test_dev
+done
-- 
2.39.3


