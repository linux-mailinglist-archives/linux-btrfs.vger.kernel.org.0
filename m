Return-Path: <linux-btrfs+bounces-13008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1EA88C79
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC17E3A301E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CF1C84B7;
	Mon, 14 Apr 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WoacjyE1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNYJVFUJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA71D63C6
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660349; cv=none; b=U3xjfZcobwe/Ai1kadfTWhnnfavPF9dNzfPj4EuNz+N/rqHxSSLaoi9kuf7XyV9VviqDPpy2oXz21awJJQiF7NVTy7xgtr+iiyfNFbMuZdgYPelE+RM+HV9muR+OYHUzgcpA5WP2Bm9p7ByH8rZtJXmHjYVRfISXxYkvjPlsGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660349; c=relaxed/simple;
	bh=SUJ/xYa4l3dfhOZiHpJ4FYI1lq0lb9XkciC1K46yAlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzUfg/xP5ctaTqBattDVJf7YpLZ5siBEuwiuw6XIQo+VDxjiXJuyT9tiDMRk0MfO4k4vv8voxHTQGINiG9R1J2NCErMgt7MRUFlcI3HXcn7gWtHqwDzHcpCT9KBfUlUpDtj14dPmT8R6bLv+wn7gN09ZFIy8/RkNx+d+yRKYT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WoacjyE1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNYJVFUJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E68C91380512;
	Mon, 14 Apr 2025 15:52:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 14 Apr 2025 15:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1744660345; x=1744746745; bh=ITiHBFeh4j
	+J6PVeFXsRCFz+ZxZNPQi8z0zxgP/GUn8=; b=WoacjyE1DCkgOPUznAJBNbgALY
	Yy8FkyVgKpl8blsHg8vdoUR2kRSJtii8rkP9TLvAnjBt5e+3wymG7IvH6rm2Y0yr
	yccWfh/g+9sJ0nyvHf7ydHbEeH5YLU4KR4gKjJfdD24paVRquZAQyc3pWWvhGzSe
	cl8iZrHtD++FnPI/uJru4kGxKTyLRrsENFf+A0vdyehFJsqF+VIpx24lBTxDqcci
	+OcVMMsCTN3MkJzByuq4kHL2DM7rnVpJ9uQcuk88WmsySZGkja/JSkp2SW+f6a2A
	5LxnHhwj7XNg5sDGXZXBPpuujDHI38DiIUNtEf7l4YpUsLtkPIR5/Sh+mTNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744660345; x=1744746745; bh=ITiHBFeh4j+J6PVeFXsRCFz+ZxZNPQi8z0z
	xgP/GUn8=; b=MNYJVFUJvFr7XvKHotLVTHMPXAGEzIdvK6nL5MzkMZtYwTzYoCb
	qvhI3bjAZTLo+iLiBNZY+33HW2LLie/BPgzYAx3aCF/GJHt2bPvPQgnUi+vcVADL
	Yi3Zdav8f8mDxtwJ2CfB5oWTudsVREpnqx9vbLDuMQq/ZtE/M85umnkJ2eBYThjH
	O48O8qNWoGCqaSC3ZQEKsA1weCZrLoxurBaklPogVpIuDmDBh62t1TRc+9+KP1k2
	BvrfUUids/OVtj/zDCBbRCsFv8NNHCHOUucSUOD9WtHXvqHSisjWmidREk/H5DdA
	JmrMnEOBZMEKmfkE6xS4kf6CI4MGmlb0ayA==
X-ME-Sender: <xms:eWf9Z7bf6NWBX7x0iQ9QJEAAHaI9cU0b8fzBtqjYMnCJCtUOVbZKQw>
    <xme:eWf9Z6bg4qR26qQlg13mMKZcQu2N12nPim4RHjlRvbdhbOsP1n9L7spX7kK7nHXa3
    PP6nD3Cp76EVqBueJ0>
X-ME-Received: <xmr:eWf9Z98i1w7jP9y4W-cMLcqo1biLlfWcf0KduLPwvvQ-WFwLaPJMrwn6EjY0DaMcJCFKyco4f9sWq-FKxz9T0-7wg8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:eWf9ZxqfZWcEXdZ0QSasWvtrWJYQSMZVZ_IeYCG88WTSljJy8IQbZA>
    <xmx:eWf9Z2reccfvPQUaZERbC2AHjFHhr5N5lfeRwzSgtORURRJQhNRfdA>
    <xmx:eWf9Z3SL7a8EAW9JyYH0AMIcVOxx-tcaFkavd3PTthnZw-g6X6jyjA>
    <xmx:eWf9Z-op_OxrFXKxoUj9eN04kG8QxYEaU8OYp4QfkLd4IlAcL0pgQA>
    <xmx:eWf9ZxtUUef4Xd2ERZyiI3C2NYUFKLrWVxEK3WfIErN6huTANxkcXH1B>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 15:52:25 -0400 (EDT)
Date: Mon, 14 Apr 2025 12:52:48 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix race in subpage sync writeback handling
Message-ID: <20250414195248.GA3218113@zen.localdomain>
References: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>

On Mon, Apr 14, 2025 at 03:32:34PM -0400, Josef Bacik wrote:
> While debugging a fs corruption with subpage we noticed a potential race
> in how we do tagging for writeback.  Boris came up with the following
> diagram to describe the race potential
> 
> EB1                                                       EB2
> btree_write_cache_pages
>   tag_pages_for_writeback
>   filemap_get_folios_tag(TOWRITE)
>   submit_eb_page
>     submit_eb_subpage
>       for eb in folio:
>         write_one_eb
>                                                           set_extent_buffer_dirty
>                                                           btrfs_meta_folio_set_dirty
>                                                           ...
>                                                           filemap_fdatawrite_range
>                                                             btree_write_cache_pages
>                                                             tag_pages_for_writeback
>           folio_lock
>           btrfs_meta_folio_clear_dirty
>           btrfs_meta_folio_set_writeback // clear TOWRITE
>           folio_unlock
>                                                             filemap_get_folios_tag(TOWRITE) //missed
> 
> The problem here is that we'll call folio_start_writeback() the first
> time we initiate writeback on one extent buffer, if we happened to dirty
> the extent buffer behind the one we were currently writing in the first
> task, and race in as described above, we would miss the TOWRITE tag as
> it would have been cleared, and we will never initiate writeback on that
> EB.
> 
> This is kind of complicated for us, the best thing to do here is to
> simply leave the TOWRITE tag in place, and only clear it if we aren't
> dirty after we finish processing all the eb's in the folio.
> 
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 23 +++++++++++++++++++++++
>  fs/btrfs/subpage.c   |  2 +-
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6cfd286b8bbc..5d09a47c1c28 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2063,6 +2063,29 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
>  		}
>  		free_extent_buffer(eb);
>  	}
> +	/*
> +	 * Normally folio_start_writeback() will clear TAG_TOWRITE, but for
> +	 * subpage we use __folio_start_writeback(folio, true), which keeps it
> +	 * from clearing TOWRITE.  This is because we walk the bitmap and
> +	 * process each eb one at a time, and then locking the folio when we
> +	 * process the eb.  We could have somebody dirty behind us, and then
> +	 * subsequently mark this range as TOWRITE.  In that case we must not
> +	 * clear TOWRITE or we will skip writing back the dirty folio.
> +	 *
> +	 * So here lock the folio, if it is clean we know we are done with it,
> +	 * and we can clear TOWRITE.
> +	 */
> +	folio_lock(folio);
> +	if (!folio_test_dirty(folio)) {
> +		XA_STATE(xas, &folio->mapping->i_pages, folio_index(folio));
> +		unsigned long flags;
> +
> +		xas_lock_irqsave(&xas, flags);
> +		xas_load(&xas);
> +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> +		xas_unlock_irqrestore(&xas, flags);
> +	}
> +	folio_unlock(folio);
>  	return submitted;
>  }
>  
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d4f019233493..53140a9dad9d 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -454,7 +454,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>  	spin_lock_irqsave(&subpage->lock, flags);
>  	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
>  	if (!folio_test_writeback(folio))
> -		folio_start_writeback(folio);
> +		__folio_start_writeback(folio, true);
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  }
>  
> -- 
> 2.48.1
> 

