Return-Path: <linux-btrfs+bounces-8016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94750978E79
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 08:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE172874CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312518E351;
	Sat, 14 Sep 2024 06:42:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF212748D;
	Sat, 14 Sep 2024 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296136; cv=none; b=kcmCJkDUBSdt+lxsJhJDhQ9/jeZeub+dNACeizOncK2Djo+CmPYINmmI6URWds+wQ260oKhyiD/9D7kFfgZ7K5ZA9LBecMYKRz5fz6YGBx32HgT9efd9xVWZeUpSitnWHyPhcNPqCujhLwzV2FC4DOTyVpGt7pPf8CYibxdgXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296136; c=relaxed/simple;
	bh=RB5m2694UUoAdkdSHGdUeOOp8FnRPJZhxkbkDi+Db1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGf7cbNE2TAA9zMQRw5B7HAsENHvh6AAwvio+pPg8nfNlMAAaVEYPf3gQ/hAaSvc5pPixrW1K4kOgekMXDGsDjYC+2El/oMPnwbr1zXlTZjcy0g/ggb0RYipJkWUrnNfQF4zmKdtcmfQf8GyZoEhs4wNnpmbotf6nOmW+QjmQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48E5o14Z015615;
	Sat, 14 Sep 2024 06:42:02 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41n1f984j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 14 Sep 2024 06:42:02 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 23:42:01 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 23:41:59 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+56360f93efa90ff15870@syzkaller.appspotmail.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in write_all_supers
Date: Sat, 14 Sep 2024 14:41:58 +0800
Message-ID: <20240914064158.75664-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008c5d090621cb2770@google.com>
References: <0000000000008c5d090621cb2770@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g5Ms3QAjNUlZmop5gpXHKKJpsyVpR3xF
X-Authority-Analysis: v=2.4 cv=afUzngot c=1 sm=1 tr=0 ts=66e5303a cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=QI9cfog0S1L15HQcuNoA:9
X-Proofpoint-GUID: g5Ms3QAjNUlZmop5gpXHKKJpsyVpR3xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_05,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 mlxlogscore=832 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409140045

if we have IGNOREDATACSUMS then don't need to backup csum root 

#syz test

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f5441e62d1..415ad3b07032 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1679,7 +1679,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 
 	if (!btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
-		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 		btrfs_set_backup_extent_root(root_backup,
 					     extent_root->node->start);
@@ -1688,11 +1687,15 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 		btrfs_set_backup_extent_root_level(root_backup,
 					btrfs_header_level(extent_root->node));
 
-		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
-		btrfs_set_backup_csum_root_gen(root_backup,
-					       btrfs_header_generation(csum_root->node));
-		btrfs_set_backup_csum_root_level(root_backup,
-						 btrfs_header_level(csum_root->node));
+		if (!btrfs_test_opt(info, IGNOREDATACSUMS)) {
+			struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
+
+			btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
+			btrfs_set_backup_csum_root_gen(root_backup,
+						       btrfs_header_generation(csum_root->node));
+			btrfs_set_backup_csum_root_level(root_backup,
+							 btrfs_header_level(csum_root->node));
+		}
 	}
 
 	/*

