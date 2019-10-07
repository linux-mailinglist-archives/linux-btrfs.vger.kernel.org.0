Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE95CED44
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJGUR5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:17:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40888 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfJGUR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:17:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so13902987qkb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YfoTHrZWTri2FfSYRFZ+GMDo6y/aJX20K7JEIIMnDMg=;
        b=Lv7bet/ADcMyXx4ArbIfw1MUY+usFbNArA8on77RygbKu4FYM3tg4w32Ba5DAZs9la
         EeOCnlFKOKy19dIYvs2vZoMpCLXoV4y/n73SbuRPshIxxEDhxM3OkuTENBJXfW5gw624
         Bn+9LjseccmNYOlUNW+OZAyYSj7WIewjjyYNMZta6a6O3bzWgFk/nhIOAKgznKxn7WBe
         h/Wz3mSNpz4+yjbYKhiTCYJl+OQubMsuvo4kd5qqKNbENS3oe11I3ATvjZXMOVsbPCBj
         xpHNsv+bFhzZ0akREux2AWUyGmd+f3gECiicEEW3R597P1ZIq/OfOWdn1/REE2u6riAn
         9k+w==
X-Gm-Message-State: APjAAAU6iLu/wJ3zE56CMBIiGlvqs8Z+e9S1ZSD+IRnK7dDakKOCtOrt
        vTGLyplHCa5cnMEuscRS9wE=
X-Google-Smtp-Source: APXvYqwiWZ4usOeVpSaYEhf6+BLNHizApCIRrJA+1gfnAueFyIpG2EDrKpm0/chGkm2t+Y/4ZgX1gQ==
X-Received: by 2002:a37:b702:: with SMTP id h2mr25986685qkf.166.1570479474296;
        Mon, 07 Oct 2019 13:17:54 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:53 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 01/19] bitmap: genericize percpu bitmap region iterators
Date:   Mon,  7 Oct 2019 16:17:32 -0400
Message-Id: <d2efb06e5e5400007a709bb1269b25e16b435169.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Bitmaps are fairly popular for their space efficiency, but we don't have
generic iterators available. Make percpu's bitmap region iterators
available to everyone.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/bitmap.h | 35 ++++++++++++++++++++++++
 mm/percpu.c            | 61 +++++++++++-------------------------------
 2 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 90528f12bdfa..9b0664f36808 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -437,6 +437,41 @@ static inline int bitmap_parse(const char *buf, unsigned int buflen,
 	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
 }
 
+static inline void bitmap_next_clear_region(unsigned long *bitmap,
+					    unsigned int *rs, unsigned int *re,
+					    unsigned int end)
+{
+	*rs = find_next_zero_bit(bitmap, end, *rs);
+	*re = find_next_bit(bitmap, end, *rs + 1);
+}
+
+static inline void bitmap_next_set_region(unsigned long *bitmap,
+					  unsigned int *rs, unsigned int *re,
+					  unsigned int end)
+{
+	*rs = find_next_bit(bitmap, end, *rs);
+	*re = find_next_zero_bit(bitmap, end, *rs + 1);
+}
+
+/*
+ * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
+ * @rs and @re should be integer variables and will be set to start and end
+ * index of the current clear or set region.
+ */
+#define bitmap_for_each_clear_region(bitmap, rs, re, start, end)	     \
+	for ((rs) = (start),						     \
+	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end));	     \
+	     (rs) < (re);						     \
+	     (rs) = (re) + 1,						     \
+	     bitmap_next_clear_region((bitmap), &(rs), &(re), (end)))
+
+#define bitmap_for_each_set_region(bitmap, rs, re, start, end)		     \
+	for ((rs) = (start),						     \
+	     bitmap_next_set_region((bitmap), &(rs), &(re), (end));	     \
+	     (rs) < (re);						     \
+	     (rs) = (re) + 1,						     \
+	     bitmap_next_set_region((bitmap), &(rs), &(re), (end)))
+
 /**
  * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
  * @n: u64 value
diff --git a/mm/percpu.c b/mm/percpu.c
index 7e06a1e58720..e9844086b236 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -270,33 +270,6 @@ static unsigned long pcpu_chunk_addr(struct pcpu_chunk *chunk,
 	       pcpu_unit_page_offset(cpu, page_idx);
 }
 
-static void pcpu_next_unpop(unsigned long *bitmap, int *rs, int *re, int end)
-{
-	*rs = find_next_zero_bit(bitmap, end, *rs);
-	*re = find_next_bit(bitmap, end, *rs + 1);
-}
-
-static void pcpu_next_pop(unsigned long *bitmap, int *rs, int *re, int end)
-{
-	*rs = find_next_bit(bitmap, end, *rs);
-	*re = find_next_zero_bit(bitmap, end, *rs + 1);
-}
-
-/*
- * Bitmap region iterators.  Iterates over the bitmap between
- * [@start, @end) in @chunk.  @rs and @re should be integer variables
- * and will be set to start and end index of the current free region.
- */
-#define pcpu_for_each_unpop_region(bitmap, rs, re, start, end)		     \
-	for ((rs) = (start), pcpu_next_unpop((bitmap), &(rs), &(re), (end)); \
-	     (rs) < (re);						     \
-	     (rs) = (re) + 1, pcpu_next_unpop((bitmap), &(rs), &(re), (end)))
-
-#define pcpu_for_each_pop_region(bitmap, rs, re, start, end)		     \
-	for ((rs) = (start), pcpu_next_pop((bitmap), &(rs), &(re), (end));   \
-	     (rs) < (re);						     \
-	     (rs) = (re) + 1, pcpu_next_pop((bitmap), &(rs), &(re), (end)))
-
 /*
  * The following are helper functions to help access bitmaps and convert
  * between bitmap offsets to address offsets.
@@ -732,9 +705,8 @@ static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk, bool full_scan)
 	}
 
 	bits = 0;
-	pcpu_for_each_md_free_region(chunk, bit_off, bits) {
+	pcpu_for_each_md_free_region(chunk, bit_off, bits)
 		pcpu_block_update(chunk_md, bit_off, bit_off + bits);
-	}
 }
 
 /**
@@ -749,7 +721,7 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 {
 	struct pcpu_block_md *block = chunk->md_blocks + index;
 	unsigned long *alloc_map = pcpu_index_alloc_map(chunk, index);
-	int rs, re, start;	/* region start, region end */
+	unsigned int rs, re, start;	/* region start, region end */
 
 	/* promote scan_hint to contig_hint */
 	if (block->scan_hint) {
@@ -765,10 +737,9 @@ static void pcpu_block_refresh_hint(struct pcpu_chunk *chunk, int index)
 	block->right_free = 0;
 
 	/* iterate over free areas and update the contig hints */
-	pcpu_for_each_unpop_region(alloc_map, rs, re, start,
-				   PCPU_BITMAP_BLOCK_BITS) {
+	bitmap_for_each_clear_region(alloc_map, rs, re, start,
+				     PCPU_BITMAP_BLOCK_BITS)
 		pcpu_block_update(block, rs, re);
-	}
 }
 
 /**
@@ -1041,13 +1012,13 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 static bool pcpu_is_populated(struct pcpu_chunk *chunk, int bit_off, int bits,
 			      int *next_off)
 {
-	int page_start, page_end, rs, re;
+	unsigned int page_start, page_end, rs, re;
 
 	page_start = PFN_DOWN(bit_off * PCPU_MIN_ALLOC_SIZE);
 	page_end = PFN_UP((bit_off + bits) * PCPU_MIN_ALLOC_SIZE);
 
 	rs = page_start;
-	pcpu_next_unpop(chunk->populated, &rs, &re, page_end);
+	bitmap_next_clear_region(chunk->populated, &rs, &re, page_end);
 	if (rs >= page_end)
 		return true;
 
@@ -1702,13 +1673,13 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	/* populate if not all pages are already there */
 	if (!is_atomic) {
-		int page_start, page_end, rs, re;
+		unsigned int page_start, page_end, rs, re;
 
 		page_start = PFN_DOWN(off);
 		page_end = PFN_UP(off + size);
 
-		pcpu_for_each_unpop_region(chunk->populated, rs, re,
-					   page_start, page_end) {
+		bitmap_for_each_clear_region(chunk->populated, rs, re,
+					     page_start, page_end) {
 			WARN_ON(chunk->immutable);
 
 			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
@@ -1858,10 +1829,10 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	spin_unlock_irq(&pcpu_lock);
 
 	list_for_each_entry_safe(chunk, next, &to_free, list) {
-		int rs, re;
+		unsigned int rs, re;
 
-		pcpu_for_each_pop_region(chunk->populated, rs, re, 0,
-					 chunk->nr_pages) {
+		bitmap_for_each_set_region(chunk->populated, rs, re, 0,
+					   chunk->nr_pages) {
 			pcpu_depopulate_chunk(chunk, rs, re);
 			spin_lock_irq(&pcpu_lock);
 			pcpu_chunk_depopulated(chunk, rs, re);
@@ -1893,7 +1864,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	}
 
 	for (slot = pcpu_size_to_slot(PAGE_SIZE); slot < pcpu_nr_slots; slot++) {
-		int nr_unpop = 0, rs, re;
+		unsigned int nr_unpop = 0, rs, re;
 
 		if (!nr_to_pop)
 			break;
@@ -1910,9 +1881,9 @@ static void pcpu_balance_workfn(struct work_struct *work)
 			continue;
 
 		/* @chunk can't go away while pcpu_alloc_mutex is held */
-		pcpu_for_each_unpop_region(chunk->populated, rs, re, 0,
-					   chunk->nr_pages) {
-			int nr = min(re - rs, nr_to_pop);
+		bitmap_for_each_clear_region(chunk->populated, rs, re, 0,
+					     chunk->nr_pages) {
+			int nr = min_t(int, re - rs, nr_to_pop);
 
 			ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
 			if (!ret) {
-- 
2.17.1

