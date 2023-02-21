Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E627A69E72C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 19:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjBUSNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 13:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBUSM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 13:12:58 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5B302B2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677003145; x=1708539145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h3Nif+4lPudarHnPiCl0Jm9VYedMD7EceXBt3fYC/kM=;
  b=rDDX5LrlgrMBaLQND9tVWY70dbLY8D1IlkLmExZp59u7j/5oAjIqyEs7
   qdzQ3LiOXkygyUOIfUQYLlWao6G5Lz/DUi9onMkBj3iCJMYosCppiIb1p
   AknhFKtykF5WVzENrUuaaByZZK1YVh/As+78oLJINYyVGNO2RBxJJq6ZU
   64Y14hiSH9VjAs3qIN3Q5IUc1ogUwH3T7COiEETgHQotzhP5fQHpriBJu
   NRoAutPjWxRJXdHpDxW8VqELn9r01Nsg7hJgWBlSQjPT8mQtMwQ30ALfz
   G/4wW5V6wrvDCSBxjY60lHeEQKmzTwUFynA8W0uiJ8O/hY2Jvw+EqdqK+
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="223840296"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 02:11:31 +0800
IronPort-SDR: BPSQRDmrvf0svAhGC8mUnGh7KS/g2Go7iHo/zNHk8JZunl2CWCbilKCqo1Z0Y37b3rha6myIWr
 XJlkavPVBykpv6FUAXcs/CQjVjize9nRlI6wZYGLi566uc00r9/9inE9DWVmMTBMI5wpfBK8Qe
 806xeAkr9eJHL23szuNrjnPRxrUn/F1j6hjoFptPn5pJDXQGaSWccsXEWNX5VcLooKqZlBiipB
 tUDgjK97igbEPx6S7B0DpmNyEBZRK/Jv/0yUese3UF+LNxOKrwHW89i7Mdq2GNeRdwl0rd0zwW
 5zk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 09:28:30 -0800
IronPort-SDR: 6L9kfAxfOO/ST94f9phXzD5kYZNGrFEJvU4bkPfFnsjmZAQHm1CZBAobsS/AU2H5uyIa6fHt2F
 J0fK9aOXQBZa8XjLM0YU+RBtTLT0aJrpwTeoE2W5bJOyPiDL5EjI1FYszP9ElWJxL9FAy02jwY
 W7NscQSdi7Z7GoCr2YYA38SFNmlTMR2CJXCNc35rQlU4KY97DSR4rCiVuK5k94gpkC6W8f7NhV
 TAu7Gc7UmtugtW36KYdMKc7UJlNQsrwmDcdh+hlcSv5QyWI2oxPa2GDtvptSEszfvTJpUv56xF
 6q4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Feb 2023 10:11:31 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Forza <forza@tnonline.net>
Subject: [PATCH] btrfs: fix percent calculation for reclaim message
Date:   Tue, 21 Feb 2023 10:11:24 -0800
Message-Id: <6107ccae94e0af75c60d1d1f6a5a0dd59aaafc58.1677003060.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a report, that the info message for block-group reclaim is crossing the
100% used mark.

This is happening as we were truncaating the divisor for the division (the
block_group->length) to a 32bit value.

Fix this by using div64_u64() to not truncate the divisor.

Reported-by: Forza <forza@tnonline.net>
Link: https://lore.kernel.org/linux-btrfs/e99483.c11a58d.1863591ca52@tnonline.net/
Fixes: 5f93e776c673 ("btrfs: zoned: print unusable percentage when reclaiming block groups")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fe4a60d7a49e..c6b9d5a04f3e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1826,7 +1826,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 
 		btrfs_info(fs_info,
 			"reclaiming chunk %llu with %llu%% used %llu%% unusable",
-				bg->start, div_u64(bg->used * 100, bg->length),
+				bg->start,
+				div64_u64(bg->used * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
-- 
2.39.1

