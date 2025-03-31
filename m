Return-Path: <linux-btrfs+bounces-12699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAEA770F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA216A97C
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA02147E8;
	Mon, 31 Mar 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLOuE50U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nDXK0GDD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLOuE50U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nDXK0GDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D07D07D
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743460752; cv=none; b=Zur6fm/rFOa3XYzXHbrX6dDyrEOBHvGv+ukdtnemtYB3k7sT0XTwQDW5KrBrkfRVIcFcDS23vTYS1OdTnIzSZ+85sQZ2abOGHc6VXXSj1rvB6LKQqb3+23jXo9pl/0yHuKuyEsFvvi/FRCUG3TkmCI2hHR+WZTn4DrAFt8qjsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743460752; c=relaxed/simple;
	bh=Q4yzag4s+LfDKbZ8Wd2pqot/I5e+KIB8J3+69g25lY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBWMuDsd+0pXooTacW9gv8tALvya5o+/gXGrGeKaH1Xg5x9POalSAi2u0JtWdsqkDPZCMmbSBY7MBZsIEPyJG2HZ4pN/txFoJ4QTQGTDKHYchgaWa8q/HVTsPqzbyEvvgNRxK6q+MvBuaXZQpoJkDtqOTT51paeKXXJ5SpELJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLOuE50U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nDXK0GDD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLOuE50U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nDXK0GDD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7017F211EB;
	Mon, 31 Mar 2025 22:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743460748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6MV3c/0y4VrlBA+JqFLoYIPvuJpZjwAQngJ+dfSd+Q=;
	b=VLOuE50UCjZ6uh5sp/f1RbD5Y/4e44A+CUKzP3qoAsarkPNBGkg78a8eZ3cOZNoxiPv3Fa
	8osdud7trEHeYEskjOdLTMrsfDXCn3gV/91q7pUtfRbyPfvaTtZsH9B/CJvdM8KQbUSng+
	3S/qW153jas5iJ99UeyvMOrzj1iOx/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743460748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6MV3c/0y4VrlBA+JqFLoYIPvuJpZjwAQngJ+dfSd+Q=;
	b=nDXK0GDD4kvo5bMEUnGYxDqtxtDdZ07I+PUV8+SzkKlCB+GwpJlUhu3Z82vhwjAyDl1DZE
	TlEN4Zn/LVQYIlDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VLOuE50U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nDXK0GDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743460748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6MV3c/0y4VrlBA+JqFLoYIPvuJpZjwAQngJ+dfSd+Q=;
	b=VLOuE50UCjZ6uh5sp/f1RbD5Y/4e44A+CUKzP3qoAsarkPNBGkg78a8eZ3cOZNoxiPv3Fa
	8osdud7trEHeYEskjOdLTMrsfDXCn3gV/91q7pUtfRbyPfvaTtZsH9B/CJvdM8KQbUSng+
	3S/qW153jas5iJ99UeyvMOrzj1iOx/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743460748;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X6MV3c/0y4VrlBA+JqFLoYIPvuJpZjwAQngJ+dfSd+Q=;
	b=nDXK0GDD4kvo5bMEUnGYxDqtxtDdZ07I+PUV8+SzkKlCB+GwpJlUhu3Z82vhwjAyDl1DZE
	TlEN4Zn/LVQYIlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43ECA139A1;
	Mon, 31 Mar 2025 22:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5LdkEIwZ62cjRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 31 Mar 2025 22:39:08 +0000
Date: Tue, 1 Apr 2025 00:39:07 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: allow folios to be released while ordered
 extent is finishing
Message-ID: <20250331223907.GL32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743004734.git.fdmanana@suse.com>
 <c20733c28d02562ff09bfff6739b01b5f710bed7.1743004734.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20733c28d02562ff09bfff6739b01b5f710bed7.1743004734.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7017F211EB
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 27, 2025 at 04:13:51PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When the release_folio callback (from struct address_space_operations) is
> invoked we don't allow the folio to be released if its range is currently
> locked in the inode's io_tree, as it may indicate the folio may be needed
> by the task that locked the range.
> 
> However if the range is locked because an ordered extent is finishing,
> then we can safely allow the folio to be released because ordered extent
> completion doesn't need to use the folio at all.
> 
> When we are under memory pressure, the kernel starts writeback of dirty
> pages (folios) with the goal of releasing the pages from the page cache
> after writeback completes, however this often is not possible on btrfs
> because:
> 
>   * Once the writeback completes we queue the ordered extent completion;
> 
>   * Once the ordered extent completion starts, we lock the range in the
>     inode's io_tree (at btrfs_finish_one_ordered());
> 
>   * If the release_folio callback is called while the folio's range is
>     locked in the inode's io_tree, we don't allow the folio to be
>     released, so the kernel has to try to release memory elsewhere,
>     which may result in triggering more writeback or releasing other
>     pages from the page cache which may be more useful to have around
>     for applications.
> 
> In contrast, when the release_folio callback is invoked after writeback
> finishes and before ordered extent completion starts or locks the range,
> we allow the folio to be released, as well as when the release_folio
> callback is invoked after ordered extent completion unlocks the range.
> 
> Improve on this by detecting if the range is locked for ordered extent
> completion and if it is, allow the folio to be released. This detection
> is achieved by adding a new extent flag in the io_tree that is set when
> the range is locked during ordered extent completion.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent-io-tree.c | 22 +++++++++++++++++
>  fs/btrfs/extent-io-tree.h |  6 +++++
>  fs/btrfs/extent_io.c      | 52 +++++++++++++++++++++------------------
>  fs/btrfs/inode.c          |  6 +++--
>  4 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 13de6af279e5..14510a71a8fd 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -1752,6 +1752,28 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
>  	return bitset;
>  }
>  
> +void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits)
> +{
> +	struct extent_state *state;
> +
> +	*bits = 0;
> +
> +	spin_lock(&tree->lock);
> +	state = tree_search(tree, start);
> +	while (state) {
> +		if (state->start > end)
> +			break;
> +
> +		*bits |= state->state;
> +
> +		if (state->end >= end)
> +			break;
> +
> +		state = next_state(state);
> +	}
> +	spin_unlock(&tree->lock);
> +}
> +
>  /*
>   * Check if the whole range [@start,@end) contains the single @bit set.
>   */
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 6ffef1cd37c1..e49f24151167 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -38,6 +38,11 @@ enum {
>  	 * that is left for the ordered extent completion.
>  	 */
>  	ENUM_BIT(EXTENT_DELALLOC_NEW),
> +	/*
> +	 * Mark that a range is being locked for finishing an ordered extent.
> +	 * Used together with EXTENT_LOCKED.
> +	 */
> +	ENUM_BIT(EXTENT_FINISHING_ORDERED),
>  	/*
>  	 * When an ordered extent successfully completes for a region marked as
>  	 * a new delalloc range, use this flag when clearing a new delalloc
> @@ -166,6 +171,7 @@ void free_extent_state(struct extent_state *state);
>  bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
>  		    struct extent_state *cached_state);
>  bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
> +void get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *bits);
>  int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
>  			     u32 bits, struct extent_changeset *changeset);
>  int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a11b22fcd154..6b9a80f9e0f5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2627,33 +2627,37 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>  {
>  	u64 start = folio_pos(folio);
>  	u64 end = start + folio_size(folio) - 1;
> -	bool ret;
> +	u32 range_bits;
> +	u32 clear_bits;
> +	int ret;
>  
> -	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
> -		ret = false;
> -	} else {
> -		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
> -				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
> -				   EXTENT_QGROUP_RESERVED);
> -		int ret2;
> +	get_range_bits(tree, start, end, &range_bits);

There's a difference how much of the tree is traversed,
test_range_bit_exists() stops on first occurence of EXTENT_LOCKED (a
single bit), get_range_bits() unconditionally explores the whole tree.

>  
> -		/*
> -		 * At this point we can safely clear everything except the
> -		 * locked bit, the nodatasum bit and the delalloc new bit.
> -		 * The delalloc new bit will be cleared by ordered extent
> -		 * completion.
> -		 */
> -		ret2 = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
> +	/*
> +	 * We can release the folio if it's locked only for ordered extent
> +	 * completion, since that doesn't require using the folio.
> +	 */
> +	if ((range_bits & EXTENT_LOCKED) &&
> +	    !(range_bits & EXTENT_FINISHING_ORDERED))

Here we need to know that LOCKED exists and FINISHING_ORDERED does not
exist in the range. This can be proven when the whole tree is traversed,
but could be in some cases be reduced to

	if (test_range_bit_exists(..., LOCKED) &&
	    !test_range_bit_exists(, FINISHING_ORDERED))

where in some percent of cases the whole tree won't be traversed (and
the lock held for a shorter time). This depends on the runtime what
combinations of the locks exist, it's possible than in the average case
the whole tree would be traversed anyway, and get_range_bits() is OK.

