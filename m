Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96E75EA70
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGXETD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGXETB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9A131
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172340; x=1721708340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ljIh24FNWlgJBFOhpynLtk4jSiZqbvtiBu5m7M+TjI=;
  b=CKdSShYChMIYJFXLfEbxdVhFqf9wgfGLMm7GYPRTT1eSLcuPczit8Myy
   /B6i2Qj40zIhzKYYMt23vLgDdqzuTNMQNpTy5JXAP6X8veIYLtfybqXYZ
   YzOWZGtnkY8tHvHkjMs8kX1B0OYWG5++4MbcoepL258KYbvM3YNe4vHBT
   Kl19mZWP9bx/cY7ySNjQtyfl4pkObNkb7JlsX+jQh5lzspHs4Z/canOK3
   HzSJsN30z/txlhKm16oSLPw5GBko5gkKX+H7uWbMhmYveqwqvUEHlty3P
   VBl/4SbwlqZkqY+CnmTBGwhAxiAx51MvGX7iFzg4qTptIh0QB3hAhDN0j
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524373"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:18:59 +0800
IronPort-SDR: rnXIbDwoX4/jcTuRYABuPqeKjO35FPhkzlr0QQmMm89YGA0DRcbsECs4SuEVadW/nrkjK5Tm9E
 KPw9DZhuO7iCC0/ckLTReDSzQgGm1NN1JjfutrPWH5vzkrR1lqhjX/Q/SWwGMz68zzV8C0jG63
 601iwPupsP+V8z1Dj4Lfe5uPh3CnmLDcTTKxFwXq9meZ8Gl94brp+4odgFhI9+5l7AI4gTwHKb
 Qlgja1uPaLVorTsJ+V4qIPK6CwKFHkOFAj+o29zIRczLB+xVPR7sqv9x/KBkNad6QU9Ap9r5Lw
 +8E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:05 -0700
IronPort-SDR: isEoQpJzqmsUpNJAK2fUied295LnhJ/Wo/iMU5IK8F/z7qwKdmmcZX3gQHJYvXpYljbprQBYyh
 hFNSrla6Vbyoll5oH++8w9q5pMiRXXY2708x3+wujJGYUdMdC2A0rz6bHpwA2IPjKlGqfxg40X
 eMKedK3XPocgnvMSwBmZ3BuVbZmXYT304DTbxLseu5B1CFrh8GKFSCcbXHqgWjfn3ynHFZ6Hj9
 7ffWrxWvCoRT50kwiw4asDO1/RaGzDJjF2PVNAxPWVM6q4X8Qd+Kwi+PRUOEZkmuETMLwjRqGE
 KyU=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/8] btrfs: zoned: update meta_write_pointer on zone finish
Date:   Mon, 24 Jul 2023 13:18:32 +0900
Message-ID: <61507f174fbd62e792667bec3defed99633605bd.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
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

On finishing a zone, the meta_write_pointer should be set of the end of the
zone to reflect the actual write pointer position.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3f8f5e8c28a9..dd86f1858c88 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2048,6 +2048,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 
 	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	block_group->alloc_offset = block_group->zone_capacity;
+	if (block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
+		block_group->meta_write_pointer = block_group->start +
+			block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
 	btrfs_clear_data_reloc_bg(block_group);
-- 
2.41.0

