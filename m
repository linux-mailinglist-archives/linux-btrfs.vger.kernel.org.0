Return-Path: <linux-btrfs+bounces-8088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0697B324
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9430B28395
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312B17B4ED;
	Tue, 17 Sep 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeZaKPHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8p/cNCFn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeZaKPHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8p/cNCFn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926A150990
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591556; cv=none; b=sAHMsNSfwznabYh4oDuokv8RCfy+2iGFLG+nKOBxvyHy3wNGPYTN8jTg4sgBNzqO6fL3+1bFYsE2vwg5QgwTQcUsInrE3iJDFRrc3FdpR8CMAeRumuUY2wKVc3g3vPiBVUhe6nRlyVshkaH6NUi8pprJ1cwxoMf7FUQPjeRaI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591556; c=relaxed/simple;
	bh=HTsq/SDOcsi51+VtASCJHUHTo3r19lBYyGpIq3aTJ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L65vYKQDhLpeSJ8FrejPX25F+e14pHCJPMW6Vywnpnkke6BqprKPkwFizjoto5LPiNGMTAXVBP7JRobgdVQFD0Egro+CbJtgVBhgFIktLh4d6qDLmM8Qvcc7+TQz0+Ay9NHZlYqQ6B5NUdtf0HMiXd8kVV6V+z7qjjD/iuOc/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeZaKPHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8p/cNCFn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeZaKPHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8p/cNCFn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 693C620120;
	Tue, 17 Sep 2024 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726591552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj7bf3tOvgo49LXfQjr+UwQHrsi/NNsybIDpcfw9HsM=;
	b=UeZaKPHw/KDjff2dgBCrlDsnC4N91dYz3WbywTlbFYcBXh5qY+9U0dwt7IFaKuiX1rUvP4
	TzRdK7ma0NzjgdLBPsuDNKNccCmStAFzEeSHWcJoTIXmLePIGNYZCi4bL1KkVqqlyqx1K+
	+l83TqEqUgPZYX+iBM5eXd0wnlR44vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726591552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj7bf3tOvgo49LXfQjr+UwQHrsi/NNsybIDpcfw9HsM=;
	b=8p/cNCFnckBXUV8Vh42xSN9YEZ6YebmLU5qlEowOf5FtC5fOwwlcuZFa+P5MZhV2eeHdIm
	bGLzC8EGehXZnvAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UeZaKPHw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8p/cNCFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726591552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj7bf3tOvgo49LXfQjr+UwQHrsi/NNsybIDpcfw9HsM=;
	b=UeZaKPHw/KDjff2dgBCrlDsnC4N91dYz3WbywTlbFYcBXh5qY+9U0dwt7IFaKuiX1rUvP4
	TzRdK7ma0NzjgdLBPsuDNKNccCmStAFzEeSHWcJoTIXmLePIGNYZCi4bL1KkVqqlyqx1K+
	+l83TqEqUgPZYX+iBM5eXd0wnlR44vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726591552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj7bf3tOvgo49LXfQjr+UwQHrsi/NNsybIDpcfw9HsM=;
	b=8p/cNCFnckBXUV8Vh42xSN9YEZ6YebmLU5qlEowOf5FtC5fOwwlcuZFa+P5MZhV2eeHdIm
	bGLzC8EGehXZnvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52407139CE;
	Tue, 17 Sep 2024 16:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RxGQE0Cy6WagawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:45:52 +0000
Date: Tue, 17 Sep 2024 18:45:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: wait for writeback if sector size is smaller than
 page size
Message-ID: <20240917164543.GG2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <39b20c5e65df079ad99aa06ec7f70f164a541c09.1726011483.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b20c5e65df079ad99aa06ec7f70f164a541c09.1726011483.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 693C620120
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Sep 11, 2024 at 09:09:05AM +0930, Qu Wenruo wrote:
> [PROBLEM]
> If sector perfect compression is enabled for sector size < page size
> case, the following case can lead dirty ranges not being written back:
> 
>      0     32K     64K     96K     128K
>      |     |///////||//////|     |/|
>                                  124K
> 
> In above example, the page size is 64K, and we need to write back above
> two pages.
> 
> - Submit for page 0 (main thread)
>   We found delalloc range [32K, 96K), which can be compressed.
>   So we queue an async range for [32K, 96K).
>   This means, the page unlock/clearing dirty/setting writeback will
>   all happen in a workqueue context.
> 
> - The compression is done, and compressed range is submitted (workqueue)
>   Since the compression is done in asynchronously, the compression can
>   be done before the main thread to submit for page 64K.
> 
>   Now the whole range [32K, 96K), involving two pages, will be marked
>   writeback.
> 
> - Submit for page 64K (main thread)
>   extent_write_cache_pages() got its wbc->sync_mode is WB_SYNC_NONE,
>   so it skips the writeback wait.
> 
>   And unlock the page and exit. This means the dirty range [124K, 128K)
>   will never be submitted, until next writeback happens for page 64K.
> 
> This will never happen for previous kernels because:
> 
> - For sector size == page size case
>   Since one page is one sector, if a page is marked writeback it will
>   not have dirty flags.
>   So this corner case will never hit.
> 
> - For sector size < page size case
>   We never do subpage compression, a range can only be submitted for
>   compression if the range is fully page aligned.
>   This change makes the subpage behavior mostly the same as non-subpage
>   cases.
> 
> [ENHANCEMENT]
> Instead of relying WB_SYNC_NONE check only, if it's a subpage case, then
> always wait for writeback flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 385e88b7fcf5..644e00d5b0f8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2116,7 +2116,27 @@ static int extent_write_cache_pages(struct address_space *mapping,
>  				continue;
>  			}
>  
> -			if (wbc->sync_mode != WB_SYNC_NONE) {
> +			/*
> +			 * For subpage case, compression can lead to mixed
> +			 * writeback and dirty flags, e.g:
> +			 * 0     32K    64K    96K    128K
> +			 * |     |//////||/////|   |//|
> +			 *
> +			 * In above case, [32K, 96K) is asynchronously submitted
> +			 * for compression, and [124K, 128K) needs to be written back.
> +			 *
> +			 * If we didn't wait wrtiteback for page 64K, [128K, 128K)

Should this be referring to the page from offset 64K, ie [64K, 128K)?
Otherwise the range in the comment does not make sense.

> +			 * won't be submitted as the page still has writeback flag
> +			 * and will be skipped in the next check.
> +			 *
> +			 * This mixed writeback and dirty case is only possible for
> +			 * subpage case.
> +			 *
> +			 * TODO: Remove this check after migrating compression to
> +			 * regular submission.

Please don't add the TODOs, keep a note or add an assertion instead.

> +			 */
> +			if (wbc->sync_mode != WB_SYNC_NONE ||
> +			    btrfs_is_subpage(inode_to_fs_info(inode), mapping)) {
>  				if (folio_test_writeback(folio))
>  					submit_write_bio(bio_ctrl, 0);
>  				folio_wait_writeback(folio);
> -- 
> 2.46.0
> 

