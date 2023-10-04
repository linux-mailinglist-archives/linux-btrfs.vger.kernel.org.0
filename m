Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8537B792B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbjJDH4c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 03:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbjJDH42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 03:56:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A6AC;
        Wed,  4 Oct 2023 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696406185; x=1727942185;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+rpwer5aJHTGV8tKBiNFMEqa/oSZvlhrh7ptZ83X8Hs=;
  b=eQiVDOKoSnRQu27G1Q63LSg3EyHo3/QY+DxnTdRTnYX5mAYLEQYcw/j+
   wXehgeBO+JR2kVcyj8C5Bqzd6vzZ7fMA89U2GgjNLpL6zxpMbXW2LyCPb
   feXVTh1u5+wX2wZKJtt94UHdRQY5fWT068gnqBccZz1pEs4/avMbpP1qo
   fgIt4SP9HflujXHR8p6IItoKpm/mUHtjsp4Im+5TyNqHcNAmEHGBDCdzs
   fFGePOh+9oZ2+XHi0ZjwEGBs+zxZ+qNeP1kcNKoJcH+KUXTQhubnGhCUh
   x+eMJ9HqhFO5Q25r+BhtOdQO8WlISr3ppz/b1iitsPZd9sIp4W7fCODwO
   g==;
X-CSE-ConnectionGUID: 0BTl8Gs3RvCsybL0Dv/UhQ==
X-CSE-MsgGUID: YAQdQu+nSrSLEb6SX85/AQ==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="351024164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 15:56:24 +0800
IronPort-SDR: lEn3nUO0s1/ih0kKKjXXW+hZDe7B1CTR1i2pRqP++iZSRnHVjqezNHrZgXgHZ/Nh0dSvwZ3+nd
 b7HCUdKpdHOkemxuYET1MglVtLAfkxyeUNPbs+cFpjBydBZCVeRCTvXyaKrCNXxEx//NZRpDi8
 0erAEVl4aFJsDXGqloR2pcADE4RrmlDCJQKupA85L2eWtWvkBQDRHBYorUNyRwgMtQnAxTJh3b
 ncjuTpb4Fq07WgQcHHdwXforR3/AKgp7k+/voK1//cuWCyOAnUieNiMYVCCa6If1NiKjVVQPW/
 NOo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 00:03:02 -0700
IronPort-SDR: GdLfE7MqiqgQ5NE0Qwt6Z/UiQy9GUgSqF2KqMRFJTBePsObtVcO2yZ7AvAMg/6dxu4AW0TwdrB
 6MTEeb0akGEjAVWapE8Qxp5yYkiiDe6dD/dSCtHyad+SaOnmxnPnehAardjsn8/07iL2xf+76U
 hyZ/n/roguX7s9d+N9xsMHNbeQjosnF6obI4OJ7pyHI1HIg0uN4fqpqQxZh2Ex/sdzUoOgP6cq
 w2xD7tKWthuBy3bKmR/3qJMM11EJAY/hqeNCILbE9TcBbtvpxfPwn/IJ5BWBRDyBCeHo8CwOmT
 S8w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2023 00:56:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 04 Oct 2023 00:56:17 -0700
Subject: [PATCH v3 2/4] btrfs: remove stride length check on read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-rst-updates-v3-2-7729c4474ade@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696406180; l=879;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=+rpwer5aJHTGV8tKBiNFMEqa/oSZvlhrh7ptZ83X8Hs=;
 b=9hiIY4SWywRd+xkjGxXBtyXHIbTYuXF2rdSQFRyKyaykhcSRR6adSUIXXNeY4559N3vZWbQxr
 dtvil4DqvckBaMQBMdVJqHT817/W+TOLTEkOD5UahXQti+U6fngK39g
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 248e048810d3..944e8f1862aa 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -237,16 +237,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_stripes; i++) {
 		struct btrfs_raid_stride *stride = &stripe_extent->strides[i];
 		u64 devid = btrfs_raid_stride_devid(leaf, stride);
-		u64 len = btrfs_raid_stride_length(leaf, stride);
 		u64 physical = btrfs_raid_stride_physical(leaf, stride);
 
-		if (offset >= len) {
-			offset -= len;
-
-			if (offset >= BTRFS_STRIPE_LEN)
-				continue;
-		}
-
 		if (devid != stripe->dev->devid)
 			continue;
 

-- 
2.41.0

