Return-Path: <linux-btrfs+bounces-13851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EBBAB0FC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73B33A86D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BE28E5E3;
	Fri,  9 May 2025 10:01:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AF222576;
	Fri,  9 May 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784913; cv=none; b=gW21DHlqseGlyLo2NDHNjYG5Z55jHx7iI73979bPXuRVaIISC3WZB9aSf/2BlUf0cwQUwDU+Ymp1tm4h6BXUmNYA1EhAiZ7hTTwNA8XpNMrvlekICDbB3USQthYk068VCnKzKc/RymSE0VUYFYgyyiBgQYPeApTwHj+79f6Opv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784913; c=relaxed/simple;
	bh=UqxSh0I3I9c3iteiH8IjuE/CVdAAqboiJmRdwbu2iZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rXzwCaySRJ8cu2W7CHJfCdZxboQQs0Fm9laiNOvJDTPthUnpLFTijU8O2K05GMBFLtugdu40S0lj3x1cSquGWs8K8zVFT/g+KjxWKeg+JjP9RRNYQzaFLAKkfI4Jmq5ZjRqrYp7n1vDJEsme8Rqo2PQbRogN1DvwnQCzOPbhHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499AZw2004245;
	Fri, 9 May 2025 10:01:45 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430pcvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 09 May 2025 10:01:44 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 9 May 2025 03:01:43 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 9 May 2025 03:01:40 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <clm@fb.com>, <josef@toxicpanda.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <wqu@suse.com>,
        <fdmanana@suse.com>
Subject: [PATCH 5.15.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Fri, 9 May 2025 18:01:39 +0800
Message-ID: <20250509100139.3246547-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681dd288 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=cm_jlSa5FMeQIn3fhkUA:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: JeU32VCosWcbvaKeJoeVU5r8e0K_5fpT
X-Proofpoint-ORIG-GUID: JeU32VCosWcbvaKeJoeVU5r8e0K_5fpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5NiBTYWx0ZWRfX2v4APnMuOAFu SNYw1upWtjV90TYTzYUUkHAusODB1X/FK4EUTOKOu5VYzuj8iULtl15ZHiBeCaGwBbsrdhnqc+K /Y1BPJEyoUF91mwWi2irmta4jUGT5Exi/gVfg3I74zCH9JZsol2kvPeNMycVDKY9yzMCw5xWrME
 eaREw89heHWomgA3VnKKYhaPJr24LAKVxQ2ymiUQkLWio8xnLSSZw0iJj+Rzc3C4MvR2OG7fEVj /wZ52pPjAyoZUACZGIjYeYfmXeYhc7vpVtSHCopTCB7jkv2tHJk48UadnV5Ie++UQiJMe1WE75P L0W9X+cHlL6uX0k0uGVwpauimc3GRRNPsQ1RebIUyablSSRHc/R7f/pJ5ROZAMWAw27Ge6R3rWb
 ijW/wek40BPGYfaoIar8eONcgvJs59kmI+zjMWDPxNdEY53SxZnNykED1gLE9mPzGPv+E61P
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=873
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090096

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
index 551faae77bc3..8959506a0aa7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -176,6 +176,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
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
 			ret = -EINVAL;
@@ -187,8 +195,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 			goto out_free;
 		}
-
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -218,10 +224,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
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


