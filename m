Return-Path: <linux-btrfs+bounces-11938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FEA49BBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B607D168E7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A926E145;
	Fri, 28 Feb 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="upAe9ani";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnagJeRx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="upAe9ani";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnagJeRx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37753363
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752351; cv=none; b=kaV4Dk85jSjNSGahfVJS7BfQlFzqA1Px9AggkSiveQmhLK20vKQX/t+AnOVkomjBMi/8XR1+TmYe6fPbq1hAMYbg6QJP5FcLlTx/0sx1kmQGaCM7wNuOyCZhucg+VZ+mwo7AOZGa+U78CYzq8sKXoeXI1qByKX28MK+ka91/7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752351; c=relaxed/simple;
	bh=xyBS8oiFkwhYv7EQoQ24HHbg4Lx7olDF1qZPY0cay1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT1Ryk5LJIZ3/PHIUT0XefSpketfMFpDeULRO8mekG5unehRb2sLg3ZEyJNjwlFwQp4oALSov4+J6mOFaCEb9ooslteyI3u7JU/91DTOx0EaA27x5IG/H7mE0LSWqO3ILphU6yxehPOe/Z6nyCQYxjH5dEIDPrCoSLtMBId6vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=upAe9ani; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnagJeRx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=upAe9ani; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnagJeRx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 034001F37E;
	Fri, 28 Feb 2025 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWXjnDNcOe+cVSDdG3tCZh/gQNwGje8D6wuJjrD885s=;
	b=upAe9anirQxs0YTFsNLN1T13CTVGvAQZilgrFRNvxw9LXTl+vS2y6k6is3ugEN/R79zhNh
	DHWEOP9XNZyhwW0h1KL8CzU+PSwKtq19UnG450tiqo70VbVhhbWEk76iXuRnwAT93yLA70
	eYlDIBm6sAGH8O6zmyWwCSMZDGBGPzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWXjnDNcOe+cVSDdG3tCZh/gQNwGje8D6wuJjrD885s=;
	b=ZnagJeRxr3SkQstLAa1BdIgfdqbkdp3iOnACSXmerLcY5dMC5lauXv5qnp3ipQ1li6BQq/
	Uf/Gtu1SU4I+n2AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740752348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWXjnDNcOe+cVSDdG3tCZh/gQNwGje8D6wuJjrD885s=;
	b=upAe9anirQxs0YTFsNLN1T13CTVGvAQZilgrFRNvxw9LXTl+vS2y6k6is3ugEN/R79zhNh
	DHWEOP9XNZyhwW0h1KL8CzU+PSwKtq19UnG450tiqo70VbVhhbWEk76iXuRnwAT93yLA70
	eYlDIBm6sAGH8O6zmyWwCSMZDGBGPzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740752348;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWXjnDNcOe+cVSDdG3tCZh/gQNwGje8D6wuJjrD885s=;
	b=ZnagJeRxr3SkQstLAa1BdIgfdqbkdp3iOnACSXmerLcY5dMC5lauXv5qnp3ipQ1li6BQq/
	Uf/Gtu1SU4I+n2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2D29137AC;
	Fri, 28 Feb 2025 14:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DO0nM9vFwWdzMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 14:19:07 +0000
Date: Fri, 28 Feb 2025 15:19:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: support 2k block size for debug builds
Message-ID: <20250228141902.GJ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740542375.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740542375.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 26, 2025 at 02:40:19PM +1030, Qu Wenruo wrote:
> [REPO]
> This series depends on the existing subpage related patches to pass most
> fstests, so please fetch it from the following repo:
> 
>  https://github.com/adam900710/linux/tree/2k_blocksize
> 
> Of course, one can still apply those involved patches on for-next
> branch, but running such btrfs with 2K block size are going to hit most
> if not all bugs fixed in the subpage branch.
> 
> 
> >From day 1 btrfs only supports block size as small as 4K, this means on
> the most common architecture, x86_64, has no way to test subpage block
> size support.
> 
> That's why most of my tests are done on aarch64 nowadays, but such
> limited availability is not a good thing for test coverage.
> The situation can be improved if we have larger data folios support, but
> that is another huge feature, and we're not sure how far away we really
> are.
> 
> So here we go with a much simpler solution, just lowering the minimal
> block size to 2K for debug builds.
> 
> The support has quite some limitations, but should not be a big deal
> because we're not pushing this support to end users:
> 
> - No 2K node size support
>   This is the limit by mkfs, not by the kernel.
>   But it's still a problem as this means we can not test the metadata
>   subpage routine.
> 
> - No mixed block groups support
>   As there is no 2K node size support from mkfs.btrfs.
> 
> - Very limited inline data extents support
>   No inline extent size can go beyond 2K, this affects both regular
>   files and symlinks/xattrs.
> 
>   Quite some inline related test will fail due to this.
> 
> This allows x86_64 to utilize the subpage block size routine, and in
> fact it already exposed a bug that is not reproducible on aarch64.
> (I believe it's related to the page reclaim behavior)
> 
> The first patch is to fix the deadlock that is only reproducible on
> x86_64.
> The second one is to fix btrfs-check errors that non-compressed block
> sized inline extents are reported as an error.
> The final one enables the 2K block size support for DEBUG builds.
> 
> For now there are around a dozen of failed test cases, mostly related to
> inline and mkfs limitations, but this is good enough as the beginning of
> subpage testing on x86_64.
> 
> Qu Wenruo (3):
>   btrfs: subpage: do not hold subpage spin lock when clearing folio
>     writeback
>   btrfs: properly limit inline data extent according to block size
>   btrfs: allow debug builds to accept 2K block size

Reviewed-by: David Sterba <dsterba@suse.com>

