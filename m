Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63863117616
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLITqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45469 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so7217607pgk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zNYgLr7J7prnwLdqLWVK7cm4anvykXFm1bcfD80vXWk=;
        b=MuWum4TMgH+LPLYp/d6UtfmhaDv/lGVeK4e7IlKmKsiw9y/Mla+WqB5j4+cm3htrPr
         SMqlkvfwGf693biHRYwdhNOkgk3Keb0ign9YvCI5rcwQgo0XZ0Z2U7WXm5lYZ9+urReC
         nna7Hk6zy58w6/65OWPcxdf3wCiHaC3UluHDB+YDmQdQQZGqbxFM2wtQfmvWexUoemOW
         OlwzyOXmdzxo5EPFGDnOxha4FiIEj4Anl3wmuhpU1REsDOIZmt4KmZH/JDdzwfp0RNZV
         9QE+F0V3J45nmFJX7Vpfzt/DYU2i5nm9pc8PMYY4Far3547+3w6B+7G+V+ACWZAG7zZH
         x87w==
X-Gm-Message-State: APjAAAUCvj3nvdKbqI/MEmkJN2s/DQxXwgO3uUMI2PuM12OsJZ5FJ1Pj
        ycGQ0UIBhB3WdbMZCFqdYjA=
X-Google-Smtp-Source: APXvYqzJ4cObkT3OU/2DQDap0o1G3z4A4/llsph7/k4RR0/RO7jVNb4n67cKgDFN/+c0MkFjqEgE9Q==
X-Received: by 2002:a63:4185:: with SMTP id o127mr14270482pga.284.1575920771781;
        Mon, 09 Dec 2019 11:46:11 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:11 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 01/22] bitmap: genericize percpu bitmap region iterators
Date:   Mon,  9 Dec 2019 11:45:46 -0800
Message-Id: <d49847dbfe2921a6708a81a281956d75c585b421.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Bitmaps are fairly popular for their space efficiency, but we don't have
generic iterators available. Make percpu's bitmap region iterators
available to everyone.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/bitmap.h | 35 ++++++++++++++++++++++++
 mm/percpu.c            | 61 +++++++++++-------------------------------
 2 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index ff335b22f23c..cb63feb3cfbe 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -456,6 +456,41 @@ static inline int bitmap_parse(const char *buf, unsigned int buflen,
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

