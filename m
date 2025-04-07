Return-Path: <linux-btrfs+bounces-12822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7204A7D1B6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD02116BB23
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7B211707;
	Mon,  7 Apr 2025 01:21:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A120FAAC;
	Mon,  7 Apr 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743988859; cv=none; b=AK3r4d0vevJki80oDShmWPCNxJ/wThe0mGkITS11ghwWdSzML/rHugMgdfpYLC2ysc18IAJPYiZkgO3+y62a9tWo8uUz39a1Y3QLEUvwl/uFlgQPXvm52YWkm7caauZXbhU4ZWME4vRWPWYWVlqgY8fg57EPpaYcaOrWYMJzLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743988859; c=relaxed/simple;
	bh=QSHGdJsuswRct7RmU0435pe/dB2N0z1BIor4wZnOKno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rxwVxITsjmHelH+tbL5+rz0K0VD1mbTI3ckc40xcHBiLxPY+/oKOsNSlKwKmFmZAz8CkmgnwXeESnY6FAiWhcLzvpN3s90MI1e7e/sr2rBjlV8puvnVwpBLtdV/OzPtKfNzlQ6S/xd6nodId47QWa+WxJI7iW2J+wTsF20Y7Ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371899t013225;
	Mon, 7 Apr 2025 01:20:47 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tug8hqq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 07 Apr 2025 01:20:46 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 6 Apr 2025 18:20:45 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 6 Apr 2025 18:20:43 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <jianqi.ren.cn@windriver.com>
Subject: [PATCH 5.10.y] btrfs: handle errors from btrfs_dec_ref() properly
Date: Mon, 7 Apr 2025 09:20:42 +0800
Message-ID: <20250407012042.208647-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iE5T1qH6hLRsiUAYwDUL6dPYwsd_eetB
X-Authority-Analysis: v=2.4 cv=YJefyQGx c=1 sm=1 tr=0 ts=67f3286e cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=XR8D0OoHHMoA:10 a=maIFttP_AAAA:8 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=bs7I7ufv3jHHAwegb78A:9 a=qR24C9TJY6iBuJVj_x8Y:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: iE5T1qH6hLRsiUAYwDUL6dPYwsd_eetB
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_08,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=763 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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
index a8089bf2be98..cf2b65be04b5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5240,7 +5240,10 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
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


