Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C680A7A0A44
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbjINQFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbjINQFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237B1BEF
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707545; x=1726243545;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iAd9M2zZ4NMSY/nI1P/jXW61ZlJl9tSSeDR7DnVrWhc=;
  b=drz6dub/G+jVHmiLer7K+Sqyw8lrarLB6UsDmP8OD8kujghF6Gh5gmz5
   iTU7rDemvwVfgAgw9V4vnMbMDo778d2cKLvFwM5Y405PzeSzet2Wuv2yC
   YkeDz2u5eNC/t2/3bghm7fXQ8LhLSaV7cMeBE2KkWdLuxUFUDw9M7MdM3
   66UEje1vwFmQMtihfKfMh9GdH6lzK+6vQKMcQx6QEXVgEIfgfyfckE/98
   /cALFde4U6V39VLk8oe0PW4nCzqACUbBvayq5T4ouoRw9y9JoyC1x6dfp
   0ki6kjSV3FyZbxUV+Uj4xoFuF8TqXK/vxdOppJ3vNB9cquay7f9fAg2HH
   Q==;
X-CSE-ConnectionGUID: cCQOkBDsQxy4dBqOWc2m7Q==
X-CSE-MsgGUID: hsqoD+SYTm+7OVYMD4eHIg==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196092"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:45 +0800
IronPort-SDR: DFYmggBN0iIrB8Z6NkWWSyWdWJZthdB5cBF08v2LIA6+NJySL8exD+CO4bp3Ac3BwaNY+NUBzI
 apAhZcWIlyGOhe/u1HpxubAH5Glx79J3ypIA2Q8hak/CBcoUB+3TpHIktkfQHYOqHNlBQ1GgR0
 CDHUYvh8Zj8nNksoUKm7zB6h5RS+sWnQsWuAXXCJ9U1bNb280fh68IsoERR2pi7TTDperjRqFh
 Xse+qNxu3k/wehGnG9MGCYEpiy/qIq+DiBB/3sHxvqJfYqefTbbBCw5VSyYPtaeZuWeEv6SW9N
 /DE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:27 -0700
IronPort-SDR: 7rzxLi1OLqmJ2D9LUs5JGPmpve64EL71tYXTE4KG18occFFeqE8rnteapk4vWEGBvrkcfdkg9u
 2/zcgqT158ZK/MSwiB601edqtEbqWF2S9ae5c3ctShjTLMTxCUUgGPQjXYQPrSMVgT7ie5tOCx
 hzhYrfFHUK6IKWinCpZDVSgqt2WSZkuoWOTX3HycDqFbSbZ5ADOI8+y9Q9A5KuT1vhHDPsId2w
 yFkjMhTsNS9BrfM+QFq0l1hqmS9oo+XmTeiitBB7FaEnmhDqM6TR9MZCjSl4/fbiF89GyVEX3M
 U4s=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:45 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:36 -0700
Subject: [PATCH v4 5/6] btrfs-progs: load zone info for all zoned devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-5-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=531;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=iAd9M2zZ4NMSY/nI1P/jXW61ZlJl9tSSeDR7DnVrWhc=;
 b=ajH9JFSR8hW7dHqJpRbxl57FFuVkKSFnQUaBlWhmdpChZ2YexzbthvL7yKY9PUZ6dtPBkd/Db
 nlGh4qqaIv2C+g7mUZImUHBCWr0YPJjCniGgDvD7MnfpEvdLE6NP2J7
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
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

