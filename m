Return-Path: <linux-btrfs+bounces-14511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA2EACF942
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D921A189A5D0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83927F73A;
	Thu,  5 Jun 2025 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xlP+1Ggy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CcYAWd2B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xlP+1Ggy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CcYAWd2B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1127E7C0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749159755; cv=none; b=Pq/Xdy0ZlQ5Dx4al+l7rMUvLqBl8ZafTO6z2gonLUqu8XmCzmKRzY60XqonSDqDzhg1tIKoOSev5sROF33CUrhWucxi7U0lxMJsexEiVltB8ClrqhAaqo08VP9cwgIGnxyTLlK6AKGZS7C7OxkB6BEvwk4W/sH4uf1aLUs3ZC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749159755; c=relaxed/simple;
	bh=m1VeN3o8m1aOHyNmJLzfHYaGhTB+Tkzxad0TWTQUI6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvenNTNgqL6fmbjsjB6hXSIbdUw4ry5B+q72EyW4mjoKN+pqAUGZ9iWPxoXczeWpNKAMzKEDy33wI5akb4LkhSKjRY4Idl18uAvC1Uf8SRMq+e+583j4UlgLX1ewTN71kHYbFeqj0rIWlMKppqnZc58wtzfCm0Iq7kqbU3gq77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xlP+1Ggy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CcYAWd2B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xlP+1Ggy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CcYAWd2B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB9C51F391;
	Thu,  5 Jun 2025 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749159751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d4rTYzSm4Lue89YnbWsZEU3rk79w73kpwJ/owSs57o=;
	b=xlP+1GgyVeP077ZjveSY/EuTPU8yLEZBn7YhdNGCXhxrVjWz/1OteLzG06RxL9KTEdp4vd
	W29hpSC6mjW+9I/Eqe48sp2EQ0x/V7k+5O0dnmI/4FQMmYvmhISLVlz9/cLKNdxkFe39Zp
	oyBvfZD3R1+9rvo9PD6Pe15qN1FeO3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749159751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d4rTYzSm4Lue89YnbWsZEU3rk79w73kpwJ/owSs57o=;
	b=CcYAWd2BF6LtmD3QQRneYhf0Gc0RVpUspLMQrskuEfvgkTRR+9fcqVRDGDamSBKOG/cRJ6
	jiGnvBHgmwLj7YDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xlP+1Ggy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CcYAWd2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749159751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d4rTYzSm4Lue89YnbWsZEU3rk79w73kpwJ/owSs57o=;
	b=xlP+1GgyVeP077ZjveSY/EuTPU8yLEZBn7YhdNGCXhxrVjWz/1OteLzG06RxL9KTEdp4vd
	W29hpSC6mjW+9I/Eqe48sp2EQ0x/V7k+5O0dnmI/4FQMmYvmhISLVlz9/cLKNdxkFe39Zp
	oyBvfZD3R1+9rvo9PD6Pe15qN1FeO3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749159751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/d4rTYzSm4Lue89YnbWsZEU3rk79w73kpwJ/owSs57o=;
	b=CcYAWd2BF6LtmD3QQRneYhf0Gc0RVpUspLMQrskuEfvgkTRR+9fcqVRDGDamSBKOG/cRJ6
	jiGnvBHgmwLj7YDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0E90137FE;
	Thu,  5 Jun 2025 21:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tCnMJkcPQmiwTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Jun 2025 21:42:31 +0000
Date: Thu, 5 Jun 2025 23:42:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
Message-ID: <20250605214226.GW4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BB9C51F391
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21
X-Spam-Level: 

On Wed, Jun 04, 2025 at 05:49:37PM +0930, Qu Wenruo wrote:
> With all the preparation patches already merged, it's pretty easy to
> enable large data folios:
> 
> - Remove the ASSERT() on folio size in btrfs_end_repair_bio()
> 
> - Add a helper to properly set the max folio order
>   Currently due to several call sites are fetching the bitmap content
>   directly into an unsigned long, we can only support BITS_PER_LONG
>   blocks for each bitmap.
> 
> - Call the helper when reading/creating an inode
> 
> The support has the following limits:
> 
> - No large folios for data reloc inode
>   The relocation code still requires page sized folio.
>   But it's not that hot nor common compared to regular buffered ios.
> 
>   Will be improved in the future.
> 
> - Requires CONFIG_BTRFS_EXPERIMENTAL
> 
> Unfortunately I do not have a physical machine for performance test, but
> if everything goes like XFS/EXT4, it should mostly bring single digits
> percentage performance improvement in the real world.
> 
> Although I believe there are still quite some optimizations to be done,
> let's focus on testing the current large data folio support first.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix a warning when CONFIG_BTRFS_EXPERIMENTAL is not enabled
>   The @fs_info is only utilized when CONFIG_BTRFS_EXPERIMENTAL is
>   enabled.
>   Fix it by remove the @fs_info declaration and grab it manually
>   inside the CONFIG_BTRFS_EXPERIMENTAL branch.

With all the code ready for the switch I think it's time to do it. Right
now there are no other changes pending that could collide with large
folios. Feel free to add this patch to for-next as you see fit.

We'll have the whole development cycle for testing. It's still under
experimental so we don't need to revert it even if some serious problems
pop up, we'll be able to fix everything in time.

Thank you very much for working on this. As the struct page is the
foundation of any data transfer in the filesystem it's critical to get
it right. The folios are a memory management abstraction taking it to
another level where the individual page state handling can be simplified
but it's still not gone and has to be done properly.  I hope we took
enough caution in the preparation works and incremental development that
there should be no big surprises.

There are claimed performance improvements when using large folios,
which is of course nice to have, but we'll be always first concerned
about the correctness.

