Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C279BD4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355911AbjIKWCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjIKNXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F3193
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694438596; x=1725974596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iAd9M2zZ4NMSY/nI1P/jXW61ZlJl9tSSeDR7DnVrWhc=;
  b=Mqr1P/v0c/mMad3dZqqK49AWyG2LSeumqgyFs/FKFpTlPIeOGn3UwTPN
   xlGQdxKlklX75ADC3IFHEOMvaUltZzRONuUFN4prNOHV8y+SxiSPBFc8O
   5xV+lED6Q1ELkSDtyigcTcqQr7RlZ18jcLZ6vFmpkYsiTjDBsE7peQfLd
   Mq3SvzVPivOrSdeUYG3tZm16bM7r/Bp/NIvklbyf53Qr1y9aLC1tKsxLL
   vlU5Hj0J0U/QYN/4p3boCmWzcd/d5HLdl9Ma/9pupsw97Cz5fMV9xsOT2
   vwv7CLF0iFfYkVc7KcnwXv+Kjw0JvljH3kz6tuqkmE7C5Necm3IJdfa1J
   g==;
X-CSE-ConnectionGUID: GtBT3eW2TM+pQtpuZk0hcQ==
X-CSE-MsgGUID: b0P7lbMWQ4aoyj8Y1Y/W/g==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="248143284"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 21:23:15 +0800
IronPort-SDR: Jwn8A35XwoeWg6g3+fn5mBnV86qNErP+pL4Ps+sNMdHCLfNLiSQbPDrrAoiNXIi5A91vpqgZTQ
 +VU7vXJj7WYJB6Kb6T+Zp9GV7SIVYg+prQF1LWoyHEpOVqoivgPfww5ySeIgYVFC0HUpXBTw70
 RS2/iUg5I/e6cYpTENF9AyD6Jcmb4vs7sbRcVkS5CqcwEwLcBwkpYnBAybcFp1yoF1vlTHlcdE
 68QjaeAPN1DF/rV/HiL1EiBxjShtJ0lho8lXHFUVN3dEhfLHrvhE7SnhTfYdkeBdJOwA/QNwxH
 jWk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:30:20 -0700
IronPort-SDR: NmnmhoSykl/C2vcMNk5MLfrtysK3dDrZ3xNhqsMS/npCnjKRRsuONg2A+Xh5J3mciCjNiw3U7x
 9FmQoFJ2Qwylf8NjDI57Qh8pHeKCJS7WYOde+w5bnKLhddW1XKsPB0Y157n3oIHqIpdiibcOLq
 9NEZljO+RYS9kum6qkcX3RYkh9ZqTIsjgVt5CXyUY1bQmHdBDNS+ErImu4mHDQjt8pmpo0Mwaw
 WJSq3JWIFO7/lN1epJv7GgJnQNl0R55NZr1GfERt4uxLw3IjNg5OCSvEcysNeYcY8s83LP8iTv
 h7o=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2023 06:23:14 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: load zone info for all zoned devices
Date:   Mon, 11 Sep 2023 06:23:01 -0700
Message-ID: <20230911-raid-stripe-tree-v1-5-c8337f7444b5@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
References: <20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694438542; l=531; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=iAd9M2zZ4NMSY/nI1P/jXW61ZlJl9tSSeDR7DnVrWhc=; b=04y44cpQK3oYE3EFlzzlwqz36ZP8wHKt14qkihxMtPhI0ruuroL5vvDLsRXl+arHhsm/DLdbE TSCHS4P0WxKC99S1dLdgD1uA0EmO3KV6FQOTSWgy3IA3IHFcy6v9Hbm
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mkfs/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 7d07ba1e7001..8a27704ac29e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1732,6 +1732,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 	}
 
+
+	if (opt_zoned)
+		btrfs_get_dev_zone_info_all_devices(fs_info);
+
 raid_groups:
 	ret = create_raid_groups(trans, root, data_profile,
 			 metadata_profile, mixed, &allocation);

-- 
2.41.0

