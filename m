Return-Path: <linux-btrfs+bounces-13849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E763AB0F9B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59A1505044
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F828DB75;
	Fri,  9 May 2025 09:51:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2D28C86D;
	Fri,  9 May 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784288; cv=none; b=Cr4m1evIz9+pT8P0qf2M5ZTIFAgfRAeI3j7CAq6/p/rFtcesy32tuzHL9T/CxcJVPEOy46j0HKvMkxqlllRkTfKoeVvPNDHAcNvdl5DYdNR4TWCNnYRuCpP3+96sPhWq9dlRCKrxSv1LR3e6Jrloh0dReP+scanYEjUXO7nur6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784288; c=relaxed/simple;
	bh=d+lSoU9WOMdXgvMp5Q1zAJQSs3xXOLPO8P24pOZXoKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmtSTR5jZf89LPzUc7AgpcwEfaQnZmIs+WGeSp7dHvcSL3GafRaF4fcyA1mRHD55xfyiQGj/WOAxnIqF0gt7gQD2/LnFjNaYHgss/taR2qlLJ47XugrujNeHKX3yAve3trm5Mf4/RCeiKBKiXHjXuxy1dY1grE8xbiK8Ovb0M10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54970X4Q030883;
	Fri, 9 May 2025 09:51:19 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c175xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 09 May 2025 09:51:19 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 9 May 2025 02:51:18 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 9 May 2025 02:51:15 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <clm@fb.com>, <josef@toxicpanda.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <wqu@suse.com>,
        <fdmanana@suse.com>
Subject: [PATCH 6.6.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Fri, 9 May 2025 17:51:14 +0800
Message-ID: <20250509095114.3245010-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=681dd017 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=cm_jlSa5FMeQIn3fhkUA:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: sOA-Ia8K_QMhNvex2gnJ07Tf4xbbIyYr
X-Proofpoint-ORIG-GUID: sOA-Ia8K_QMhNvex2gnJ07Tf4xbbIyYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5NSBTYWx0ZWRfXx5zwhR94oQrT o2JRLFMhgwB7QSVCo2fTAE6V5ymDgVnonARq52L9djRLuA2Rk8D6M7qN3Xawc+DRNaLIGuhQm0v 8B7LKRmFV6BNoQDpft8JAY+d4XvO7ym+lwR9OTLFKVHaG8KRR6FMfgyxnH9ryXDv0N4VrloOta3
 jiJpk4IaN+xSnmmcGoTNaLoqh6hgCVkQd/VavYNrU8O8SZaSr0WPqM/8rIp2lW4nEb8pxv9m+CW sk5qVA6g9gThHSgkJcLlZRAp0SVGNr01TdHa05z7pLzGc9CSaWZKimwWFtZCjGDlrYb2+0NhphH UbyzpexxCm0gCRMC+00FS8YQZgrT9bWahT6XTGk+scTjYagnRYLbOzBK4EFodVRzLVUMXynapGB
 PiWXwsLv5WcDCNO0oI4SyQO2iZzmZBp51kLo+49EUQXNDCU7BqKAa306ARi/ej+mB7CQj9d5
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=861 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090095

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 28cb13f29faf6290597b24b728dc3100c019356f ]

Instead of doing a BUG_ON() handle the error by returning -EUCLEAN,
aborting the transaction and logging an error message.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 fs/btrfs/extent-tree.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index af03a1c6ba76..ef77d4208510 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -164,6 +164,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			num_refs = btrfs_extent_refs(leaf, ei);
+			if (unlikely(num_refs == 0)) {
+				ret = -EUCLEAN;
+				btrfs_err(fs_info,
+			"unexpected zero reference count for extent item (%llu %u %llu)",
+					  key.objectid, key.type, key.offset);
+				btrfs_abort_transaction(trans, ret);
+				goto out_free;
+			}
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
 			ret = -EUCLEAN;
@@ -177,8 +185,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 			goto out_free;
 		}
-
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -208,10 +214,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto search_again;
 		}
 		spin_lock(&head->lock);
-		if (head->extent_op && head->extent_op->update_flags)
+		if (head->extent_op && head->extent_op->update_flags) {
 			extent_flags |= head->extent_op->flags_to_set;
-		else
-			BUG_ON(num_refs == 0);
+		} else if (unlikely(num_refs == 0)) {
+			spin_unlock(&head->lock);
+			mutex_unlock(&head->mutex);
+			spin_unlock(&delayed_refs->lock);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			  "unexpected zero reference count for extent %llu (%s)",
+				  bytenr, metadata ? "metadata" : "data");
+			btrfs_abort_transaction(trans, ret);
+			goto out_free;
+		}
 
 		num_refs += head->ref_mod;
 		spin_unlock(&head->lock);
-- 
2.34.1


