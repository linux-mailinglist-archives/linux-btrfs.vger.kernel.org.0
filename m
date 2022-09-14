Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B65B907F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 00:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiINWXX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 18:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINWXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 18:23:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD15114B
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Puzjm8Bb70oBqrS47YXhRwL4s/NJY+aZ1vClTRRLS0Y=; b=SldHwIbqGOqbMAI6rTa7ypp2rn
        0z1eznpDtKZFXRCGbC3rRfLkHnD2X7eDGL6mNBO8ZjlcFWklIMyaWJknfQj2iMY7D/DguKm1GHpeW
        iG6ugqioWTVlnfXrGuIbRVpRxLDkVCR/0+oOzMM8fQUZ8Y47eS5H4dJEjUBFKuMbTCyddgmGXzD1O
        dPjqgm0/hAyeZ2eP+RMoqGnLCfs9Dac2Cl6fGDhpyb0Ts0AxD4z8s++F19epko1gkgA84u3pRmTao
        Y1ubOOzbAAsVDzZ6br6SUKOsvP953Uzzm4NhMzYoWiSD1nxjEcfPbjrR1ZjxDzwoqbwXmo+U5rblt
        90LU65hQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYamn-000YMj-Je; Wed, 14 Sep 2022 22:23:13 +0000
Date:   Wed, 14 Sep 2022 23:23:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Is it possible to force an address_space to always allocate
 pages in specific order?
Message-ID: <YyJUUQjLj6z19lP0@casper.infradead.org>
References: <1780f977-2717-8ea8-c5ec-6cf30d98d261@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780f977-2717-8ea8-c5ec-6cf30d98d261@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 02:17:24PM +0800, Qu Wenruo wrote:
> With recent folio MM changes, I'm wondering if it's possible to force an
> address space to always allocate a folio in certain order?

You're the second person to ask me about this today.  Well, actually,
the first because the other person asked me in-person after you sent
this email.

We have most of the infrastructure in place to do this now.  There
are some places still missing, such as allocating-pages-on-buffered-write.
I don't think any of them will be _hard_, we just need to do the work.

> E.g. For certain inode, we always allocate pages (folios) in the order
> of 2 for its page cache.
> 
> I'm asking this seemingly weird question for the following reasons:
> 
> - Support multi-page blocksize of various filesystems
>   Currently most file systems only go support sub-page, not multi-page
>   blocksize.
> 
>   Thus if there is forced order for all the address space, it would be
>   much easier to implement multi-page blocksize support.
>   (Although I strongly doubt if we need such multi-page blocksize
>    support for most fses)

It makes the MM people nervous when we *have* to do high-order
allocations.  For XFS, Dave Chinner has/had a patch set that uses base
page size to cache smaller pieces of larger blocks.  That approach works
for fs blocksize > page size, but doesn't work for storage LBA size >
page size.

It's definitely going to be easier to use large folios to solve your
use case, and since the page cache is usually a large part of the
memory consumption of a system, maybe it won't be as bad as the MM
people believe.

I have the beginnings of support for this (allowing the fs to set both a
minimum and maximum folio allocation order).  It's not tested, incomplete,
and as I mention above, it doesn't do the write-into-a-cache-miss
allocation.  Maybe there would also be other places that need to be
fixed too.  Would this API work for you?

(as you can see, i've been sitting on it for a while)

From 1aeee696f4d322af5f34544e39fc00006c399fb8 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 15 Dec 2020 10:57:34 -0500
Subject: [PATCH] fs: Allow fine-grained control of folio sizes

Some filesystems want to be able to limit the maximum size of folios,
and some want to be able to ensure that folios are at least a certain
size.  Add mapping_set_folio_orders() to allow this level of control
(although it is not yet honoured).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cad81db32e61..9cbb8bdbaee7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -198,9 +198,15 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_FOLIO_ORDER_MIN = 8,
+	AS_FOLIO_ORDER_MAX = 13,
+	/* 8-17 are used for FOLIO_ORDER */
 };
 
+#define AS_FOLIO_ORDER_MIN_MASK	0x00001f00
+#define AS_FOLIO_ORDER_MAX_MASK 0x0002e000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -290,6 +296,29 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/**
+ * mapping_set_folio_orders() - Set the range of folio sizes supported.
+ * @mapping: The file.
+ * @min: Minimum folio order (between 0-31 inclusive).
+ * @max: Maximum folio order (between 0-31 inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which sizes of folio the VFS can use to cache the contents
+ * of the file.  This should only be used if the filesystem needs special
+ * handling of folio sizes (ie there is something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ * 
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_orders(struct address_space *mapping,
+		unsigned int min, unsigned int max)
+{
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+			(min << AS_FOLIO_ORDER_MIN) |
+			(max << AS_FOLIO_ORDER_MAX);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
@@ -303,7 +332,12 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_orders(mapping, 0, 31);
+}
+
+static inline unsigned mapping_max_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
 }
 
 /*
@@ -312,8 +346,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.35.1

