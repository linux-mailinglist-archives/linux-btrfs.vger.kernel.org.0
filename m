Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F659B838
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiHVEJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 00:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiHVEJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 00:09:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7E1182B
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Aug 2022 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661141353; x=1692677353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pNTnsxqGR73TaP9dAchMGXEFgi2HxJ9zCEbvX4mnuiY=;
  b=hPtdJffQYB5GfJOFUEE30lVcb5ENvEBvA8ZQwHZTu5ql84pmHh7HVDyw
   ohUu2bOatuQB4F5/MeZP/l5t8i8W1XwHwKCgK7JevVTFbdHRGgyMJS1cH
   8zz/M0Hi9fZcSd2h91Ewd68W6aMhiX73e14FbGBfoE1GA7LzQgG0BZKK0
   uM892iU6OtrAHNGNKOjW4HJUwatdwG7Pj6zIW76dx23DitaPBy4gMzCjs
   NmXT25nEUDwWLzbstN5Dhs7N8RhwRnvzcj0m0qpHAz/BJqLVcaatUEwOb
   XFqcl5H0Rn/OQmI46op7uULpN9Od7ekIJ6ZdHLrkcWy47krue4RNyaefS
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654531200"; 
   d="scan'208";a="313568403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 12:09:12 +0800
IronPort-SDR: HoWlckh8Ko4bUwq6jLAf4cEYMf8Jk7/YWFxf0XZZt9BO732oYXvqk29rQP5jTfHq8/xxMdrxgs
 x5su+5qToQ76QiwcShKfwAuv/G58srPl4TFs3EgCWfRcL1kgv7Uy9q7Np+rbTF22NGJD3ldtVR
 thuVs8RPENeuMN388/BIZbACjji2MtJ9A1hoo7RspIjXavk974UVM89TFZ/yuI1fi0orcxeGCz
 Els4t+CRCFuaYKac90FFiLXKnZ3uEBcSsgYc3JMO0oWph7PNMb1O6h8pQ7SYy8W4m5qhqpJgkq
 2AnjSg6RRh9DA2ME+Ez0U24i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2022 20:29:54 -0700
IronPort-SDR: VpUdOeUKx4xHZN9WyLvCZS2KxihC9uIiclmYaLFCWvowqkFTnxEVyyZbtyCuonbIVvGQgZ5zBi
 9/S6y4JmiSRJMkCD/tZMzRRCYdAmZXqCS8sRkuLShMnqFComsIClAqzyOj0DAofp9aVQstKD0+
 rG/ENO7elBH7jLjUu2AiGRJty7uhZHQmI4hdVDVrWGIDEK/QuUPD6hiSdUm2FvA8jADeXV9H/F
 j7Ok2N2IaqXo/e+6PWNlraz2m/m4znGIHABCJ9h4SdBOIIvEV+0a/UGMH0qUImLUZDeoyPdCu0
 xWY=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.50.191])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Aug 2022 21:09:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: revert mistakenly removed space accounting
Date:   Mon, 22 Aug 2022 13:08:40 +0900
Message-Id: <20220822040840.614891-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit ee1cd63d10a8 ("btrfs: convert block group bit field to use bit
helpers") removed an accounting of space_info->active_total_bytes, maybe by
mistake. Revert it back to make the active zone tracking properly work
again.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 61ae58c3a354..0043c09667c0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1893,6 +1893,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
+	space_info->active_total_bytes += block_group->length;
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
-- 
2.37.2

