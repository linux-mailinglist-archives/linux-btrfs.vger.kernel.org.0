Return-Path: <linux-btrfs+bounces-15613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE6B0CBD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 22:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEC727A2F04
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D423AE87;
	Mon, 21 Jul 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="N2pruza7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAQcYtQO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332819E7E2
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129687; cv=none; b=Uj8OOIPLZzJkMK41FcK/ISIEy58Kuw/tp6XXASbQ/Zl5yP+psh6XsehcvBhsHalKGRkUO+opOl0cYlIoS9DM/Qt3I7OmVq3lQ2Iz+43+L6K2yC+LItl44yOcAyoNZZhZYa0WiXvaVuJf+U8DCmBKduTFTDsoKclTyNev+Mlpi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129687; c=relaxed/simple;
	bh=k4+u+V0ZiNZFyYEje9uTBIWnb8KXFP34QE2OOVKo56I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM43lFeJQMAj1X2pV+fSXD8gEojqDyLqIWGsXzOqe9wrwJokD3gqPdN4ZBxniZP0AC/ibSLeuw/4MhoPEdAjedUbj/H5iP1/cGL6WoMhyphEuu/BblyXv9UV9ANA4k73SjKO2WgHPLJz7vAnkOk0BJYhTEAte421L+1gm6B+EK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=N2pruza7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAQcYtQO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5183AEC02B7;
	Mon, 21 Jul 2025 16:28:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 16:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753129684; x=1753216084; bh=VPxXUo+U+y
	W4eiE4ft7WvCdGg4Zw6NBlz30nlHDSNEY=; b=N2pruza7C+5bZrF/W8vDO926+p
	7Frwk/trXmmoFXN+KLPLYg1G7u5wYdDAyA6IGANT/dFNiE25NZMtKK+9hPXBVmz8
	k4yTXNzCL1BSQcKECNTxunWSow9W5N87LVMKjcCmjJTfYMvqDlFjgoO0fA/zZUlv
	jBZToKfh6d9eg9HsmKA4cZYdgOAtOCktdfz7eq2jUVnRMM8IVZujT5dmJN/VESIe
	uoLTeOQgvKmpfQSIxDrwAhYbCOmBHXYL4rWZ09xaSBLqWQwDkoVqBua3G6qosdxg
	Qt0VH4qGKPXOar4ipqy0lMmi2Vg9PO1LFrdAiDzs4LC3aNl8cgCSLLq/qHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753129684; x=1753216084; bh=VPxXUo+U+yW4eiE4ft7WvCdGg4Zw6NBlz30
	nlHDSNEY=; b=DAQcYtQOd+9ivbbmrcwwZHFFVI3N2n1gSw5qxp+puR0SakGVWvs
	Y3tkSgPKAaImTMk/Ri4qfKiB6qMlHVVQZgcTYp0h0nJtsGhoW9iV+rb6NdYY4dDc
	V8eRM7ulrJZ38Er6djzh9mlDgZmsw1b5RbpNeykKg1EjnAvu2jJFqW/nEPMinHYX
	uLl7xYmEbEHy7wDSaII/Eohhw+rONLAsfzR01E80rWJmhvafBBKlZm/eDYJe1OLB
	CzucEq9a0HdJVfROrSKGSZjpmV5fBqYiS153OUKfyTfUN+jZww/UldOB/jewunXe
	JKVesfeysA1Tzt8pNCNau078/yjGUyq/LKw==
X-ME-Sender: <xms:1KJ-aDralT2W-WkPZLPzsv8KU-Vt1J2yDXgNiFqQYYNQ_9EO71fA5g>
    <xme:1KJ-aN38nohCEzx87UdBBtAQOnm58YxrJGC1s5WJJ4jvqLX10mLTsWqG214573BTZ
    C5iYqwKH2TN3F05-Y0>
X-ME-Received: <xmr:1KJ-aCCBduykrJ7vBIXebL83Z01k5YsT3kcCKVwEN-DQSNhfGIaG87wLII4tdvLD0JzbtBke9pFkquSPBE-fCwTsq0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1KJ-aFc4vtkYmNWtBuU140a8HTOplOP9mmbNVkcEouqXDjocfCwaGw>
    <xmx:1KJ-aHgSaJx2oXcR-GerixZcKGE0V_A161ZwMvoMXj99iWTOLm88Qg>
    <xmx:1KJ-aNpfHAsDur2jiw44P_ZPV07sQ0m8-rIwtdgpeoB185tgQE3HEQ>
    <xmx:1KJ-aHGj_FPd8sXuNfq98mWO1CDg__EANqoNgCanW1iq0x2tnPqTog>
    <xmx:1KJ-aObjckhQYpFquwRqqTGQ0tO5rA2jCxrT-XGfPO3u-WPSayQeDz1J>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:28:03 -0400 (EDT)
Date: Mon, 21 Jul 2025 13:29:28 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: replace double boolean parameters of
 cow_file_range()
Message-ID: <20250721202928.GB2071341@zen.localdomain>
References: <cover.1752992367.git.wqu@suse.com>
 <3480a38763369c46ca8bbe79a8e4a5b87d20197a.1752992367.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3480a38763369c46ca8bbe79a8e4a5b87d20197a.1752992367.git.wqu@suse.com>

On Sun, Jul 20, 2025 at 03:59:09PM +0930, Qu Wenruo wrote:
> The function cow_file_range() has two boolean parameters, which is never
> a good thing for eyes.
> 
> Replace it with a single @flags parameter, with two flags:
> 
> - COW_FILE_RANGE_NO_INLINE
> - COW_FILE_RANGE_KEEP_LOCKED
> 
> And since we're here, also update the comments of cow_file_range() to
> replace the old "page" usage with "folio".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Had a nit, but looks good overall. I think the flag approach is nice.
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b77dd22b8cdb..fc47e234b729 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -72,6 +72,9 @@
>  #include "raid-stripe-tree.h"
>  #include "fiemap.h"
>  
> +#define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
> +#define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
> +
>  struct btrfs_iget_args {
>  	u64 ino;
>  	struct btrfs_root *root;
> @@ -1243,18 +1246,18 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>   * locked_folio is the folio that writepage had locked already.  We use
>   * it to make sure we don't do extra locks or unlocks.
>   *
> - * When this function fails, it unlocks all pages except @locked_folio.
> + * When this function fails, it unlocks all folios except @locked_folio.
>   *
>   * When this function successfully creates an inline extent, it returns 1 and
> - * unlocks all pages including locked_folio and starts I/O on them.
> - * (In reality inline extents are limited to a single page, so locked_folio is
> - * the only page handled anyway).
> + * unlocks all folios including locked_folio and starts I/O on them.
> + * (In reality inline extents are limited to a single block, so locked_folio is
> + * the only folio handled anyway).
>   *
> - * When this function succeed and creates a normal extent, the page locking
> + * When this function succeed and creates a normal extent, the folio locking
>   * status depends on the passed in flags:
>   *
> - * - If @keep_locked is set, all pages are kept locked.
> - * - Else all pages except for @locked_folio are unlocked.
> + * - If COW_FILE_RANGE_KEEP_LOCKED flag is set, all folios are kept locked.
> + * - Else all folios except for @locked_folio are unlocked.
>   *
>   * When a failure happens in the second or later iteration of the
>   * while-loop, the ordered extents created in previous iterations are cleaned up.
> @@ -1262,7 +1265,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>  static noinline int cow_file_range(struct btrfs_inode *inode,
>  				   struct folio *locked_folio, u64 start,
>  				   u64 end, u64 *done_offset,
> -				   bool keep_locked, bool no_inline)
> +				   unsigned long flags)
>  {
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> @@ -1290,7 +1293,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>  
> -	if (!no_inline) {
> +	if (!(flags & COW_FILE_RANGE_NO_INLINE)) {

I get that you are keeping the existing semantics, but if you are
bothering to refactor it, I think it would be nice to also get rid of
the double negative here. COW_FILE_RANGE_ALLOW_INLINE or TRY_INLINE
maybe?

>  		/* lets try to make an inline extent */
>  		ret = cow_file_range_inline(inode, locked_folio, start, end, 0,
>  					    BTRFS_COMPRESS_NONE, NULL, false);
> @@ -1318,7 +1321,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	 * Do set the Ordered (Private2) bit so we know this page was properly
>  	 * setup for writepage.
>  	 */
> -	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
> +	page_ops = ((flags & COW_FILE_RANGE_KEEP_LOCKED) ? 0 : PAGE_UNLOCK);
>  	page_ops |= PAGE_SET_ORDERED;
>  
>  	/*
> @@ -1685,7 +1688,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
>  
>  	while (start <= end) {
>  		ret = cow_file_range(inode, locked_folio, start, end,
> -				     &done_offset, true, false);
> +				     &done_offset, COW_FILE_RANGE_KEEP_LOCKED);
>  		if (ret)
>  			return ret;
>  		extent_write_locked_range(&inode->vfs_inode, locked_folio,
> @@ -1767,8 +1770,8 @@ static int fallback_to_cow(struct btrfs_inode *inode,
>  	 * is written out and unlocked directly and a normal NOCOW extent
>  	 * doesn't work.
>  	 */
> -	ret = cow_file_range(inode, locked_folio, start, end, NULL, false,
> -			     true);
> +	ret = cow_file_range(inode, locked_folio, start, end, NULL,
> +			     COW_FILE_RANGE_NO_INLINE);
>  	ASSERT(ret != 1);
>  	return ret;
>  }
> @@ -2347,8 +2350,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  		ret = run_delalloc_cow(inode, locked_folio, start, end, wbc,
>  				       true);
>  	else
> -		ret = cow_file_range(inode, locked_folio, start, end, NULL,
> -				     false, false);
> +		ret = cow_file_range(inode, locked_folio, start, end, NULL, 0);
>  	return ret;
>  }
>  
> -- 
> 2.50.0
> 

