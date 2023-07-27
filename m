Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAD764DAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjG0IhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjG0Igv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 04:36:51 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F602729C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 01:20:02 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6862d4a1376so189956b3a.0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445698; x=1691050498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyLc13iHrkV+klh05yD71xFAgQY4jD2CPzn+LZNOh3k=;
        b=j/RnjlDR/6PJZ/VyI7X0aptMT1iXf8RcI3J7hjmtLDlbxdSOVetAiPedXKNsMAsgMH
         vW2t4XX80i81CSKm1+58CCJFBxWJpCYufXIihrr1Qh0iO58Dre4wc/nYIv2x1kkcDjep
         Q77tkS1cKyF/pOEivdyfGUKn80RYpS5tTRhJav3vzv1noykGmdY/2w8uvsgxbLtx6BmO
         OFB/9kEDCl8hjuP0RIabQrnt0SteIjjBa9je+XXYyBGZ78X0iI751Sfa8HKvZa7gdAPd
         T87WUXRoY50jn0E4HH6vQWiTU2dwGY69uu92bxpk78xQ0HZ4QCB+dWaTfpG84kK4Opxe
         wgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445698; x=1691050498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyLc13iHrkV+klh05yD71xFAgQY4jD2CPzn+LZNOh3k=;
        b=C2DHpG3tlgyDUhpuRk7ukzEB/JUnJqSuh94Sy2iAwnLVoY9Yy/JsxGPjpsE8EpNx9v
         BYxuJ2nfIGF+PekTHa5zEK0M9kyf7u4Bm1uxWR6Mv+q34ObaFpWpgFwH3Jfrm3WL+CB+
         6Y51tB73EIT90dNdEcbamyX7wn+yg8fVvpeTuWo810ZQxGupKrU/+nETWXYiCO5VlxPt
         GvzbZfYn1XuiTNhjBZFQ4qAe+MH8yKccYoyDHguJAnWlHcDUVXgTsDm7oR6IJYMlWIyf
         suX6UnovS4XCuHIUfzXswJH7l604lShGwpEQeSAONiC1imXMiEs62kbjQMsrwidXQpEe
         yL9w==
X-Gm-Message-State: ABy/qLaZ2rG5MNbCowUMGYTYbYOMR5hZt5QGsGvy8hP5MIMLsn1z+lmr
        2imDLgpfsUDnYRpFZlM+mRUKrg==
X-Google-Smtp-Source: APBJJlHHYMtR97FgZwPKg/I4FvBtMIi/WenRh8r+QxTKT4uZnBzRavnMRN782PTiMjlEUg18pWA/Fw==
X-Received: by 2002:a05:6a20:8f23:b0:137:8ddf:4647 with SMTP id b35-20020a056a208f2300b001378ddf4647mr5934103pzk.2.1690445698478;
        Thu, 27 Jul 2023 01:14:58 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:14:58 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 45/49] mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}
Date:   Thu, 27 Jul 2023 16:04:58 +0800
Message-Id: <20230727080502.77895-46-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we maintain two linear arrays per node per memcg, which are
shrinker_info::map and shrinker_info::nr_deferred. And we need to resize
them when the shrinker_nr_max is exceeded, that is, allocate a new array,
and then copy the old array to the new array, and finally free the old
array by RCU.

For shrinker_info::map, we do set_bit() under the RCU lock, so we may set
the value into the old map which is about to be freed. This may cause the
value set to be lost. The current solution is not to copy the old map when
resizing, but to set all the corresponding bits in the new map to 1. This
solves the data loss problem, but bring the overhead of more pointless
loops while doing memcg slab shrink.

For shrinker_info::nr_deferred, we will only modify it under the read lock
of shrinker_rwsem, so it will not run concurrently with the resizing. But
after we make memcg slab shrink lockless, there will be the same data loss
problem as shrinker_info::map, and we can't work around it like the map.

For such resizable arrays, the most straightforward idea is to change it
to xarray, like we did for list_lru [1]. We need to do xa_store() in the
list_lru_add()-->set_shrinker_bit(), but this will cause memory
allocation, and the list_lru_add() doesn't accept failure. A possible
solution is to pre-allocate, but the location of pre-allocation is not
well determined.

Therefore, this commit chooses to introduce a secondary array for
shrinker_info::{map, nr_deferred}, so that we only need to copy this
secondary array every time the size is resized. Then even if we get the
old secondary array under the RCU lock, the found map and nr_deferred are
also true, so no data is lost.

[1]. https://lore.kernel.org/all/20220228122126.37293-13-songmuchun@bytedance.com/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  12 +-
 include/linux/shrinker.h   |  17 +++
 mm/shrinker.c              | 250 +++++++++++++++++++++++--------------
 3 files changed, 172 insertions(+), 107 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e765d1ff9cbb..2c9327d27c3b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,7 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/shrinker.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -88,17 +89,6 @@ struct mem_cgroup_reclaim_iter {
 	unsigned int generation;
 };
 
-/*
- * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
- * shrinkers, which have elements charged to this memcg.
- */
-struct shrinker_info {
-	struct rcu_head rcu;
-	atomic_long_t *nr_deferred;
-	unsigned long *map;
-	int map_nr_max;
-};
-
 struct lruvec_stats_percpu {
 	/* Local (CPU and cgroup) state */
 	long state[NR_VM_NODE_STAT_ITEMS];
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 025c8070dd86..eb342994675a 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -5,6 +5,23 @@
 #include <linux/atomic.h>
 #include <linux/types.h>
 
+#define SHRINKER_UNIT_BITS	BITS_PER_LONG
+
+/*
+ * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
+ * shrinkers, which have elements charged to the memcg.
+ */
+struct shrinker_info_unit {
+	atomic_long_t nr_deferred[SHRINKER_UNIT_BITS];
+	DECLARE_BITMAP(map, SHRINKER_UNIT_BITS);
+};
+
+struct shrinker_info {
+	struct rcu_head rcu;
+	int map_nr_max;
+	struct shrinker_info_unit *unit[];
+};
+
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
  * We consolidate the values for easier extension later.
diff --git a/mm/shrinker.c b/mm/shrinker.c
index a27779ed3798..1911c06b8af5 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -12,15 +12,50 @@ DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
 
-/* The shrinker_info is expanded in a batch of BITS_PER_LONG */
-static inline int shrinker_map_size(int nr_items)
+static inline int shrinker_unit_size(int nr_items)
 {
-	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
+	return (DIV_ROUND_UP(nr_items, SHRINKER_UNIT_BITS) * sizeof(struct shrinker_info_unit *));
 }
 
-static inline int shrinker_defer_size(int nr_items)
+static inline void shrinker_unit_free(struct shrinker_info *info, int start)
 {
-	return (round_up(nr_items, BITS_PER_LONG) * sizeof(atomic_long_t));
+	struct shrinker_info_unit **unit;
+	int nr, i;
+
+	if (!info)
+		return;
+
+	unit = info->unit;
+	nr = DIV_ROUND_UP(info->map_nr_max, SHRINKER_UNIT_BITS);
+
+	for (i = start; i < nr; i++) {
+		if (!unit[i])
+			break;
+
+		kvfree(unit[i]);
+		unit[i] = NULL;
+	}
+}
+
+static inline int shrinker_unit_alloc(struct shrinker_info *new,
+				       struct shrinker_info *old, int nid)
+{
+	struct shrinker_info_unit *unit;
+	int nr = DIV_ROUND_UP(new->map_nr_max, SHRINKER_UNIT_BITS);
+	int start = old ? DIV_ROUND_UP(old->map_nr_max, SHRINKER_UNIT_BITS) : 0;
+	int i;
+
+	for (i = start; i < nr; i++) {
+		unit = kvzalloc_node(sizeof(*unit), GFP_KERNEL, nid);
+		if (!unit) {
+			shrinker_unit_free(new, start);
+			return -ENOMEM;
+		}
+
+		new->unit[i] = unit;
+	}
+
+	return 0;
 }
 
 void free_shrinker_info(struct mem_cgroup *memcg)
@@ -32,6 +67,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		info = rcu_dereference_protected(pn->shrinker_info, true);
+		shrinker_unit_free(info, 0);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -40,28 +76,27 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
-	int nid, size, ret = 0;
-	int map_size, defer_size = 0;
+	int nid, ret = 0;
+	int array_size = 0;
 
 	down_write(&shrinker_rwsem);
-	map_size = shrinker_map_size(shrinker_nr_max);
-	defer_size = shrinker_defer_size(shrinker_nr_max);
-	size = map_size + defer_size;
+	array_size = shrinker_unit_size(shrinker_nr_max);
 	for_each_node(nid) {
-		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
-		if (!info) {
-			free_shrinker_info(memcg);
-			ret = -ENOMEM;
-			break;
-		}
-		info->nr_deferred = (atomic_long_t *)(info + 1);
-		info->map = (void *)info->nr_deferred + defer_size;
+		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
+		if (!info)
+			goto err;
 		info->map_nr_max = shrinker_nr_max;
+		if (shrinker_unit_alloc(info, NULL, nid))
+			goto err;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
 
 	return ret;
+
+err:
+	free_shrinker_info(memcg);
+	return -ENOMEM;
 }
 
 static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
@@ -71,15 +106,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
-static int expand_one_shrinker_info(struct mem_cgroup *memcg,
-				    int map_size, int defer_size,
-				    int old_map_size, int old_defer_size,
-				    int new_nr_max)
+static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
+				    int old_size, int new_nr_max)
 {
 	struct shrinker_info *new, *old;
 	struct mem_cgroup_per_node *pn;
 	int nid;
-	int size = map_size + defer_size;
 
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
@@ -92,21 +124,18 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		if (new_nr_max <= old->map_nr_max)
 			continue;
 
-		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
+		new = kvmalloc_node(sizeof(*new) + new_size, GFP_KERNEL, nid);
 		if (!new)
 			return -ENOMEM;
 
-		new->nr_deferred = (atomic_long_t *)(new + 1);
-		new->map = (void *)new->nr_deferred + defer_size;
 		new->map_nr_max = new_nr_max;
 
-		/* map: set all old bits, clear all new bits */
-		memset(new->map, (int)0xff, old_map_size);
-		memset((void *)new->map + old_map_size, 0, map_size - old_map_size);
-		/* nr_deferred: copy old values, clear all new values */
-		memcpy(new->nr_deferred, old->nr_deferred, old_defer_size);
-		memset((void *)new->nr_deferred + old_defer_size, 0,
-		       defer_size - old_defer_size);
+		/* copy old values, allocate all new values */
+		memcpy(new->unit, old->unit, old_size);
+		if (shrinker_unit_alloc(new, old, nid)) {
+			kvfree(new);
+			return -ENOMEM;
+		}
 
 		rcu_assign_pointer(pn->shrinker_info, new);
 		kvfree_rcu(old, rcu);
@@ -118,9 +147,8 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 static int expand_shrinker_info(int new_id)
 {
 	int ret = 0;
-	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
-	int map_size, defer_size = 0;
-	int old_map_size, old_defer_size = 0;
+	int new_nr_max = round_up(new_id + 1, SHRINKER_UNIT_BITS);
+	int new_size, old_size = 0;
 	struct mem_cgroup *memcg;
 
 	if (!root_mem_cgroup)
@@ -128,15 +156,12 @@ static int expand_shrinker_info(int new_id)
 
 	lockdep_assert_held(&shrinker_rwsem);
 
-	map_size = shrinker_map_size(new_nr_max);
-	defer_size = shrinker_defer_size(new_nr_max);
-	old_map_size = shrinker_map_size(shrinker_nr_max);
-	old_defer_size = shrinker_defer_size(shrinker_nr_max);
+	new_size = shrinker_unit_size(new_nr_max);
+	old_size = shrinker_unit_size(shrinker_nr_max);
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
-		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
-					       old_map_size, old_defer_size,
+		ret = expand_one_shrinker_info(memcg, new_size, old_size,
 					       new_nr_max);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
@@ -150,17 +175,34 @@ static int expand_shrinker_info(int new_id)
 	return ret;
 }
 
+static inline int shriner_id_to_index(int shrinker_id)
+{
+	return shrinker_id / SHRINKER_UNIT_BITS;
+}
+
+static inline int shriner_id_to_offset(int shrinker_id)
+{
+	return shrinker_id % SHRINKER_UNIT_BITS;
+}
+
+static inline int calc_shrinker_id(int index, int offset)
+{
+	return index * SHRINKER_UNIT_BITS + offset;
+}
+
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct shrinker_info *info;
+		struct shrinker_info_unit *unit;
 
 		rcu_read_lock();
 		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		unit = info->unit[shriner_id_to_index(shrinker_id)];
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
 			smp_mb__before_atomic();
-			set_bit(shrinker_id, info->map);
+			set_bit(shriner_id_to_offset(shrinker_id), unit->map);
 		}
 		rcu_read_unlock();
 	}
@@ -209,26 +251,31 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 				   struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	struct shrinker_info_unit *unit;
 
 	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+	unit = info->unit[shriner_id_to_index(shrinker->id)];
+	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
 }
 
 static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 				  struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	struct shrinker_info_unit *unit;
 
 	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+	unit = info->unit[shriner_id_to_index(shrinker->id)];
+	return atomic_long_add_return(nr, &unit->nr_deferred[shriner_id_to_offset(shrinker->id)]);
 }
 
 void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 {
-	int i, nid;
+	int nid, index, offset;
 	long nr;
 	struct mem_cgroup *parent;
 	struct shrinker_info *child_info, *parent_info;
+	struct shrinker_info_unit *child_unit, *parent_unit;
 
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
@@ -239,9 +286,13 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
-		for (i = 0; i < child_info->map_nr_max; i++) {
-			nr = atomic_long_read(&child_info->nr_deferred[i]);
-			atomic_long_add(nr, &parent_info->nr_deferred[i]);
+		for (index = 0; index < shriner_id_to_index(child_info->map_nr_max); index++) {
+			child_unit = child_info->unit[index];
+			parent_unit = parent_info->unit[index];
+			for (offset = 0; offset < SHRINKER_UNIT_BITS; offset++) {
+				nr = atomic_long_read(&child_unit->nr_deferred[offset]);
+				atomic_long_add(nr, &parent_unit->nr_deferred[offset]);
+			}
 		}
 	}
 	up_read(&shrinker_rwsem);
@@ -407,7 +458,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int i;
+	int offset, index = 0;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
@@ -419,56 +470,63 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, info->map_nr_max) {
-		struct shrink_control sc = {
-			.gfp_mask = gfp_mask,
-			.nid = nid,
-			.memcg = memcg,
-		};
-		struct shrinker *shrinker;
+	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
+		struct shrinker_info_unit *unit;
 
-		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
-			if (!shrinker)
-				clear_bit(i, info->map);
-			continue;
-		}
+		unit = info->unit[index];
 
-		/* Call non-slab shrinkers even though kmem is disabled */
-		if (!memcg_kmem_online() &&
-		    !(shrinker->flags & SHRINKER_NONSLAB))
-			continue;
+		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
+			struct shrink_control sc = {
+				.gfp_mask = gfp_mask,
+				.nid = nid,
+				.memcg = memcg,
+			};
+			struct shrinker *shrinker;
+			int shrinker_id = calc_shrinker_id(index, offset);
 
-		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY) {
-			clear_bit(i, info->map);
-			/*
-			 * After the shrinker reported that it had no objects to
-			 * free, but before we cleared the corresponding bit in
-			 * the memcg shrinker map, a new object might have been
-			 * added. To make sure, we have the bit set in this
-			 * case, we invoke the shrinker one more time and reset
-			 * the bit if it reports that it is not empty anymore.
-			 * The memory barrier here pairs with the barrier in
-			 * set_shrinker_bit():
-			 *
-			 * list_lru_add()     shrink_slab_memcg()
-			 *   list_add_tail()    clear_bit()
-			 *   <MB>               <MB>
-			 *   set_bit()          do_shrink_slab()
-			 */
-			smp_mb__after_atomic();
-			ret = do_shrink_slab(&sc, shrinker, priority);
-			if (ret == SHRINK_EMPTY)
-				ret = 0;
-			else
-				set_shrinker_bit(memcg, nid, i);
-		}
-		freed += ret;
+			shrinker = idr_find(&shrinker_idr, shrinker_id);
+			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
+				if (!shrinker)
+					clear_bit(offset, unit->map);
+				continue;
+			}
 
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
+			/* Call non-slab shrinkers even though kmem is disabled */
+			if (!memcg_kmem_online() &&
+			    !(shrinker->flags & SHRINKER_NONSLAB))
+				continue;
+
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY) {
+				clear_bit(offset, unit->map);
+				/*
+				 * After the shrinker reported that it had no objects to
+				 * free, but before we cleared the corresponding bit in
+				 * the memcg shrinker map, a new object might have been
+				 * added. To make sure, we have the bit set in this
+				 * case, we invoke the shrinker one more time and reset
+				 * the bit if it reports that it is not empty anymore.
+				 * The memory barrier here pairs with the barrier in
+				 * set_shrinker_bit():
+				 *
+				 * list_lru_add()     shrink_slab_memcg()
+				 *   list_add_tail()    clear_bit()
+				 *   <MB>               <MB>
+				 *   set_bit()          do_shrink_slab()
+				 */
+				smp_mb__after_atomic();
+				ret = do_shrink_slab(&sc, shrinker, priority);
+				if (ret == SHRINK_EMPTY)
+					ret = 0;
+				else
+					set_shrinker_bit(memcg, nid, shrinker_id);
+			}
+			freed += ret;
+
+			if (rwsem_is_contended(&shrinker_rwsem)) {
+				freed = freed ? : 1;
+				goto unlock;
+			}
 		}
 	}
 unlock:
-- 
2.30.2

