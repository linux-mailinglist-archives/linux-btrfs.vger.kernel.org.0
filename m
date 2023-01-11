Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33605665480
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAKGYJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjAKGX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:23:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535010FF9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Zj3A2WENTw0W7MKRon0E+ttSCQcf7whRE1tCwuw1YE=; b=hL+RBOWrmzf4oqzDX46uLk9E5I
        4KI4AQ0Md14eMNqWoRH1Q3gTKI33J+HZvU2g1Alnxz8ad+x2qZoLguITeOymgz5JahKoONWgEja2C
        03X7jzViW5B1Koujr5hssalmeZf52fUnqFRZPwopkcxb9tfLY5/l1aAA2Aa+Z50Qdd4tuO6XOPcbN
        v+1LCXdvJctf7spTpMoAEJZs94XoaF6Plwedo+roEbFgT7kz0CHRi9U4j1O4G4AaiE1tXrhpUU44h
        zYohgodPTEF1S83XSrRL3oXDvaaC66NbioU5APcBiu1LWBArJOmjOllOIM3DJ07e3WhbUA89JpIu/
        LBJIvKNw==;
Received: from [2001:4bb8:181:656b:8732:62ba:c286:a05b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFUWU-009rAK-87; Wed, 11 Jan 2023 06:23:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: cleanup rmw_rbio
Date:   Wed, 11 Jan 2023 07:23:26 +0100
Message-Id: <20230111062335.1023353-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230111062335.1023353-1-hch@lst.de>
References: <20230111062335.1023353-1-hch@lst.de>
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

Remove the write goto label by moving the data page allocation and data
read into the branch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 2cd5b1d7983009..0483f70a4fed74 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2293,24 +2293,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
 	 * Either full stripe write, or we have every data sector already
 	 * cached, can go to write path immediately.
 	 */
-	if (rbio_is_full(rbio) || !need_read_stripe_sectors(rbio))
-		goto write;
-
-	/*
-	 * Now we're doing sub-stripe write, also need all data stripes to do
-	 * the full RMW.
-	 */
-	ret = alloc_rbio_data_pages(rbio);
-	if (ret < 0)
-		return ret;
+	if (!rbio_is_full(rbio) && need_read_stripe_sectors(rbio)) {
+		/*
+		 * Now we're doing sub-stripe write, also need all data stripes
+		 * to do the full RMW.
+		 */
+		ret = alloc_rbio_data_pages(rbio);
+		if (ret < 0)
+			return ret;
 
-	index_rbio_pages(rbio);
+		index_rbio_pages(rbio);
 
-	ret = rmw_read_wait_recover(rbio);
-	if (ret < 0)
-		return ret;
+		ret = rmw_read_wait_recover(rbio);
+		if (ret < 0)
+			return ret;
+	}
 
-write:
 	/*
 	 * At this stage we're not allowed to add any new bios to the
 	 * bio list any more, anyone else that wants to change this stripe
-- 
2.35.1

