Return-Path: <linux-btrfs+bounces-7703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB1966D8D
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 02:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834CBB2265A
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11526FCC;
	Sat, 31 Aug 2024 00:36:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA41D1309;
	Sat, 31 Aug 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064579; cv=none; b=EOxpqfpYmbBzGn/YNJ75+VEUGnzOjvo5iHCJJVpNSqmV+xXBUUz+bE2SObVOsvoGbDkANvHDqe2o5gOv+R3dlnNk+NbN3bJVTO/9mRw2VSuLVfqLYIoZP/hA2/zcSOO2eqS0RwLKqUk7MxbcRQF7Vj2e/YxKvdk/hIzl/bDstPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064579; c=relaxed/simple;
	bh=ez1uLWZElCWBv5bLkXxc6KjkAHcwOdiyQY1fr5ULPOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b65+ZesIHb74qnvRDfsCGJBeajztjihAlsB8K5PrpZ75gCO69WaiyXDXST6A6Tn6/tA1VIcEDHij8N85PAxQ/7LCgFeoT+9tpjzdk+UB4z1LjFn4pGZdzkEGvCbTD5LptrtbUDV07iNsq/I6WWW8rq7op2aK1oZ0XYbAqgDS90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47V0Ad6V000915;
	Fri, 30 Aug 2024 17:22:25 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 419unh3p8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 30 Aug 2024 17:22:25 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 17:22:24 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 17:22:23 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] btrfs: Add assert or condition
Date: Sat, 31 Aug 2024 08:22:22 +0800
Message-ID: <20240831002222.2275740-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000044ff540620d7dee2@google.com>
References: <00000000000044ff540620d7dee2@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YeYNFiSsZKJWH2ppmGtPvnp5jBaQ1zN9
X-Proofpoint-ORIG-GUID: YeYNFiSsZKJWH2ppmGtPvnp5jBaQ1zN9
X-Authority-Analysis: v=2.4 cv=K8RwHDWI c=1 sm=1 tr=0 ts=66d26241 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=yoJbH4e0A30A:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=WQ4PzUGnyvOGiPlKdjgA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_12,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1011 mlxlogscore=697 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408310001

When the value of fsync_skip_inode_lock is true, i_mmap_lock is used,
so add it or condition in the ASSERT. 

Reported-and-tested-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4704b3cc972bd76024f1
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/btrfs/ordered-data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 82a68394a89c..d0187e1fb941 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1015,7 +1015,8 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 {
 	struct rb_node *n;
 
-	ASSERT(inode_is_locked(&inode->vfs_inode));
+	ASSERT(inode_is_locked(&inode->vfs_inode) ||
+	       rwsem_is_locked(&inode->i_mmap_lock));
 
 	spin_lock_irq(&inode->ordered_tree_lock);
 	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {
-- 
2.43.0


