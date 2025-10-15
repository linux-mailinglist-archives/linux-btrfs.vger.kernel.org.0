Return-Path: <linux-btrfs+bounces-17797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC20BDC574
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 220BB34FFF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 03:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FE29BDA9;
	Wed, 15 Oct 2025 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TvNWj89z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFaSCuKc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F042529ACC2;
	Wed, 15 Oct 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498956; cv=none; b=VkpzW4PbyE7SK7ET9XSgCLCuu4Ihpqns9Ubt5HH2lg687b/d+IKjPFPd6TQPcPaie0bWF5oaiF+Dxazc8N6F0DNJ7VbOaD+uDu4qdiPxLDCstrxazUw9wUFItzxXZtR68NJ9Ee4afifBmTE6BECFsAassM4FUailB4ipABVSRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498956; c=relaxed/simple;
	bh=3yJc2U4Jv0xsD3KR7kK20wGCoC1h1ZRE9wKGtVA/L64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIFPC1p0Wb2Fkk2XOWa/tV2fnDcKEWGCsT/Lkde1yBWu0c1IsRaJqSwkCm7RrEGkzi0yb5ZJBnt92P6/qDh53mSQ11hDixX6uxEYEd8Og9aDicIw0qctYqIa1PRrBUaEq/dkCqtdgBYD9Mnf7b8+ohKH22adBwOO5h0wsJNRgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TvNWj89z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xFaSCuKc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE33214000B8;
	Tue, 14 Oct 2025 23:29:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 14 Oct 2025 23:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760498951; x=1760585351; bh=MLKpo42AdU
	ONt702HfyTqM+vdjqH2K39hmIZquyEsbo=; b=TvNWj89zEFK/34STxUVXacQavv
	B6Y9mTjQKwoBkpTE9UIWO5ChryLmIs339cKQfXZ/GtrTzofrhrQQNhtgc4htvcDj
	RS8cA0ROYV22A/lPfbsQX2GC641sV0r641hZpQ8XjpMOIUwXoi14AtpZWDXfO2qH
	SiQhbhU80sCWk4PsEQDH6Op2nn/tlMKI9/7ElWF8D5D7Wixr+SDEaZwYq5XztDIR
	DWn3FsU6lkOMWC3SDLb+0digirFDBYHfbphR/I/p4g/gzUatPzguudpJSm1/+vkP
	7r5c/eoDHZPVgni0pEpnH5adFRGC/VhV4qJplgn+utg4fiZ6QJ9wWu6UNWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760498951; x=1760585351; bh=MLKpo42AdUONt702HfyTqM+vdjqH2K39hmI
	ZquyEsbo=; b=xFaSCuKcZlYHn1GPtK5huSIMZTyKVGK5MyKPfmRR6nE+QnUOE7h
	lVop4k4C1X/jxTsYLBdl8dyXvU4QLv77ZtLXAG01iDpyoB6vVoxaEXBSbdFZ+1Pp
	k5a1yCn5GqGxHudEEWSl4lI7ppCGsKE1MWcrYolw9FQKqFSLAjNPnMjtnaBfjDH3
	K9eKZIT3OlqkYYuzkxQrxgyyYY5Wgb+gTPUQqKMi2uDhDLrDxLQB8wB2CHXIZt6g
	33u8R53qE5ar52OuC9mhPDYyE4hXXnq0/rU7ZPQ/QKQh1RuNof6OFs+jxf/hPKRd
	FxDOf36SYAScMd4OLwdmf41fXKx8Guh5JJA==
X-ME-Sender: <xms:BxXvaMwzKWxsNOXezMwNBK6AnE-T5j3KdS8Fr-j5XwB-UJICWgFx7g>
    <xme:BxXvaOFjRJO-kIAH-0kbcBqTBZCt2YUagqCr-KCEfqpCqp6sBTA6hG9d_kSnB7CA4
    BK2xQTRFwbMS9qFPkpAC8b-7VD3okwYOGCm80pwNMdanOCU2qNn4Q>
X-ME-Received: <xmr:BxXvaIzihwSBroch9XhTcec32L-nbst7dKvqez8vfbyWt424hwZZ55Q3NrJyeyhWbD0PIKGZnayjkxYUxvLTLT5V1kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthht
    ohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BxXvaHuLC5MdKTqynn7V5e-1Ru6VvdmvnL1JU2AYuUBVGPp2rwwfjA>
    <xmx:BxXvaN34icIp7u1JoUNrP8Vi8O1OiBlBbnmTEayz7muckPqfGIkG8Q>
    <xmx:BxXvaK9qPvdCie7KZxjNmW9r9nKdIglDSggnwtry0nlOB3NVDpxq6w>
    <xmx:BxXvaGM50xcGTlFe3Tj_9hvtfxw-bEIY_sApQaIS78wBpQb1Qv2Img>
    <xmx:BxXvaKgUs1AzH5buyBE6ijMoQIDD71x_oFAp-7IxlxYQC5ngZgqf1Xfv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 23:29:11 -0400 (EDT)
Date: Tue, 14 Oct 2025 20:28:50 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: add tracing for find_free_extent skip
 conditions
Message-ID: <20251015032817.GA1702774@zen.localdomain>
References: <cover.1759532729.git.loemra.dev@gmail.com>
 <e5bb7036ec9f54f4ff862327d3ff3ccc9128077d.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bb7036ec9f54f4ff862327d3ff3ccc9128077d.1759532729.git.loemra.dev@gmail.com>

On Fri, Oct 03, 2025 at 04:41:58PM -0700, Leo Martins wrote:
> Add detailed tracing to the find_free_extent() function to improve
> observability of extent allocation behavior. This patch introduces:
> > - A new trace event btrfs_find_free_extent_skip_block_group() that 
>   captures
>   allocation context and skip reasons
> - Comprehensive set of FFE_SKIP_BG_* constants defining specific
>   reasons why block groups are skipped during allocation
> - Trace points at all major skip conditions in the allocator loop
> 
> The trace event includes key allocation parameters (root, size, flags,
> loop iteration) and block group details (start, length, flags) along
> with the specific skip reason and associated error codes.
> 
> These trace points will help diagnose allocation performance
> issues, understand allocation patterns, and debug extent allocator
> behavior.
> 

One nit inline, but this looks great, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/extent-tree.c       | 38 +++++++++++++++++++--
>  fs/btrfs/extent-tree.h       | 17 ++++++++++
>  include/trace/events/btrfs.h | 66 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 28b442660014..3b6d57d39bd5 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4455,6 +4455,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				 * target because our list pointers are not
>  				 * valid
>  				 */
> +				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_REMOVING, 0);
>  				btrfs_put_block_group(block_group);
>  				up_read(&space_info->groups_sem);
>  			} else {
> @@ -4466,6 +4468,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				goto have_block_group;
>  			}
>  		} else if (block_group) {
> +			if (!block_group_bits(block_group, ffe_ctl->flags))
> +				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_WRONG_FLAGS, block_group->flags & ~ffe_ctl->flags);
> +			else if (block_group->space_info != space_info)
> +				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_WRONG_SPACE_INFO, 0);
> +			else if (block_group->cached == BTRFS_CACHE_NO)
> +				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_NOT_CACHED, 0);

nit: I think this would look nicer with the code/data selected by the
ifs and then a single trace call.

>  			btrfs_put_block_group(block_group);
>  		}
>  	}
> @@ -4481,6 +4492,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ffe_ctl->hinted = false;
>  		/* If the block group is read-only, we can skip it entirely. */
>  		if (unlikely(block_group->ro)) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_READ_ONLY, 0);
>  			if (ffe_ctl->for_treelog)
>  				btrfs_clear_treelog_bg(block_group);
>  			if (ffe_ctl->for_data_reloc)
> @@ -4492,6 +4505,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ffe_ctl->search_start = block_group->start;
>  
>  		if (!block_group_bits(block_group, ffe_ctl->flags)) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_WRONG_FLAGS, block_group->flags & ~ffe_ctl->flags);
>  			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
>  			continue;
>  		}
> @@ -4511,6 +4526,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  			 * error that caused problems, not ENOSPC.
>  			 */
>  			if (ret < 0) {
> +				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_CACHE_ERROR, ret);
>  				if (!cache_block_group_error)
>  					cache_block_group_error = ret;
>  				ret = 0;
> @@ -4520,18 +4537,26 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		}
>  
>  		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_CACHE_ERROR, -EIO);
>  			if (!cache_block_group_error)
>  				cache_block_group_error = -EIO;
>  			goto loop;
>  		}
>  
> -		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
> +		if (!find_free_extent_check_size_class(ffe_ctl, block_group)) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_SIZE_CLASS_MISMATCH, block_group->size_class);
>  			goto loop;
> +		}
>  
>  		bg_ret = NULL;
>  		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
> -		if (ret > 0)
> +		if (ret > 0) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_DO_ALLOCATION_FAILED, ret);
>  			goto loop;
> +		}
>  
>  		if (bg_ret && bg_ret != block_group) {
>  			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
> @@ -4545,22 +4570,29 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		/* move on to the next group */
>  		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
>  		    block_group->start + block_group->length) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_SEARCH_BOUNDS, block_group->start + block_group->length);
>  			btrfs_add_free_space_unused(block_group,
>  					    ffe_ctl->found_offset,
>  					    ffe_ctl->num_bytes);
>  			goto loop;
>  		}
>  
> -		if (ffe_ctl->found_offset < ffe_ctl->search_start)
> +		if (ffe_ctl->found_offset < ffe_ctl->search_start) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							FFE_SKIP_BG_SEARCH_BOUNDS, ffe_ctl->found_offset);
>  			btrfs_add_free_space_unused(block_group,
>  					ffe_ctl->found_offset,
>  					ffe_ctl->search_start - ffe_ctl->found_offset);
> +		}
>  
>  		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
>  					       ffe_ctl->num_bytes,
>  					       ffe_ctl->delalloc,
>  					       ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS);
>  		if (ret == -EAGAIN) {
> +			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_ADD_RESERVED_FAILED, -EAGAIN);
>  			btrfs_add_free_space_unused(block_group,
>  					ffe_ctl->found_offset,
>  					ffe_ctl->num_bytes);
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index e970ac42a871..4f1dc077b7c9 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -23,6 +23,23 @@ enum btrfs_extent_allocation_policy {
>  	BTRFS_EXTENT_ALLOC_ZONED,
>  };
>  
> +/*
> + * Enum for find_free_extent skip reasons used in trace events.
> + * Each enum corresponds to a specific unhappy path in the allocator.
> + */
> +enum {
> +	FFE_SKIP_BG_REMOVING,
> +	FFE_SKIP_BG_READ_ONLY,
> +	FFE_SKIP_BG_WRONG_SPACE_INFO,
> +	FFE_SKIP_BG_WRONG_FLAGS,
> +	FFE_SKIP_BG_NOT_CACHED,
> +	FFE_SKIP_BG_CACHE_ERROR,
> +	FFE_SKIP_BG_SIZE_CLASS_MISMATCH,
> +	FFE_SKIP_BG_DO_ALLOCATION_FAILED,
> +	FFE_SKIP_BG_SEARCH_BOUNDS,
> +	FFE_SKIP_BG_ADD_RESERVED_FAILED,
> +};
> +
>  struct find_free_extent_ctl {
>  	/* Basic allocation info */
>  	u64 ram_bytes;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 7e418f065b94..72aa250983d4 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -103,6 +103,19 @@ struct find_free_extent_ctl;
>  	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
>  	EMe(RESET_ZONES,		"RESET_ZONES")
>  
> +#define FIND_FREE_EXTENT_SKIP_REASONS						\
> +	EM( FFE_SKIP_BG_REMOVING,		"BG_REMOVING")			\
> +	EM( FFE_SKIP_BG_READ_ONLY,		"BG_READ_ONLY")			\
> +	EM( FFE_SKIP_BG_WRONG_SPACE_INFO,	"BG_WRONG_SPACE_INFO")		\
> +	EM( FFE_SKIP_BG_WRONG_FLAGS,		"BG_WRONG_FLAGS")		\
> +	EM( FFE_SKIP_BG_NOT_CACHED,		"BG_NOT_CACHED")		\
> +	EM( FFE_SKIP_BG_CACHE_ERROR,		"BG_CACHE_ERROR")		\
> +	EM( FFE_SKIP_BG_SIZE_CLASS_MISMATCH,	"BG_SIZE_CLASS_MISMATCH")	\
> +	EM( FFE_SKIP_BG_DO_ALLOCATION_FAILED,	"BG_DO_ALLOCATION_FAILED")	\
> +	EM( FFE_SKIP_BG_SEARCH_BOUNDS,		"BG_SEARCH_BOUNDS")		\
> +	EMe(FFE_SKIP_BG_ADD_RESERVED_FAILED,	"BG_ADD_RESERVED_FAILED")
> +
> +
>  /*
>   * First define the enums in the above macros to be exported to userspace via
>   * TRACE_DEFINE_ENUM().
> @@ -118,6 +131,7 @@ FI_TYPES
>  QGROUP_RSV_TYPES
>  IO_TREE_OWNER
>  FLUSH_STATES
> +FIND_FREE_EXTENT_SKIP_REASONS
>  
>  /*
>   * Now redefine the EM and EMe macros to map the enums to the strings that will
> @@ -1388,6 +1402,58 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
>  	TP_ARGS(block_group, ffe_ctl)
>  );
>  
> +TRACE_EVENT(btrfs_find_free_extent_skip_block_group,
> +
> +	TP_PROTO(const struct btrfs_root *root,
> +		 const struct find_free_extent_ctl *ffe_ctl,
> +		 const struct btrfs_block_group *block_group,
> +		 int reason,
> +		 s64 error_or_value),
> +
> +	TP_ARGS(root, ffe_ctl, block_group, reason, error_or_value),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	root_objectid		)
> +		__field(	u64,	num_bytes		)
> +		__field(	u64,	empty_size		)
> +		__field(	u64,	flags			)
> +		__field(	int,	loop			)
> +		__field(	bool,	hinted			)
> +		__field(	int,	size_class		)
> +		__field(	u64,	bg_start		)
> +		__field(	u64,	bg_length		)
> +		__field(	u64,	bg_flags		)
> +		__field(	int,	reason			)
> +		__field(	s64,	error_or_value		)
> +	),
> +
> +	TP_fast_assign_btrfs(root->fs_info,
> +		__entry->root_objectid	= btrfs_root_id(root);
> +		__entry->num_bytes	= ffe_ctl->num_bytes;
> +		__entry->empty_size	= ffe_ctl->empty_size;
> +		__entry->flags		= ffe_ctl->flags;
> +		__entry->loop		= ffe_ctl->loop;
> +		__entry->hinted		= ffe_ctl->hinted;
> +		__entry->size_class	= ffe_ctl->size_class;
> +		__entry->bg_start	= block_group ? block_group->start : 0;
> +		__entry->bg_length	= block_group ? block_group->length : 0;
> +		__entry->bg_flags	= block_group ? block_group->flags : 0;
> +		__entry->reason		= reason;
> +		__entry->error_or_value	= error_or_value;
> +	),
> +
> +	TP_printk_btrfs(
> +"root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s) loop=%d hinted=%d size_class=%d bg=[%llu+%llu] bg_flags=%llu(%s) reason=%s error_or_value=%lld",
> +		  show_root_type(__entry->root_objectid),
> +		  __entry->num_bytes, __entry->empty_size, __entry->flags,
> +		  __print_flags((unsigned long)__entry->flags, "|", BTRFS_GROUP_FLAGS),
> +		  __entry->loop, __entry->hinted, __entry->size_class,
> +		  __entry->bg_start, __entry->bg_length, __entry->bg_flags,
> +		  __print_flags((unsigned long)__entry->bg_flags, "|", BTRFS_GROUP_FLAGS),
> +		  __print_symbolic(__entry->reason, FIND_FREE_EXTENT_SKIP_REASONS),
> +		  __entry->error_or_value)
> +);
> +
>  TRACE_EVENT(btrfs_find_cluster,
>  
>  	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
> -- 
> 2.47.3
> 

