Return-Path: <linux-btrfs+bounces-141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115067EC958
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 18:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DD81C20B82
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7774122C;
	Wed, 15 Nov 2023 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cFlUumTL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D724177E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 17:06:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA59E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 09:06:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C4378204E3;
	Wed, 15 Nov 2023 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700068006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iBwi7zIPPN2rKwuQVzgn49NeH/x+QmXBf40QtEMNyao=;
	b=cFlUumTLnKBAXyUtx4QmnR00THFxWPnAKH62ysh6s/gw0kxUoLI20O2eQwTY28jMF8Pp5P
	lDYAu1LnTY2tnTeojC6jlP64ilcUGy1aJ3y6if9raK6kg9BnWm3V0q84TozjwrCbcFoHIe
	qAW14CrKFOMbPxq3PVpaLTVScYOlzTQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id ADFB72C16E;
	Wed, 15 Nov 2023 17:06:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id EF275DA86C; Wed, 15 Nov 2023 17:59:41 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use shrinker for compression page pool
Date: Wed, 15 Nov 2023 17:59:41 +0100
Message-ID: <54f7314782c6fd1137d4f720c6a02b7d82cd401d.1700067287.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700067287.git.dsterba@suse.com>
References: <cover.1700067287.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.50 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.50
X-Rspamd-Queue-Id: C4378204E3
X-Spam: Yes

The pages are now allocated and freed centrally, so we can extend the
logic to manage the lifetime. The main idea is to keep a few recently
used pages and hand them to all writers. Ideally we won't have to go to
allocator at all (a slight performance gain) and also raise chance that
we'll have the pages available (slightly increased reliability).

In order to avoid gathering too many pages, the shrinker is attached to
the cache so we can free them on when MM demands that. The first
implementation will drain the whole cache. Further this can be refined
to keep some minimal number of pages for emergency purposes.  The
ultimate goal to avoid memory allocation failures on the write out path
from the compression.

The pool threshold is set to cover full BTRFS_MAX_COMPRESSED / PAGE_SIZE
for minimal thread pool, which is 8 (btrfs_init_fs_info()). This is 128K
/ 4K * 8 = 256 pages at maximum, which is 1MiB.

This is for all filesystems currently mounted, with heavy use of
compression IO the allocator is still needed. The cache helps for short
burst IO.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 102 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1cd15d6a9c49..05595d113ff8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
+#include <linux/shrinker.h>
 #include <crypto/hash.h>
 #include "misc.h"
 #include "ctree.h"
@@ -169,16 +170,96 @@ static void btrfs_free_compressed_pages(struct compressed_bio *cb)
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
+/*
+ * Global cache of last unused pages for compression/decompression.
+ */
+static struct btrfs_compr_pool {
+	struct shrinker *shrinker;
+	spinlock_t lock;
+	struct list_head list;
+	int count;
+	int thresh;
+} compr_pool;
+
+static unsigned long btrfs_compr_pool_count(struct shrinker *sh, struct shrink_control *sc)
+{
+	int ret;
+
+	/*
+	 * We must not read the values more than once if 'ret' gets expanded in
+	 * the return statement so we don't accidentally return a negative
+	 * number, even if the first condition finds it positive.
+	 */
+	ret = READ_ONCE(compr_pool.count) - READ_ONCE(compr_pool.thresh);
+
+	return ret > 0 ? ret : 0;
+}
+
+static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_control *sc)
+{
+	struct list_head remove;
+	struct list_head *tmp, *next;
+	int freed;
+
+	if (compr_pool.count == 0)
+		return SHRINK_STOP;
+
+	INIT_LIST_HEAD(&remove);
+
+	/* For now, just simply drain the whole list. */
+	spin_lock(&compr_pool.lock);
+	list_splice_init(&compr_pool.list, &remove);
+	freed = compr_pool.count;
+	compr_pool.count = 0;
+	spin_unlock(&compr_pool.lock);
+
+	list_for_each_safe(tmp, next, &remove) {
+		struct page *page = list_entry(tmp, struct page, lru);
+
+		ASSERT(page_ref_count(page) == 1);
+		put_page(page);
+	}
+
+	return freed;
+}
+
 /*
  * Common wrappers for page allocation from compression wrappers
  */
 struct page *btrfs_alloc_compr_page(void)
 {
+	struct page *page = NULL;
+
+	spin_lock(&compr_pool.lock);
+	if (compr_pool.count > 0) {
+		page = list_first_entry(&compr_pool.list, struct page, lru);
+		list_del_init(&page->lru);
+		compr_pool.count--;
+	}
+	spin_unlock(&compr_pool.lock);
+
+	if (page)
+		return page;
+
 	return alloc_page(GFP_NOFS);
 }
 
 void btrfs_free_compr_page(struct page *page)
 {
+	bool do_free = false;
+
+	spin_lock(&compr_pool.lock);
+	if (compr_pool.count > compr_pool.thresh) {
+		do_free = true;
+	} else {
+		list_add(&page->lru, &compr_pool.list);
+		compr_pool.count++;
+	}
+	spin_unlock(&compr_pool.lock);
+
+	if (!do_free)
+		return;
+
 	ASSERT(page_ref_count(page) == 1);
 	put_page(page);
 }
@@ -974,15 +1055,36 @@ int __init btrfs_init_compress(void)
 			offsetof(struct compressed_bio, bbio.bio),
 			BIOSET_NEED_BVECS))
 		return -ENOMEM;
+
+	compr_pool.shrinker = shrinker_alloc(SHRINKER_NONSLAB, "btrfs-compr-pages");
+	if (!compr_pool.shrinker)
+		return -ENOMEM;
+
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
 	zstd_init_workspace_manager();
+
+	spin_lock_init(&compr_pool.lock);
+	INIT_LIST_HEAD(&compr_pool.list);
+	compr_pool.count = 0;
+	/* 128K / 4K = 32, for 8 threads is 256 pages. */
+	compr_pool.thresh = BTRFS_MAX_COMPRESSED / PAGE_SIZE * 8;
+	compr_pool.shrinker->count_objects = btrfs_compr_pool_count;
+	compr_pool.shrinker->scan_objects = btrfs_compr_pool_scan;
+	compr_pool.shrinker->batch = 32;
+	compr_pool.shrinker->seeks = DEFAULT_SEEKS;
+	shrinker_register(compr_pool.shrinker);
+
 	return 0;
 }
 
 void __cold btrfs_exit_compress(void)
 {
+	/* For now scan drains all pages and does not touch the parameters. */
+	btrfs_compr_pool_scan(NULL, NULL);
+	shrinker_free(compr_pool.shrinker);
+
 	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_NONE);
 	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_ZLIB);
 	btrfs_cleanup_workspace_manager(BTRFS_COMPRESS_LZO);
-- 
2.42.1


