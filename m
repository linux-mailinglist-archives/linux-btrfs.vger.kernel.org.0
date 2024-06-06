Return-Path: <linux-btrfs+bounces-5501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66448FE461
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0541C24EDB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EC194C8A;
	Thu,  6 Jun 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AwGzVZ1G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839031E52A
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669994; cv=none; b=C/hjL1PXCY8dOFK9LyXl4WYK/4kj+eqFELqquv848wmIYgxrNEI0kZfC8SLQs9Zefh4NfbwKDJYYrPrkGdeiW3B1eq0viEXXYFy9E09v/DXoj4Hlq0tUdWcJlq6whXXSoe5bdKhFy654XVkZqTOFhEvx+WcHtcqQ+sS4vJHkbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669994; c=relaxed/simple;
	bh=1XbXXZ7KjOkXXXxamrw0zVF6hEiYrH4HxlYVlyst96g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uZoL00bw6GmyYGFHzcY9JCjhkxrCxkgfEUd8j1yGOLfkH0KFwcp8BwTg4VCLokTkjg5B0lPUbL4G1xD9m/odW7w15mPElK4f+R/MG3vsK1MRI/lrSTOqGOOHeV6bZAjFlaTyY+CJA8inZuiBtktxrcUMx+McjUoN99x7IZqHK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AwGzVZ1G; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iMKk016280;
	Thu, 6 Jun 2024 10:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=SGMKYIBeaRk49ZRB+ZjG3wRM0l/aQZbWb0We8sDIwwY=;
 b=AwGzVZ1GFIHxpMlYHSU2O3aeOkdyWQr2ADjhsxitK1K+NE6LzvCB00OvpSIQ0m9gqTnG
 f3Efv6eShojY27n8Mu2yanNSzVSyzuIVtTq9+chwF4CzuIng9QUy6DXfgPefUCXlt085
 Mz4bRheW1iRmZY5ustovPftqhpa4LsKlc9tmrHZv5kuvaT+fq09Nh6qwZeI+pHDR6QYl
 dGuXARvU9YLWaXWtzCS1AVV1ycztqKO1y5sgN8BfijgAhYo4QgI+I5KV5slXKQ3L5YuW
 +bVmWmKFNOM16FSOBEELxfHNdNTUOD9cwZSqkcDOI/epz8ugtRn90C7PyEGJ1/id8HGl jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhb7ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:33:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4568Vwep016183;
	Thu, 6 Jun 2024 10:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrscv688-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:33:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456AX2Nw033408;
	Thu, 6 Jun 2024 10:33:02 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ygrscv5wv-1;
	Thu, 06 Jun 2024 10:33:02 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH] btrfs-progs: tests: add convert test case for block number overflow
Date: Thu,  6 Jun 2024 10:32:28 +0000
Message-Id: <20240606103228.3697282-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060077
X-Proofpoint-GUID: 9Bsp637wR7WhhaGTkyv9LduSOAN08yS0
X-Proofpoint-ORIG-GUID: 9Bsp637wR7WhhaGTkyv9LduSOAN08yS0

This test cases will test whether btrfs-convert can handle ext4
filesystems that are largerthan 16TiB.

At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or
corrupts fs if 64 bit block numbers are not supported.

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 .../025-64-bit-block-numbers/test.sh          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/convert-tests/025-64-bit-block-numbers/test.sh

diff --git a/tests/convert-tests/025-64-bit-block-numbers/test.sh b/tests/convert-tests/025-64-bit-block-numbers/test.sh
new file mode 100755
index 00000000..0eb6bb49
--- /dev/null
+++ b/tests/convert-tests/025-64-bit-block-numbers/test.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# Check if btrfs-convert can handle 64 bit block numbers in an ext4 fs.
+# At 16TiB block numbers overflow 32 bits and screw up total size and used
+# space calculation
+
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_prereq btrfs-convert
+check_global_prereq mke2fs
+
+setup_root_helper
+prepare_test_dev 16t
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check_umount_test_dev
+
+convert_test_do_convert
+run_check_mount_test_dev
+run_check_umount_test_dev
-- 
2.39.3


