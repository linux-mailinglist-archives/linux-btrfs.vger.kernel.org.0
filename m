Return-Path: <linux-btrfs+bounces-19577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5ACAE18B
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90CA5300B171
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E522EA490;
	Mon,  8 Dec 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGDOUOZT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UvBVEVX8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="02poafrG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DpEIhfJX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BD2EA168
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222651; cv=none; b=GUVxsvsF41pI0PzzEK7LJ2zWA0miuFq5KzJwmIqZkmvXYU+qbHC+uCuAScap+Zu0vX+CSZUuKAV6WU69zoCxA+6oxxB+ZSVnDCa846/b1iRfENU+FK4UpiXT/HFiPA7DmJ/oa6CJVhZEbjm/XZOA7OjeD6uo0NM70XynKmEgDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222651; c=relaxed/simple;
	bh=gQK+7RyWd4fLCsd8+R9rAeHUEMQigyHpOTbF2Ir48Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imMT1zWatQjn2WbLlO//Vzt1bimEHH3E2nzX5wvmm8KGs1dUOwEzuLjEvOI+083hFXXRwRL0gPypEqB24GwHniUUY+sKv/R6EDsrpUGYG8FjPMl7lxWlntI/kM9VJg1yXcg7psanpFla4AOegyE8ZTiCrPnHBr/sIqXtmpGMV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGDOUOZT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UvBVEVX8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=02poafrG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DpEIhfJX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F40B336FD;
	Mon,  8 Dec 2025 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765222646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph/2wB02ENlZ9Cri2yOqVQaH9c6qcR6gN0R35CFrWBQ=;
	b=JGDOUOZTxLbsS7zahOmSgvnN9M6RRLqkmTIDz8gc4EimluBOMp1ydykY3fJRicg/0//wBG
	6+wCvQudTg+0VyY68EvHIgS/yiBPvfCHON7ZsOH58LOVUCye+Xz5txNHaVm/AVPw9Ok/pu
	jS7CA5EXdc1COl/is+fucF/ggBHUEQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765222646;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph/2wB02ENlZ9Cri2yOqVQaH9c6qcR6gN0R35CFrWBQ=;
	b=UvBVEVX87fuIZubA/D3vvV2/qgB+1r7K9CSOlT2FUPuKZaQ1gmdqBa5xSdaPLEhwjYCdnD
	dqsas4F7YrQqAkAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=02poafrG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DpEIhfJX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765222645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph/2wB02ENlZ9Cri2yOqVQaH9c6qcR6gN0R35CFrWBQ=;
	b=02poafrGnXEKb2LWhcPL8gCo4L/9LeXnpLD3/BZscuhK2/bnCi+Fz57obMPUtKVWlG6AYA
	z+jckoQkQcWLqNbuc1ar6dYxO+qd6WWdItp2PRDvgE0BPz8dUc96xrLnpCRXlpASA2A3qV
	2mxrP8a/SbMvb4lW/Dv8iVeDJ13I7P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765222645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ph/2wB02ENlZ9Cri2yOqVQaH9c6qcR6gN0R35CFrWBQ=;
	b=DpEIhfJXt0T1hTZTX8ThNWlf2e778teL9azLpBBUpi2XcSekG5WZ9MChJFn2IX5YAt6hH4
	UAHoyDs0h3GKvMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E4093EA63;
	Mon,  8 Dec 2025 19:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gkFAEvUoN2l/UwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 19:37:25 +0000
Date: Mon, 8 Dec 2025 20:37:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/12] bio cleanups
Message-ID: <20251208193724.GB4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251208121020.1780402-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 7F40B336FD
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon, Dec 08, 2025 at 12:10:07PM +0000, Andreas Gruenbacher wrote:
> Hello,
> 
> we are not quite careful enough about setting bio->bi_status in all
> places (see BACKGROUND below).  This patch queue tries to fix this by
> systematically eliminating the direct assignments to bi_status sprinkled
> all throughout the code.  Please comment.
> 
> 
> The first patch ("bio: rename bio_chain arguments") is an loosely
> related cleanup.  The remaining changes are:
> 
> - Use bio_io_error() in more places.
> 
> - Add a bio_set_errno() helper for setting bi_status based on an errno.
>   Use this helper throughout the code.
> 
> - Add a bio_set_status() helper for setting bi_status to a blk_status_t
>   status code.  Use this helper in places in the code where it's
>   necessary, or at least useful without adding any overhead.
> 
> And on top of that, we have two more cleanups:
> 
> - Add a bio_endio_errno() helper that combines bio_set_errno() and
>   bio_endio().
> 
> - Add a bio_endio_status() helper that combines bio_set_status() and
>   bio_endio().
> 
> The patches are currently based on v6.18.
> 
> GIT tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=bio-cleanups
> 
> With these changes, only a few direct assignments to bio->bi_status
> remain, in BTRFS and in MD, and SOME OF THOSE MAY BE UNSAFE.  Could the
> maintainers of those subsystems please have a look?

The btrfs bits look good to me, we expect the same semantics, ie. not
overwrite existing error with 0. If there are racing writes to the
status like in btrfs_bio_end_io() we use cmpxchg() so we don't overwrite
it.

> Once the remaining direct assignments to bi_status are gone, we may want
> to think about "write protecting" bi_status to prevent unintended new
> direct assignments from creeping back in.

This makes sense, though I'm not sure if this takes into account the
mentioned cmpxchg pattern:

	if (status != BLK_STS_OK)
		cmpxchg(&bbio->status, BLK_STS_OK, status);

