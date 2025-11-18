Return-Path: <linux-btrfs+bounces-19089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C0C6A75E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B40734C11E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D5364E98;
	Tue, 18 Nov 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M8D7nuHX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vMjkI3jG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M8D7nuHX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vMjkI3jG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B134F492
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481363; cv=none; b=VpxuTnqvx2V1jIjp0bFdf0Xm66H02YJ8X1sWkPkLEFo9JvL4M+0y8pwj/bmDX3DYDc8hzlrHnBpQzycWXmM0/m3Ti1MDAXxIdjWacpLZkPdxqjS+lYhSTFwHjo3qRetRmajppexpMCoH+H4mhD6QdKne4KseQESzk7YlApY+Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481363; c=relaxed/simple;
	bh=dDhvovqB2eJnRUqgNDlQs2jKyPgfvznPdHonqRLfbdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HExIxNrwZUqeUAuTbFXGdKxpwOzVfPSn5X5wxDM7SZX+A4mcr0EGyrAxr05c5ZCyJyI6WAeIDYBAc4BjAxFQKPUO5kU6RHR1wvgOZG+ap6D84TtEw9JUyr5fONX4tVDJdSc59Q8A6v4Fa8lircQMsQx7675vbstBqqgdZn2JmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M8D7nuHX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vMjkI3jG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M8D7nuHX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vMjkI3jG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98C4C1FF70;
	Tue, 18 Nov 2025 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763481358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtMpRmamzi0znrZnl/qGBHKWjlTUQ8M7uSVJn/colcY=;
	b=M8D7nuHXZ90ZD7bkmoL+lF8W+M23H4flUC5JFUFC/zzsw1YkitbDimseNZQ44cZsOpvrkp
	ff8XPqSO5GnXb6uX0zAErZsBZ04BC7GmREkMuZgX6UN6Qa6UXTvEx0rjeS02qAHB5Ln0UY
	WsY1Zya7nBppQK27DOhah9ATeUeYrZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763481358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtMpRmamzi0znrZnl/qGBHKWjlTUQ8M7uSVJn/colcY=;
	b=vMjkI3jGKywSQT4p5yncbNTUUy+V0MXDeOO5+3jLsT8F8+OXUimz43zO2x9jgB7JALea0X
	Ya6MbHwcsat9JaAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763481358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtMpRmamzi0znrZnl/qGBHKWjlTUQ8M7uSVJn/colcY=;
	b=M8D7nuHXZ90ZD7bkmoL+lF8W+M23H4flUC5JFUFC/zzsw1YkitbDimseNZQ44cZsOpvrkp
	ff8XPqSO5GnXb6uX0zAErZsBZ04BC7GmREkMuZgX6UN6Qa6UXTvEx0rjeS02qAHB5Ln0UY
	WsY1Zya7nBppQK27DOhah9ATeUeYrZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763481358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtMpRmamzi0znrZnl/qGBHKWjlTUQ8M7uSVJn/colcY=;
	b=vMjkI3jGKywSQT4p5yncbNTUUy+V0MXDeOO5+3jLsT8F8+OXUimz43zO2x9jgB7JALea0X
	Ya6MbHwcsat9JaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EFAB3EA61;
	Tue, 18 Nov 2025 15:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c2TBHg6XHGkUVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 15:55:58 +0000
Date: Tue, 18 Nov 2025 16:55:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: always update
 btrfs_scrub_progress::last_physical
Message-ID: <20251118155557.GZ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5e19e3656afeb899f91a1c81367d7e79215bee01.1762136447.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e19e3656afeb899f91a1c81367d7e79215bee01.1762136447.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[twin.jikos.cz:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Nov 03, 2025 at 12:51:09PM +1030, Qu Wenruo wrote:
> [BUG]
> When a scrub failed immediately without any byte scrubbed, the returned
> btrfs_scrub_progress::last_physical will always be 0, even if there is a
> non-zero @start passed into btrfs_scrub_dev() for resume cases.
> 
> This will reset the progress and make later scrub resume start from the
> beginning.
> 
> [CAUSE]
> The function btrfs_scrub_dev() accepts a @progress parameter to copy its
> updated progress to the caller, there are cases where we either don't
> touch progress::last_physical at all or copy 0 into last_physical:
> 
> - last_physical not updated at all
>   If some error happened before scrubbing any super block or chunk, we
>   will not copy the progress, leaving the @last_physical untouched.
> 
>   E.g. failed to allocate @sctx, scrubbing a missing device or even
>   there is already a running scrub and so on.
> 
>   All those cases won't touch @progress at all, resulting the
>   last_physical untouched and will be left as 0 for most cases.
> 
> - Error out before scrubbing any bytes
>   In those case we allocated @sctx, and sctx->stat.last_physical is all
>   zero (initialized by kvzalloc()).
>   Unfortunately some critical errors happened during
>   scrub_enumerate_chunks() or scrub_supers() before any stripe is really
>   scrubbed.
> 
>   In that case although we will copy sctx->stat back to @progress, since
>   no byte is really scrubbed, last_physical will be overwritten to 0.
> 
> [FIX]
> Make sure the parameter @progress always has its @last_physical member
> updated to @start parameter inside btrfs_scrub_dev().
> 
> At the very beginning of the function, set @progress->last_physical to
> @start, so that even if we error out without doing progress copying,
> last_physical is still at @start.
> 
> Then after we got @sctx allocated, set sctx->stat.last_physical to
> @start, this will make sure even if we didn't get any byte scrubbed, at
> the progress copying stage the @last_physical is not left as zero.
> 
> This should resolve the resume progress reset problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

