Return-Path: <linux-btrfs+bounces-10213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D039EBF3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 00:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8446C1657E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 23:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195891EE7DD;
	Tue, 10 Dec 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AhANjjWP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2cJ2ppR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AhANjjWP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2cJ2ppR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037CE86324
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873065; cv=none; b=ic7vcMCauZbAbJicLPdqpFLQnzv3q3CGDj1wbZ5wt4Tfs3xJDohViVgmOeuj5Rh9gJXpc3JdKbvQPALCt4vm0T5OA3NDX3XyOHs+4z4GfdR/P9GtvU7wNbTUzdNVV/Tq/oxJlv2urRsZmOJpJ8rTqxaWMPpbjO/km61KK5pY0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873065; c=relaxed/simple;
	bh=mLYoVpU18XoopvJYU3t8p+djQ8aqWsz5cdlRJZgdK4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNlmBn01GemGK+fbmcP5vRW4t78KOTzcWalO9I3gS5n+bhRgRMMHtmM81zP1QBnpOGelDaOjsgThp3ip0WKhWHMpCJEPSGth9c3MbVZ01auPwCwWvwzUutCqX9Joexr/5cp5sjgFD17JX5Voq7NS3TFbtnpk2knQ1jnq4XwWlWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AhANjjWP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2cJ2ppR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AhANjjWP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2cJ2ppR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC07721119;
	Tue, 10 Dec 2024 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733873060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fpR3n7WmSngUDbDwZMlawlLM3a5i4B3Cjn+5YJOH1c=;
	b=AhANjjWPMyTLB/cbjKDVYoRT1OjfoJ+HBHSkJvx0eHsCAQVl1To9ZGVnDj3h+rsiF2qjK3
	iZYZEoRa5kzYFBvUVTY86AGV2kAiL3lUJgqb3P5ewsSa2V53fW16E1L2IBfacAho7T5LNJ
	/YA75/2AeoIgz7CflAsQmjtqz3YidaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733873060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fpR3n7WmSngUDbDwZMlawlLM3a5i4B3Cjn+5YJOH1c=;
	b=B2cJ2ppR02yxFqpcH3ceVkR5ZTaR9OK8vfUAvpNXCHVekQttH1UMaQhGdx+yF0m4P74gv7
	CS73pHo6OSc2/mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AhANjjWP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B2cJ2ppR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733873060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fpR3n7WmSngUDbDwZMlawlLM3a5i4B3Cjn+5YJOH1c=;
	b=AhANjjWPMyTLB/cbjKDVYoRT1OjfoJ+HBHSkJvx0eHsCAQVl1To9ZGVnDj3h+rsiF2qjK3
	iZYZEoRa5kzYFBvUVTY86AGV2kAiL3lUJgqb3P5ewsSa2V53fW16E1L2IBfacAho7T5LNJ
	/YA75/2AeoIgz7CflAsQmjtqz3YidaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733873060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fpR3n7WmSngUDbDwZMlawlLM3a5i4B3Cjn+5YJOH1c=;
	b=B2cJ2ppR02yxFqpcH3ceVkR5ZTaR9OK8vfUAvpNXCHVekQttH1UMaQhGdx+yF0m4P74gv7
	CS73pHo6OSc2/mDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D93138D2;
	Tue, 10 Dec 2024 23:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JlC+IqTNWGcqMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 10 Dec 2024 23:24:20 +0000
Date: Wed, 11 Dec 2024 00:24:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 00/10] btrfs: backref cache cleanups
Message-ID: <20241210232411.GP31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727970062.git.josef@toxicpanda.com>
 <20241206193854.GL31418@twin.jikos.cz>
 <20241209140114.GB2840216@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209140114.GB2840216@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: AC07721119
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
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Dec 09, 2024 at 09:01:14AM -0500, Josef Bacik wrote:
> On Fri, Dec 06, 2024 at 08:38:54PM +0100, David Sterba wrote:
> > On Thu, Oct 03, 2024 at 11:43:02AM -0400, Josef Bacik wrote:
> > > Hello,
> > > 
> > > This is the followup to the relocation fix that I sent out earlier.  This series
> > > cleans up a lot of the complicated things that exist in backref cache because we
> > > were keeping track of changes to the file system during relocation.  Now that we
> > > do not do this we can simplify a lot of the code and make it easier to
> > > understand.  I've tested this with the horror show of a relocation test I was
> > > using to trigger the original problem.  I'm running fstests now via the CI, but
> > > this seems solid.  Hopefully this makes the relocation code a bit easier to
> > > understand.  Thanks,
> > > 
> > > Josef
> > > 
> > > Josef Bacik (10):
> > >   btrfs: convert BUG_ON in btrfs_reloc_cow_block to proper error
> > >     handling
> > >   btrfs: remove the changed list for backref cache
> > >   btrfs: add a comment for new_bytenr in bacref_cache_node
> > >   btrfs: cleanup select_reloc_root
> > >   btrfs: remove clone_backref_node
> > >   btrfs: don't build backref tree for cowonly blocks
> > >   btrfs: do not handle non-shareable roots in backref cache
> > >   btrfs: simplify btrfs_backref_release_cache
> > >   btrfs: remove the ->lowest and ->leaves members from backref cache
> > >   btrfs: remove detached list from btrfs_backref_cache
> > 
> > The patches have been in misc-next as I've been expecting an update. We
> > want the cleanups so I've applied the series to for-next. I've removed
> > th ASSERT(0) callls, we need proper macros/functions in case you really
> > want to see something fail during development. As the errors are EUCLEAN
> > they'll bubble up eventually with some noisy message so I hope we're not
> > losing much.
> 
> Sorry Dave, I let this one fall through the cracks, thanks for picking it up for
> me.
> 
> As for replacing ASSERT(0) I agree this is a blunt tool.  Maybe we could have a
> macro that we put around EUCLEAN, at least in these cases where it also
> indicates we might have broken something?  Something like
> 
> #ifdef CONFIG_BTRFS_DEBUG
> #define BTRRFS_EUCLEAN ({ WARN_ON(1); -EUCLEAN; })
> #else
> #define BTRFS_EUCLEAN -EUCLEAN
> #endif
> 
> And then we can just use BTRFS_EUCLEAN to replace the ASSERT(0) calls.  Thanks,

Something like that, though I'd prefer a standalone macro and name it
like WARN_DEBUG or WARN_EUCLEAN for this particular error, not to
override an error code. We don't want to print a stack for each instance
of EUCLEAN, this is meant to be selective for new code or something
you'd really like to debug or know about once it happens.

