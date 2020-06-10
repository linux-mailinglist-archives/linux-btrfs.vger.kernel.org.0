Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37E21F54E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgFJMdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 08:33:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12382 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgFJMd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 08:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591792408; x=1623328408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1FcJZjdTxkREy1X3S1iMZVT1/faVLCWruKgGFYb/ZC0=;
  b=R75EmNR/3wOGZ3kIhf2BZBZArb08wSkMWLED+a9SqbWTHVUCHMLh+zMc
   mJK5gQAV/CNbr7PdUT3rwgq77P5KV7WVd1FzNV3jjlhp6cLd2gbNwdt31
   1WM170NdFYzNuczLkW+1qK0Jg1QNtQucrZo8k6KDr4zpeRedHWvRj96T9
   glEfBdETj5sSPeGCv1MaAOR1EAhSsz7ay/aw4BCw4HDYsviVYewkYgMQy
   C5PrI8GXv+uPZWb+W7aHZ2IYOyOHItIYNSRqvhLHi0mwhJQTCGgq7/A/D
   p6ap8v84dG4pR9icpx5XnTmZLD5DCRoReyAaZDFfX/BZgYUxdrvAmsQuj
   g==;
IronPort-SDR: lmP7C+4yCTg+p+mQ6gbPbQLGQ4Il1vWnI0kSwdQ24vmxyvIOTxoR4KZYqIxREPBIKDhwUEvVnI
 xoeuHx5ZMFSYKt7Gblcuw4dXWWc20Zjt/Ge02BU0c1EmL7bbVGM2LOufxH7S2LLz7vIj+iXZCS
 5ikLV8aALMCv/ARczvfhirweh95MiDLSxyaPiIL9n+hDcJs5uSi5owqFiTpAENkjmeaPfe6rhK
 LGQTymBh9ZFZE9SI2hyxtAIv6JHB/0UZxO96G46QNjbfWIL/DlFkijpxuz3NhCLO0txMGegnvP
 a8g=
X-IronPort-AV: E=Sophos;i="5.73,496,1583164800"; 
   d="scan'208";a="139632704"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 20:33:10 +0800
IronPort-SDR: 0J+8dcHfm14vs+vKLGQqKmRX/zqvP+8vN+R/IcTplJdLzVEl6G/R34yqUhwGkttOIDW8FnqWa1
 OeXQPiGYj79cLAOHbYqQyC86rI9Q+3uts=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 05:22:37 -0700
IronPort-SDR: /JsKXHT7rUjMF/iLqa/ptNDUInm1cghCnBjoXrMvgHx7y8iOdvgzf7k1C20gMrwMJP9wtpxukA
 2cXi+vBlvx/Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jun 2020 05:33:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/15] btrfs-progs: consolidate assignment of sub_stripes
Date:   Wed, 10 Jun 2020 21:32:51 +0900
Message-Id: <20200610123258.12382-9-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
References: <20200610123258.12382-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a table holding the sub_stripes value we can consolidate
all setting of alloc_chunk_ctl::sub_stripes to a signle table lookup.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index 9076f055f6bd..32d3dfe0decd 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1103,7 +1103,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	ctl.num_stripes = 1;
 	ctl.max_stripes = 0;
 	ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-	ctl.sub_stripes = 1;
+	ctl.sub_stripes = btrfs_raid_profile_table[ctl.type].sub_stripes;
 	ctl.stripe_len = BTRFS_STRIPE_LEN;
 	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
 
@@ -1160,7 +1160,6 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (ctl.num_stripes < ctl.min_stripes)
 			return -ENOSPC;
 		ctl.num_stripes &= ~(u32)1;
-		ctl.sub_stripes = 2;
 	}
 	if (ctl.type == BTRFS_RAID_RAID5) {
 		ctl.min_stripes = btrfs_raid_profile_table[ctl.type].min_stripes;
-- 
2.26.2

