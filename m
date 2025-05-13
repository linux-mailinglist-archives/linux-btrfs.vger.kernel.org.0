Return-Path: <linux-btrfs+bounces-13951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5EAB4852
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B851656DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 00:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542117BD6;
	Tue, 13 May 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TEQhJcOp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7/M1J0X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2517D2
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747095350; cv=none; b=aLxJlmTU0wtHZ3STCSXx31mH3SgiJbXCvpSRi4qJEZgp8Ek8Mrwslr0r/LeLraDqnwcoS4969G+a3sMKAldqUkJQyTrvec+PXx1gCqBdiQawqOFihhMJwdybS2g45AzAXy8XR8B2BNsCU1XRkveWh9PBoU9fqy6ShXyfxcNO2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747095350; c=relaxed/simple;
	bh=Y0Csdo2PstefX806COxJQC5aEhafHlYGGDbWr0o7FKM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QgY6s4XPLKhJ0xCO8P8GqRvlh0pdvCiQZWNU+WW7qOJb1kCeNjSpAiRLNdFRJznQQhfw9P9amThmWkTDBW9M75fwONWha/9W1HhMQ1uvozM3am474eHhCrkkHZWiFmGKAGmjpZdh6B0wgdzI54f/EP7+Zrd0+u/lxzKYIkSNfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TEQhJcOp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7/M1J0X; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB89E25400A0;
	Mon, 12 May 2025 20:15:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 12 May 2025 20:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1747095344; x=1747181744; bh=0KLm7BKGaCenp/IcMoWao
	HEjDd3LoziLurABAthf9CM=; b=TEQhJcOpQHGVZK0LcXRTxd0Gt0/5ynhUYGrOD
	muXJFUPBoJLYdwhHm+lyJOnKNCefVETvk73AvLHplkCptL97dZhXmgkRm8yGIrKV
	OqbOUlIc5HkBnWEy2/55qOdrLqS+rMeqTXQaCrUETWzFqGveKWilCliS/E0nbOf8
	Ab2Csl4D38VO7OP2cYRGgKv9deTB9MRs7AwA7p3//O5oqgm9JFtSkmSCFEgHbkqe
	v0sfsE9lXKaE7DcMv5jyc7x1xfngK9LS253KhGI0lvaReXyy5VRt7jxH3MGFnWIp
	um/BsOtHmeQR7oR55YhPavy0sCHYJjHPeNVRv4kc8GHaJQneQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747095344; x=1747181744; bh=0KLm7BKGaCenp/IcMoWaoHEjDd3LoziLurA
	BAthf9CM=; b=Y7/M1J0XKKwG60f9pTGmE/FdkbdwWZv1q8l5CBF6y8/DAUSEuYP
	Ik6sYtYQKpGrsm538JF7nyR0vXsVJn/8p82qFo8BPgTmyB6Ub6dw+1o2XqIqFc72
	MrW9c3i4ws7Xm+ZeQyZ8DWL58M6I5Nct5gXY35CZr+Hl473pmrMdAVdDbHTX8Bv+
	Kk2sGaDdGzW9PgmAE1xzv+OnQPZ9ou6wVyBssMK+B9zbrscxDrnWJI1/TdfA5oZ/
	4eXciuJ+SXtoxfn/huG3Z+kXYnZp9LWz02pY+AW4a8vx3Qxq1WKcfMYWeLC/CwYn
	iUL5wBwQkuCoNeWTzuX2VEOSoIuxVrgEtbw==
X-ME-Sender: <xms:MI8iaHbiymnzqcAv5LcFNEs3zrSuZZW5DUZjYGKIE0CrEahqJVUJ1g>
    <xme:MI8iaGaMlrNUVS82MCD00YSKKDhn5EF2Ep75zBlIo084q3iPAgLQQk3hCru2nETsx
    6MKQih3pQ9lzwEgkuo>
X-ME-Received: <xmr:MI8iaJ_DpZIHvjxMktKaQxsnmaupmcNqPv8FrRbRAvSr7HxaSib50dZKT7D42kDh5aQ8u4cWmMkjCUGAp8NguqltkxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:MI8iaNqQzNvvt6iyhBH_sJtIThUDLuGjfRXZ2yBK_sfd_XHJa5T2fg>
    <xmx:MI8iaCpNeTGWWTLCaRV7w9wCp6lBE0GwpYlY6FpxWy4NAAIwAYHLkw>
    <xmx:MI8iaDQzmBuwUkrqbiwnR3gLGiPitoP_lbaI0q1wYHTZioFDllNWtA>
    <xmx:MI8iaKoWXDyxzb-O-HEYk4fClicnD1gNBZLCWZq5nOn-G6Ir7LBpxw>
    <xmx:MI8iaN-NeI2vWpBP0VGQ5h0j8DYtQERYAmRn39CKAXTJ3MhHRthIQrE6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 20:15:44 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH RFC] btrfs: collect untracked allocation stats
Date: Mon, 12 May 2025 17:16:17 -0700
Message-ID: <e42e7c06710b0406ac548739945b386d8319b48e.1747095022.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We allocate memory for extent_buffers and compressed io in a manner that
isn't tracked by any memory statistic. It is, in principle, possible to
sort of track this memory by subtracting all trackable allocations from
the total memory and comparing to the amount free, but that is clumsy to
do, breaks when new memory accounting is added in the mm subsystem and
lacks any useful granularity.

I have recently worked on two separate types of leaks in these
allocations which would have been easier to detect and measure the
resolution of with this kind of data collection.

This RFC proposes explicitly tracking btrfs's untracked allocations and
reporting them in /sys/fs/btrfs/<uuid>/memory_stats.

Main open questions in my mind:
1. Does this seem worth pursuing?
2. What is the best concurrency model? I experimented with percpu
   variables which I don't think allow us to split it by fs_info in a
   reasonable way (short of dynamically growing a pointed-to percpu
   array as we add fs-es). I haven't thought too hard between spinlock,
   atomic, etc..
3. Am I missing any other untracked allocations / is this a valid
   "class" of allocations to care about?

So far, for validation, I have just run fstests. I haven't yet tried to
super carefully vet the accuracy of the stats.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/compression.c | 31 +++++++++++++++++++++++++++----
 fs/btrfs/compression.h |  6 ++++--
 fs/btrfs/extent_io.c   | 23 ++++++++++++++++++++++-
 fs/btrfs/fs.h          | 10 ++++++++++
 fs/btrfs/inode.c       | 16 ++++++++++------
 fs/btrfs/lzo.c         | 10 ++++++----
 fs/btrfs/sysfs.c       | 17 ++++++++++-------
 fs/btrfs/zlib.c        | 16 +++++++---------
 fs/btrfs/zstd.c        | 16 +++++++---------
 9 files changed, 103 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4..988887cc79ff 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -160,8 +160,10 @@ static int compression_decompress(int type, struct list_head *ws,
 
 static void btrfs_free_compressed_folios(struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
+
 	for (unsigned int i = 0; i < cb->nr_folios; i++)
-		btrfs_free_compr_folio(cb->compressed_folios[i]);
+		btrfs_free_compr_folio(fs_info, cb->compressed_folios[i]);
 	kfree(cb->compressed_folios);
 }
 
@@ -223,7 +225,7 @@ static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_co
 /*
  * Common wrappers for page allocation from compression wrappers
  */
-struct folio *btrfs_alloc_compr_folio(void)
+struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info)
 {
 	struct folio *folio = NULL;
 
@@ -238,10 +240,13 @@ struct folio *btrfs_alloc_compr_folio(void)
 	if (folio)
 		return folio;
 
-	return folio_alloc(GFP_NOFS, 0);
+	folio = folio_alloc(GFP_NOFS, 0);
+	if (folio)
+		btrfs_inc_compressed_io_folios(fs_info);
+	return folio;
 }
 
-void btrfs_free_compr_folio(struct folio *folio)
+void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
 	bool do_free = false;
 
@@ -259,6 +264,22 @@ void btrfs_free_compr_folio(struct folio *folio)
 
 	ASSERT(folio_ref_count(folio) == 1);
 	folio_put(folio);
+	btrfs_dec_compressed_io_folios(fs_info);
+}
+
+void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info) {
+	spin_lock(&fs_info->memory_stats_lock);
+	fs_info->memory_stats.nr_compressed_io_folios++;
+	spin_unlock(&fs_info->memory_stats_lock);
+}
+
+void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->memory_stats_lock);
+	ASSERT(fs_info->memory_stats.nr_compressed_io_folios > 0,
+	       "%lu", fs_info->memory_stats.nr_compressed_io_folios);
+	fs_info->memory_stats.nr_compressed_io_folios--;
+	spin_unlock(&fs_info->memory_stats_lock);
 }
 
 static void end_bbio_compressed_read(struct btrfs_bio *bbio)
@@ -617,6 +638,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		status = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
 	}
+	for (int i = 0; i < cb->nr_folios; i++)
+		btrfs_inc_compressed_io_folios(fs_info);
 
 	add_ra_bio_pages(&inode->vfs_inode, em_start + em_len, cb, &memstall,
 			 &pflags);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index d34c4341eaf4..a72a58337c76 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -105,8 +105,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 int btrfs_compress_str2level(unsigned int type, const char *str);
 
-struct folio *btrfs_alloc_compr_folio(void);
-void btrfs_free_compr_folio(struct folio *folio);
+struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info);
+void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio);
 
 enum btrfs_compression_type {
 	BTRFS_COMPRESS_NONE  = 0,
@@ -188,5 +188,7 @@ struct list_head *zstd_alloc_workspace(int level);
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_get_workspace(int level);
 void zstd_put_workspace(struct list_head *ws);
+void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info);
+void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 281bb036fcb8..56e036ee3c87 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -611,6 +611,22 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 	return 0;
 }
 
+static void inc_extent_buffer_folios(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->memory_stats_lock);
+	fs_info->memory_stats.nr_extent_buffer_folios++;
+	spin_unlock(&fs_info->memory_stats_lock);
+}
+
+static void dec_extent_buffer_folios(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->memory_stats_lock);
+	ASSERT(fs_info->memory_stats.nr_extent_buffer_folios > 0,
+	       "%lu", fs_info->memory_stats.nr_extent_buffer_folios);
+	fs_info->memory_stats.nr_extent_buffer_folios--;
+	spin_unlock(&fs_info->memory_stats_lock);
+}
+
 /*
  * Populate needed folios for the extent buffer.
  *
@@ -626,8 +642,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
 	if (ret < 0)
 		return ret;
 
-	for (int i = 0; i < num_pages; i++)
+	for (int i = 0; i < num_pages; i++) {
 		eb->folios[i] = page_folio(page_array[i]);
+		inc_extent_buffer_folios(eb->fs_info);
+	}
 	eb->folio_size = PAGE_SIZE;
 	eb->folio_shift = PAGE_SHIFT;
 	return 0;
@@ -2816,6 +2834,7 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 			continue;
 
 		detach_extent_buffer_folio(eb, folio);
+		dec_extent_buffer_folios(eb->fs_info);
 	}
 }
 
@@ -2865,6 +2884,7 @@ static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
 		detach_extent_buffer_folio(eb, eb->folios[i]);
 		folio_put(eb->folios[i]);
 		eb->folios[i] = NULL;
+		dec_extent_buffer_folios(eb->fs_info);
 	}
 }
 
@@ -3418,6 +3438,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		ASSERT(!folio_test_private(folio));
 		folio_put(folio);
 		eb->folios[i] = NULL;
+		dec_extent_buffer_folios(eb->fs_info);
 	}
 	btrfs_release_extent_buffer(eb);
 	if (ret < 0)
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4394de12a767..47a66251ed1f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include "compression.h"
 #include <linux/blkdev.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
@@ -422,6 +423,11 @@ struct btrfs_commit_stats {
 	u64 total_commit_dur;
 };
 
+struct btrfs_memory_stats {
+	unsigned long nr_compressed_io_folios;
+	unsigned long nr_extent_buffer_folios;
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -866,6 +872,9 @@ struct btrfs_fs_info {
 	/* Updates are not protected by any lock */
 	struct btrfs_commit_stats commit_stats;
 
+	spinlock_t memory_stats_lock;
+	struct btrfs_memory_stats memory_stats;
+
 	/*
 	 * Last generation where we dropped a non-relocation root.
 	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
@@ -897,6 +906,7 @@ struct btrfs_fs_info {
 #endif
 };
 
+
 #define folio_to_inode(_folio)	(BTRFS_I(_Generic((_folio),			\
 					  struct folio *: (_folio))->mapping->host))
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 964088d3f3f7..6a19f13d2eb6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1026,13 +1026,14 @@ static void compress_file_range(struct btrfs_work *work)
 	if (folios) {
 		for (i = 0; i < nr_folios; i++) {
 			WARN_ON(folios[i]->mapping);
-			btrfs_free_compr_folio(folios[i]);
+			btrfs_free_compr_folio(fs_info, folios[i]);
 		}
 		kfree(folios);
 	}
 }
 
-static void free_async_extent_pages(struct async_extent *async_extent)
+static void free_async_extent_pages(struct btrfs_fs_info *fs_info,
+				    struct async_extent *async_extent)
 {
 	int i;
 
@@ -1041,7 +1042,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 
 	for (i = 0; i < async_extent->nr_folios; i++) {
 		WARN_ON(async_extent->folios[i]->mapping);
-		btrfs_free_compr_folio(async_extent->folios[i]);
+		btrfs_free_compr_folio(fs_info, async_extent->folios[i]);
 	}
 	kfree(async_extent->folios);
 	async_extent->nr_folios = 0;
@@ -1175,7 +1176,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
 	if (free_pages)
-		free_async_extent_pages(async_extent);
+		free_async_extent_pages(fs_info, async_extent);
 	kfree(async_extent);
 	return;
 
@@ -1190,7 +1191,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
-	free_async_extent_pages(async_extent);
+	free_async_extent_pages(fs_info, async_extent);
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
 	btrfs_debug(fs_info,
@@ -9723,6 +9724,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			ret = -ENOMEM;
 			goto out_folios;
 		}
+		btrfs_inc_compressed_io_folios(fs_info);
 		kaddr = kmap_local_folio(folios[i], 0);
 		if (copy_from_iter(kaddr, bytes, from) != bytes) {
 			kunmap_local(kaddr);
@@ -9845,8 +9847,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_unlock_extent(io_tree, start, end, &cached_state);
 out_folios:
 	for (i = 0; i < nr_folios; i++) {
-		if (folios[i])
+		if (folios[i]) {
 			folio_put(folios[i]);
+			btrfs_dec_compressed_io_folios(fs_info);
+		}
 	}
 	kvfree(folios);
 out:
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index d403641889ca..741cf70375a9 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -128,7 +128,8 @@ static inline size_t read_compress_length(const char *buf)
  *
  * Will allocate new pages when needed.
  */
-static int copy_compressed_data_to_page(char *compressed_data,
+static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
+					char *compressed_data,
 					size_t compressed_size,
 					struct folio **out_folios,
 					unsigned long max_nr_folio,
@@ -152,7 +153,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 	cur_folio = out_folios[*cur_out / PAGE_SIZE];
 	/* Allocate a new page */
 	if (!cur_folio) {
-		cur_folio = btrfs_alloc_compr_folio();
+		cur_folio = btrfs_alloc_compr_folio(fs_info);
 		if (!cur_folio)
 			return -ENOMEM;
 		out_folios[*cur_out / PAGE_SIZE] = cur_folio;
@@ -178,7 +179,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
 		cur_folio = out_folios[*cur_out / PAGE_SIZE];
 		/* Allocate a new page */
 		if (!cur_folio) {
-			cur_folio = btrfs_alloc_compr_folio();
+			cur_folio = btrfs_alloc_compr_folio(fs_info);
 			if (!cur_folio)
 				return -ENOMEM;
 			out_folios[*cur_out / PAGE_SIZE] = cur_folio;
@@ -213,6 +214,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 			u64 start, struct folio **folios, unsigned long *out_folios,
 			unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
 	struct folio *folio_in = NULL;
@@ -263,7 +265,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
 			goto out;
 		}
 
-		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
+		ret = copy_compressed_data_to_page(fs_info, workspace->cbuf, out_len,
 						   folios, max_nr_folio,
 						   &cur_out, sectorsize);
 		if (ret < 0)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5e6377a8f0f9..ff4ae6dd9e5c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1132,18 +1132,20 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
-static ssize_t btrfs_memory_usage_show(struct kobject *kobj,
+static ssize_t btrfs_memory_stats_show(struct kobject *kobj,
                                         struct kobj_attribute *a, char *buf)
 {
-    struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-    unsigned long memory_used = fs_info->memory_used; // Assume this variable exists
-    unsigned long memory_free = fs_info->memory_free; // Assume this variable exists
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	struct btrfs_memory_stats *memory_stats = &fs_info->memory_stats;
 
-    return sysfs_emit(buf, "memory_used %lu\nmemory_free %lu\n",
-                      memory_used, memory_free);
+	return sysfs_emit(buf,
+			  "compressed_io_folios %lu\n"
+			  "extent_buffer_folios %lu\n",
+			  memory_stats->nr_compressed_io_folios,
+			  memory_stats->nr_extent_buffer_folios);
 }
 
-BTRFS_ATTR(, memory_usage, btrfs_memory_usage_show);
+BTRFS_ATTR(, memory_stats, btrfs_memory_stats_show);
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
 
 static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
@@ -1600,6 +1602,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+	BTRFS_ATTR_PTR(, memory_stats),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
 #endif
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 5292cd341f70..56dd7acaa50b 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -137,6 +137,8 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_inode *inode = BTRFS_I(mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret;
 	char *data_in = NULL;
@@ -155,9 +157,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 	ret = zlib_deflateInit(&workspace->strm, workspace->level);
 	if (unlikely(ret != Z_OK)) {
-		struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
-		btrfs_err(inode->root->fs_info,
+		btrfs_err(fs_info,
 	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
 		ret = -EIO;
@@ -167,7 +167,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_folio = btrfs_alloc_compr_folio();
+	out_folio = btrfs_alloc_compr_folio(fs_info);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -225,9 +225,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (unlikely(ret != Z_OK)) {
-			struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
-			btrfs_warn(inode->root->fs_info,
+			btrfs_warn(fs_info,
 		"zlib compression failed, error %d root %llu inode %llu offset %llu",
 				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
 				   start);
@@ -252,7 +250,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -288,7 +286,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4a796a049b5a..77cf8a605532 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -389,6 +389,8 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
+	struct btrfs_inode *inode = BTRFS_I(mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	zstd_cstream *stream;
 	int ret = 0;
@@ -412,8 +414,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
 			workspace->size);
 	if (unlikely(!stream)) {
-		struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
 		btrfs_err(inode->root->fs_info,
 	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
 			  workspace->req_level, btrfs_root_id(inode->root),
@@ -432,7 +432,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	workspace->in_buf.size = cur_len;
 
 	/* Allocate and map in the output buffer */
-	out_folio = btrfs_alloc_compr_folio();
+	out_folio = btrfs_alloc_compr_folio(fs_info);
 	if (out_folio == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -448,9 +448,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
 				&workspace->in_buf);
 		if (unlikely(zstd_is_error(ret2))) {
-			struct btrfs_inode *inode = BTRFS_I(mapping->host);
-
-			btrfs_warn(inode->root->fs_info,
+			btrfs_warn(fs_info,
 "zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
 				   workspace->req_level, zstd_get_error_code(ret2),
 				   btrfs_root_id(inode->root), btrfs_ino(inode),
@@ -482,7 +480,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_folio = btrfs_alloc_compr_folio();
+			out_folio = btrfs_alloc_compr_folio(fs_info);
 			if (out_folio == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -525,7 +523,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 		if (unlikely(zstd_is_error(ret2))) {
 			struct btrfs_inode *inode = BTRFS_I(mapping->host);
 
-			btrfs_err(inode->root->fs_info,
+			btrfs_err(fs_info,
 "zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
 				  workspace->req_level, zstd_get_error_code(ret2),
 				  btrfs_root_id(inode->root), btrfs_ino(inode),
@@ -549,7 +547,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 			ret = -E2BIG;
 			goto out;
 		}
-		out_folio = btrfs_alloc_compr_folio();
+		out_folio = btrfs_alloc_compr_folio(fs_info);
 		if (out_folio == NULL) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.49.0


