Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034E674EA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 08:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjATHs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 02:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjATHsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 02:48:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96A3891E7
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 23:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QsezZ3Yyh4nvTrhpEwV8dLPvhr2dXb48IHLG2mnBDx4=; b=IQjfFYy/42E3aLejnSH0JyNw7z
        wxtUByqV3Gijjult78Y2Erui0uE3sK1IkeZkHyzzYYyEHdpeJ0TpugHUb6uIih33neCKoX/MhI+uo
        Lp+owglgT+yk/fTlEbtuhv8rwmy0mdUU32l1qG2A20Ab7lwVxgtJV0QtBnty8OcGk29EhWFPfyKbe
        CFUxN85gZECeUsc9JW55cQMcZKZWgYyeaY7Iq8MnDCL3ZlRxaNxsssecHyzwBHtBa1z7rjZhNOHlw
        GZ+PL6qZczm1gm/l/P5W97qVfRRWggPOuFc/5Tuy7tAUsVxxn3aBENbmMQizlFu0TVmapzoX1V9tJ
        OgHWhGiA==;
Received: from [2001:4bb8:19a:2039:1233:6ec3:7a32:5885] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIm72-008rxU-J5; Fri, 20 Jan 2023 07:47:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Date:   Fri, 20 Jan 2023 08:46:57 +0100
Message-Id: <20230120074657.1095829-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
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

These days all the operations that take locks in the raid56.c code
are run from user context (mostly workqueues).  Drop all the irqsafe
locking that is not required any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Note: this sits on top of the "small raid56 cleanups v3" series

 fs/btrfs/raid56.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d8dd25a8155a52..23f6550ea663d5 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -407,16 +407,15 @@ static void __remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_stripe_hash_table *table;
-	unsigned long flags;
 
 	if (!test_bit(RBIO_CACHE_BIT, &rbio->flags))
 		return;
 
 	table = rbio->bioc->fs_info->stripe_hash_table;
 
-	spin_lock_irqsave(&table->cache_lock, flags);
+	spin_lock(&table->cache_lock);
 	__remove_rbio_from_cache(rbio);
-	spin_unlock_irqrestore(&table->cache_lock, flags);
+	spin_unlock(&table->cache_lock);
 }
 
 /*
@@ -425,19 +424,18 @@ static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 static void btrfs_clear_rbio_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_stripe_hash_table *table;
-	unsigned long flags;
 	struct btrfs_raid_bio *rbio;
 
 	table = info->stripe_hash_table;
 
-	spin_lock_irqsave(&table->cache_lock, flags);
+	spin_lock(&table->cache_lock);
 	while (!list_empty(&table->stripe_cache)) {
 		rbio = list_entry(table->stripe_cache.next,
 				  struct btrfs_raid_bio,
 				  stripe_cache);
 		__remove_rbio_from_cache(rbio);
 	}
-	spin_unlock_irqrestore(&table->cache_lock, flags);
+	spin_unlock(&table->cache_lock);
 }
 
 /*
@@ -467,14 +465,13 @@ void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info)
 static void cache_rbio(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_stripe_hash_table *table;
-	unsigned long flags;
 
 	if (!test_bit(RBIO_CACHE_READY_BIT, &rbio->flags))
 		return;
 
 	table = rbio->bioc->fs_info->stripe_hash_table;
 
-	spin_lock_irqsave(&table->cache_lock, flags);
+	spin_lock(&table->cache_lock);
 	spin_lock(&rbio->bio_list_lock);
 
 	/* bump our ref if we were not in the list before */
@@ -501,7 +498,7 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
 			__remove_rbio_from_cache(found);
 	}
 
-	spin_unlock_irqrestore(&table->cache_lock, flags);
+	spin_unlock(&table->cache_lock);
 }
 
 /*
@@ -530,15 +527,14 @@ static void run_xor(void **pages, int src_cnt, ssize_t len)
  */
 static int rbio_is_full(struct btrfs_raid_bio *rbio)
 {
-	unsigned long flags;
 	unsigned long size = rbio->bio_list_bytes;
 	int ret = 1;
 
-	spin_lock_irqsave(&rbio->bio_list_lock, flags);
+	spin_lock(&rbio->bio_list_lock);
 	if (size != rbio->nr_data * BTRFS_STRIPE_LEN)
 		ret = 0;
 	BUG_ON(size > rbio->nr_data * BTRFS_STRIPE_LEN);
-	spin_unlock_irqrestore(&rbio->bio_list_lock, flags);
+	spin_unlock(&rbio->bio_list_lock);
 
 	return ret;
 }
@@ -657,14 +653,13 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	struct btrfs_stripe_hash *h;
 	struct btrfs_raid_bio *cur;
 	struct btrfs_raid_bio *pending;
-	unsigned long flags;
 	struct btrfs_raid_bio *freeit = NULL;
 	struct btrfs_raid_bio *cache_drop = NULL;
 	int ret = 0;
 
 	h = rbio->bioc->fs_info->stripe_hash_table->table + rbio_bucket(rbio);
 
-	spin_lock_irqsave(&h->lock, flags);
+	spin_lock(&h->lock);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
 		if (cur->bioc->raid_map[0] != rbio->bioc->raid_map[0])
 			continue;
@@ -724,7 +719,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	refcount_inc(&rbio->refs);
 	list_add(&rbio->hash_list, &h->hash_list);
 out:
-	spin_unlock_irqrestore(&h->lock, flags);
+	spin_unlock(&h->lock);
 	if (cache_drop)
 		remove_rbio_from_cache(cache_drop);
 	if (freeit)
@@ -742,7 +737,6 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 {
 	int bucket;
 	struct btrfs_stripe_hash *h;
-	unsigned long flags;
 	int keep_cache = 0;
 
 	bucket = rbio_bucket(rbio);
@@ -751,7 +745,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 	if (list_empty(&rbio->plug_list))
 		cache_rbio(rbio);
 
-	spin_lock_irqsave(&h->lock, flags);
+	spin_lock(&h->lock);
 	spin_lock(&rbio->bio_list_lock);
 
 	if (!list_empty(&rbio->hash_list)) {
@@ -788,7 +782,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 			list_add(&next->hash_list, &h->hash_list);
 			refcount_inc(&next->refs);
 			spin_unlock(&rbio->bio_list_lock);
-			spin_unlock_irqrestore(&h->lock, flags);
+			spin_unlock(&h->lock);
 
 			if (next->operation == BTRFS_RBIO_READ_REBUILD)
 				start_async_work(next, recover_rbio_work_locked);
@@ -808,7 +802,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 	}
 done:
 	spin_unlock(&rbio->bio_list_lock);
-	spin_unlock_irqrestore(&h->lock, flags);
+	spin_unlock(&h->lock);
 
 done_nolock:
 	if (!keep_cache)
@@ -891,16 +885,16 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
 	ASSERT(index >= 0 && index < rbio->nr_sectors);
 
-	spin_lock_irq(&rbio->bio_list_lock);
+	spin_lock(&rbio->bio_list_lock);
 	sector = &rbio->bio_sectors[index];
 	if (sector->page || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
 		if (!sector->page)
 			sector = NULL;
-		spin_unlock_irq(&rbio->bio_list_lock);
+		spin_unlock(&rbio->bio_list_lock);
 		return sector;
 	}
-	spin_unlock_irq(&rbio->bio_list_lock);
+	spin_unlock(&rbio->bio_list_lock);
 
 	return &rbio->stripe_sectors[index];
 }
@@ -1148,11 +1142,11 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	struct bio *bio;
 
-	spin_lock_irq(&rbio->bio_list_lock);
+	spin_lock(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list)
 		index_one_bio(rbio, bio);
 
-	spin_unlock_irq(&rbio->bio_list_lock);
+	spin_unlock(&rbio->bio_list_lock);
 }
 
 static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
@@ -1888,9 +1882,9 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
 	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
-		spin_lock_irq(&rbio->bio_list_lock);
+		spin_lock(&rbio->bio_list_lock);
 		set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
-		spin_unlock_irq(&rbio->bio_list_lock);
+		spin_unlock(&rbio->bio_list_lock);
 	}
 
 	index_rbio_pages(rbio);
@@ -2259,9 +2253,9 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
 	 * bio list any more, anyone else that wants to change this stripe
 	 * needs to do their own rmw.
 	 */
-	spin_lock_irq(&rbio->bio_list_lock);
+	spin_lock(&rbio->bio_list_lock);
 	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
-	spin_unlock_irq(&rbio->bio_list_lock);
+	spin_unlock(&rbio->bio_list_lock);
 
 	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
 
-- 
2.39.0

