Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE32FD023
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbhATMSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:18:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:37902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbhATK12 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmcR2Ie6fb7Rd8E82AhOW2/0MIVQMzw7L/HTX9ZShUo=;
        b=XW0SV10B4csZnvNAsPO7/uBmw9bBlRuDqRC7UgzCPTpcd7fiWSPU57nEi78l6TAtxGfyjG
        Lm2uV+eZdEwVBVUTc6b2t/quuIAPccfJIvCq2fL/fOkYpcb1ssJtWWI5iPv97eg9XOVGFh
        x9c7uiS/aehCPWNwaK1cM5JcmA4ouYU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFE14B04C;
        Wed, 20 Jan 2021 10:25:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 12/14] btrfs: Fix parameter description for functions in extent_io.c
Date:   Wed, 20 Jan 2021 12:25:24 +0200
Message-Id: <20210120102526.310486-13-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This makes the file W=1 clean and fixes the following warnings:

fs/btrfs/extent_io.c:414: warning: Function parameter or member 'tree' not described in '__etree_search'
fs/btrfs/extent_io.c:414: warning: Function parameter or member 'offset' not described in '__etree_search'
fs/btrfs/extent_io.c:414: warning: Function parameter or member 'next_ret' not described in '__etree_search'
fs/btrfs/extent_io.c:414: warning: Function parameter or member 'prev_ret' not described in '__etree_search'
fs/btrfs/extent_io.c:414: warning: Function parameter or member 'p_ret' not described in '__etree_search'
fs/btrfs/extent_io.c:414: warning: Function parameter or member 'parent_ret' not described in '__etree_search'
fs/btrfs/extent_io.c:1607: warning: Function parameter or member 'tree' not described in 'find_contiguous_extent_bit'
fs/btrfs/extent_io.c:1607: warning: Function parameter or member 'start' not described in 'find_contiguous_extent_bit'
fs/btrfs/extent_io.c:1607: warning: Function parameter or member 'start_ret' not described in 'find_contiguous_extent_bit'
fs/btrfs/extent_io.c:1607: warning: Function parameter or member 'end_ret' not described in 'find_contiguous_extent_bit'
fs/btrfs/extent_io.c:1607: warning: Function parameter or member 'bits' not described in 'find_contiguous_extent_bit'
fs/btrfs/extent_io.c:1644: warning: Function parameter or member 'tree' not described in 'find_first_clear_extent_bit'
fs/btrfs/extent_io.c:1644: warning: Function parameter or member 'start' not described in 'find_first_clear_extent_bit'
fs/btrfs/extent_io.c:1644: warning: Function parameter or member 'start_ret' not described in 'find_first_clear_extent_bit'
fs/btrfs/extent_io.c:1644: warning: Function parameter or member 'end_ret' not described in 'find_first_clear_extent_bit'
fs/btrfs/extent_io.c:1644: warning: Function parameter or member 'bits' not described in 'find_first_clear_extent_bit'
fs/btrfs/extent_io.c:4187: warning: Function parameter or member 'epd' not described in 'extent_write_cache_pages'
fs/btrfs/extent_io.c:4187: warning: Excess function parameter 'data' description in 'extent_write_cache_pages'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7f689ad7709c..62f892238149 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -392,13 +392,13 @@ static struct rb_node *tree_insert(struct rb_root *root,
  * __etree_search - searche @tree for an entry that contains @offset. Such
  * entry would have entry->start <= offset && entry->end >= offset.
  *
- * @tree - the tree to search
- * @offset - offset that should fall within an entry in @tree
- * @next_ret - pointer to the first entry whose range ends after @offset
- * @prev - pointer to the first entry whose range begins before @offset
- * @p_ret - pointer where new node should be anchored (used when inserting an
+ * @tree:  the tree to search
+ * @offset: offset that should fall within an entry in @tree
+ * @next_ret: pointer to the first entry whose range ends after @offset
+ * @prev_ret: pointer to the first entry whose range begins before @offset
+ * @p_ret: pointer where new node should be anchored (used when inserting an
  *	    entry in the tree)
- * @parent_ret - points to entry which would have been the parent of the entry,
+ * @parent_ret: points to entry which would have been the parent of the entry,
  *               containing @offset
  *
  * This function returns a pointer to the entry that contains @offset byte
@@ -1589,11 +1589,11 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 
 /**
  * find_contiguous_extent_bit: find a contiguous area of bits
- * @tree - io tree to check
- * @start - offset to start the search from
- * @start_ret - the first offset we found with the bits set
- * @end_ret - the final contiguous range of the bits that were set
- * @bits - bits to look for
+ * @tree: io tree to check
+ * @start: offset to start the search from
+ * @start_ret: the first offset we found with the bits set
+ * @end_ret: the final contiguous range of the bits that were set
+ * @bits: bits to look for
  *
  * set_extent_bit and clear_extent_bit can temporarily split contiguous ranges
  * to set bits appropriately, and then merge them again.  During this time it
@@ -1628,11 +1628,11 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
  * find_first_clear_extent_bit - find the first range that has @bits not set.
  * This range could start before @start.
  *
- * @tree - the tree to search
- * @start - the offset at/after which the found extent should start
- * @start_ret - records the beginning of the range
- * @end_ret - records the end of the range (inclusive)
- * @bits - the set of bits which must be unset
+ * @tree: the tree to search
+ * @start: the offset at/after which the found extent should start
+ * @start_ret: records the beginning of the range
+ * @end_ret: records the end of the range (inclusive)
+ * @bits: the set of bits which must be unset
  *
  * Since unallocated range is also considered one which doesn't have the bits
  * set it's possible that @end_ret contains -1, this happens in case the range
@@ -4171,7 +4171,7 @@ int btree_write_cache_pages(struct address_space *mapping,
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
  * @wbc: subtract the number of written pages from *@wbc->nr_to_write
- * @data: data passed to __extent_writepage function
+ * @epd: holds context for the write, namely the bio
  *
  * If a page is already under I/O, write_cache_pages() skips it, even
  * if it's dirty.  This is desirable behaviour for memory-cleaning writeback,
-- 
2.25.1

