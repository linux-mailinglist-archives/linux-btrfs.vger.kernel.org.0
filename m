Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E43702850
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjEOJWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjEOJWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 05:22:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CEC1989
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hdpHk8QkK0ZBo3oRfPD5O1FhkU4yUddPnBxIYKPd3Eo=; b=e5cpsB2JXYTfCQezFGsWl4ovuP
        sgYsOPQR3iahyQtpgigwwkL9qkcoxhw3RDLZ7FbdWYENb0xxfQI+tvdZ9YHH9zmHaEYPj1nm1wuNJ
        v7qKS/Q7F+MjomraKJmX28fyLNxJ9Tu3sYsh9SFYz/lLeDQa5kwrgdcJj1kB7/+7j9WYCd88Gg8hr
        bHALvv8VkR1wua4f2rcvsJsOq1z+0ietEBod11g1ONfIUK7sB5K4KiM7yZRQ6LZKc4FyGHduPEblg
        nK/pvBbBVT7hxYo/41RBoKSQnVC3ZmPdqpkmoYEENCrOMm6O57e/JfOCGz7PwByxpWYX58RzxlbaL
        Yk31XuiA==;
Received: from [2001:4bb8:188:2249:a9c8:a66b:dc10:3abf] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyULa-001WyZ-27;
        Mon, 15 May 2023 09:18:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: call btrfs_orig_bbio_end_io when btrfs_end_bio_work
Date:   Mon, 15 May 2023 11:18:21 +0200
Message-Id: <20230515091821.304310-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When I implemented the storage layer bio splitting, I was under the
assumption that we'll never split metadata bios.  But Qu reminded me that
this can actually happen with very old file systems with unaligned
metadata chunks and RAID0.  I still haven't seen such a case in practice,
but we better handled this case, especially as it is fairly easily
to do not calling the ->end_іo method directly in btrfs_end_io_work,
and using the proper btrfs_orig_bbio_end_io helper instead.

Fixes: 103c19723c80 ("btrfs: split the bio submission path into a separate file")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 40cadab7df76a7..2d474ff7df601b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -357,7 +357,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	if (is_data_bbio(bbio))
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 	else
-		bbio->end_io(bbio);
+		btrfs_orig_bbio_end_io(bbio);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
-- 
2.39.2

