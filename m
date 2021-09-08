Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE1403D7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbhIHQU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbhIHQUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117986; x=1662653986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5bnL7YNSud7hLrNgtGCkwrCrFlHG5rgQI9w0SAvSSw=;
  b=SH4WwZTByTNlynE5kZ5nwDQT0xumPaUB0GmboBYT+zIzgWKFb3ew4zXN
   toPsraoHK+NEcEVc35pfw2zAXfUaVhhNkWJCi1KQiXHi5LzyZIlsoocgc
   N7t7m4fPPtSmfC4HhJyuVqheMNV5PTrndDXii14+3oGDTZZvhQt/2qhGf
   P1dn3w1sqHYnXo5ET4z9yf1j1Y5+DTuZrjUlfM7U/KNYWYHqCQAEalTbc
   /EIvEfRtI3znIzasdSZDEg/kNuH20iLmfLV7kJuvzK+UAXHRA3ITBd0b0
   YDoAVFHUjC0GsVgFItXeTTPTqt+FVQWtC/6TbiZw3wlL1ZNRv0c98wYPb
   w==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493941"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:46 +0800
IronPort-SDR: 8CuLlsbkIoIm/bKn0z9xZvCjBQiJLxR3vm/zyg/aNlR3NqtOc7QbYwLCvKMNhZmnmNUTYc/blS
 75k7TZnMzKF4alJxI7+1ab+SuwWz/ndO7IuHf3HYAmvG6e5E8Isdut2ipOUKODGt3l2dRRh7ok
 jzaCOtQzQdW1Z0hyydeBXqBUDQ29UJ7YS5qg/pclnELAtIWTp97GH2N6YEijivFTLoUn8r52BQ
 n1hC4kWw1DHi6WpJjiIn23jzQ8HOXYvuCdIb600FM0pWsW7Op9Jv2gpw4gj0D7D4FEt5+VKmVx
 9C7yp4y6/7EMF5cWFoUFNWfY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:44 -0700
IronPort-SDR: h/VuA2cTK7UejJW4QRg/Tj7vaa0eZXuJvwiWAQN66L55iGaAxkXf2CqZSSkidl7hds7usbxKCZ
 h18SmnUDsU4W1G8sl6b/RDy9PTrF6h0gJXMr602jK8PrH+KtrFoeuZgZwW5njCJvHo0JgMQOFf
 jAfH+4ibsCPIta2Is0u3zYu5ou+kzpnQb3TIzHfc11nsO5oT158BGis5o1h4kvEdlKZ4jPYNNK
 So5LfADc6RgFRzZuwFKJxdu0Dscm817tVksEFPP6+W8aBHfJz2M2JVk/60zaoJdO7RadKJvDlR
 d0Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 4/8] btrfs: zoned: use regular writes for relocation
Date:   Thu,  9 Sep 2021 01:19:28 +0900
Message-Id: <d6e516cf9c20a8b410995cad4b3e65b5de8b2419.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a dedicated block group for relocation, we can use
REQ_OP_WRITE instead of  REQ_OP_ZONE_APPEND for writing out the data on
relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c7fe3e11e685..bfc3a48567a7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1490,6 +1490,17 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
+	/*
+	 * Using REQ_OP_ZONE_APPNED for relocation can break assumptions on the
+	 * extent layout the relocation code has.
+	 * Furthermore we have set aside an own block-group from which only the
+	 * relocation "process" can allocate and made sure only one process at a
+	 * time can add pages to an extent that gets relocatied, so it's safe to
+	 * use regular REQ_OP_WRITE for this special case.
+	 */
+	if (btrfs_is_data_reloc_root(inode->root))
+		return false;
+
 	cache = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(cache);
 	if (!cache)
-- 
2.32.0

