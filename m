Return-Path: <linux-btrfs+bounces-9158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEA9AF905
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E971F22431
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F118D626;
	Fri, 25 Oct 2024 04:56:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCD18B487;
	Fri, 25 Oct 2024 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832166; cv=none; b=jBbQTqcRs4kVwj35YOiKWUkhzpkqmybFK/AIWpPIxmmIV0iZsaL4YDEaYh/XjzcrOAp4J8TeOQPIuVYBDOkCmcOnGoLI/1Ine6NjWNS61q+lSnwEJhBDOiezwunxKeV4OzJ1+1dTPmGWWbJPZk0shUBYRtvscFURuNMlCVGrZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832166; c=relaxed/simple;
	bh=U6Ae3QYyiN4i0Sjm6MxU18NbqQy8yK3LLjURS4fLhfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvExSI58B1gFm1MtRG6yuQX6y+E5bCafMnrL0mbdnyxQwk1iZ7u5FaE/h5kToFpauDxgvrQmMqI5LrWieyhpj9as6tNSQUiZCeEk/aOvQK3aYqiR5v6kD4OljSZ5CgV5cjz22m8DlJ0wZbg3mRlLQKCq1bf5aHPlyr/ATdVzT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P4o3GZ009775;
	Fri, 25 Oct 2024 04:55:57 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42f2g42cpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Oct 2024 04:55:57 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 21:55:56 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 21:55:54 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] btrfs: add a sanity check for btrfs root
Date: Fri, 25 Oct 2024 12:55:53 +0800
Message-ID: <20241025045553.2012160-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zc91gNqY_nokhqEOYGbIa20gOoEsa7v1
X-Proofpoint-GUID: zc91gNqY_nokhqEOYGbIa20gOoEsa7v1
X-Authority-Analysis: v=2.4 cv=eoKNzZpX c=1 sm=1 tr=0 ts=671b24dd cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=qleOxOUtj-rFPy2f1jgA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_04,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=826 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410250034

Syzbot report a null-ptr-deref in btrfs_search_slot.
It use the input logical can't find the extent root in extent_from_logical,
and triger the null-ptr-deref in btrfs_search_slot.
Add sanity check for btrfs root before using it in btrfs_search_slot.

Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/btrfs/ctree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..9c05cab473f5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2010,7 +2010,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, struct btrfs_path *p,
 		      int ins_len, int cow)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct extent_buffer *b;
 	int slot;
 	int ret;
@@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	int min_write_lock_level;
 	int prev_cmp;
 
+	if (!root)
+		return -EINVAL;
+
+	fs_info = root->fs_info;
 	might_sleep();
 
 	lowest_level = p->lowest_level;
-- 
2.43.0


