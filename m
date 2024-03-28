Return-Path: <linux-btrfs+bounces-3731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B52789047C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BD01F25A14
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BC8004E;
	Thu, 28 Mar 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DzRRc/vw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0T17xhGT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692682870
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Mar 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641912; cv=none; b=Z1U0G7pWh5PfwQBzc4j7w5XTnl5HntAMpIpY9q1nhZavV0d2dcszujJdowCpMSsWWjZrQSk5IUMxtLwFNwQ6SoKgaa5CYVSIlpPDCFAdIz/LnQIUDQS03vAVHz8EpAiV3zDiGy9NuSByF6rLrEPLpBh22N/d7HnTXUl7WKsUhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641912; c=relaxed/simple;
	bh=JiiA7sW9T3PKI55xrDZeFTEIM8JCpXd3FDpCBjmeKJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7d5mOIZ9QykZZ3S4qFmIHvr5HI4YncPUuoQZLL/0jrq+1vY6cGVlq+X7iUrrMrT0Ew8unXheXVsOnurI8gQaM0m6MXA7Z793EUk2Naw49dFhXoy8E9d4XYeOjYaSB9ltDbEKdNQl4dfKhXeuraBrurhnVFUUpLl4psI8Xz+PtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DzRRc/vw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0T17xhGT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C823320B5F;
	Thu, 28 Mar 2024 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711641905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVonQetH1ard+Xf5Rs4IFJMbaT2YM0TM9484Vr5csc=;
	b=DzRRc/vwP0IVBuUnR0FAxTEb4z1o8RmFffROOOKKTKXqBf3rV3br2zfVlKRzVUC1LTg1AQ
	lL7C7myXuffYwktvAXJAVI+qnP+m1+B9++oIihnRzDl6HU7lO/9KFwYHHxMFg6kbCFpiAC
	zCYuLAPTOWrBzJUoJ/7nQsHsZOOPdi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711641905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFVonQetH1ard+Xf5Rs4IFJMbaT2YM0TM9484Vr5csc=;
	b=0T17xhGT6apCA0il+vhTV1fqj7TC4u2QyVp9pGYFJCD/VTiC6rlcxNde/NFPVZ05IIT6vg
	k+jzr8R1ugOHXaAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A58C113A92;
	Thu, 28 Mar 2024 16:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IhMcKDGVBWaHcAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 28 Mar 2024 16:05:05 +0000
Date: Thu, 28 Mar 2024 16:57:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Julian Taylor <julian.taylor@1und1.de>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
Message-ID: <20240328155746.GY14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.31
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: C823320B5F

On Tue, Mar 26, 2024 at 09:16:46AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a recent report that when memory pressure is high (including
> cached pages), btrfs can spend most of its time on memory allocation in
> btrfs_alloc_page_array() for compressed read/write.
> 
> [CAUSE]
> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
> even if the bulk allocation failed (fell back to single page
> allocation) we still retry but with extra memalloc_retry_wait().
> 
> If the bulk alloc only returned one page a time, we would spend a lot of
> time on the retry wait.
> 
> The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
> incomplete batch memory allocations").
> 
> [FIX]
> Although the commit mentioned that other filesystems do the wait, it's
> not the case at least nowadays.
> 
> All the mainlined filesystems only call memalloc_retry_wait() if they
> failed to allocate any page (not only for bulk allocation).
> If there is any progress, they won't call memalloc_retry_wait() at all.
> 
> For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
> if there is no allocation progress at all, and the call is not for
> metadata readahead.
> 
> So I don't believe we should call memalloc_retry_wait() unconditionally
> for short allocation.
> 
> This patch would only call memalloc_retry_wait() if failed to allocate
> any page for tree block allocation (which goes with __GFP_NOFAIL and may
> not need the special handling anyway), and reduce the latency for
> btrfs_alloc_page_array().

Is this saying that it can fail with GFP_NOFAIL?

> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> Tested-by: Julian Taylor <julian.taylor@1und1.de>
> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Still use bulk allocation function
>   Since alloc_pages_bulk_array() would fall back to single page
>   allocation by itself, there is no need to go alloc_page() manually.
> 
> - Update the commit message to indicate other fses do not call
>   memalloc_retry_wait() unconditionally
>   In fact, they only call it when they need to retry hard and can not
>   really fail.
> ---
>  fs/btrfs/extent_io.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7441245b1ceb..c96089b6f388 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>  			   gfp_t extra_gfp)
>  {
> +	const gfp_t gfp = GFP_NOFS | extra_gfp;
>  	unsigned int allocated;
>  
>  	for (allocated = 0; allocated < nr_pages;) {
>  		unsigned int last = allocated;
>  
> -		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
> -						   nr_pages, page_array);
> +		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
> +		if (unlikely(allocated == last)) {
> +			/* Can not fail, wait and retry. */
> +			if (extra_gfp & __GFP_NOFAIL) {
> +				memalloc_retry_wait(GFP_NOFS);

Can this happen? alloc_pages_bulk_array() should not fail when
GFP_NOFAIL is passed, there are two allocation phases in
__alloc_pages_bulk() and if it falls back to __alloc_pages() + NOFAIL it
will not fail ... so what's the point of the retry?

Anyway the whole thing with NOFAIL flag that's passed only from
alloc_extent_buffer() could be made a bit more straightforward. The gfp
flags replaced by a bool with 'nofail' semantics or 2 helpers one that
is for normal use an the one for the special purpose.

