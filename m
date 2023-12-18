Return-Path: <linux-btrfs+bounces-1035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC608176DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A56284AC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F328740A6;
	Mon, 18 Dec 2023 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QjZlEGw+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27047204B
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702915363; x=1734451363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJhTX+6/OGBOBtFGidv8T5Jxvu+NMnKG7TRIKpbYGwc=;
  b=QjZlEGw+0eHe2Fm2b6gyp00gVX48QmY38hfAF5HFq7XX1xJ3Kaj4iWUs
   vWynoKC/gWek4XTKmc++lAefZHtU8KjE0hN0NDfQCNN+A7W4OKmq0Y2am
   Z4b5LAElTOlg8Ww/hbNH8qy2k6QiO3+VMogKAeE2/ATagSmUIqM/mAqAM
   ywnWDq2wmFb21EMRkx2dpfl+9NbJGLKHMqR3fJOQsrKX4x+p8o2aau2S2
   sImraA+3m9XXdKJOW6jCcyv5pR1igYFrtWr1bcjxziSypUo/gscudjvIr
   ngQZV8GafiVJWwvwBVugchWTs3SsAkS9pMNaBu6c9J2DU7XJGkqWmo2rq
   g==;
X-CSE-ConnectionGUID: 8dQsPYBMSFOsIm/FdoowBg==
X-CSE-MsgGUID: iN3xMVceSQCPM2eYAfgqbA==
X-IronPort-AV: E=Sophos;i="6.04,286,1695657600"; 
   d="scan'208";a="5487548"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 00:02:41 +0800
IronPort-SDR: 2wnsqo2lew84uTWO+/0nu9sL68N+shXK5FeZkSrjcQiN3x2OALGv1wNlw+NftwCzRT/6YVkZf9
 WySAJiZ2CpnQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2023 07:13:26 -0800
IronPort-SDR: h0/UuG4hhDasDp72gdvtO3X+6tqa2AqQdi8drRHsgX2v6PS+uLhcnP4+xeMcWNoG+naIo7ULSG
 rKXDFWsZp/CA==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.88])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Dec 2023 08:02:40 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: optimize hint byte for zoned allocator
Date: Tue, 19 Dec 2023 01:02:29 +0900
Message-ID: <66b60a59f7ef31dd0ed5a1be992114e81f7b26e5.1702913643.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702913643.git.naohiro.aota@wdc.com>
References: <cover.1702913643.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing sequentially to a huge file on btrfs on a SMR HDD revealed a
decline of the performance (220 MiB/s to 30 MiB/s after 500 minutes).

The performance goes down because of increased latency of the extent
allocation, which is induced by a traversing of a lot of full block groups.

So, this patch optimizes the ffe_ctl->hint_byte by choosing a block group
with sufficient size from the active block group list, which does not
contain full block groups.

After applying the patch, the performance is maintained well.

Fixes: 2eda57089ea3 ("btrfs: zoned: implement sequential extent allocation")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d260b970bec7..6d680031211a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4311,6 +4311,24 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 		if (fs_info->data_reloc_bg)
 			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
 		spin_unlock(&fs_info->relocation_bg_lock);
+	} else if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
+		struct btrfs_block_group *block_group;
+
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
+			/*
+			 * No lock is OK here because avail is monotinically
+			 * decreasing, and this is just a hint.
+			 */
+			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
+
+			if (block_group_bits(block_group, ffe_ctl->flags) &&
+			    avail >= ffe_ctl->num_bytes) {
+				ffe_ctl->hint_byte = block_group->start;
+				break;
+			}
+		}
+		spin_unlock(&fs_info->zone_active_bgs_lock);
 	}
 
 	return 0;
-- 
2.43.0


