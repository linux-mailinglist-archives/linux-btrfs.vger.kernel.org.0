Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA40769F4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGaRUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGaRUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC22110
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823949; x=1722359949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vEOtRxCSRKx2pAmA1DUGLA0cJmEAPn5KhY7gJ9HmTRU=;
  b=IP8JjM3jUzI9kj3EysqtpBUk95INa/QST+JBLjmgqxJTiR8fp4miOPAN
   G+biGQoaC2nzifT5SaifF45Af5mBh1kxOZ2xuBps/NB0NjyoG0anieb2a
   9EFqKY6NzFvqmsSeythzG4eMchFI53ycp9FDMYkV7PRHrVEOXk6tEty2Z
   u8fjY3yEXseyy78gbBUiuIxDcDHYa8aFHWAbMclBCDKtz37R0rnBqz66C
   frVx8qafqxm3R9pKetvfCppVunheeDpkS3xEDVJyKRp4fS/JR7A1EqbPj
   UZFLAvQU/L0WorphU4MernA8bzeB1tAE8LJW/OLrSKRL27BZRqLv2DiB7
   g==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269562"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:37 +0800
IronPort-SDR: echdY/PDR9eLQt5aNCdkpOmuOOgnjDI9rS90c/KThTnjUxo/YNXFRgtuV2ARmivmtHX4j0wEjN
 2dA6XIehJw54cvmWdXBoWYc4Yvf47pfAhwnS2X5t8202D/PPg9caohhJq60YzEMC6MC19JDJ/K
 5Kl/WyVjTBkJSCOasuH17o2Uqgg9gIef7gsRCa4Gy1DYhNlm6xyXh6sh4UNeEXZCPAPMTJc8X7
 HDT9ScR2J/64Pzvkmh6eb+Nr6uRvLh0npl/DhgJiARbI4c3Cg0IOu32qMIDCERJeLgi4vU1Qcu
 a2Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:14 -0700
IronPort-SDR: 2OrkP3CgvIQIR2ISWXDc6FuVBQbDl5igohG23Q5DIQGEtLSZKNtc/NaNwlPG+6T56fekv9iSkb
 vcoNa5eVAvW0D7rQAfiBkm5Oeny8lM/2pJY6ilGJe3ZRfZfWFF/FnLTp00Booc/YUgiLwFKxAD
 oqbG7n0OBKXUnAwe/iBoC3Uq+zo7OMC+6adJh55LMzBhYW909ChWm0w3o1esfI9DdoxWCDPOgT
 qUSmY+z9xgsFSi14tgfA0ySTGdcaXYxSLrKklP6NauXWsTQ/RHE17ELeOJqLvCXVUxOct8P++4
 b78=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/10] btrfs: zoned: update meta_write_pointer on zone finish
Date:   Tue,  1 Aug 2023 02:17:14 +0900
Message-ID: <22b2378b5f33e1b7f244f6a930f1d01821804893.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On finishing a zone, the meta_write_pointer should be set of the end of the
zone to reflect the actual write pointer position.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fa595eca39ca..3902c16b9188 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2056,6 +2056,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 
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

