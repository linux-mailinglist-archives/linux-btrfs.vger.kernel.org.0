Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B054401DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhJ2Sav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:30:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21530 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhJ2Sav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:30:51 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THwSRh017394
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=CGRfiNpDw41zqqW6lbhY/Lq0BxX376+J4osQ1+soSGc=;
 b=K0ckmFkuEWj4jF0Ki2fiCvTWGsnK8BNDLF7/wO3hmI8qNISIFSU5MXMeISex+gH/FYNz
 YEKXQYXyqIGM32pIjh3RjpAr1S85vvtN0z3u4xr109WvNa+ZvhFP3blmzi0TOGwVOg+v
 K0YlcSThCFH0ag6UuCA2FB8FalSNlzXJBwY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c09avxf2x-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:21 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:28:18 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id F10145BCB642; Fri, 29 Oct 2021 11:28:15 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 4/4] btrfs: increase metadata alloc size to 5GB for volumes > 50GB
Date:   Fri, 29 Oct 2021 11:28:12 -0700
Message-ID: <20211029182812.3560677-7-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029182812.3560677-1-shr@fb.com>
References: <20211029182812.3560677-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: QpbydH4j8R32nZ-Xip7jvlZ5cucHnbUA
X-Proofpoint-ORIG-GUID: QpbydH4j8R32nZ-Xip7jvlZ5cucHnbUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=981 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290100
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
index 7370c152ce8a..44507262c515 100644
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

