Return-Path: <linux-btrfs+bounces-14418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A34ACCD68
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B491A188D91A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534B2202F79;
	Tue,  3 Jun 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="REpukKOs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfRGGDjs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730361ABED9
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976889; cv=none; b=HQAiTb10Q8sHl+XzSg1Rf3XON1NYzfcJlWw61wynSDKj0SUHWiomo66k7sr/Dq9p2bsYx21krOqUsCMPGZyFcR+eadmdAIxJdeMK3TK1Hu9xc+M91G52CwCoyxT8Bk477knCyDwCHVf+0WNKhmBmEo8GwVZsco0cA/WJW15Kxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976889; c=relaxed/simple;
	bh=uOqaXgtixiDzNi1wZF8lQNjBx+AsWnFXbpnt9ySF0Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/wVohlNyry4XBEp1ImPYskQUTah/2ngtucAvrubuZeGs1iQVlO7flfoSgFssYoddD36I+IekCFVcf+DpPO4fl07v0QoZA0Xd2Q3B3hZPVVgc/SXncGjA+rdzNi9yL7vRQQWcEL5khizKpsH3rgoKjrh/nnfUTfqkkQ+b+fiV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=REpukKOs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfRGGDjs; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E0DE25400F3;
	Tue,  3 Jun 2025 14:54:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 03 Jun 2025 14:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748976885; x=1749063285; bh=a4Wi3lI/R5
	otp6AfwuoqL2uew3JwJQeXMnZ2MCLVruc=; b=REpukKOsJ1cPbrOUWfkibMHqI2
	OA3+NtDjOrquoVvsmL4iUKtmVss6bMKitN4hp8K1DElrvWhg0O5A3iPpeemCKleE
	WmSQTPQ4CO4IChQnUtoKNyb7FQEHA9Cvy/n//qrqsGvkXakN+3iNQte+AdzofC69
	1+l0fCCQ9E8UtjZr+AU4E9nr0mfWYci9ezSDpfe8W5wZJcSMND/xiY3gf98Z+UTb
	HgfjNifXqQKU3+feDHznIn/dX4bzQzCeSzCnY/yUkBaqkFyF7oxL5/xPdvZWBDAb
	EC/6z0Q0O7jSZTir/AEhHUKA3ZXGYp8ZMis9k518ewF0CqNhZNhPedr71UTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748976885; x=1749063285; bh=a4Wi3lI/R5otp6AfwuoqL2uew3JwJQeXMnZ
	2MCLVruc=; b=LfRGGDjse403/NCKBglUf/9LSsQmV8fgvBxJ+AjRenUrxuuKz97
	25zs3JjIwIkpVSljwIt6XKiZ0CBhbILTi1BtRNfSlyPGTLm5vvcKZEbtsN8LfFJs
	/6BqOUTcMMu5ycEtEtMOuxQ4+QlwSBLGRLfVmBN1v5/JW08LVR37g7KqrELKWM4/
	cxmYYByDKn4HyxpFfRg9la21XL7q79Ho0K5aNzl7oDObPx3oH7sfFZdELrtKz9aA
	c1ilgdzm9S7fwP+dcIJ4/KzQWmefVdibaA/eo4zdRg7oKe7/UZEnGOv2Zp2cs/Sh
	XEXdIIpogj+UAKgTkZhFgQ12om2fLeczJRQ==
X-ME-Sender: <xms:9UQ_aFqaP_00whz__tqfo4Ck9GCoLAMmqCk-vs1D476ET69QtSYxTQ>
    <xme:9UQ_aHqwr5diOSW8NYpaC6TzQlLJS1KYHeGsOcvu5QBXFPJuztQ6AZjP7B8zTBRAu
    PE1IGZK9prpKkGFE74>
X-ME-Received: <xmr:9UQ_aCMYNOKfucy7wRFIkqQf_oSsTw9lWi0GyTSz_XWWGlW0V25SU3cRBC_i3g3UuD0dRinjPY5rDzcRHvFglwkA8G0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecugg
    ftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefg
    tdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9UQ_aA4lBf3cTjs3GH8SAvVeXbXNahVxdrCqzTBCsgytLtneAceMXQ>
    <xmx:9UQ_aE4fp-NOVxyC3bElD9FrMY3OwbYXM1wX0V9vxKUOCfvGN0yn7w>
    <xmx:9UQ_aIgEFxWds68HJoTgiUaLEpevHMFQtQtkpc5Lo5ZBy7123qmf-Q>
    <xmx:9UQ_aG6v3DhpEyOk_1uSf3MpoZ0fAV4NYKbZ2AjexkeVKwNqNohStg>
    <xmx:9UQ_aAocEKtv48Zf4RhydWVa98aGF1_zOQEyPHomy9Q2ci7E6o_jtkZv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 14:54:44 -0400 (EDT)
Date: Tue, 3 Jun 2025 11:54:42 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add helper folio_end()
Message-ID: <20250603185442.GA2633115@zen.localdomain>
References: <cover.1748938504.git.dsterba@suse.com>
 <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>

On Tue, Jun 03, 2025 at 10:16:17AM +0200, David Sterba wrote:
> There are several cases of folio_pos + folio_size, add a convenience
> helper for that. Rename local variable in defrag_prepare_one_folio() to
> avoid name clash.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/defrag.c | 8 ++++----
>  fs/btrfs/misc.h   | 7 +++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 6dca263b224e87..e5739835ad02f0 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -849,7 +849,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
>  	struct address_space *mapping = inode->vfs_inode.i_mapping;
>  	gfp_t mask = btrfs_alloc_write_mask(mapping);
>  	u64 folio_start;
> -	u64 folio_end;
> +	u64 folio_last;

This is nitpicky, but I think introducing the new word "last" in in an
inconsistent fashion is a mistake.

In patch 2 at truncate_block_zero_beyond_eof() and
btrfs_writepage_fixup_worker, you have variables called "X_end" that get
assigned to folio_end() - 1. Either those should also get called
"X_last" or this one should have "end" in its name.

>  	struct extent_state *cached_state = NULL;
>  	struct folio *folio;
>  	int ret;
> @@ -886,14 +886,14 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
>  	}
>  
>  	folio_start = folio_pos(folio);
> -	folio_end = folio_pos(folio) + folio_size(folio) - 1;
> +	folio_last = folio_pos(folio) + folio_size(folio) - 1;
>  	/* Wait for any existing ordered extent in the range */
>  	while (1) {
>  		struct btrfs_ordered_extent *ordered;
>  
> -		btrfs_lock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
> +		btrfs_lock_extent(&inode->io_tree, folio_start, folio_last, &cached_state);
>  		ordered = btrfs_lookup_ordered_range(inode, folio_start, folio_size(folio));
> -		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
> +		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_last, &cached_state);
>  		if (!ordered)
>  			break;
>  
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 9cc292402696cc..ff5eac84d819d8 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -7,6 +7,8 @@
>  #include <linux/bitmap.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
>  #include <linux/math64.h>
>  #include <linux/rbtree.h>
>  
> @@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
>  	return (found_set == start + nbits);
>  }
>  
> +static inline u64 folio_end(struct folio *folio)
> +{
> +	return folio_pos(folio) + folio_size(folio);
> +}
> +

Is there a reason we can't propose this is a generic folio helper
function alongside folio_pos() and folio_size()? Too many variables out
there called folio_end from places that would include it?

>  #endif
> -- 
> 2.49.0
> 

