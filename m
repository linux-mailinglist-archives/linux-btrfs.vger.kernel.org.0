Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA01E6F5B00
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjECPZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjECPZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD8420F
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yXD+jTbNCS7N5VOG89TfXV+g5QShQoYV9xU9rWBfAJ0=; b=psaw4konW07JawJK3KIXgZeeAN
        bJOYO2DaG4CWWZog93bNWSe+OzrrUbgDW4RYgftlhTyDQGxVADK/4kNkWpqhr1R9RRr1Untv+8A3J
        mdGKPifNO4pIJHNsDtPIiH2f2qrb+HFpcdDY97a25eywTKYfJTdINQDAEGFKxV5JGnfN664A9z4Rj
        AmHzM4Z8djTBLkkmpFhkfUGxlMMw9anJncxR4otSSOtpsd8fyFn4kulh/5TyhgWo7hCkAG4EF5UD3
        h3BXPJijoNrJGPnez2xf+r3hf8urbXw4+p66yH9p5++m7WaoXzC+AsLaSWchEPYMe1kcfZJnS5kex
        408LlWnw==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELs-004xi9-1T;
        Wed, 03 May 2023 15:25:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/21] btrfs: do not try to unlock the extent for non-subpage metadata reads
Date:   Wed,  3 May 2023 17:24:29 +0200
Message-Id: <20230503152441.1141019-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only subpage metadata reads lock the extent.  Don't try to unlock it and
waste cycles in the extent tree lookup for PAGE_SIZE or larger metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index df77cc496017d5..4692aca5d42c15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4208,8 +4208,10 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 		bio_offset += bvec->bv_len;
 	}
 
-	unlock_extent(&bbio->inode->io_tree, eb->start,
-		      eb->start + bio_offset - 1, NULL);
+	if (eb->fs_info->nodesize < PAGE_SIZE) {
+		unlock_extent(&bbio->inode->io_tree, eb->start,
+			      eb->start + bio_offset - 1, NULL);
+	}
 	free_extent_buffer(eb);
 
 	bio_put(&bbio->bio);
-- 
2.39.2

