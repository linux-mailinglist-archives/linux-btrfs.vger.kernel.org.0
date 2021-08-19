Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25C33F1934
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbhHSM2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46907 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbhHSM2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376046; x=1660912046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2Nna96c4js3hoGzXcDP7F0m3ZA/YEJruB6k/OwVLbI=;
  b=OwqkngVqU1KSn3edCdsTH1mnrBsR5OFr5LieAELGPFJO/eU/8D6JyN+d
   Uk6N6tdunOMc+5sRB1fuUgtNQJE7rqXsT1d1gDw7r+8CB77oD15tqCBkA
   e3ABR5mtJmoD1e8twzL6+6fRJ1VPTRyiMCPSYgRlrS+44OTiOP2LzLe7W
   v47s7lpezy0hULqVVobkFN4XzX/63rotVMRjNCamGVTS+rQ2IInI1+8XT
   9/rOjhkWiRiYwiaTKtgvId2TcH37/GTkxMwmPdYDYimcI/wbAN9e9qMDa
   R4UfoJRDJCtY0WXztBu5KGfZ6vC5f8qGOQXThvrnw9EAt2+qA8fg8p1Uw
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773636"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:26 +0800
IronPort-SDR: WWn35kOZk2ugrGRrucUjfcdLuf8iEpnqSrx3y9i44oiLZjdJCwgMFuIoE8kd7H1Yfct9kht6Tk
 F6OSZi/Se5qeG2s1+CnAzHC9TSLYy/jhv/ldITodJTgUIUyxbSbJ8J+n/ZafrtuoJyB279PLy6
 Uz4aS+7rLEPCXzpJ+9N/HCctyAbfBSKkqqvke3a8KriXA/tgpuAdOmG4qDzG+zCy01hhZ6hbKC
 Yzk22rpDs9lJecDE31RJfSSnFv5pZ6wfT7eyNYgcZQ+Guo5EHqqUc2nOm5lBHhnztCzEeBsa3U
 rqU6uSPELv4ZGRM1E7S6qrCH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:34 -0700
IronPort-SDR: hokmOs3jT+2oxyqCiOi4tY2lO1zGvejeqHcQLDTCgPvP2k9M52PrHFa8Vz5aAkzNXa/102zM6u
 uQVz3fia9QLghr1I9KgQAmX4k9990O96A2wSqaJ4flkWVCPdnGE+S57vgA6OyT185eWaTbRUY6
 A/+G+XbZ9okLbo4Y0xnsScDHlkrKG/RgDp4MWYl8pXoIMRIW1jRIrcviXPHU9el+fRi5pdAjWW
 Nnpnk4rY2QEAPxGu6dt3uH4hNRpE6LaxKHIRGbbli/KhSSqxj5YT3RfS5iI6pjEWWWbYwHtmGN
 GiU=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 17/17] btrfs: zoned: finish relocating block group
Date:   Thu, 19 Aug 2021 21:19:24 +0900
Message-Id: <be3dcaf4b7ea90874d3a7724ad4768034f3603bf.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will no longer write to a relocating block group. So, we can finish it
now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 914d403b4415..63d2b22cf438 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "misc.h"
 #include "subpage.h"
+#include "zoned.h"
 
 /*
  * Relocation overview
@@ -4063,6 +4064,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 				 rc->block_group->start,
 				 rc->block_group->length);
 
+	ret = btrfs_zone_finish(rc->block_group);
+	WARN_ON(ret && ret != -EAGAIN);
+
 	while (1) {
 		int finishes_stage;
 
-- 
2.33.0

