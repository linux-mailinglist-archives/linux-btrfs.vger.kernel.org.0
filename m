Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17336FE34
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhD3QBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 12:01:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbhD3QBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 12:01:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UFhmSp012125
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QMRkwXirvrGMfM7BIotRYrzLY1j1sXpHJILeWsRDn/w=;
 b=HXfzfZgUSSQM9rOj7bzedarf1j98SgmSjermdIwtcBr8idt4fbucSym7y1KkXdHf9Hll
 qddp06I5mmEOOtIMVfq90mUPoiKH4bwQAt033Ww3eOSJfTXuCskZ0V8LagUWqppJjTR+
 fy+N1GRsLKQ9MIkybmX2w93snBNy7hiyam6b6SdJGpRHAb7Jj8KBiGoN2aa6bIMNmaxt
 MlnlOAb4Cp3aRkbGCxqfRFTjNsRz5K4XqrGK38c4RyyzwZP8cRocMp/LCF8xmNuqP7f4
 hiIhdgzEOb+OFBA8Ohe3TKLM98PoMDgse00DwaTz9axY1F1Unaq3tgbPwLJzmSc1DV1H BA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388msn0h88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 12:01:06 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UFwumf012704
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 16:01:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 384ay81ung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 16:01:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UG10HJ24838438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 16:01:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91E8BAE059;
        Fri, 30 Apr 2021 16:01:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E64AE053;
        Fri, 30 Apr 2021 16:01:00 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Apr 2021 16:01:00 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] btrfs: Add error handling in btrfs_fileattr_set for transaction handle
Date:   Fri, 30 Apr 2021 21:30:55 +0530
Message-Id: <f24fb4c9f8613fe76f5a7201752152637647f8ba.1619797915.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ocg_WTspxzQbLlBecRR8WbNqEOevDV4U
X-Proofpoint-ORIG-GUID: ocg_WTspxzQbLlBecRR8WbNqEOevDV4U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_10:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300105
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add error handling in btrfs_fileattr_set in case of an error while
starting a transaction. This fixes btrfs/232 which otherwise used to
fail with below signature on Power.

btrfs/232 [ 1119.474650] run fstests btrfs/232 at 2021-04-21 02:21:22
<...>
[ 1366.638585] BUG: Unable to handle kernel data access on read at 0xffffffffffffff86
[ 1366.638768] Faulting instruction address: 0xc0000000009a5c88
cpu 0x0: Vector: 380 (Data SLB Access) at [c000000014f177b0]
    pc: c0000000009a5c88: btrfs_update_root_times+0x58/0xc0
    lr: c0000000009a5c84: btrfs_update_root_times+0x54/0xc0
    <...>
    pid   = 24881, comm = fsstress
	 btrfs_update_inode+0xa0/0x140
	 btrfs_fileattr_set+0x5d0/0x6f0
	 vfs_fileattr_set+0x2a8/0x390
	 do_vfs_ioctl+0x1290/0x1ac0
	 sys_ioctl+0x6c/0x120
	 system_call_exception+0x3d4/0x410
	 system_call_common+0xec/0x278

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ee1dbabb5d3c..98ecb70466bf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -259,6 +259,8 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 	if (!fa->flags_valid) {
 		/* 1 item for the inode */
 		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
 		goto update_flags;
 	}
 
-- 
2.30.2

