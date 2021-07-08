Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CE3C1546
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 16:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGHOjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 10:39:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhGHOj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 10:39:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 82CC5201FD;
        Thu,  8 Jul 2021 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625755006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yq+Znsjp1QYVup7/gHk50wW4SLmbIrlfygfyg1XArg0=;
        b=l6+vYXjVloXQTnPDSvOEjDCZmSYbpb2s5DVnREHVCZTTp6BBbwTgL6BOmsriWkf8KZpxVt
        oMheNCNL3ubZ9FavJ+9YCCD8mRp8gwQvjMgbPyW+JxyDG+3Rf3T5OA8dMHDDHFDAKxI/X7
        +hmFKG5NP1sIQ/hLztXjzYU0ykY8m4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625755006;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yq+Znsjp1QYVup7/gHk50wW4SLmbIrlfygfyg1XArg0=;
        b=++YeMitRKXmXe+IY1BPnvR6MMLfbAfkSxSN+3Lz/5Dptpo/ArSiR7YA8He+fEDi1T9S4me
        d5BVkU+DPBMaAqBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 720EAA3BC5;
        Thu,  8 Jul 2021 14:36:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 335E7DAF79; Thu,  8 Jul 2021 16:34:12 +0200 (CEST)
Date:   Thu, 8 Jul 2021 16:34:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210708143412.GC2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
References: <20210701160039.12518-1-dsterba@suse.com>
 <YN67+nvpQBfiLXzh@infradead.org>
 <20210702110630.GE2610@twin.jikos.cz>
 <YOLD3CJjDgiq+kfR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOLD3CJjDgiq+kfR@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 09:33:34AM +0100, Christoph Hellwig wrote:
> On Fri, Jul 02, 2021 at 01:06:30PM +0200, David Sterba wrote:
> > On Fri, Jul 02, 2021 at 08:10:50AM +0100, Christoph Hellwig wrote:
> > > > +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
> > > >  		return get_unaligned_le##bits(token->kaddr + oip);	\
> > > > +	} else {							\
> > > 
> > > No need for an else after the return and thus no need for all the
> > > reformatting.
> > 
> > That leads to worse code, compiler does not eliminate the block that
> > would otherwise be in the else block. Measured on x86_64 with
> > instrumented code to force INLINE_EXTENT_BUFFER_PAGES = 1 this adds
> > +1100 bytes of code and has impact on stack consumption.
> > 
> > That the code that is in two branches that do not share any code is
> > maybe not pretty but the compiler did what I expected.  The set/get
> > helpers get called a lot and are performance sensitive.
> > 
> > This patch pre (original version), post (with dropped else):
> > 
> > 1156210   19305   14912 1190427  122a1b pre/btrfs.ko
> > 1157386   19305   14912 1191603  122eb3 post/btrfs.ko
> 
> For the obvious trivial patch (see below) I see the following
> difference, which actually makes the simple change smaller:
> 
>    text	   data	    bss	    dec	    hex	filename
> 1322580	 112183	  27600	1462363	 16505b	fs/btrfs/btrfs.o.hch
> 1322832	 112183	  27600	1462615	 165157	fs/btrfs/btrfs.o.dave

This was on x86_64 and without any further changes to the
extent_buffer::pages, right?

I've tested your version with the following diff emulating the single
page that would be on ppc:

--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,7 +94,8 @@ struct extent_buffer {

        struct rw_semaphore lock;

-       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+       struct page *pages[1];
+       /* struct page *pages[INLINE_EXTENT_BUFFER_PAGES]; */
        struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
        struct list_head leak_list;
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 8260f8bb3ff0..4f8e8f7b29d1 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -52,6 +52,8 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
  * from 0 to metadata node size.
  */

+#define _INLINE_EXTENT_BUFFER_PAGES 1
...
---

And replacing _INLINE_EXTENT_BUFFER_PAGES in the checks. This leads to
the same result as in my original version with the copied blocks:

   text    data     bss     dec     hex filename
1161350   19305   14912 1195567  123e2f pre/btrfs.ko
1156090   19305   14912 1190307  1229a3 post/btrfs.ko

DELTA: -5260

ie. compiler properly removed the dead code after evaluating the
conditions. As your change is simpler code I'll take it, tahnks for the
suggestion.
