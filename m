Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8543BB964
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhGEIgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhGEIgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 04:36:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1258C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 01:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uhPqddLphZ56kB+J3WFVFYUo5Q5hnkOxoJDzKbtj1G4=; b=Dk2LZsttqYGYvhtVmKUP2gBz+Y
        tp0iEKO2MK2RBdYN6eYOCxhGaOnAqM1OKOBvqaWu4XcmDezeRhnHKsyw39Ay1sb0SPaNcTn57N1ql
        HsUgUVlqi7XRt8sh5QFWg5EhFzIr8KGy4Mrg0anFWJ8CSd2Aw+7PXLje54ESlafg+kiU/z1yfJqes
        5Sf9EpLtI/Oyfe5e4vfYCHFPqXf6Q+griYzDyZABGi3G6QcLuFddIf94ZjTiVmXLA3M/HMwF3FYDI
        LETmZxcQsahluQE0KGQ+C2IsMSB5TDXtqGDId+h/IJdOfpMbBb2P92IJSNqHn9pE/+i0offTimazr
        4Dgq0dBw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0K2o-00A2we-B6; Mon, 05 Jul 2021 08:33:43 +0000
Date:   Mon, 5 Jul 2021 09:33:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <YOLD3CJjDgiq+kfR@infradead.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org>
 <20210702110630.GE2610@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702110630.GE2610@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 02, 2021 at 01:06:30PM +0200, David Sterba wrote:
> On Fri, Jul 02, 2021 at 08:10:50AM +0100, Christoph Hellwig wrote:
> > > +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
> > >  		return get_unaligned_le##bits(token->kaddr + oip);	\
> > > +	} else {							\
> > 
> > No need for an else after the return and thus no need for all the
> > reformatting.
> 
> That leads to worse code, compiler does not eliminate the block that
> would otherwise be in the else block. Measured on x86_64 with
> instrumented code to force INLINE_EXTENT_BUFFER_PAGES = 1 this adds
> +1100 bytes of code and has impact on stack consumption.
> 
> That the code that is in two branches that do not share any code is
> maybe not pretty but the compiler did what I expected.  The set/get
> helpers get called a lot and are performance sensitive.
> 
> This patch pre (original version), post (with dropped else):
> 
> 1156210   19305   14912 1190427  122a1b pre/btrfs.ko
> 1157386   19305   14912 1191603  122eb3 post/btrfs.ko

For the obvious trivial patch (see below) I see the following
difference, which actually makes the simple change smaller:

   text	   data	    bss	    dec	    hex	filename
1322580	 112183	  27600	1462363	 16505b	fs/btrfs/btrfs.o.hch
1322832	 112183	  27600	1462615	 165157	fs/btrfs/btrfs.o.dave

This is sing the following compiler:
gcc version 10.2.1 20210110 (Debian 10.2.1-6) 

---
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 8260f8bb3ff0..a20954f06ec8 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -73,7 +73,7 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	}								\
 	token->kaddr = page_address(token->eb->pages[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
-	if (oip + size <= PAGE_SIZE)					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE)	\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
 									\
 	memcpy(lebytes, token->kaddr + oip, part);			\
@@ -94,7 +94,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (oip + size <= PAGE_SIZE)					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE)	\
 		return get_unaligned_le##bits(kaddr + oip);		\
 									\
 	memcpy(lebytes, kaddr + oip, part);				\
@@ -124,7 +124,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	}								\
 	token->kaddr = page_address(token->eb->pages[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
-	if (oip + size <= PAGE_SIZE) {					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
@@ -146,7 +146,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (oip + size <= PAGE_SIZE) {					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
 		put_unaligned_le##bits(val, kaddr + oip);		\
 		return;							\
 	}								\
