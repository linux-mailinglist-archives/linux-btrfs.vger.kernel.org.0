Return-Path: <linux-btrfs+bounces-15289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D1AFB348
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EDF1AA16F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C24513635C;
	Mon,  7 Jul 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hRcgSVmI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dNlxM7Uo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hRcgSVmI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dNlxM7Uo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0780B
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891438; cv=none; b=VJKixzjOa9SwlRg/x2RWIxCboN7sLPCmUL5NraqJLv1UNDYAsGhTjVG+ppa+45rjhsgnK2paS8clqquBSMYyhkFnbpqW0QQPHXi+IoCdTtayzpG6Yde8Xt8l9F1zJF8wP+AvP7ltiOvMjF5XKqPFmq6QWaS+KbvtUsyIx+BoLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891438; c=relaxed/simple;
	bh=q/8UYu+6pyFzQq9eirZlMeRdz3vlHiapUtM+IZa01pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae6k6J+HyGE7FV2yd8WgALbCMvteHFNdOX8Lixf15U3gC27CA/TUT8DGb5iH7FsYypgxZdxv+ktdEBmgDJchZXef1WyPfmbd+BoT4+DgpbLvnEpwOGpeAxh7KLd0NnTa1TZAo59PR/54BAqU6MuQsqUjoqRRiarlQ3VoXsM6wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hRcgSVmI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dNlxM7Uo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hRcgSVmI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dNlxM7Uo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AE7C1F444;
	Mon,  7 Jul 2025 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751891432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppDGILQ2XPhyBXaRkQaZRpW+rKk5mqdfSHuPMZYsknA=;
	b=hRcgSVmIVYb2BB/fdBf5rSLhPACGUOv0HBfNvuwYkLVs1jifFCdI6wJyZz0BrIjaKzkZMm
	cP/LW7NNTGwvDBiVBGshcxfIattEzlWRfPZhqb8DUwcBuLoWRdmH/deSRw4HOuXMss1MXu
	Kg0KX7xJBw9UMbdQRufX3Drmyn//Vq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751891432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppDGILQ2XPhyBXaRkQaZRpW+rKk5mqdfSHuPMZYsknA=;
	b=dNlxM7UowEOcFHIfqDringhDLuGXnEqc0pO0rUtwDqDrDUpgo2HhJ+dR1eToElb/RSAaZN
	I9KFKnmXz+FdApCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hRcgSVmI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dNlxM7Uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751891432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppDGILQ2XPhyBXaRkQaZRpW+rKk5mqdfSHuPMZYsknA=;
	b=hRcgSVmIVYb2BB/fdBf5rSLhPACGUOv0HBfNvuwYkLVs1jifFCdI6wJyZz0BrIjaKzkZMm
	cP/LW7NNTGwvDBiVBGshcxfIattEzlWRfPZhqb8DUwcBuLoWRdmH/deSRw4HOuXMss1MXu
	Kg0KX7xJBw9UMbdQRufX3Drmyn//Vq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751891432;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppDGILQ2XPhyBXaRkQaZRpW+rKk5mqdfSHuPMZYsknA=;
	b=dNlxM7UowEOcFHIfqDringhDLuGXnEqc0pO0rUtwDqDrDUpgo2HhJ+dR1eToElb/RSAaZN
	I9KFKnmXz+FdApCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4342E13A66;
	Mon,  7 Jul 2025 12:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmY3EOi9a2g9BwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 12:30:32 +0000
Date: Mon, 7 Jul 2025 14:30:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
Message-ID: <20250707123026.GE4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <8abcc475-98c8-4bb7-add7-c4fa40065add@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8abcc475-98c8-4bb7-add7-c4fa40065add@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5AE7C1F444
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, Jul 07, 2025 at 02:53:58PM +0930, Qu Wenruo wrote:
> > Reason for RFC:
> > I'm not sure if cancelling is the best solution, but it is the easiest
> > one to implementation.
> > 
> > Pause the scrub/balance is not really feasible yet, as it will still hold the
> > mnt_want_write_file(), thus blocking freezing.
> > 
> > Meanwhile for end users, pausing scrub/balance when freezing, and resume
> > when thawing should be the best outcome.
> 
> I have explored some other solutions, like dropping and grabbing the 
> s_writers.rw_sem during the balance/scrub.
> 
> The problem of that solution is the reserved lock sequence, thus it will 
> be deadlock prune.

What do you mean by 'reserved lock sequence'?

> Currently I guess the best solution would be introducing a special error 
> code (maybe >0? -EGAIN may be a little too generic in this case) so that 
> if we hit that specific error code, we error out as usual.
> 
> But at the top level where we call mnt_want_write*() function, we drop 
> the rw_sem, and retry other than exit.
> 
> By this, we split the original long-running ioctl into several different 
> smaller sections (the split only happens after the fs being frozen), so 
> that they can properly follow the fs freeze behavior.

We have cancellable balance and scrub so there are checkpoints that can
be extended to also handle freezing in a way that pauses the operation
and waits until unfreeze. The sequence "drop locks/freeze/take locks"
should work. For the exclusive ops it's guaranteed nothing else will
start so the state will remain the same.

> The challenge is how to resume from such interruption.
> Currently neither scrub nor balance can properly handle such resume and 
> will restart from the beginning.
> 
> And even with that resume implementation, the checks in this patch will 
> still be needed.

The checks peek into the interals of the freezing mechanism, which I
think is not the right.

