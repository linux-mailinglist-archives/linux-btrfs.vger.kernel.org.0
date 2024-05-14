Return-Path: <linux-btrfs+bounces-4974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8558C5990
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEA21F23F6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB1802D9;
	Tue, 14 May 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQMXiZyM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BaIQPxC9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQMXiZyM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BaIQPxC9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E50181333
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703377; cv=none; b=VM0piHN9wVwNwSL4riX3tNC76XBkNg2TkagQ4XPl1PfVaC6JXhX4WLyMIHZ0ausHHVD5S1Xlv+jCDN1xY/sjs9GbEu4pJ6qO6VA6vkFFwMtpw3hG5Cb4ancZNj8EJ0CMhfEieAbkMKIW+3YjmFHEGZHxLSNRqMCxqlv9gXOSZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703377; c=relaxed/simple;
	bh=XTFLnt4RncNoIXxjCubh7IEDXNLQQEhVhO0uga4jSiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRi82WltciydD1RyQ1QHhbXii2PJoNzyK/KZ1egpGcuQT7XwFv3pE4piuN9hHKXAOwIiHT540nlbGhOuqmfcWI0XhlGxTdiB/EdqtxeY5HsVOvQuThx+OWUYrKTSYuyEymVNW2Vzxkh2aOp3htS/JU89HBh6yOj3qpK1QXCE744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQMXiZyM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BaIQPxC9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQMXiZyM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BaIQPxC9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EA1E3E995;
	Tue, 14 May 2024 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715703373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf8ObM/tvnu/5NcdsJcNAsQP5z4jf2tntmZCC74myd4=;
	b=pQMXiZyM2Lc1a3TF+9SihtoyjmiJDZp/BUHp3abLajiXh2Bt9ESn+ofedVC960mcuDtWtm
	A5Fo+TvAVBgg3ZrlcoIRzYqlp6iZjxPGfWFPcZAatPDbSv3Q4pCOTq6gkUlo2Gf8+aMz+v
	Px9sk2WvBC07ullLkvLRiv+05ip19SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715703373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf8ObM/tvnu/5NcdsJcNAsQP5z4jf2tntmZCC74myd4=;
	b=BaIQPxC99nhwaH/1BelWmoUXO/LB97o7tVsZterbr026ABUFKKWaQfFB34exuiYLjfyZrv
	PU6Ev/lI2XblolBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pQMXiZyM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BaIQPxC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715703373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf8ObM/tvnu/5NcdsJcNAsQP5z4jf2tntmZCC74myd4=;
	b=pQMXiZyM2Lc1a3TF+9SihtoyjmiJDZp/BUHp3abLajiXh2Bt9ESn+ofedVC960mcuDtWtm
	A5Fo+TvAVBgg3ZrlcoIRzYqlp6iZjxPGfWFPcZAatPDbSv3Q4pCOTq6gkUlo2Gf8+aMz+v
	Px9sk2WvBC07ullLkvLRiv+05ip19SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715703373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf8ObM/tvnu/5NcdsJcNAsQP5z4jf2tntmZCC74myd4=;
	b=BaIQPxC99nhwaH/1BelWmoUXO/LB97o7tVsZterbr026ABUFKKWaQfFB34exuiYLjfyZrv
	PU6Ev/lI2XblolBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 810571372E;
	Tue, 14 May 2024 16:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mkVVH02OQ2aGWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 16:16:13 +0000
Date: Tue, 14 May 2024 18:08:56 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/10] btrfs: inode management and memory consumption
 improvements
Message-ID: <20240514160856.GH4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8EA1E3E995
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Fri, May 10, 2024 at 06:32:48PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some inode related improvements, to use an xarray to track open inodes per
> root instead of a red black tree, reduce lock contention and use less memory
> per btrfs inode, so now we can fit 4 inodes per 4K page instead of 3.

That's great, thank you very much.

The slack space per page is slightly less than 1/4 (25%) in SLUB as it
has more pages per slab per object. Depending on that it can go down to
12.5% (for 8 pages per slab). But still this is a noticeable
improvement.

The 4 byte hole after otime members is still there, we might find use
for it in the future.

I'm thinking about adding a _static_assert(sizeof(btrfs_inode) <= 1024)
on a release config (and x86_64). Given the amount of time and efforts
it took to shrink the size I want to make it visible when a deliberate
change to either struct inode or any embedded structure increases the
size again.

