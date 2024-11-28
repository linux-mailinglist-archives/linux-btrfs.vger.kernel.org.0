Return-Path: <linux-btrfs+bounces-9951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953F9DB86B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BB16375C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFC01A2631;
	Thu, 28 Nov 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8Fliw9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBWdvD1B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8Fliw9W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBWdvD1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6F19884B
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799965; cv=none; b=ayxeV3VEg1t7mcIdDLp09/+/toMRXo5wkBgl7MOjHb+8wvY26HikoMsnRIvo0DUt5uIqzAI1Rygtv+EMm1vDHDOdxcYTdYNBl2HD8rnI74JiJx4rhfecgsZyNoNiRDqI8qBUa9Ixhb3Zixh/f+U6wQSKgaXOH+GhevuMCcLVVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799965; c=relaxed/simple;
	bh=3AUY9OT7xdIvFnXYxvF4Szq6RQr7qadDkijpe+4mZ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCxI7TGhsEvI6Hk0b7ed0QA4Cx0lMPAM+LhdV8JRCD94A70C8EE0cnLfiJCaMdvvzEzkHmE6hABrOhslL/6Tk7z34WGnAVV1xdHyfo3Aklbt4dBiQsdzF3Ne9Q/jD5z43jFY+G4RMaHIVkBH/medaY0g+7PR1D0dprvxGFJP6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8Fliw9W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBWdvD1B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8Fliw9W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBWdvD1B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4339221166;
	Thu, 28 Nov 2024 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Su8iEmGPkwBrtL0/esDFamU7d+q1TdEsVagJ5RelS0=;
	b=i8Fliw9Wu7PFGRdmJswWWzXSe9UJaogJIYXyCT2KmXwd9317Xh4Sra8hA7rsdAPtYA3JeA
	V634MfkQUDl/W7UeE6IqwJ8vWOg8K8ALK5mBpm7b4Ff1t85H242GGxPq49jwpWCnazWqoH
	Ikrg0Tc5HHNdswMraTPU3ki04+iCsIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Su8iEmGPkwBrtL0/esDFamU7d+q1TdEsVagJ5RelS0=;
	b=iBWdvD1Bkrj1OAYWnMaXhj68xz1+QWtVjiVZhWYsWpQN1MkgZG7U4ITVSXqTMlus24XrlZ
	9n37E3vR1WIq8LDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i8Fliw9W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iBWdvD1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732799960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Su8iEmGPkwBrtL0/esDFamU7d+q1TdEsVagJ5RelS0=;
	b=i8Fliw9Wu7PFGRdmJswWWzXSe9UJaogJIYXyCT2KmXwd9317Xh4Sra8hA7rsdAPtYA3JeA
	V634MfkQUDl/W7UeE6IqwJ8vWOg8K8ALK5mBpm7b4Ff1t85H242GGxPq49jwpWCnazWqoH
	Ikrg0Tc5HHNdswMraTPU3ki04+iCsIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732799960;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Su8iEmGPkwBrtL0/esDFamU7d+q1TdEsVagJ5RelS0=;
	b=iBWdvD1Bkrj1OAYWnMaXhj68xz1+QWtVjiVZhWYsWpQN1MkgZG7U4ITVSXqTMlus24XrlZ
	9n37E3vR1WIq8LDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27F7B13690;
	Thu, 28 Nov 2024 13:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dAiOCdhtSGfIegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 13:19:20 +0000
Date: Thu, 28 Nov 2024 14:19:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: validate system chunk array at
 btrfs_validate_super()
Message-ID: <20241128131914.GS31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
 <20241126182132.GN31418@twin.jikos.cz>
 <e6211467-c1b1-4dcc-9ec9-96d69a3c2948@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6211467-c1b1-4dcc-9ec9-96d69a3c2948@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4339221166
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Nov 27, 2024 at 06:48:08AM +1030, Qu Wenruo wrote:
> > Well, the memcpy() is not the problem but rather calling
> > alloc_dummy_extent_buffer() at the time we want to write the superblock.
> > This requires allocation of the extent buffer structure and all the
> > pages/folios. And the alloc/free would be done for each commit. A system
> > under load and memory pressure won't be able to flush the data. This a
> > known pattern we want to avoid.
> 
> That's exactly the concern I have too.
> > 
> > So either preallocate the dummy extent buffer and keep it around
> > (possibly freeing the unused pages/folios), or somehow make the extent
> > buffer helpers work with the superblock.
> 
> Preallocation makes sense.
> 
> > There are 2 trivial helpers that we can replace
> > (btrfs_chunk_num_stripes, btrfs_chunk_type), but
> > btrfs_check_chunk_valid() needs a proper eb with folio array.
> 
> And the reason for full eb helpers is, chunk tree blocks can be 
> multi-paged, so that we need the eb helpers to handle cross-page cases.
> 
> For superblock one, we can accept full on-stack pointer, since a sb is 
> fixed to 4096 bytes, no more than one page for all archs.
> 
> So if you really need, I can go with dedicated helpers for sb chunk, but 
> I'm not sure if it's the best solution.

Keeping around one extent buffer + pages per filesystem is IMHO an
acceptable overhead, it's probably not optimal but we'd have to
duplicate code for accessing low level structures access.

