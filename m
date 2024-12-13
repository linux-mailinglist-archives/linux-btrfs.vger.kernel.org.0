Return-Path: <linux-btrfs+bounces-10343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FC9F073A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED871160528
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB31AF0AB;
	Fri, 13 Dec 2024 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIPCC05h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F611A8F68;
	Fri, 13 Dec 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080779; cv=none; b=XLDzdi2xZ0bnE0vIF4TBZ6iEkV4/aMlOMqIFIRGhRwXZvtKy7hOqj+cK4WpHldYU6qXLEHcg/jeIjtE2Ct3+3OKOyodIIm9FYVbmkvDWW+pgPj7ZctH4Gg8d+wl5i9ctuzhNjV16MmUf2otxxPBO0gDA/uaiSHzqnxRdy1wQQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080779; c=relaxed/simple;
	bh=cLnJF8QFL0DMyGW/SWCm4zsxjRWAHmFTPEKA/fy/YIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb9eeIgtwWV9QkvvTZHLNu8q9QTGzB3oxFTvL7aQgmYhLSFOXWDf4m2N575ZCT9O3wVDiqhVCz8DCw5/lczmEBdmRznOsH5/EdGohUvsbGik1R54DfMFMTzomzO2pl3CJJG0ggJHGkkOQRBooLwEUeguXlkVLOH4/SNiFO0Nhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UIPCC05h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sA8rC/4ASNV4/IfEjkXWC+WvJ4cdmRo/VbEGd81GdWs=; b=UIPCC05hxdfcmg+jlUlzHYHljl
	u3rCLnoEtefEjnYso+ZRQu2hVTKyWSZUob1j6BLSRn1wnFMVEOcX3vskAEG0mLNgexKXIeBGcF5p5
	S7QI9+VOLxjKdceCPbYhC47qQ68LMsNdO1scpMA4jV0b1FWLGBHRr0SJadyLQAs8aT7Lo9+wPa4tO
	bebFDp5nKHxYhIezmJkCzrdUjgzQj32VAbulJTV+eXfzyZIOwpQA5yZq47mEXD2CM9qPo/52XzNvD
	a7fMVnZgTjbhRqaNbGVJKshlYo06A9saMI5HAZwHiGpPExHdEaEpjYHbTL0MUmD4sVNroqLA4ZysS
	tb/msouA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM1cj-0000000BkRH-2yMu;
	Fri, 13 Dec 2024 09:06:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FDD930005F; Fri, 13 Dec 2024 10:06:13 +0100 (CET)
Date: Fri, 13 Dec 2024 10:06:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: dsterba@suse.cz, oleg@redhat.com, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Message-ID: <20241213090613.GC21636@noisy.programming.kicks-ass.net>
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>

On Thu, Dec 12, 2024 at 10:46:18AM -0600, Roger L. Beckermeyer III wrote:
> Adds rb_find_add_cached() as a helper function for use with
> red-black trees. Used in btrfs to reduce boilerplate code.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> index 7c173aa64e1e..0d4444c0cfb3 100644
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
>  	rb_insert_color(node, tree);
>  }
>  
> +/**
> + * rb_find_add_cached() - find equivalent @node in @tree, or add @node
> + * @node: node to look-for / insert
> + * @tree: tree to search / modify
> + * @cmp: operator defining the node order
> + *
> + * Returns the rb_node matching @node, or NULL when no match is found and @node
> + * is inserted.
> + */
> +static __always_inline struct rb_node *
> +rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
> +	    int (*cmp)(struct rb_node *, const struct rb_node *))
> +{
> +	bool leftmost = true;
> +	struct rb_node **link = &tree->rb_root.rb_node;
> +	struct rb_node *parent = NULL;
> +	int c;
> +
> +	while (*link) {
> +		parent = *link;
> +		c = cmp(node, parent);
> +
> +		if (c < 0) {
> +			link = &parent->rb_left;
> +		} else if (c > 0) {
> +			link = &parent->rb_right;
> +			leftmost = false;
> +		} else {
> +			return parent;
> +		}
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color_cached(node, tree, leftmost);
> +	return NULL;
> +}
> +
>  /**
>   * rb_find_add() - find equivalent @node in @tree, or add @node
>   * @node: node to look-for / insert
> -- 
> 2.45.2
> 

