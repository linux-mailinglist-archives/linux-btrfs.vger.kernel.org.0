Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D615A44B515
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbhKIWFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 17:05:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237422AbhKIWFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 17:05:14 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A9LwJcj005580
        for <linux-btrfs@vger.kernel.org>; Tue, 9 Nov 2021 14:02:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uv8tcymSgViQDXFTk5CH4OYDAeiQrzXqUVLW3ixjzSc=;
 b=OjxkAYvjYjUurub3NCrgMI2C0Ey7U8S1BVMZ+Apf3GhGlkP3B0C59NSJsPHn4DUbtOBf
 PGFchhMkezrMQf6cNlu4iCpStQQaVNtiCE9rRrWL9q5xxtg/38/X8tB2LiHJmXRZYQd9
 JoDvxJOIgpVqNPPHoJG31sllmPl2EgwxAjM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c7tefcpb6-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 14:02:27 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 14:02:22 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 494036326D86; Tue,  9 Nov 2021 14:02:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 4/4] btrfs: increase metadata alloc size to 5GB for volumes > 50GB
Date:   Tue, 9 Nov 2021 14:02:18 -0800
Message-ID: <20211109220218.602995-5-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109220218.602995-1-shr@fb.com>
References: <20211109220218.602995-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: O0EflO94qmEqxJJaUa4i9V4pEId20gFG
X-Proofpoint-ORIG-GUID: O0EflO94qmEqxJJaUa4i9V4pEId20gFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090119
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
index 3a31aea701a8..0d0accbe3bfb 100644
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

