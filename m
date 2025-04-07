Return-Path: <linux-btrfs+bounces-12820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E2A7D1AF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F116ADC2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD6211469;
	Mon,  7 Apr 2025 01:20:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519E2C9A;
	Mon,  7 Apr 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743988809; cv=none; b=MS7c6ddWRl4XbGbkqucDfdXXdo82z43h9MGiT0KjOwpSuPM8cM6zLGB7NORsSs2gSY0I9BCFcb15Ab9v1JMR/VIHF4FmAK/n62E2xsu1Kx8r9Xp5WRJLCDbUp/5o79w9r79W26YbYtCJrXsJ4mPWL9vOiSek0TWSbV1sXRaGJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743988809; c=relaxed/simple;
	bh=/yZCAnPXLbbq0+7qtCW8t6ONxQGN39h8GqPiIGZgSY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYGFYTaJYxtQMQz8vG31D8i8zhnZsm6xWu6sep97ZVr66RLo6L8lpxG8RAPXoOONys+37Pr4ECcl1CumYGj4iLNkTnEOs5bRwWNI2zYzeelA0GXyXkGpikgIV8tZ8HGnAXsrBW8jHrgLObeclQ7J6Gp1n+z6FnnKbughmQECGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371HAwi012505;
	Sun, 6 Apr 2025 18:20:00 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45u41m1ae6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 06 Apr 2025 18:19:59 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 6 Apr 2025 18:19:59 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 6 Apr 2025 18:19:56 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <jianqi.ren.cn@windriver.com>
Subject: [PATCH 6.1.y] btrfs: handle errors from btrfs_dec_ref() properly
Date: Mon, 7 Apr 2025 09:19:55 +0800
Message-ID: <20250407011955.208594-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iblByoqbwsUi6iAWvXTVT4MJyTgeXi2o
X-Proofpoint-ORIG-GUID: iblByoqbwsUi6iAWvXTVT4MJyTgeXi2o
X-Authority-Analysis: v=2.4 cv=QOZoRhLL c=1 sm=1 tr=0 ts=67f3283f cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=maIFttP_AAAA:8 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=bs7I7ufv3jHHAwegb78A:9 a=qR24C9TJY6iBuJVj_x8Y:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=779 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504070008

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 5eb178f373b4f16f3b42d55ff88fc94dd95b93b1 ]

In walk_up_proc() we BUG_ON(ret) from btrfs_dec_ref().  This is
incorrect, we have proper error handling here, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 50bc553cc73a..9040108eda64 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5575,7 +5575,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				ret = btrfs_dec_ref(trans, root, eb, 1);
 			else
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			BUG_ON(ret); /* -ENOMEM */
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			if (is_fstree(root->root_key.objectid)) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
 				if (ret) {
-- 
2.34.1


