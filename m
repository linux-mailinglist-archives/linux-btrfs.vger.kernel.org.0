Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6A64B150
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiLMIln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiLMIll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:41:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC5192AD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5jdf34j+amEJsCbqD1YhToQRqv/TMDwaIQQFBK9KTS4=; b=d+B/UApPY/+1TG4WunMqQpAEkz
        3qNogt7t5vIP4ZMpmt9hs24Ec2/fOshIH2BYiQ3Pz6aowxVVtpmB/v9i7cJz+1nuqbHMqbsJrwdYF
        q+TABYeuwW773JE3Lzc2vOOD6SYkMby8oTQXs2NTSD+afmT8qxj79dzA2fBNDtDN//uAcOL1LGVjD
        4D3fQWrQBdganBJg1kxAdw4ifpiGinM/aXQVJ618H7ZIT2c/pqUtGeBK7C0VjFoujWm2hn4qcSh5n
        ElaFtaSXp6XWToXnSBy+BJmisKP7o2VfXqwgz0Is8obc1iOBqS124mZm0SguUti3OdsF+kESQDIhE
        arv/M/yg==;
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p50r3-00E0s1-9w; Tue, 13 Dec 2022 08:41:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: cleanup recover_rbio
Date:   Tue, 13 Dec 2022 09:41:19 +0100
Message-Id: <20221213084123.309790-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213084123.309790-1-hch@lst.de>
References: <20221213084123.309790-1-hch@lst.de>
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

The bio_list is only filled by recover_assemble_read_bios when
successful, so don't try to walk it and put the bios on any
failure before the successful call to recover_assemble_read_bios.
Also initialize bio_list at initialization time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e0966126ab27a4..5dab0685e17dd5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1987,7 +1987,7 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
 
 static int recover_rbio(struct btrfs_raid_bio *rbio)
 {
-	struct bio_list bio_list;
+	struct bio_list bio_list = BIO_EMPTY_LIST;
 	struct bio *bio;
 	int ret;
 
@@ -1996,28 +1996,24 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
 	 * caller should have set error bitmap correctly.
 	 */
 	ASSERT(bitmap_weight(rbio->error_bitmap, rbio->nr_sectors));
-	bio_list_init(&bio_list);
 
 	/* For recovery, we need to read all sectors including P/Q. */
 	ret = alloc_rbio_pages(rbio);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	index_rbio_pages(rbio);
 
 	ret = recover_assemble_read_bios(rbio, &bio_list);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	submit_read_bios(rbio, &bio_list);
 	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
 
 	ret = recover_sectors(rbio);
-
-out:
 	while ((bio = bio_list_pop(&bio_list)))
 		bio_put(bio);
-
 	return ret;
 }
 
-- 
2.35.1

