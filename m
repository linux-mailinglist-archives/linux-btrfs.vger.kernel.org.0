Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44817A7792
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Sep 2023 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjITJbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjITJbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 05:31:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE1AB;
        Wed, 20 Sep 2023 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695202289; x=1726738289;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8iVMZ37k3ebDLUhTpFcPxEFFHsyZo3NYBSCH5A0OsrA=;
  b=G7Pak7Sc+JuG6OMJ57tspIi+h+JVB3U0SDJfNaFcj5UN0ilaTZcvgJlZ
   ShxCIODDqg7iTM/fA0wa1BO616GAqkGKDmsuuOGuK8qEtUWNl3NkFxTnd
   c7Dac4Izz8qUhqmwR2C5UU6LXz5XFv59zD0mzLjKq0TnT/moRpdoJpzQz
   dmsxhaWHFtptsQJvSz5xLsX5Grr2lbaCeIwz/rTpH3q0eAv2c8FUYj46i
   9maYBFmu+8pZd34tMI/NFRQ7EOhTb2muFeH8toL/7UBK8qVyDA5CeHvkQ
   Frj6VNCljQ+rEcKLZCoA59lQL7bQczUd52STG4jhIA+AEJk4eK5zshIoz
   w==;
X-CSE-ConnectionGUID: WSxBuEPGQOKA6+++Iv+Gfg==
X-CSE-MsgGUID: Jk36h8bVTpuMdpPx6dXBjg==
X-IronPort-AV: E=Sophos;i="6.02,161,1688400000"; 
   d="scan'208";a="356502800"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 17:31:29 +0800
IronPort-SDR: MMjB/6VvgiF8t6Ko0Xa+LkEhxPq+6twTYPPUwXqIOkWWyCA/qL1Y57mM4jxsn6UMdT2fMWVZWQ
 /f0CUlKLKRWskB5lZVf847YGjfOuuB7cHdAgUNHjVo+BXnbmZik5ErduCMHH9UJi/yot7+nywB
 VLcTNgK8SL/t7YnMmLaEpDGdLqTMF0b4Qm2gxJyJhdzEpTHDWI1XaVuHGV2MDSO1fCa5ZCsF5L
 pLrJn34dD66VI7E7nV1RwU7HOF/36dqgI9bOQmXh5dgQklLV2Ka3uKIZe2LgdcKpVEth/kP7wE
 1rQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 01:44:04 -0700
IronPort-SDR: 9zEHcTSQyQAe7+FWjnrfWthoNTS7foNY/Tgzg3SebtkBTXOEY0nI0AnI/wbF/JxJYkUOqoxG6b
 U1tVQQkubtgWUoWV+R9Q6o9g2gw13+fFWhk9SnFMw2+6PWmznLC3XgglUnec00BsQYMlq6g5ZD
 q5sZoJT/S1itbmrmF4B3PdqoCQ0yk2SjoPhzFRp/vKPrBy15Go1L73KEDYLNtlXc4FAcMnZB5J
 k8ZiILvU4+2yWFzwbC0uyKCfCa+9Y6ELiItiKCDtmEL4oV++Idb+ZY9EFtqO+O7hK9L6SX3jDt
 O8I=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Sep 2023 02:31:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 20 Sep 2023 02:31:18 -0700
Subject: [PATCH v2 2/2] btrfs: check for incompat bit in
 btrfs_need_stripe_tree_update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-rst-updates-v2-2-b4dc154a648f@wdc.com>
References: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
In-Reply-To: <20230920-rst-updates-v2-0-b4dc154a648f@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695202286; l=714;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=8iVMZ37k3ebDLUhTpFcPxEFFHsyZo3NYBSCH5A0OsrA=;
 b=mpEu1QDAPPZk0hKGOfkY1c/HD386Rd9soVUB+8AnTBwfd6f5GwIRPKlvUTodh77eF+ZgWdlfq
 +9dtoDCqNzFD9ANHnWagbxGDjTWqedSdVW4WPTw03XU0NdRM0/29Kj/
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index b5c64974e702..cdb58b38fcb5 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -29,7 +29,7 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 	u64 type = map_type & BTRFS_BLOCK_GROUP_TYPE_MASK;
 	u64 profile = map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
 
-	if (!fs_info->stripe_root)
+	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE))
 		return false;
 
 	if (type != BTRFS_BLOCK_GROUP_DATA)

-- 
2.41.0

