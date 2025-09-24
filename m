Return-Path: <linux-btrfs+bounces-17142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481FB9BA3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0411C1B267A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81F1258CE7;
	Wed, 24 Sep 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="i9OPmnOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifgo3GTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FA25484D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758741251; cv=none; b=L4hjOSVM9XVHy0S7vsbPxzPre1HCipiN/XR4WERBP9ufTrGBywLjndPj8j10L1/t+w7CoFgm6VuPvVkd3Uq16juza2MnRUeGoBd1VibMHcFNaLeQrSG3pLnitz9y8H/eN43JKbo4U3Lb9yMA5z00UgS+hmRFbtRvlG2aobxfhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758741251; c=relaxed/simple;
	bh=66ltB21a/yGqc4UmonB1B2/J5vCBaqwyYSa81ZJ6sCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTB6Rf4W4gn0GP40PCg7DMMg4QTN8l+vntDZzuTf9xrfw9Ug/9NpKXSMb+cuE2QEPukE5tPEmNnpaV+2eHaRqopRK/r5tuOsUMUT3jLxiUbCszF6/GNn00phdQR92B21UA9LVb6hmp4e7mndepvK1AjhncavejqwIYhWb0U6dxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=i9OPmnOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifgo3GTu; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6CD17A0176;
	Wed, 24 Sep 2025 15:14:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 15:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758741247; x=1758827647; bh=pCnJYt14rJ
	ABsdUM8bwR6x+EtcRqSj3mtv9x8SWXOi4=; b=i9OPmnOj3stjfMXIdc6AnP3pb8
	7LChSlNLwLjhYjsZI894EcNOV02CHB0mtRiPYt80lolLskGYpp1d335ST9sAk+He
	s3f122ryNVGv4LdxVAOI1lIgsh2WO4CcCv/O36FTC23KSzJu6BcoGbaS+2YgZ46n
	j2usDJ/uh4cds4FfbB6Xo88CyVpEMXlLdoT7mxV/85F+2OzT5uKI3EzSx4EsckBN
	/ajW/HrWuNFcAUYmVGglv1U0LPWTdSCZBf0iNM0TnOiswa4ZLqlkh3HzsZtO5JIR
	Y0ppjcSbLOon8C5tB94IceWg4xOwrYvdVXgGsFyyYnRMkUjMdPlXvoznUfIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758741247; x=1758827647; bh=pCnJYt14rJABsdUM8bwR6x+EtcRqSj3mtv9
	x8SWXOi4=; b=ifgo3GTuFZ9D+bjz+qC9AGewbNNPJO+bwnAov/LWU/HkHWR4z31
	4Nwx1eO8PGq4+1ywF9oRsCdbrNlHQjbHr78f/w5NQbNAHJX6mA/YlIzWzbm3B1AQ
	Hk5L/tSwmYTUIrsw30SLd3HOqC5t6PAwGgcHom1FS27wYxvmsU71XBkwKNPfXI+h
	oQa5mArgx/UIWZ/iAgn42VRlCTWFECs0Gomn/OXPwRYhooThIItEvbB/CEEv1Q39
	g8Y34pd58qlJbR3ZFwd77QufGXUz59pY/6fGT33GPD4O6rO0viLx9/hIygNJBbV1
	D5vYXF/ZLrGawpyfZ0Gy2oU4VgHUmL0TX/Q==
X-ME-Sender: <xms:_0LUaB0TjyNSN9EqbfMPg_WK3xCZ5gslyuR8ne9U0NoRP39aGyk9Hw>
    <xme:_0LUaPgopSXTAgCp1EmbF9dFiTqkWkWxIUKk1mOS68D498vyg_QbHUc0lnFRTjs5T
    kFYh0D8nvCax-iuwYgE5W7i7_3QTWOEf9fuD6KjRkqjJjjCQv3GUCmg>
X-ME-Received: <xmr:_0LUaPRJP3NLR-I8avKC3BPQp_IeqkhYET1YX6SGwVlrvx7mtNz8fq2MncGYVs7_sE3Exxo0CcFGQKgpgHgbRdvdoxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhovghmrhgrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:_0LUaIg4Hpxo7_hR6egNrAdkqxf6XCPzTK5Ahpse3gbPtuwXgruAng>
    <xmx:_0LUaH69aRdAcncwGeyRDtWECBqUm-MPMEE8r3o_CEKofgASmUBcww>
    <xmx:_0LUaNBj_vazTC-i8O8o9D-XFHBN4bADef1sXVIN60Xy_itLbid_dA>
    <xmx:_0LUaGZpkImIV8WMBVEDavyRnOAckwPaiFDtANVu_Ey6drC-SuQp4g>
    <xmx:_0LUaCZTidye6pNxEX-wFxfqeYpJ2Jj6dAI5q2NZIe9c0Sc47oPOMNft>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 15:14:07 -0400 (EDT)
Date: Wed, 24 Sep 2025 12:14:06 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add tracing for find_free_extent skip
 conditions
Message-ID: <20250924191406.GC3027411@zen.localdomain>
References: <cover.1758587352.git.loemra.dev@gmail.com>
 <7d0be9ae8855ddc20bc18f15234b9c527cf3d64a.1758587352.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0be9ae8855ddc20bc18f15234b9c527cf3d64a.1758587352.git.loemra.dev@gmail.com>

On Mon, Sep 22, 2025 at 06:13:15PM -0700, Leo Martins wrote:
> Add detailed tracing to the find_free_extent() function to improve
> observability of extent allocation behavior. This patch introduces:
> 
> - A new trace event 'btrfs_find_free_extent_skip' that captures
>   allocation context and skip reasons
> - Comprehensive set of FFE_SKIP_* constants defining specific
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

Looks great. A couple naming/semantics improvements suggested inline.

Have you run a "full" tracing of ffe including tracing the loop with
the other tracepoints btrfs_find_free_extent_search_loop and
btrfs_reserve_extent? If the bpftrace program and output from that
aren't huge, could be nice to include them in the commit message too.

Thanks,
Boris
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/extent-tree.c       | 36 +++++++++++++++++---
>  fs/btrfs/extent-tree.h       | 18 ++++++++++
>  include/trace/events/btrfs.h | 65 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 072d9bb84dd8..ed50f7357f19 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4425,8 +4425,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	}
>  
>  	ret = prepare_allocation(fs_info, ffe_ctl, space_info, ins);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		trace_btrfs_find_free_extent_skip(root, ffe_ctl, NULL,
> +						  FFE_SKIP_PREPARE_ALLOC_FAILED, ret);

This one is less a "skip" and more of a "fail", I think mixing them is
probably more confusing than it's worth.

Then you can also name it btrfs_find_free_extent_skip_block_group which
makes more sense too.

>  		return ret;
> +	}
>  
>  	ffe_ctl->search_start = max(ffe_ctl->search_start,
>  				    first_logical_byte(fs_info));
> @@ -4453,6 +4456,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				 * target because our list pointers are not
>  				 * valid
>  				 */
> +				trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +								  FFE_SKIP_HINTED_BG_INVALID, 0);
>  				btrfs_put_block_group(block_group);
>  				up_read(&space_info->groups_sem);
>  			} else {
> @@ -4464,6 +4469,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  				goto have_block_group;
>  			}
>  		} else if (block_group) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_HINTED_BG_INVALID, 0);

If you get rid of INVALID, you can just check the above conditions to
categorize it. Or create a special HINT_INVALID case or something?

>  			btrfs_put_block_group(block_group);
>  		}
>  	}
> @@ -4478,6 +4485,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ffe_ctl->hinted = false;
>  		/* If the block group is read-only, we can skip it entirely. */
>  		if (unlikely(block_group->ro)) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_READ_ONLY, 0);

One of the INVALID cases is also checking bg->ro, so I think having a
READ_ONLY category is kinda confusing. Maybe make this INVALID too? Or
change that one to READ_ONLY too? Or make both of them "REMOVING" or
something. tl;dr: I feel like they're really the same condition just
hinted/un-hinted.

>  			if (ffe_ctl->for_treelog)
>  				btrfs_clear_treelog_bg(block_group);
>  			if (ffe_ctl->for_data_reloc)
> @@ -4489,6 +4498,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ffe_ctl->search_start = block_group->start;
>  
>  		if (!block_group_bits(block_group, ffe_ctl->flags)) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_WRONG_FLAGS, 0);

you can stash the wrong flags from the bg in error_or_value

>  			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
>  			continue;
>  		}
> @@ -4508,6 +4519,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  			 * error that caused problems, not ENOSPC.
>  			 */
>  			if (ret < 0) {
> +				trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +								  FFE_SKIP_BG_CACHE_ERROR, ret);
>  				if (!cache_block_group_error)
>  					cache_block_group_error = ret;
>  				ret = 0;
> @@ -4517,18 +4530,26 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		}
>  
>  		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_BG_CACHE_ERROR, -EIO);
>  			if (!cache_block_group_error)
>  				cache_block_group_error = -EIO;
>  			goto loop;
>  		}
>  
> -		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
> +		if (!find_free_extent_check_size_class(ffe_ctl, block_group)) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_SIZE_CLASS_MISMATCH, 0);

you can stash the wrong size class from the bg in error_or_value

>  			goto loop;
> +		}
>  
>  		bg_ret = NULL;
>  		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
> -		if (ret > 0)
> +		if (ret > 0) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_DO_ALLOCATION_FAILED, ret);
>  			goto loop;
> +		}
>  
>  		if (bg_ret && bg_ret != block_group) {
>  			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
> @@ -4542,22 +4563,29 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		/* move on to the next group */
>  		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
>  		    block_group->start + block_group->length) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_EXTENDS_BEYOND_BG, 0);

I would prefer this name and "FOUND_BEFORE_SEARCH_START" to have a
similar structure to suggest that they are the same sort of error. Or
you can just do something like SEARCH_BOUNDS. The trace's error_or_value
can include the offending value as well?

>  			btrfs_add_free_space_unused(block_group,
>  					    ffe_ctl->found_offset,
>  					    ffe_ctl->num_bytes);
>  			goto loop;
>  		}
>  
> -		if (ffe_ctl->found_offset < ffe_ctl->search_start)
> +		if (ffe_ctl->found_offset < ffe_ctl->search_start) {
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_FOUND_BEFORE_SEARCH_START, 0);
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
> +			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
> +							  FFE_SKIP_ADD_RESERVED_FAILED, -EAGAIN);
>  			btrfs_add_free_space_unused(block_group,
>  					ffe_ctl->found_offset,
>  					ffe_ctl->num_bytes);
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index e970ac42a871..667581c454a3 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -23,6 +23,24 @@ enum btrfs_extent_allocation_policy {
>  	BTRFS_EXTENT_ALLOC_ZONED,
>  };
>  
> +/*
> + * Enum for find_free_extent skip reasons used in trace events.
> + * Each enum corresponds to a specific unhappy path in the allocator.
> + */
> +enum {
> +	FFE_SKIP_PREPARE_ALLOC_FAILED,
> +	FFE_SKIP_HINTED_BG_INVALID,
> +	FFE_SKIP_BG_READ_ONLY,
> +	FFE_SKIP_BG_WRONG_FLAGS,
> +	FFE_SKIP_BG_CACHE_FAILED,
> +	FFE_SKIP_BG_CACHE_ERROR,
> +	FFE_SKIP_SIZE_CLASS_MISMATCH,
> +	FFE_SKIP_DO_ALLOCATION_FAILED,
> +	FFE_SKIP_EXTENDS_BEYOND_BG,
> +	FFE_SKIP_FOUND_BEFORE_SEARCH_START,
> +	FFE_SKIP_ADD_RESERVED_FAILED,
> +};
> +
>  struct find_free_extent_ctl {
>  	/* Basic allocation info */
>  	u64 ram_bytes;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 7e418f065b94..39544a706654 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -103,6 +103,18 @@ struct find_free_extent_ctl;
>  	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
>  	EMe(RESET_ZONES,		"RESET_ZONES")
>  
> +#define FIND_FREE_EXTENT_SKIP_REASONS						\
> +	EM( FFE_SKIP_PREPARE_ALLOC_FAILED,	"PREPARE_ALLOC_FAILED")		\
> +	EM( FFE_SKIP_HINTED_BG_INVALID,		"HINTED_BG_INVALID")		\
> +	EM( FFE_SKIP_BG_READ_ONLY,		"BG_READ_ONLY")			\
> +	EM( FFE_SKIP_BG_WRONG_FLAGS,		"BG_WRONG_FLAGS")		\
> +	EM( FFE_SKIP_BG_CACHE_ERROR,		"BG_CACHE_ERROR")		\
> +	EM( FFE_SKIP_SIZE_CLASS_MISMATCH,	"SIZE_CLASS_MISMATCH")		\
> +	EM( FFE_SKIP_DO_ALLOCATION_FAILED,	"DO_ALLOCATION_FAILED")		\
> +	EM( FFE_SKIP_EXTENDS_BEYOND_BG,		"EXTENDS_BEYOND_BG")		\
> +	EM( FFE_SKIP_FOUND_BEFORE_SEARCH_START,	"FOUND_BEFORE_SEARCH_START")	\
> +	EMe(FFE_SKIP_ADD_RESERVED_FAILED,	"ADD_RESERVED_FAILED")
> +
>  /*
>   * First define the enums in the above macros to be exported to userspace via
>   * TRACE_DEFINE_ENUM().
> @@ -118,6 +130,7 @@ FI_TYPES
>  QGROUP_RSV_TYPES
>  IO_TREE_OWNER
>  FLUSH_STATES
> +FIND_FREE_EXTENT_SKIP_REASONS
>  
>  /*
>   * Now redefine the EM and EMe macros to map the enums to the strings that will
> @@ -1388,6 +1401,58 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
>  	TP_ARGS(block_group, ffe_ctl)
>  );
>  
> +TRACE_EVENT(btrfs_find_free_extent_skip,
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

