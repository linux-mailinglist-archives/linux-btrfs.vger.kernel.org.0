Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE739515A
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhE3O4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 10:56:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229580AbhE3O4M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 10:56:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14UEY9Hw032644;
        Sun, 30 May 2021 10:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bIXLsU8hAWHigIcRVv4hniprsMyi1xr+pzgBebOC4WY=;
 b=Cyh/E6wkh2RwByZVipz90s/ofFpbhbDt+ABfnatRl+7Sbd3OiqnSVcC8Sw4cz5VCYIe6
 BPDVYfYQw9EQUYwlxUH5HsqQFpLZuIOszkQgcvlpnCar+OYKSiQbeKdVNGMfGjHt+vx6
 WlaTb/SQa/C7RAXr7sn34FVXym8YoZcl4Y0W9crQN4bZORT1wJ5H4ulcOA/IzOetOesG
 5o4uWNfeCyLC8kVvDGZUiXspAfsk0AD1zoR365laXBnbUedTzr1IfFHpraFCzBK7RZGO
 GWypNzNWlaxx9R5Vq1UblxNKrzwuxIC9ceV/YP683MmHMg8A1x0wrrTT0LBlo5IC+se3 Mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38vart1hhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 10:54:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14UErOOs025337;
        Sun, 30 May 2021 14:54:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 38ud888hp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 May 2021 14:54:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14UEsQOR33095994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 May 2021 14:54:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA0A9A405B;
        Sun, 30 May 2021 14:54:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A293A4054;
        Sun, 30 May 2021 14:54:25 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 May 2021 14:54:25 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] btrfs: Fix return value of btrfs_mark_extent_written() in case of error
Date:   Sun, 30 May 2021 20:24:05 +0530
Message-Id: <76ddeec8b7de89c338b8cb94ee2c4015a0be6e2f.1622386360.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -miuSCelc30d6sYBr0H9iLF7XX5l321k
X-Proofpoint-ORIG-GUID: -miuSCelc30d6sYBr0H9iLF7XX5l321k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-30_08:2021-05-27,2021-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105300115
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We always return 0 even in case of an error in btrfs_mark_extent_written().
Fix it to return proper error value in case of a failure.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
Tested fstests with "-g quick" group. No new failure seen.

 fs/btrfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3b10d98b4ebb..55f68422061d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1094,7 +1094,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	int del_nr = 0;
 	int del_slot = 0;
 	int recow;
-	int ret;
+	int ret = 0;
 	u64 ino = btrfs_ino(inode);

 	path = btrfs_alloc_path();
@@ -1315,7 +1315,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	}
 out:
 	btrfs_free_path(path);
-	return 0;
+	return ret;
 }

 /*
--
2.31.1

