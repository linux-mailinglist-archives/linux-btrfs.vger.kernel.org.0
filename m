Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC314354E4D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbhDFII0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbhDFIIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696500; x=1649232500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nr/roP5dmvDV6cXQ+o6UhQRvP3AXPeKsjYeZa856KhA=;
  b=Taaev3rg4vzFnmnPs/XMCIGAAFp2tZfyfX5IpwlI35xazTSTbKa23yvR
   HnpqkTNrY6Mj4jwaZR0DfuUnk7x0349dACP4V6gRND1V+4yBC6+NLU4Ug
   3qiAkqfJHLMhoSnMTVwCBU2EgodvX4wWZXf3t7F5r+XCIl04obCEpy1x9
   dE+uHXsb6kUdwKGr7MI/OhFMJVehnL5tY2O/c6ohYfcU88K0cB4FY7WKs
   qOQwZGwnvKUqf2m/rL8cUw/VF8IgfYXDuELiNUlFIG+Vxjn3+ZOpyVJpy
   tgaioDULOy1/gBptojhATmVg5dX//MYeGrlYlFNH47I3nA7/PPO0l/Odq
   A==;
IronPort-SDR: ReO+OxWeuYj//g+M70sJia7nHSDCaXLG6YWbX9UYhVbhpESekkutvxGb90exgys8/yiVYBd0CT
 U2wEd6vFU0BDVN2J79+NJnWDcr07OJ+i6OkGF2oiqglyzCeaeQpRSC5+fLYENq0ZNjYCBMyFg0
 hCBbo06G4yj3diTJkMVIaj6HVd8Snotwf1dHduOyBeIjk23QEGFgJ+Cg7y7TYIaNnVBPNHQSsK
 LuHu0qBwRgtwfVfLuFxBwiv1i1mVMAQXZp8BNMOx5blmgSp7fi+5kpy5GvZ3nnVeDCag+zXDOo
 v4c=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290726"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:08:05 +0800
IronPort-SDR: XVKyLbxNH8DZExdGXFDf9Ly1PwPgev7YOxhgvhKVJw/83M2oTHO6Q+4z07YDwn40tY3CSQwCul
 HU3+JnLfEpiZIAc1j1JqIXKUJOXqMurRnnx0o1qTgaS6PWKSVNNfGguZZaVeL0FYK3e8rFTAIJ
 327gNEL7CPu/HIx3fnymrCo5+2Dqza1qxF3J2gc9yTzHuns+HXPPZpWpKcNW46yAwZlW3cAy2s
 3M5h0W1m4io218fZ4vIoSblXN/W/UtyvpZN+uT0HCcpzebeOdR5xpegCNkr0l1KqVsZ5zKGJAS
 huxWrvCS6DeaZ32pUVoc5Mc2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:30 -0700
IronPort-SDR: OX13jAiQqMOI7lSwFCj5NirKiPSdNLJd4n8ETXrsKm2Q86Rj99AQ0B7jNMy/zuOI2ynMF6LcSm
 KpIIEJ2Cft7vBwxdbsoC1F/Bcjsiqzs597rfBiapkU/feLzj4x3/V8mroNv8fWxLCfBO2OBfv3
 Tslhsoos7CinyF+vlQYvGiTily//sbXEw48Ii2iLaGcPbvOPSVOut5Upr6WU52EzoiBWfWzbic
 nsfy9r3WVB5FaHtBJaCJ8WOcNQUJLaavgjfHBos6CXPtuq1P2ijVjzjvzeSiO5h2YUW0pIsp2Z
 yuY=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 11/12] btrfs-progs: simplify arguments of chunk_bytes_by_type()
Date:   Tue,  6 Apr 2021 17:05:53 +0900
Message-Id: <38d5cd309609dc520bc9bdac8706e2481aa714ce.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chunk_bytes_by_type() takes type, calc_size, and ctl as arguments. But the
first two can be obtained from the ctl. Let's drop these arguments for
simplicity.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 280537f6549d..d4ef5d626f12 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -897,9 +897,11 @@ int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 	return 0;
 }
 
-static u64 chunk_bytes_by_type(u64 type, u64 calc_size,
-			       struct alloc_chunk_ctl *ctl)
+static u64 chunk_bytes_by_type(struct alloc_chunk_ctl *ctl)
 {
+	u64 type = ctl->type;
+	u64 calc_size = ctl->calc_size;
+
 	if (type & (BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_DUP))
 		return calc_size;
 	else if (type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4))
@@ -1091,9 +1093,7 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 
 static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 {
-	u64 chunk_size = chunk_bytes_by_type(ctl->type, ctl->calc_size, ctl);
-
-	if (chunk_size > ctl->max_chunk_size) {
+	if (chunk_bytes_by_type(ctl) > ctl->max_chunk_size) {
 		ctl->calc_size = ctl->max_chunk_size;
 		ctl->calc_size /= ctl->num_stripes;
 		ctl->calc_size = round_down(ctl->calc_size, BTRFS_STRIPE_LEN);
@@ -1158,7 +1158,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	}
 
 	stripes = &chunk->stripe;
-	ctl->num_bytes = chunk_bytes_by_type(ctl->type, ctl->calc_size, ctl);
+	ctl->num_bytes = chunk_bytes_by_type(ctl);
 	index = 0;
 	while (index < ctl->num_stripes) {
 		u64 dev_offset;
-- 
2.31.1

