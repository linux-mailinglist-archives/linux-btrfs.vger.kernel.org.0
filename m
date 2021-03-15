Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD77D33C008
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 16:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhCOPf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 11:35:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233668AbhCOPfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 11:35:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C8F8AC23;
        Mon, 15 Mar 2021 15:35:44 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oliver Glitta <glittao@gmail.com>
Subject: [PATCH] [PATCH] mm, slub: enable slub_debug static key when creating cache with explicit debug flags
Date:   Mon, 15 Mar 2021 16:34:15 +0100
Message-Id: <20210315153415.24404-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
introduced a static key to optimize the case where no debugging is enabled for
any cache. The static key is enabled when slub_debug boot parameter is passed,
or CONFIG_SLUB_DEBUG_ON enabled.

However, some caches might be created with one or more debugging flags
explicitly passed to kmem_cache_create(), and the commit missed this. Thus the
debugging functionality would not be actually performed for these caches unless
the static key gets enabled by boot param or config.

This patch fixes it by checking for debugging flags passed to
kmem_cache_create() and enabling the static key accordingly.

Note such explicit debugging flags should not be used outside of debugging and
testing as they will now enable the static key globally. btrfs_init_cachep()
creates a cache with SLAB_RED_ZONE but that's a mistake that's being corrected
[1]. rcu_torture_stats() creates a cache with SLAB_STORE_USER, but that is a
testing module so it's OK and will start working as intended after this patch.

Also note that in case of backports to kernels before v5.12 that don't have
59450bbc12be ("mm, slab, slub: stop taking cpu hotplug lock"),
static_branch_enable_cpuslocked() should be used.

[1] https://lore.kernel.org/linux-btrfs/20210315141824.26099-1-dsterba@suse.com/

Reported-by: Oliver Glitta <glittao@gmail.com>
Fixes: ca0cab65ea2b ("mm, slub: introduce static key for slub_debug()")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 350a37f30e60..cd6694ad1a0a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3827,6 +3827,15 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 {
+#ifdef CONFIG_SLUB_DEBUG
+	/*
+	 * If no slub_debug was enabled globally, the static key is not yet
+	 * enabled by setup_slub_debug(). Enable it if the cache is being
+	 * created with any of the debugging flags passed explicitly.
+	 */
+	if (flags & SLAB_DEBUG_FLAGS)
+		static_branch_enable(&slub_debug_enabled);
+#endif
 	s->flags = kmem_cache_flags(s->size, flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
-- 
2.30.1

