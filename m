Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9BDC1F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407507AbfJRJ6l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:58:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390955AbfJRJ6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:58:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46B2DB57B;
        Fri, 18 Oct 2019 09:58:40 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/4] btrfs: remove pointless local variable in lock_stripe_add()
Date:   Fri, 18 Oct 2019 11:58:21 +0200
Message-Id: <20191018095823.15282-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018095823.15282-1-jthumshirn@suse.de>
References: <20191018095823.15282-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In lock_stripe_add() we're caching the bucket for the stripe hash table
just for a single call to dereference the stripe hash.

If we just directly call rbio_bucket() we can safe the pointless local
variable.

Also move the dereferencing of the stripe hash outside of the variable
declaration block to not break over the 80 characters limit.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/raid56.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 9e8a6c447e51..530719ff8185 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -671,8 +671,7 @@ static struct page *rbio_qstripe_page(struct btrfs_raid_bio *rbio, int index)
  */
 static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 {
-	int bucket = rbio_bucket(rbio);
-	struct btrfs_stripe_hash *h = rbio->fs_info->stripe_hash_table->table + bucket;
+	struct btrfs_stripe_hash *h;
 	struct btrfs_raid_bio *cur;
 	struct btrfs_raid_bio *pending;
 	unsigned long flags;
@@ -680,6 +679,8 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	struct btrfs_raid_bio *cache_drop = NULL;
 	int ret = 0;
 
+	h = rbio->fs_info->stripe_hash_table->table + rbio_bucket(rbio);
+
 	spin_lock_irqsave(&h->lock, flags);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
 		if (cur->bbio->raid_map[0] != rbio->bbio->raid_map[0])
-- 
2.16.4

