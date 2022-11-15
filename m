Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976C4629488
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiKOJjy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKOJjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 04:39:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20F713D66
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 01:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=s16ETC3gXqhcqEYR/y292h03aRN6uorjCKf2blHsR6s=; b=LS9dZkd1iJBBNbwXjYGTGZcghP
        DXvn1V+W+of+p8wEkjo3pvEo/lMs1JM8FNLhXBxZdjYwfRPhtwOkjjbR7tQmxdIqhe5mghUi18TDz
        GfXwbskFl3mZX8HASKdjzb0VCz1Hs4/fqB3Yez9Y1xQgNG0d9mjT77UyAR5cJMe19gUHVSou4z+vL
        k2VHrCOu5HAhXBalrt9LfBbSDvY/iYetnVEMV8wDdm5R4G41n0RocR3/kdISJOu/srTS/x1dQdWCI
        15kVaVmSAoMCSJFKMlOMbmMyvmK0/prpRf3L4JH66wTk197qgKvriF3VjKmSwDqE0m6onm4VLxoZC
        aPobrEOQ==;
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ousQ0-009U5d-E3; Tue, 15 Nov 2022 09:39:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix missing endianess conversion in sb_write_pointer
Date:   Tue, 15 Nov 2022 10:39:44 +0100
Message-Id: <20221115093944.1625659-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

generation is an on-disk __le64 value, so use btrfs_super_generation to
convert it to host endian before comparing it.

Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - use btrfs_super_generation instead of le64_to_cpu

 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6781c141a6b41..4b55a5c68826f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -137,7 +137,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 			super[i] = page_address(page[i]);
 		}
 
-		if (super[0]->generation > super[1]->generation)
+		if (btrfs_super_generation(super[0]) >
+		    btrfs_super_generation(super[1]))
 			sector = zones[1].start;
 		else
 			sector = zones[0].start;
-- 
2.30.2

