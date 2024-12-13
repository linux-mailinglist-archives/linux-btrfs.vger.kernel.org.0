Return-Path: <linux-btrfs+bounces-10342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118629F072E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1FD28151E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF21ACDF0;
	Fri, 13 Dec 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MflO+6nv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D618E377;
	Fri, 13 Dec 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080715; cv=none; b=sKghxMFZkuIdKvsUuzdEj/Tt9OHiz1VSL38X7RsvDqUoPzqBkGMzL2e+OCVBvzDsu0PTXB7VvWf6psaXEbMZ+J+gqgZu2saqVZyaeg+JaC1hFq4spq4u2o0wxpiGzR+UnUskiVFXnt5/uw4EwyF/2SkrWnEDC7gx4IfQFebwOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080715; c=relaxed/simple;
	bh=GdUYKk1NnGTL1RKij+QpGMfkiUryDvmruO1tEqbzjDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkeD1j94eOiXfntr0IydjU1BlKr5bUh/wYXLdP22BnraJ2BHIqwru6bp/IrtuaqEavBbTmrCUkJfKskmDhezelO5lhRGvqS8kp5BkdDpWDxsWUCx5RDKvnJkzlNSKewjU4w4uv61nDHIrmDvkKmF+44R7aC/n8+amzoHCKoOmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MflO+6nv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MOpxGLnB0Zdlwwn6qH2xMgY5IO9WDMOFqPHpvJonJHI=; b=MflO+6nvKOtu2AXwbdJ5n1nedE
	opnOzu3b01KF4SrQR3M245/Se8YXsyCcliDtgOmYdDyDa1clOCphqjy1rC4V/FpS/cnmOAKJcJTd7
	sIg5Hm5gZGHQDeCzUyfK77d8W3HdMbpqg2E7qiL7q3yElXEqzVhzB3ElK1IXaECQTIUoaf2k8fWjX
	XizOCVbydNhMuEsF16HvR1QgF11wiGSetObHVPxuOA3SxM9i5kRo55wbadhs2gMfil7aRRMjHa+a4
	7xzfwtdqZfkPI0z9C29sDel/UeYY7HOpEwtHAoW8txUjodTyQr4ovst3PwYEj20CSLJFa5AtEeJSb
	3+PB23BA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM1bg-0000000Bk1v-07MY;
	Fri, 13 Dec 2024 09:05:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9253830049D; Fri, 13 Dec 2024 10:05:07 +0100 (CET)
Date: Fri, 13 Dec 2024 10:05:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>, dsterba@suse.cz,
	oleg@redhat.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Message-ID: <20241213090507.GB21636@noisy.programming.kicks-ass.net>
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
 <f4d62504-140b-4fde-9b52-65cf3a0ddd0a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4d62504-140b-4fde-9b52-65cf3a0ddd0a@gmx.com>

On Fri, Dec 13, 2024 at 05:51:44PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/13 03:16, Roger L. Beckermeyer III 写道:
> > Adds rb_find_add_cached() as a helper function for use with
> > red-black trees. Used in btrfs to reduce boilerplate code.
> 
> I won't call it boilerplate code though, it's just to utilize the cached
> rb tree feature as an optimization.

Nah, all this is boilerplate :-)

> > 
> > Suggested-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> > ---
> >   include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> > index 7c173aa64e1e..0d4444c0cfb3 100644
> > --- a/include/linux/rbtree.h
> > +++ b/include/linux/rbtree.h
> > @@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
> >   	rb_insert_color(node, tree);
> >   }
> > 
> > +/**
> > + * rb_find_add_cached() - find equivalent @node in @tree, or add @node
> > + * @node: node to look-for / insert
> > + * @tree: tree to search / modify
> > + * @cmp: operator defining the node order
> > + *
> > + * Returns the rb_node matching @node, or NULL when no match is found and @node
> > + * is inserted.
> > + */
> > +static __always_inline struct rb_node *
> > +rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
> > +	    int (*cmp)(struct rb_node *, const struct rb_node *))
> 
> This function is almost the same as rb_add_cached(), the only difference
> is the extra handling for the cmp function returning 0.
> 
> So I'm wondering if it's possible to enhance rb_add_cached(), or even
> refactor it so there can be a shared core function and rb_add_cached()
> and rb_find_add_cached() can reuse the same function.

Nope, rb_add_cached() can add multiple entries with the same key,
rb_find_add() cannot.

Also, note that all these things are effectively 'templates', they
generate code at the call site. The cmp() function as required for
find_add() is a tri-state return and generates more logic than the
binary less() required for add().


