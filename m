Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441D3F192F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhHSM2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:28:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbhHSM15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629376041; x=1660912041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=83QfKnRnxoXJ8jTUCFN0cJc2MTrBHcWtC29a2k/ApN0=;
  b=qb0na0ZPxJ8AnXMd1loutXnItHDFNEYI4aNAD3JX2gftzUKFCuqPAvzK
   8nggwsHl5ydE2jS2n+CkO26fCX6IRKdXdCOIReK+fdceYi1RYhsmhaSKY
   2HnHdVY86VidfQjYa1dZMnCRzvYDAQ7RyUxJOIR11z1ZCHAiijav5Ziu5
   qxXJ10TQjCWZj6vyfRC+uUMesfKWhTKn+FlcSQjfLNFZAZrzGmTtfaMrE
   EKI0CScZ6IWWCB6A40gbOHGIAZyJ2PfC1nus7RHyclBUs1dFFS6dqU1uY
   8PXnsZbNbARrP5Gy3kfsWapNvgLxKVAeYUG88TUHDPOu9Ntocku/O3knc
   A==;
X-IronPort-AV: E=Sophos;i="5.84,334,1620662400"; 
   d="scan'208";a="177773603"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 20:27:20 +0800
IronPort-SDR: dfGaTe7+4Zl0vm58PA2qHHmLcq71SNlbzwPvL0kqbaYJbUmawofcHT8NDH7Npng3l2Y1rfw7R0
 iVgAOJUot5WkKdVqN8vK5Ku23xqASQ3POthGs/AxZWZ5i3WZekmYKeULUtKljR215W3leVCjBl
 KG+8LfRAfZsrX9Wc5FDsod9CPry76Xr/QLVttsws0gI9SsPHPQlPf7OpXX3eSJI7898Drb8HAd
 yIarglg4mcY/zdYu6ZTZottRbPYu0kVdur14FCG+r67abrSSJ57LEru+gLKnt7GZa6DkGA65Ji
 Kl7hnsUp+Rwc8PwjmmvWq27F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:04:28 -0700
IronPort-SDR: h6JeO2w25Xc0lpj89UGXOxdfIvm3O06bYyMj0SahfbheJt3we24NKf6NWeU0qN24BM/aHH0cX2
 QO3NDFPTNbII7j4oDTw8oqgI3ZiEzh8+lCjwYLcdhy0sG1ZENg+zdVcHNHVJj5o/l/vrIgsE1t
 uqW9LSaaBduTlH0XUEixQkYVjr43CHVCxcRg4R+jG9AIISJn9IDra9Tl85gykvTyQlz29pJbr7
 vvE8R98GEr/uo7AGNqm1KhHuJ3OG2AG4uoLoFoSy2vCwf06GalkxsiZFb9AyrxIu9OVxv/xeW8
 2K4=
WDCIronportException: Internal
Received: from gkg9hr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.52.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2021 05:27:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 12/17] btrfs: zoned: activate block group on allocation
Date:   Thu, 19 Aug 2021 21:19:19 +0900
Message-Id: <246d2f2a36c906e1aa35555c5e63cd1945b852c7.1629349224.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629349224.git.naohiro.aota@wdc.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Activate a block group when trying to allocate an extent from it. We check
read-only case and no space left case before trying to activate a block
group not to consume the number of active zones uselessly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8dafb61c4946..ac367f1dc4e6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3773,6 +3773,18 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (skip)
 		return 1;
 
+	/* Check RO and no space case before trying to activate it */
+	spin_lock(&block_group->lock);
+	if (block_group->ro ||
+	    block_group->alloc_offset == block_group->zone_capacity) {
+		spin_unlock(&block_group->lock);
+		return 1;
+	}
+	spin_unlock(&block_group->lock);
+
+	if (!btrfs_zone_activate(block_group))
+		return 1;
+
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	spin_lock(&fs_info->treelog_bg_lock);
-- 
2.33.0

