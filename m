Return-Path: <linux-btrfs+bounces-9896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36A9D8A00
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF47E2853DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD61B4144;
	Mon, 25 Nov 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KraCnvF/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jp1eMZi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KraCnvF/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jp1eMZi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828D2500D2
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551093; cv=none; b=G7IwBi13CYlI4pf+2bM/piy3YM9FXezBFP7wql+es8loLwRhRAqwTmP3IEJ3+CItHVJjkXvCvMeuvRlJ7y40LpledhoWXxYvIn69tdoOSQT8z1yiAutqLrptWGZBlSFlGGx/oVHADFWCFkglsujgjdtVS18mO31ii1r9JOAIQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551093; c=relaxed/simple;
	bh=CHNXydyipILzP0DgzHLbbmejJxrjP+kkcC/p1PFpov0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSIfzre1BtCb45KO9PtDXRRuA9PUQzBPlScLLn5Mt8fzYg6Uu5CF08P7JQu4virYtSTuNyP3Bw862Y+C4BbnZKJ56Z5k3vL381/kkbBgzMQGVJVAthVBpAnFb+ri+STuJGFOOsNuw5yPzkcyz2o9oC3IlJl3boBSOejzUsEf7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KraCnvF/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jp1eMZi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KraCnvF/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jp1eMZi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C4221190;
	Mon, 25 Nov 2024 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732551089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VThrnatpc5pxDT6Qlvjz7XUr/sDhdQ+ybz3kshXMJw=;
	b=KraCnvF/qgIameiR7sAoLxtpisOLgnaFYL7vJMo17fM/R8AiMfrsdGqlV3AdNSQX5Xgd7Z
	ZHSpj6tXzGuXyV305aP4zs0yo5MqwcXdVc/8fZS/MST8KDV30tm4fTntxWP+g0XmRW5dfo
	Pac0D7B9VIMXF0EG/anvuTSZlV41ayQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732551089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VThrnatpc5pxDT6Qlvjz7XUr/sDhdQ+ybz3kshXMJw=;
	b=2jp1eMZiAoaggLyFLW9akCrqUN9M/ucHPNh2zC+68JKfNoO9cVQzR7wUF1buyCKK92B0zW
	RSOWWwhX3MBAc7DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="KraCnvF/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2jp1eMZi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732551089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VThrnatpc5pxDT6Qlvjz7XUr/sDhdQ+ybz3kshXMJw=;
	b=KraCnvF/qgIameiR7sAoLxtpisOLgnaFYL7vJMo17fM/R8AiMfrsdGqlV3AdNSQX5Xgd7Z
	ZHSpj6tXzGuXyV305aP4zs0yo5MqwcXdVc/8fZS/MST8KDV30tm4fTntxWP+g0XmRW5dfo
	Pac0D7B9VIMXF0EG/anvuTSZlV41ayQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732551089;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VThrnatpc5pxDT6Qlvjz7XUr/sDhdQ+ybz3kshXMJw=;
	b=2jp1eMZiAoaggLyFLW9akCrqUN9M/ucHPNh2zC+68JKfNoO9cVQzR7wUF1buyCKK92B0zW
	RSOWWwhX3MBAc7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55DE813890;
	Mon, 25 Nov 2024 16:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3nDDFLGhRGdVbAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 16:11:29 +0000
Date: Mon, 25 Nov 2024 17:11:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject out-of-band dirty folios during writeback
Message-ID: <20241125161128.GC31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 75C4221190
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 12, 2024 at 06:56:51PM +1030, Qu Wenruo wrote:
> An out-of-band folio means the folio is marked dirty but without
> notifying the filesystem.
> 
> This used to be a problem related to get_user_page(), but with the
> introduction of pin_user_pages_locked(), we should no longer hit such
> case anymore.
> 
> In btrfs, we have a long history of handling such out-of-band dirty
> folios by:
> 
> - Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
>   So that any buffered write into the page cache will have
>   EXTENT_DEALLOC flag set for the corresponding range in btrfs' extent
>   io tree.
> 
> - Marking the folio ordered during delalloc
>   This is based on EXTENT_DELALLOC flag in the extent io tree.
> 
> - During folio submission for writeback check the ordered flag
>   If the folio has no ordered folio, it means it doesn't go through
>   the initial btrfs_dirty_folio(), thus it's definitely an out-of-band
>   one.
> 
>   If we got one, we go through COW fixup, which will re-dirty the folio
>   with proper handling in another workqueue.
> 
> Such workaround is a blockage for us to migrate to iomap (it requires
> extra flags to trace if a folio is dirtied by the fs or not) and I'd
> argue it's not data checksum safe, since the folio can be modified
> halfway.
> 
> But with the introduction of pin_user_pages_locked() during v5.8 merge

I don't see pin_user_pages_locked() in git, only
pin_user_pages_unlocked() but that does not seem to be the right one.
5.8 is quite old so there could have been changes and renames but still
the reason why we can drop the cow fixup eventually should be correct.

> window, such out-of-band dirty folio such be treated as a bug.
> Ext4 has treated such case by warning and erroring out even before
> pin_user_pages_locked().
> 
> Here we take one step between ext4 and the COW fixup workaround, that we
> go the ext4 way (warning and error out) for experimental builds, so that
> we can test if the no more out-of-band dirty folios expectation is true.
> 
> For non-experimental builds we still keep the existing COW fixup, but I
> hope in several releases we can get rid of the COW fixup completely,
> making it much easier to migrate to iomap.

Yes, if things will show up fine it will be removed. The fixup is hard
to hit on x86_64, it's easier on s390 so a longer testing period would
be good.

> The new checks happen in two locations:
> 
> - extent_writepage()
>   If an out-of-band dirty folio is marked dirty, it may not even have
>   page->private properly set.
>   Reject it early here.
> 
> - btrfs_writepage_cow_fix()
>   Error out with -EUCLEAN instead if we're sure it's an out-of-band one,
>   and make the caller to check errors other than -EAGAIN.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 27 ++++++++++++++++++++++++++-
>  fs/btrfs/inode.c     | 15 +++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e629d2ee152a..b8d2857f114b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1400,12 +1400,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>  	       start + len <= folio_start + folio_size(folio));
>  
>  	ret = btrfs_writepage_cow_fixup(folio);
> -	if (ret) {
> +	if (ret == -EAGAIN) {
>  		/* Fixup worker will requeue */
>  		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
>  		folio_unlock(folio);
>  		return 1;
>  	}
> +	if (ret < 0)
> +		goto out;
>  
>  	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
>  		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
> @@ -1492,6 +1494,29 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  	 * The proper bitmap can only be initialized until writepage_delalloc().
>  	 */
>  	bio_ctrl->submit_bitmap = (unsigned long)-1;
> +	/*
> +	 * If the page is dirty but without private set, it's marked dirty
> +	 * without informing the fs.
> +	 * Nowadays that is a bug, since the introduction of
> +	 * pin_user_pages_locked().
> +	 *
> +	 * So here we check if the page has private set to rule out such
> +	 * case.
> +	 * But we also have a long history of relying on the COW fixup,
> +	 * so here we only enable this check for experimental builds until
> +	 * we're sure it's safe.
> +	 */
> +	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) && !folio_test_private(folio)) {

You can also add unlikely() as it's leading to -EUCLEAN.

> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		btrfs_err_rl(fs_info,
> +	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
> +			     BTRFS_I(inode)->root->root_key.objectid,
> +			     btrfs_ino(BTRFS_I(inode)),
> +			     folio_pos(folio));
> +		ret = -EUCLEAN;
> +		goto done;
> +	}
> +
>  	ret = set_folio_extent_mapped(folio);
>  	if (ret < 0)
>  		goto done;

