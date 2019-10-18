Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA74DC1F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407890AbfJRJ6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 05:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389081AbfJRJ6m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 05:58:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44329B57A;
        Fri, 18 Oct 2019 09:58:40 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/4] btrfs: reduce indentation in lock_stripe_add
Date:   Fri, 18 Oct 2019 11:58:20 +0200
Message-Id: <20191018095823.15282-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018095823.15282-1-jthumshirn@suse.de>
References: <20191018095823.15282-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In lock_stripe_add() we're traversing the stripe hash list and check if
the current list element's raid_map equals is equal to the raid bio's
raid_map. If both are equal we continue processing.

If we'd check for inequality instead of equality we can reduce one level
of indentation.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/raid56.c | 90 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8f47a85944eb..9e8a6c447e51 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -682,62 +682,58 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 
 	spin_lock_irqsave(&h->lock, flags);
 	list_for_each_entry(cur, &h->hash_list, hash_list) {
-		if (cur->bbio->raid_map[0] == rbio->bbio->raid_map[0]) {
-			spin_lock(&cur->bio_list_lock);
-
-			/* can we steal this cached rbio's pages? */
-			if (bio_list_empty(&cur->bio_list) &&
-			    list_empty(&cur->plug_list) &&
-			    test_bit(RBIO_CACHE_BIT, &cur->flags) &&
-			    !test_bit(RBIO_RMW_LOCKED_BIT, &cur->flags)) {
-				list_del_init(&cur->hash_list);
-				refcount_dec(&cur->refs);
-
-				steal_rbio(cur, rbio);
-				cache_drop = cur;
-				spin_unlock(&cur->bio_list_lock);
+		if (cur->bbio->raid_map[0] != rbio->bbio->raid_map[0])
+			continue;
 
-				goto lockit;
-			}
+		spin_lock(&cur->bio_list_lock);
 
-			/* can we merge into the lock owner? */
-			if (rbio_can_merge(cur, rbio)) {
-				merge_rbio(cur, rbio);
-				spin_unlock(&cur->bio_list_lock);
-				freeit = rbio;
-				ret = 1;
-				goto out;
-			}
+		/* can we steal this cached rbio's pages? */
+		if (bio_list_empty(&cur->bio_list) &&
+		    list_empty(&cur->plug_list) &&
+		    test_bit(RBIO_CACHE_BIT, &cur->flags) &&
+		    !test_bit(RBIO_RMW_LOCKED_BIT, &cur->flags)) {
+			list_del_init(&cur->hash_list);
+			refcount_dec(&cur->refs);
 
+			steal_rbio(cur, rbio);
+			cache_drop = cur;
+			spin_unlock(&cur->bio_list_lock);
 
-			/*
-			 * we couldn't merge with the running
-			 * rbio, see if we can merge with the
-			 * pending ones.  We don't have to
-			 * check for rmw_locked because there
-			 * is no way they are inside finish_rmw
-			 * right now
-			 */
-			list_for_each_entry(pending, &cur->plug_list,
-					    plug_list) {
-				if (rbio_can_merge(pending, rbio)) {
-					merge_rbio(pending, rbio);
-					spin_unlock(&cur->bio_list_lock);
-					freeit = rbio;
-					ret = 1;
-					goto out;
-				}
-			}
+			goto lockit;
+		}
 
-			/* no merging, put us on the tail of the plug list,
-			 * our rbio will be started with the currently
-			 * running rbio unlocks
-			 */
-			list_add_tail(&rbio->plug_list, &cur->plug_list);
+		/* can we merge into the lock owner? */
+		if (rbio_can_merge(cur, rbio)) {
+			merge_rbio(cur, rbio);
 			spin_unlock(&cur->bio_list_lock);
+			freeit = rbio;
 			ret = 1;
 			goto out;
 		}
+
+
+		/*
+		 * we couldn't merge with the running rbio, see if we can merge
+		 * with the pending ones.  We don't have to check for rmw_locked
+		 * because there is no way they are inside finish_rmw right now
+		 */
+		list_for_each_entry(pending, &cur->plug_list, plug_list) {
+			if (rbio_can_merge(pending, rbio)) {
+				merge_rbio(pending, rbio);
+				spin_unlock(&cur->bio_list_lock);
+				freeit = rbio;
+				ret = 1;
+				goto out;
+			}
+		}
+
+		/* no merging, put us on the tail of the plug list, our rbio
+		 * will be started with the currently running rbio unlocks
+		 */
+		list_add_tail(&rbio->plug_list, &cur->plug_list);
+		spin_unlock(&cur->bio_list_lock);
+		ret = 1;
+		goto out;
 	}
 lockit:
 	refcount_inc(&rbio->refs);
-- 
2.16.4

