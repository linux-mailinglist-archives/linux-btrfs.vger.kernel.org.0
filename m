Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296756C531
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiGHXTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGHXTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021724198F;
        Fri,  8 Jul 2022 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322354; x=1688858354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f2igtJVgD9KUWGwQbp9cGyvAS3rC0g3GISa20ZYjc3M=;
  b=WjKsMxmu2msDE92WPQv7iHrUhJmmtB7/pN+W1TkZWD3zAJ3+AOU+1ayW
   aUMJd2QAIq/iVrAoUnU5OT5zwTQBJY29AyXJYxbyt41tzhJatmC/eMeJr
   fCSKjucH8RLN4r8SYZOSuqhT5wQVdwq6/KT2c/QF9CymNbTkl0bvaTqIP
   hdWUcLwCRjjaK44I5pJw5Kxnoh8cRO3BBMp58eO9nRlquOtEBR41YNZpr
   cW1bOz7dDgyqR/m+iMQUTrU7a3y+GIeS1JdnLWgKCdhxUQXzgwf1bVAEU
   7DjoT7fQbE1Aa5Kj8crfaNhSXZwfpjO5x7/Br5p2V4/uE2JJ1OKYyLc5u
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871832"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:13 +0800
IronPort-SDR: w2kdxiJUA8WR27D+mQ6PjxG+0nEymtYVq5w+tMF0fNF83eVgAf6ty2CAvKbFyH+pvEoXIeUq/o
 dNw3/hvNtu7Z7VlNwLT4K3bznt7Uq2dtPtrycvebnaK5eJpve5t36dEyZlAdSP3RkYpBfGY4qL
 MUPWUJHfoWwTz1BuqlK5mWwUqXoVxtA+Ti7a93QardtdCL/YWJ6nR366cqNtUFQeMrey7cYCki
 NepmikcYjdQkWAwxIDzJQNM+lKGVicpxa4bhizshKaiQOXddCVVOdjuyKfz+REtMWVYnzlPlJM
 7kJzDuLokSril1zJOWKwx59s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:19 -0700
IronPort-SDR: YpjFQaxDmuUNh2/uhq5OtMaDTbryc3Um0+0onc9GHzUQhrvU/ZbktweZO2o/jqwLgD/IuO4bhe
 8zcaS556ieJIJsQ7Jh53DfHohNngwNZEzdqLdMe4vsQx490toyyQiC65wmEovTrrD3gu09gBA8
 Z50nVuyoOEpnqwD6N1V4Wz7wmz6bTwqxmKSCk3DeiygumbHPQDNUkIG1SPGrhMELsBFlXcCUHv
 NlbYf+3FPv34tlEbh+14HU8syuYn5qwYpO2WwtFcSHFS7tYwaKZbx4OqYWTFgRaCFv4r2dho00
 1Z8=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/13] btrfs: zoned: disable metadata overcommit for zoned
Date:   Sat,  9 Jul 2022 08:18:46 +0900
Message-Id: <42999b4386c75896ed14fde52d2d411a45824c0a.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

The metadata overcommit makes the space reservation flexible but it is also
harmful to active zone tracking. Since we cannot finish a block group from
the metadata allocation context, we might not activate a new block group
and might not be able to actually write out the overcommit reservations.

So, disable metadata overcommit for zoned btrfs. We will ensure the
reservations are under active_total_bytes in the following patches.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b970909c0820..7183a8dc9b34 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -399,7 +399,10 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 		return 0;
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = calc_available_free_space(fs_info, space_info, flush);
+	if (btrfs_is_zoned(fs_info) && (space_info->flags & BTRFS_BLOCK_GROUP_METADATA))
+		avail = 0;
+	else
+		avail = calc_available_free_space(fs_info, space_info, flush);
 
 	if (used + bytes < writable_total_bytes(fs_info, space_info) + avail)
 		return 1;
-- 
2.35.1

