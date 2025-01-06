Return-Path: <linux-btrfs+bounces-10744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4DA027A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BB188585B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE7433CA;
	Mon,  6 Jan 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X+TJnFgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVf3x993";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X+TJnFgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uVf3x993"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABF469D
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173169; cv=none; b=RoflXUoquoKXbB8rytb5zS0uEsCxd4HuI7ZgqTQ6F0v8KcdFIxcrk9eTyy/gEFw5LR3aDXP080ykc6Q0YlfbPB2+L/xWQIx6i7b0rxN05zHlBg3PNiVmJ0eoWwDMxTxZLL/l0GpLy6wGAJmYxjkheFGBEfFz+qC3wNKOEGtPuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173169; c=relaxed/simple;
	bh=NcTkDFZKmQry5rX5xyC9ST0yfGDlfgGlKeTmjbqnLNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epu/dlfDMQDjornrrVexhcW3VtpN179jNX7/Rep8k8cfZOLi1M7do5mvKgeXSg8SfFoS5dJWE0srGnss+pZKLeLIQboh+1Ckb2z22dqpd8TJ5qMx5lwKgThdaOx2iJ1kdTqXbyhloteNLZx3j6ZG3ckMByBL2n5PVqhN77TJVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X+TJnFgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVf3x993; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X+TJnFgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uVf3x993; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2E5F2115D;
	Mon,  6 Jan 2025 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736173165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq2Yk83rlFmZ2SFqBmYUKAgKuyF/rmkRAkuyUZXtvbA=;
	b=X+TJnFgDFriVb9bTIvlKw9+y4eWR1gjAj5fkZOrm/1N18cuEdGwL3XFT8xlT5RYiJO9uVA
	0lIXwmFYEFSx0lntsSIPUSreq+e5EwF6nmRFoyphJE7smXXUrIO7TCOqKMMp3fhMRSV2Kp
	4VfQUsuhAY6a6gfzsWGyjbY91hoQSK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736173165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq2Yk83rlFmZ2SFqBmYUKAgKuyF/rmkRAkuyUZXtvbA=;
	b=uVf3x993LLOabaeWM389WfM1kHTXgWTwQCdIRf/Fe03N7r8H3NNhpv+V3IeQET3l5721Vw
	rvHdNnEv1gZQX0CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736173165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq2Yk83rlFmZ2SFqBmYUKAgKuyF/rmkRAkuyUZXtvbA=;
	b=X+TJnFgDFriVb9bTIvlKw9+y4eWR1gjAj5fkZOrm/1N18cuEdGwL3XFT8xlT5RYiJO9uVA
	0lIXwmFYEFSx0lntsSIPUSreq+e5EwF6nmRFoyphJE7smXXUrIO7TCOqKMMp3fhMRSV2Kp
	4VfQUsuhAY6a6gfzsWGyjbY91hoQSK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736173165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq2Yk83rlFmZ2SFqBmYUKAgKuyF/rmkRAkuyUZXtvbA=;
	b=uVf3x993LLOabaeWM389WfM1kHTXgWTwQCdIRf/Fe03N7r8H3NNhpv+V3IeQET3l5721Vw
	rvHdNnEv1gZQX0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95198137DA;
	Mon,  6 Jan 2025 14:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jrXrI23me2cOOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 14:19:25 +0000
Date: Mon, 6 Jan 2025 15:19:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/20] btrfs: remove plenty of redundant
 btrfs_mark_buffer_dirty() calls
Message-ID: <20250106141924.GW31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734527445.git.fdmanana@suse.com>
 <20241223200859.GN31418@twin.jikos.cz>
 <CAL3q7H4vqj-u+NdkiRgc+PNjFbhkRgm_ECHGyGD=CjRgTLKOdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4vqj-u+NdkiRgc+PNjFbhkRgm_ECHGyGD=CjRgTLKOdw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Jan 06, 2025 at 10:54:05AM +0000, Filipe Manana wrote:
> On Mon, Dec 23, 2024 at 8:09 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Dec 18, 2024 at 05:06:27PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > There's quite a lot of places calling btrfs_mark_buffer_dirty() when it
> > > is not necessary because we already have a path setup for writing, due
> > > to calls to btrfs_search_slot() with a 'cow' argument having a value of 1
> > > or anything that calls btrfs_search_slot() that way (and it's obvious
> > > from the context). These make the code more verbose, add some overhead
> > > and increase the module's text size unnecessarily. This patchset removes
> > > such unnecessary calls. Often people keep adding them because they copy
> > > the approach done from such places.
> >
> > I've read the explict calls to btrfs_mark_buffer_dirty() as source-level
> > marker of the section pairing btrfs_search_slot(). There are also some
> > assertions and eb state checks that were done in set_extent_buffer_dirty(),
> > now we're losing them.
> 
> No, we aren't losing the assertions.
> We've done them inside ctree.c, where we have already called
> btrfs_mark_buffer_dirty() (which calls set_extent_buffer_dirty()).

What I mean that we would be doing the assertions again, after some
lines of code since the last call to btrfs_mark_buffer_dirty() from
ctree.c.

> > While the code gets reduced and the calls may be redundant for some
> > reasons I think we should keep something at least to do the assertions,
> > or eventually optimize btrfs_mark_buffer_dirty() to be faster if the
> > path is set up by the search slot with cow=1.
> 
> This isn't just about optimization.
> It's about simplifying usage of btree modification calls to users
> outside ctree.c and having cleaner APIs.
> 
> In some places outside ctree.c we (unnecessarily) call
> btrfs_mark_buffer_dirty(), while for others we don't.
> Probably in the very early days it was needed for some reason, but
> that's not the case anymore and we call btrfs_mark_buffer_dirty()
> every time we COW or allocate a new block as part of a node/leaf split
> in ctree.c.
> 
> Keeping these redundant calls is like saying we don't trust what
> ctree.c does. Marking a new extent buffer dirty is a clear
> responsibility of ctree.c.

I would not interpret is as distrust in the ctree.c code but rather as
an additional verification like we do elsewhere. Schematically

caller - start a new change in eb, call the API
ctree.c - create new eb
ctree.c - call btrfs_mark_buffer_dirty()
caller - do more changes, anything until the path is released etc
caller - (removed in the series) call btrfs_mark_buffer_dirty(), now
         performing transid assertion checks,
	 in set_extent_buffer_dirty():
	 - check_buffer_tree_ref()
	 - a few WARN_ONs checking state bits
	 - folio dirty bit checks

From functional POV removing btrfs_mark_buffer_dirty() is ok, but we may
still want to add a simple helper that verifies similar things as
before. With assertions it happens that the checks are redundant.
But feel free to add the series to for-next. The additional verification
would need a separate pass, examine the code locations and pick the
right checks.

