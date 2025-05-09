Return-Path: <linux-btrfs+bounces-13850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AFAB0FBC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDD176BE3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5BA28E594;
	Fri,  9 May 2025 09:59:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B228DF40;
	Fri,  9 May 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784792; cv=none; b=MVgciLy7zv+/lCmfbzUpgI9Rxr/78GMJsxX7SfB4HULa8BT7Ze0UhNDijFtclva/YIACwTqHmMWYk4LtQ1AH3OuCt2bFkcgMMqHm0pbSUYCScobWE60EJNw7BmbhXA3cVgwJtBT7fVge1KWxHYdiLc89Nl3rXT2rdyvEoHcQF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784792; c=relaxed/simple;
	bh=pL6ps/hBTNCXxZb9p7MP3H9tcqqYEJIGBA1k8SnPWBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cCsHfzS3Qm7x5pQ7qbVce1yVzEkes5pm3i4MoSlnYj/dp1sR9J8jfpvlp/uAKaUpf/tfdkgep7bOSYG9+q6Uxyg+YoDjV6lKCji/qUpMrCBxH5rHXNlcFXUoMG5aJjy91tJXD8o3A4C4XeDUum+E+OB2kgKlSWaqavHMTq7UTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5495S6Rj028250;
	Fri, 9 May 2025 02:59:43 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46dee3f0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 09 May 2025 02:59:43 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 9 May 2025 02:59:42 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 9 May 2025 02:59:39 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <clm@fb.com>, <josef@toxicpanda.com>,
        <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>, <wqu@suse.com>,
        <fdmanana@suse.com>
Subject: [PATCH 6.1.y] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Fri, 9 May 2025 17:59:38 +0800
Message-ID: <20250509095938.3246212-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mSLvNq1oBDogTTbOVCgEECU-Tk3pizen
X-Authority-Analysis: v=2.4 cv=Pd3/hjhd c=1 sm=1 tr=0 ts=681dd20f cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=iox4zFpeAAAA:8 a=t7CeM3EgAAAA:8 a=cm_jlSa5FMeQIn3fhkUA:9 a=WzC6qhA0u3u7Ye7llzcV:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: mSLvNq1oBDogTTbOVCgEECU-Tk3pizen
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5NiBTYWx0ZWRfX+vkc0w1XTARR kCYzg7rLiTAJvBrnoa5JK4vC70lMxSE1HN7POyxr5fU3mKxtOMNE+kLQ84t+339mn4EhMcg9oYH K03/sMUYH1vXRbnXJotI8UwEJ4wxtILTtUVgozsXcZr/8R0bkzXs/e1TFYoO66s8gGOfNH7L6In
 /0ojw4y2Xwlf3aGOjASLnAHBW3sGOhO/a4c8UbeIOv27OCHCPuvGJfbilcH0cnl5P5YTbQjmDco hhj1X8RzrVPOriW/6361hGYR9Gj0p5xAxJ/tGB1h9OpL5pvU267KHsZmWYmNuVPwO2ZaQ1oZOut 7U7jUoSFxR0Xv9yVe/Z0eNn4VxEw2cCIvLSGVACL/OabFYTvdsj7QLT1hhsdVhR35N/Ht9U4GL3
 WUi1NRMSiJA3VsX+/kPuhfefhpC480yQnJcOSiGVHna5ed/qO2qoHJjRKspj4b/SUaGXLb8j
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxlogscore=865 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
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
index 9040108eda64..5395e27f9e89 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -179,6 +179,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
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
@@ -190,8 +198,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 			goto out_free;
 		}
-
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -221,10 +227,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
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


