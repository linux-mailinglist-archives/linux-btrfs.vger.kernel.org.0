Return-Path: <linux-btrfs+bounces-8649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89E995530
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF901F27BC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512681E1024;
	Tue,  8 Oct 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I/SYxUge";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uk5Ga1IT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I/SYxUge";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uk5Ga1IT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDD1DEFDC
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406722; cv=none; b=GiDD8B6GNDfICVqjHbNv7tGQCZDFl0N+bR1w54IEVqFnBY63dXPLFTakAKo5A0ihEvwnUbXkb0fizdTXW9Itdx7sDbTljVN6ClOvESH33HlH1pWzzwpAYUfh8ck9vKyrBqwOm/Uv/UAJlm4osggvkKFJNNO0+tbHO5Y4m18ESEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406722; c=relaxed/simple;
	bh=oCenfyFPttEMTjycufP7VtxUip9fOY6nrTAi6iePZfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVMfpomJbSh/30ZuIYeXYDjY7s00F83GUeWWhDurLOgC/ro9n2kRu0fiQDO4rEAqhw7HgHZdnjcHwoU5JNk2SbbuHsjWZ+p+15S9DkEKe9t84tTIfM5Bilh6jOBVjolpZMfi0Qz8QQJAH3newDmaimVeGEkon7gjBVhU4DOhGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I/SYxUge; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uk5Ga1IT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I/SYxUge; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uk5Ga1IT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77A6021D8C;
	Tue,  8 Oct 2024 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728406718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BctEEllBCzf7PzyZEiopHZrkEXvpDhRhWwKmKtt4T3M=;
	b=I/SYxUgehNFfBCoFcbLL/fAj3sApntR663pA37Mzr+cxE+pQfeVAs+4bccNe+Nl5TBwhm8
	h8c5hfdGGz0Q/gzMTNZbmZ/0xCNNOt/YuFoj/FxxmTSB6KCj9jg10b1xB7jkt7uzv+g+4t
	/2gi8xR9R9H6ZVyZXCcdU5rAVn2frGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728406718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BctEEllBCzf7PzyZEiopHZrkEXvpDhRhWwKmKtt4T3M=;
	b=uk5Ga1ITwaNGUzc6plcj6TPlAQ9uSjNQ5frKMfQI+n0XRzaD15+DE0HCRZtvw/dAA2UCjH
	5Gw2WcxXgKZF1rBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="I/SYxUge";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uk5Ga1IT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728406718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BctEEllBCzf7PzyZEiopHZrkEXvpDhRhWwKmKtt4T3M=;
	b=I/SYxUgehNFfBCoFcbLL/fAj3sApntR663pA37Mzr+cxE+pQfeVAs+4bccNe+Nl5TBwhm8
	h8c5hfdGGz0Q/gzMTNZbmZ/0xCNNOt/YuFoj/FxxmTSB6KCj9jg10b1xB7jkt7uzv+g+4t
	/2gi8xR9R9H6ZVyZXCcdU5rAVn2frGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728406718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BctEEllBCzf7PzyZEiopHZrkEXvpDhRhWwKmKtt4T3M=;
	b=uk5Ga1ITwaNGUzc6plcj6TPlAQ9uSjNQ5frKMfQI+n0XRzaD15+DE0HCRZtvw/dAA2UCjH
	5Gw2WcxXgKZF1rBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D29137CF;
	Tue,  8 Oct 2024 16:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xiHAEb5kBWdZUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 16:58:38 +0000
Date: Tue, 8 Oct 2024 18:58:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: fix the delalloc range locking if sector size
 < page size
Message-ID: <20241008165833.GD1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <305e53f3931e164c8ab3b09c059ea68bd792a4b2.1728256845.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305e53f3931e164c8ab3b09c059ea68bd792a4b2.1728256845.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 77A6021D8C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Oct 07, 2024 at 09:51:40AM +1030, Qu Wenruo wrote:
> Inside lock_delalloc_folios(), there are several problems related to
> sector size < page size handling:
> 
> - Set the writer locks without checking if the folio is still valid
>   We call btrfs_folio_start_writer_lock() just like it's folio_lock().
>   But since the folio may not even be the folio of the current mapping,
>   we can easily screw up the folio->private.
> 
> - The range is not clampped inside the page
>   This means we can over write other bitmaps if the start/len is not
>   properly handled, and trigger the btrfs_subpage_assert().
> 
> - @processed_end is always rounded up to page end
>   If the delalloc range is not page aligned, and we need to retry
>   (returning -EAGAIN), then we will unlock to the page end.
> 
>   Thankfully this is not a huge problem, as now
>   btrfs_folio_end_writer_lock() can handle range larger than the locked
>   range, and only unlock what is already locked.
> 
> Fix all these problems by:
> 
> - Lock and check the folio first, then call
>   btrfs_folio_set_writer_lock()
>   So that if we got a folio not belonging to the inode, we won't
>   touch folio->private.
> 
> - Properly truncate the range inside the page
> 
> - Update @processed_end to the locked range end
> 
> - Remove btrfs_folio_start_writer_lock()
>   Since all callsites only utilize btrfs_folio_set_writer_lock() now,
>   remove the unnecessary btrfs_folio_start_writer_lock().
> 
> Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")

This commit is in 5.14, so we'd need backport to 5.15+. The v1 would be
more suitable as it does not remove the unused
btrfs_folio_start_writer_lock(). As it's exported function there should
be no warning.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the unused btrfs_folio_start_writer_lock() function
> ---
>  fs/btrfs/extent_io.c | 15 +++++++-------
>  fs/btrfs/subpage.c   | 47 --------------------------------------------
>  fs/btrfs/subpage.h   |  2 --
>  3 files changed, 7 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e0b43640849e..0448cee2b983 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -262,22 +262,21 @@ static noinline int lock_delalloc_folios(struct inode *inode,
>  
>  		for (i = 0; i < found_folios; i++) {
>  			struct folio *folio = fbatch.folios[i];
> -			u32 len = end + 1 - start;
> +			u64 range_start = max_t(u64, folio_pos(folio), start);
> +			u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
> +					      end + 1) - range_start;
>  
>  			if (folio == locked_folio)
>  				continue;
>  
> -			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
> -							  len))
> -				goto out;
> -
> +			folio_lock(folio);
>  			if (!folio_test_dirty(folio) || folio->mapping != mapping) {

Should the range_start and range_end be set after folio_lock? One of the
prolblems you're fixing is the folio and mapping mismatch, if I read it
correctly. 

