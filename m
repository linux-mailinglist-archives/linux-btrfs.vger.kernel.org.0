Return-Path: <linux-btrfs+bounces-18770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1FC3A7E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0335102C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685730DD1B;
	Thu,  6 Nov 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zbnmODPm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SeUQlVWb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w6by+Nbh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9snTvWXp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081622737FC
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427770; cv=none; b=twuuER6pbI/TZP1GcrRefuIkiCE+PTJlPSUOI6Q3ijEmcWaiilhvgESuUAUAsixqYi7irSlmy2FbXEciQ2HNxpPuHSlNOeYZLbF3ikgd0FeZuKZCR2iixPVUh/zCKq51ZwtYTnEA20tMv2MSbWkFJrbAxnZs43t1bU9zWSnUFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427770; c=relaxed/simple;
	bh=Fth+FkM5EjHdGKEkgEHCpu+WMm3SqTt4usowENot3KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O068M9OogN+9eOO05CA2OGBhcZw79i/nR3Z3jd6kYtD7JTp5poq8WKlfC/0hMQeTtCInR4tyadCt9YqbRFwCuiH4g/ABYsKf2c+HQnl6d7Fu8c7GOv9l/XFwT9/IaHXN4SIpdohL83bz1P1ijeJkq65ZcZ8mW16cd0wTZmtVlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zbnmODPm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SeUQlVWb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w6by+Nbh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9snTvWXp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCFC41F45F;
	Thu,  6 Nov 2025 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762427766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9glp4z9CTNaalrglyEC8qjO651OvkgwSr1ueapNmUc=;
	b=zbnmODPmW/upRyBTK4xRLFZmFKqIpmakFHGEh4NGnwm3d0bTgo6RfXhov9VKF7mjueS8GG
	QmiZqM7QWuQyjLZHnSdyT/p+BvTZKBDn0+M/HT+9aquPtKK75u50bjxM1XtRNeyX5kpCck
	n20T2DnZjp37jB7U5gVhqh2AtqKnm+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762427766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9glp4z9CTNaalrglyEC8qjO651OvkgwSr1ueapNmUc=;
	b=SeUQlVWbiFbwRnXcrWmlg2qQPqYnxx4EMy/D/23l5CxAMvy/bogg/83MK3eL9jdwWAC6nm
	CGpoIqCKHCNj3hDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w6by+Nbh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9snTvWXp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762427764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9glp4z9CTNaalrglyEC8qjO651OvkgwSr1ueapNmUc=;
	b=w6by+NbhKM3LwdgQ+BGi2iInbLnJMj/0LdD0m/vmmtM2R5xG6HKQe7JNaBtBrSI30vhVR5
	hUja6Z+Eb+atCU5EUtpmP7MpJK9sLWEvXRNtiKvUovrEUbyudGsw8Xpmo8kE5FAXqSaQX9
	fsL+ZN4xVTSK2UXf0hkdVvhh8B1IT+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762427764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9glp4z9CTNaalrglyEC8qjO651OvkgwSr1ueapNmUc=;
	b=9snTvWXpzl6+/ALd5B1p7CMKg7/6Ms2nKNJZUkV9dPq8fT2+cIhf6SOrOyCClKrZAOgkk6
	6sGa5nNx4k2jP7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A054D139A9;
	Thu,  6 Nov 2025 11:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7SD3JnSDDGkTAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Nov 2025 11:16:04 +0000
Date: Thu, 6 Nov 2025 12:16:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: extract the parity scrub code into a helper
Message-ID: <20251106111603.GW13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a07e2c42e9f29dce1bb50a9b875cf29dfa909afd.1762421429.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07e2c42e9f29dce1bb50a9b875cf29dfa909afd.1762421429.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: BCFC41F45F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Nov 06, 2025 at 08:02:15PM +1030, Qu Wenruo wrote:
> The function scrub_raid56_parity_stripe() is handling the partity stripe
> by the following steps:
> 
> - Scrub each data stripes
>   And make sure everything is fine in each data stripe
> 
> - Cache the data stripe into the raid bio
> 
> - Use the cached raid bio to scrub the target parity stripe
> 
> Extract the last two steps into a new helper,
> scrub_radi56_cached_parity(), as a cleanup and make the error handling
> more straightforward.
> 
> With the following minor cleanups:
> 
> - Use on-stack bio structure
>   The bio is always empty thus we do not need any bio vector nor the
>   block device. Thus there is no need to allocate a bio, the on-stack
>   one is more than enough to cut it.
> 
> - Remove the unnecessary btrfs_put_bioc() call if btrfs_map_block()
>   failed
>   If btrfs_map_block() is failed, @bioc_ret will not be touched thus
>   there is no need to call btrfs_put_bioc() in this case.
> 
> - Use a proper out: tag to do the cleanup
>   Now the error cleanup is much shorter and simpler, just
>   btrfs_bio_counter_dec() and bio_uninit().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rebased to the latest for-next branch
>   The latest branch has the memory leak fixed merged, causing a minor
>   conflict.
> 
> - Remove the DECLARE_COMPLETION_ONSTACK() inside the caller
>   Which is no longer utilized.

Reviewed-by: David Sterba <dsterba@suse.com>

