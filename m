Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3C7A4CFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjIRPp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjIRPp2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:45:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C579E57;
        Mon, 18 Sep 2023 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695051780; x=1726587780;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n8+tXm3WHp7oNeBpa7q8p5M/w6ei7Q0/BVkj3CYejmg=;
  b=Gr9+atfTmB7EwrZb9+pbFOxhHgHRJEiKnrTupVpRqv5c3Yo2Ygh2LwrM
   cr2n0jGPWuZekyNRDn6coIfc+cmMkCTKkSdB80iUk60mpQ5su8w3FXATE
   eQJVpqhww/6cBCppyuW6sdkJw3oJeDi1kpR+MsS80pMV6631tYG7XSx39
   rXC9rLX3806phRbsqaeJfO81KTSCQPjUAOYfQj1G938gUREtfrbYtEdn8
   Vb7RUSNqGHM+ZGFyJ0G0UaFMuWmO0rxOQcotlVnqdZVT6tHp1XRpQfK74
   dK/jisvIltx1gyrkOoD1VkhD97JjeV1aKNaoAK2e/sZ4CqulGYL8hA0Tx
   w==;
X-CSE-ConnectionGUID: TYkyqP4ST3Oinu5Y6Uz+Eg==
X-CSE-MsgGUID: /LIBPyh+QYa9ySrQXEYnVQ==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242446874"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:14:39 +0800
IronPort-SDR: BDETJMeCR9OVFN3fa75w6fuparJXxluOmIVb26Td1akDletwb6N4kIAdTB3zd/h6IiF35VGnS7
 elqbrX5GZhVgYzOlwU43/PGLfsWQNYpyeFAz1zuHdq7ngj6eZXbtgTvdeC4rj+cVN6fYFYj1+r
 f6++KLa5mAawaoU15Kge0jnaPQURg3uLx5B2aTB3shJF69i3xONuPCOdzUx/NLZgy0sWrTA3dh
 tTDHHOsFdWBumgh9y9V98kLg2ZChTYDyhRNdzvGcNWRUvqAaIqjPfrs7QRLfqOlwnoo5UwNXVg
 my4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:21:36 -0700
IronPort-SDR: cnBdLx5NHPQr919v73GaSxDzyljumcrn+rt1KiGGfwNhQRiePzknysAERfjPPE26puALZYLO4u
 6TEcLoh40gsLH4KSgpHZXRVQhcLvBMpBiVkOmE2ahttWWA4QwvaUgmWkPtNbrpE0U1xovPb3m6
 Q08d9BoP0wdITR7dWmC8cCVWDdih1toMdISHI+/MkpZZQoCxje4Qsbzp7Rg6PVOK+KmvRUZV/d
 a3BsOkloTJLCNtVV6HN0ktm0JRyHR3yl2sgQ77gJP0Z4G98PDuBrNxan48Pq85AZtDgG9PFFyD
 ABo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2023 07:14:38 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Mon, 18 Sep 2023 07:14:31 -0700
Subject: [PATCH 2/4] btrfs: break loop in case set_io_stripe fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-rst-updates-v1-2-17686dc06859@wdc.com>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
In-Reply-To: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695046476; l=1242;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=n8+tXm3WHp7oNeBpa7q8p5M/w6ei7Q0/BVkj3CYejmg=;
 b=DRXiyrPBfRUQuNzQ7pOQQSiNszDGICRsi9JCpNSyILcJ3Q+ng17Ove6cT33qIY9suFfj7WXT6
 2WCCsmVGEizAdJx8CoDPdHgSzq+CB6L1c63L1m2qg6qkGl0t5I8XGmH
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Break out of the loop in case st_io_stripe() fails.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0c5bd8d2ea06..d2a0ae9d91c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6576,11 +6576,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 */
 		bioc->full_stripe_logical = em->start +
 			btrfs_stripe_nr_to_offset(stripe_nr * data_stripes);
-		for (i = 0; i < num_stripes; i++)
+		for (i = 0; i < num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
 					    &bioc->stripes[i], map,
 					    (i + stripe_nr) % num_stripes,
 					    stripe_offset, stripe_nr);
+			if (ret)
+				break;
+		}
+
 	} else {
 		/*
 		 * For all other non-RAID56 profiles, just copy the target
@@ -6590,6 +6594,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			ret = set_io_stripe(fs_info, op, logical, length,
 					    &bioc->stripes[i], map, stripe_index,
 					    stripe_offset, stripe_nr);
+			if (ret)
+				break;
 			stripe_index++;
 		}
 	}

-- 
2.41.0

