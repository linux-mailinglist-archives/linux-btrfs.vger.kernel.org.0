Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D0627913
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 10:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiKNJfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 04:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKNJfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 04:35:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47960119
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 01:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=93Bi2HPnr+3/UmniA99ta7uNHHmJMAIyrooTTtCqdH8=; b=3UroppVrzGQaiQY6h8CZUrZTIa
        1unsUknkr1ii8JxLq3S9/xwK/b9O34mczEeIq6K7A7gJFOS4DDVepVOlBU4ysUnw6C6k9mB7d/Hq9
        oCJwdFfpn0KXzExfDFK1aoMO68WG8CMh73LdxQ8cnJLOwG8Z0aT4H0sNE2mkXSUUQwsRfOCMXvNjk
        a9JmNWEUxcjjeWLa+vISsXNILxcYZ6aOuGymzpyRARbofQnGNwgvS2MaLdshRVXv+3gIRMCro1iWM
        Rg7UGj/Sl3RrEzQeWq1dWcPHEJ4D5qFvwdCcJXb8S1Chn0FjkDf6nNBOFBbsNcTDLxN0nmntKixzq
        O9Bx5lXg==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouVsM-00HDDI-5v; Mon, 14 Nov 2022 09:35:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix missing endianess conversion in sb_write_pointer
Date:   Mon, 14 Nov 2022 10:35:31 +0100
Message-Id: <20221114093531.1240849-1-hch@lst.de>
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

generation is an on-disk __le64 value, so use le64_to_cpu to convert
it to host endian before comparing it.

Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONED mode")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 57aae7694f12c..a055b10c6c884 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -136,7 +136,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 			super[i] = page_address(page[i]);
 		}
 
-		if (super[0]->generation > super[1]->generation)
+		if (le64_to_cpu(super[0]->generation) >
+		    le64_to_cpu(super[1]->generation))
 			sector = zones[1].start;
 		else
 			sector = zones[0].start;
-- 
2.30.2

