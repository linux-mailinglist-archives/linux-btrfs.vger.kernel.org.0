Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41158B471
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiHFIED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiHFID7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D613DE5
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZNk/+yrxZbOkCYhW40N8VjWtPtgLippH3CaWLgpsSXU=; b=NdxCxoM2Qwe4Kn7khhcO1kv/Ql
        ISSEEUXGX7VDwYhQhu6Aj0BqRJH39AwcGu29SuMi44RqVh7CRRnek4vdhpkO6y1JpHlTXM5e4RIuN
        TZ9XolzP07wzNPnlCPj0nNb5/ykG16gUncUzqbFKDJNkZK+IXMwuaSTkZM7JsrnR0/M8SKRBNLxZl
        wi8aDBFQP0N7n7fbRM1cOkOMRs3LJfYx0iV+gXW393Nny6SlIyf+WUBJXLwVk0kCxIp8TwRlOZiXl
        VleAuBTGlQNFSrVqgkD+fdcWraW8ep5IyFc8prRID83roPZDHz/XxM7mai/UDqszD9xuHhh+DFP+Z
        SqVvbkOw==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmp-006LvW-8W; Sat, 06 Aug 2022 08:03:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: simplify the submit_stripe_bio calling convention
Date:   Sat,  6 Aug 2022 10:03:28 +0200
Message-Id: <20220806080330.3823644-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the orig_bio argument as it can be derived from the bioc, and
the clone argument as it can be calculated from bioc and dev_nr.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5c5beb789594d..df8e2a5b88bb0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6782,13 +6782,12 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	submit_bio(bio);
 }
 
-static void submit_stripe_bio(struct btrfs_io_context *bioc,
-			      struct bio *orig_bio, int dev_nr, bool clone)
+static void submit_stripe_bio(struct btrfs_io_context *bioc, int dev_nr)
 {
-	struct bio *bio;
+	struct bio *orig_bio = bioc->orig_bio, *bio;
 
 	/* Reuse the bio embedded into the btrfs_bio for the last mirror */
-	if (!clone) {
+	if (dev_nr == bioc->num_stripes - 1) {
 		bio = orig_bio;
 		btrfs_bio(bio)->device = bioc->stripes[dev_nr].dev;
 		bio->bi_end_io = btrfs_end_bio;
@@ -6844,11 +6843,8 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 		BUG();
 	}
 
-	for (dev_nr = 0; dev_nr < total_devs; dev_nr++) {
-		const bool should_clone = (dev_nr < total_devs - 1);
-
-		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
-	}
+	for (dev_nr = 0; dev_nr < total_devs; dev_nr++)
+		submit_stripe_bio(bioc, dev_nr);
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

