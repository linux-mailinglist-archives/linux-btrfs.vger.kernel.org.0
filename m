Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F148467FA8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383319AbhLCWIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:08:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383317AbhLCWIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 17:08:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6Kcv003520
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Dec 2021 14:04:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wLJhkfoVzpmaKpBFvG9lf5GnLSICnxc4/A0MgNK7mW4=;
 b=Wz+84ayJKDEsRiRnIWAzNtOpkT6e6mK/tcKStTIp0PEsqEBUgQWkx38rpUIAUs0BAC0e
 5SGHBiehdN6nLxhghE2RPUS255xgULR7kR0NZXDPCz0dN1rkoDDsDBvx7ALS3kYD6lOf
 xEd7inqw8VwuGko8TLgPHGOJ+j5HDTb5bz4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqnf02u1d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:04:52 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:04:51 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3BFB976B31D9; Fri,  3 Dec 2021 14:04:47 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v6 4/4] btrfs: increase metadata alloc size to 5GB for volumes > 50GB
Date:   Fri, 3 Dec 2021 14:04:45 -0800
Message-ID: <20211203220445.2312182-5-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203220445.2312182-1-shr@fb.com>
References: <20211203220445.2312182-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: OqNS2evpfGmIBzSAgWOlRUEjUHMhzmuj
X-Proofpoint-ORIG-GUID: OqNS2evpfGmIBzSAgWOlRUEjUHMhzmuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=987 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This increases the metadata default allocation size from 1GB to 5GB for
volumes with a size greater than 50GB.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 437d1240f491..cda78aa1ee4f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -195,7 +195,7 @@ static u64 compute_chunk_size_regular(struct btrfs_fs=
_info *info, u64 flags)
=20
 	/* Handle BTRFS_BLOCK_GROUP_METADATA */
 	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-		return SZ_1G;
+		return 5ULL * SZ_1G;
=20
 	return SZ_256M;
 }
--=20
2.30.2

