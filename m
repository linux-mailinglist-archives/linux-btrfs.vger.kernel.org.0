Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23C61F54ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgFJMdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12377 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgFJMdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792402; x=1623328402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KYnZrg9iPjRo4w2i+VT65N1zKUg+5T2AWHqxxaE2aU=;
  b=a+TNompDMPUl3W7oEIhDNr7vhLuN1KRNrHguJtj1vmwpni5z/RR9eT3N
   J2FMqooCqNsVvbtgVUyzfLn3nQ/eqn+in3AakImQqaWqz0NYCsLoreOVV
   sxoFZPuxNgi72I6l8t/rKzLUH9mypmzsjHnK0WqXXgdnfutz+AeqniR/f
   xBzjSJpoyjVRxSrSQTVwFbXohOY1oCqNuYF0FH/KObLddCJYH8+2AwrqC
   DJd/OQnY+vqKNvLqpiNSn35kFMh+XEm1NjlgeOOhmCcp8OUeeDlQ8hvVv
   lid3R22RLo478k52BVLEdjJU5uBNQNqeoU4dH62Yw/xmOk1SKFTbUsFjG
   Q==;
IronPort-SDR: Laqwg2hOd8tRTd41q2r3cUF846OqSdjtmyz45Ley6ajdpW/3lV0W42oPw7ORWPAjJ4gIaGOgM1
 nwOvCUtfRi9WaiDvXk/0Em3jOb/KZqBlmxc/4TiPmEYQnMYxjo0OpPtewmQN/Czb5qM2Tl+fD1
 NIxZyrSSo7TId4VA11k1DGIKKVbR9FJPx+i/voLiFTQyBwm7BICbmaYHDxy0LHoPEVF3fy99QX
 rRAN/5BMqQW4XJu/WzUd88WkIPdArG0325eJyvn6xUP5nQYnyoaaYMVePbOzg1KwEDP+WeTtIt
 RSU=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632698"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:08 +0800
IronPort-SDR: LqnG0rT9Gshx0PELFbTCVWi7PcdP6ucb39l8wcD10y0rPS552BVY0snYdv8qt23xkR66RhaQHJ
 jXLXdn0M8APB8C2YvfNhgaJQW+6w9VZxE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:35 -0700
IronPort-SDR: 0/GoCiBD4xQzZBjqr5n7oIbKRPdr7G9OBvzLh+F473kfyc2vx4drgGWcm2sstJEGC5kBEaez3r
 LVFBKW0LWCnw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/15] btrfs-progs: pass alloc_chunk_ctl to chunk_bytes_by_type
Date:   Wed, 10 Jun 2020 21:32:48 +0900
Message-Id: <20200610123258.12382-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass the whole alloc_chunk_ctl to chunk_bytes_by_type instead of its
num_stripes and sub_stripes members.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/volumes.c b/volumes.c
index 539c3d8648c6..04bc3d19a025 100644
--- a/volumes.c
+++ b/volumes.c
@@ -883,21 +883,21 @@ int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	return 0;
 }
 
-static u64 chunk_bytes_by_type(u64 type, u64 calc_size, int num_stripes,
-			       int sub_stripes)
+static u64 chunk_bytes_by_type(u64 type, u64 calc_size,
+			       struct alloc_chunk_ctl *ctl)
 {
 	if (type & (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_DUP))
 		return calc_size;
 	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
 		return calc_size;
 	else if (type & BTRFS_BLOCK_GROUP_RAID10)
-		return calc_size * (num_stripes / sub_stripes);
+		return calc_size * (ctl->num_stripes / ctl->sub_stripes);
 	else if (type & BTRFS_BLOCK_GROUP_RAID5)
-		return calc_size * (num_stripes - 1);
+		return calc_size * (ctl->num_stripes - 1);
 	else if (type & BTRFS_BLOCK_GROUP_RAID6)
-		return calc_size * (num_stripes - 2);
+		return calc_size * (ctl->num_stripes - 2);
 	else
-		return calc_size * num_stripes;
+		return calc_size * ctl->num_stripes;
 }
 
 
@@ -1122,8 +1122,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	max_chunk_size = min(percent_max, max_chunk_size);
 
 again:
-	if (chunk_bytes_by_type(type, calc_size, ctl.num_stripes,
-				ctl.sub_stripes) > max_chunk_size) {
+	if (chunk_bytes_by_type(type, calc_size, &ctl) > max_chunk_size) {
 		calc_size = max_chunk_size;
 		calc_size /= ctl.num_stripes;
 		calc_size /= ctl.stripe_len;
@@ -1196,8 +1195,7 @@ again:
 	}
 
 	stripes = &chunk->stripe;
-	*num_bytes = chunk_bytes_by_type(type, calc_size,
-					 ctl.num_stripes, ctl.sub_stripes);
+	*num_bytes = chunk_bytes_by_type(type, calc_size, &ctl);
 	index = 0;
 	while(index < ctl.num_stripes) {
 		struct btrfs_stripe *stripe;
-- 
2.26.2

