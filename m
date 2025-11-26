Return-Path: <linux-btrfs+bounces-19358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23EC898B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76B1F351CB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F33242D8;
	Wed, 26 Nov 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/J0Ll9q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1B322C66;
	Wed, 26 Nov 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156915; cv=none; b=Ivmd66fwpm3C+GDgDxwN0ySSs9ePuWFqNbXcebn+oT8ODb/iNg3qErITWHnv2DIyFoS51S7X5yeZjcyItHbEH1aoNT0xWcw7e+vdyv239QaAuIvm3SliNbsmrXzURQEIc4RLGYvzV0Tyj2/w2jLdlLO/pyNvguSjehDi1W1xg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156915; c=relaxed/simple;
	bh=MGz7vC6JDronoeMRnjLq4hufSogmHtO/m4KwiVm9uZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3v9QSl9nGopkiLEjBYzXfN6xnzvj8aKM4c9C8G+4D/1++zwuvYrE54bwNodhdzLN6gLscvQdEfaNiK2UL0LHJGiWZ3kpChne+sYm8BRdq2YLsB0d1jM9Ypbz2BgxdJVFZciSs/eYNICFayu2+jw7cjcD/AsDx/DXctCmu5BVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E/J0Ll9q; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQANW1v1479599;
	Wed, 26 Nov 2025 11:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+a1oF
	kQAmBjNLWNM9cEWj5JJ26kNsj586e1VeUzBlKU=; b=E/J0Ll9qInAGuxa1MQX9s
	cbmrMPHWWGAshURYvAD2M5Bf4H0Mfy3zJaOsa9lXzcy/Fg3iuG7zzYi+Fhcl/jN+
	7G7w0pa2TocNN84iXT/ufy8biTl7TXOv03q7AbfeF4/Jszb51oNH4UdNKy5gA9o4
	IEwdS+r5Q3NQl0wI7NAeq+r7FSLLYYjdn14n5j1Sm8VPV7rQZKmEqA2/QRWw5WAp
	8gEi7zGq0M3vU5z/ALPjJnTQZwiicsi8NYic7nunZzWkvDD3b+TyYRiKGEBTevGz
	1SpHGO85+Udws3n7lanxQF9G59PKRUClxT/9j+cYZDpSfHYTcDgegrvV2tnBsGwt
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkkp5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:35:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAIjLG032105;
	Wed, 26 Nov 2025 11:35:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mavguk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:35:09 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AQBZ8Xi007474;
	Wed, 26 Nov 2025 11:35:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3mavgtg-2;
	Wed, 26 Nov 2025 11:35:08 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: harshvardhan.j.jha@oracle.com, linux-btrfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] btrfs: add helper to truncate inode items when logging inode
Date: Wed, 26 Nov 2025 03:35:06 -0800
Message-ID: <20251126113507.3836193-2-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126113507.3836193-1-harshvardhan.j.jha@oracle.com>
References: <20251126113507.3836193-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260095
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=6926e5ee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
 a=lRuuxtJEyW5utAoZhM8A:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA5NCBTYWx0ZWRfXwBHWhmXL5Qtr
 At3WGv8FqBa4tNZ9vK+cuss0iMBWZJycrqMfdAPnsvs4o5Me03GFq8fWBBaEipTZPxrlVPWgK/4
 8tTFijkSmWZTNAEI3765/PgCCajnyseMrhdznqQYpdZX9puxj0CbypjUwedsOSKMaDpc29+Cbim
 ZuGafmd0X4A7r7A3RjhPfNj343awBDQ/2aqpopT5PV7PCcxoC/On/nngUQ/pu4t+otvBccZ9UVo
 bEuzEYQJ+TKyV6CfzuVimusf42SGy85smrviHcGR3LYz3aa5NTKYzxztExbeAmKeIQaPK+5OUKf
 zTeGBq+cHdMD+gg3dlGTnbV3LCj7MJygrOl3MPPW+tubRgLc8ivcgnOF4J41hmBr5eE9JMLeS55
 2PUpbEjPl+Kew0E062mQzB+1JqWTLg==
X-Proofpoint-ORIG-GUID: kl6IBRIZuqDVaYteQag7kuRfU-_JUXP5
X-Proofpoint-GUID: kl6IBRIZuqDVaYteQag7kuRfU-_JUXP5

From: Filipe Manana <fdmanana@suse.com>

Move the call to btrfs_truncate_inode_items(), and the surrounding retry
loop, into a local helper function. This avoids some repetition and avoids
making the next change a bit awkward due to a bit of too much indentation.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 6/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit 8a2b3da191e5a167bba9776e109b775b21cb4d85)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 fs/btrfs/tree-log.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 34fedac4e1864..81826aa1a3f1d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3955,6 +3955,21 @@ static int drop_objectid_items(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int truncate_inode_items(struct btrfs_trans_handle *trans,
+				struct btrfs_root *log_root,
+				struct btrfs_inode *inode,
+				u64 new_size, u32 min_type)
+{
+	int ret;
+
+	do {
+		ret = btrfs_truncate_inode_items(trans, log_root, inode,
+						 new_size, min_type, NULL);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+
 static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *leaf,
 			    struct btrfs_inode_item *item,
@@ -4548,13 +4563,9 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 			 * Avoid logging extent items logged in past fsync calls
 			 * and leading to duplicate keys in the log tree.
 			 */
-			do {
-				ret = btrfs_truncate_inode_items(trans,
-							 root->log_root,
-							 inode, truncate_offset,
-							 BTRFS_EXTENT_DATA_KEY,
-							 NULL);
-			} while (ret == -EAGAIN);
+			ret = truncate_inode_items(trans, root->log_root, inode,
+						   truncate_offset,
+						   BTRFS_EXTENT_DATA_KEY);
 			if (ret)
 				goto out;
 			dropped_extents = true;
@@ -5531,12 +5542,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					  &inode->runtime_flags);
 				clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					  &inode->runtime_flags);
-				while(1) {
-					ret = btrfs_truncate_inode_items(trans,
-						log, inode, 0, 0, NULL);
-					if (ret != -EAGAIN)
-						break;
-				}
+				ret = truncate_inode_items(trans, log, inode, 0, 0);
 			}
 		} else if (test_and_clear_bit(BTRFS_INODE_COPY_EVERYTHING,
 					      &inode->runtime_flags) ||
-- 
2.50.1


