Return-Path: <linux-btrfs+bounces-22208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCUmM9Stp2mMjAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22208-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:58:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368931FA8C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 04:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1377930A8F27
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED137DEBC;
	Wed,  4 Mar 2026 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ketiPXpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p16uB9eV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lp54+mUP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GSz/rPkO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FC34D90F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596683; cv=none; b=MWazgTf+k5BfKH93UjsJlogtnw76HW4yezQIillvm+X5Ia9rGigY0hWQm74/Cw8w1+yWOdGq1V8vyr3QKWNSDZNnYinRZYLgRqONXGqZM9wv96jw8wVOMhyZiIvQxDsxcjs+qdNJ67pIee3bPfzkLVyRQHCUdtRK0KEY804a8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596683; c=relaxed/simple;
	bh=UJOb6aBO6jtLjjln4pEw75inVw3uRh/JJ63uiHvZlAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgKw+KMewQvQv3EmT0mvxFpNr83o2TXhXnKELcatwzNjYNQHQs6qktvPyUTNBeNdke/HxmoMOiV9x+cKJYz/vwO9jKVZH871NQngoCgdC7etv2QuetLX3gAY893w7cyY2Ey7hHPoRYoF0cSa2UUaC70ox1yGt+NtpqVnR8smE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ketiPXpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p16uB9eV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lp54+mUP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GSz/rPkO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8E223F881;
	Wed,  4 Mar 2026 03:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772596675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UX/66x1epyqB44PphgJvAzDCAn75TlXSJLDgLvQiVGQ=;
	b=ketiPXpJZHUiBNq2UhJE1efYcbsd1HWfJ2gf+zLArLFdrKrz+8ILiI5bzZPHC9wOZum6F/
	3Wa9sl+9WiiVQBDGMRlYgpynTOb1KUbVsdE5VcsAIAzPHx8YMlbd0IGLsaMO+7gAI8B9A+
	EYZhV+s7oOf9DPtSDvQI4FQ9z2rKIQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772596675;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UX/66x1epyqB44PphgJvAzDCAn75TlXSJLDgLvQiVGQ=;
	b=p16uB9eVg8X0b0GpD2yEZbjiBA9NvjCgVq3efmJBlW8QUNWZY5rXZsdmTQVu25xe8RoKYQ
	dpS1kFlnBBiab4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772596673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UX/66x1epyqB44PphgJvAzDCAn75TlXSJLDgLvQiVGQ=;
	b=Lp54+mUPjHtfyfhS1jbU72oSJuQI5IyGGcdjoywjj+V3pDmFfHLl7frLCWG8gHreofo3od
	LFTyrwPvcBFd3gQJKdLvoIu+T1J8qh/YRnmPavVJFjgxwJQeHxD7e80XD/bRwzuGx7hPoI
	ILg3dsBRkmVOc68LfShEpi4SKCBy5uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772596673;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UX/66x1epyqB44PphgJvAzDCAn75TlXSJLDgLvQiVGQ=;
	b=GSz/rPkOwIs8gq7qJ1JFO6MmUwSZRhRIqxuuYolto3hFgfmiHulUoA3F/s77iYDZY23PUl
	6Fs5H+7QDjZ04KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E013EA69;
	Wed,  4 Mar 2026 03:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id enCJL8Gtp2nKeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Mar 2026 03:57:53 +0000
Date: Wed, 4 Mar 2026 04:57:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: move some features out of experimental
Message-ID: <20260304035752.GH8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1772162871.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772162871.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 368931FA8C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22208-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 02:03:42PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Move bs < ps && bs != 4K out of experimental
>   That feature is a pretty small niche though.
>   The basis is already there from the bs < ps support for a while.
> 
> - Remove 2K block size support
>   That is too niche, considering how easy to trigger subpage routine
>   with the larger data folio support, there is not much need for it.
> 
> The following features can be moved out of experimental in v7.1:
> 
> - Large data folios
>   It's introduced in v6.17, but we still have a bug fix related for it
>   in v6.19.
>   If there is no new bug exposed I believe it's time to expose this
>   feature to end users.
> 
> - Shutdown and remove_bdev callbacks
>   It's introduced in v6.19, but there is no major known bug exposed yet.
>   Furthermore the remove_bdev callback, aka auto-shutdown/degradation
>   when a device is missing, can affect end users.
> 
>   Thus we want some feedbacks from early adopters.
> 
> - Block size smaller than page size but not 4K support
>   The requirement for 4K block size is purely artificial to reduce our
>   test load.
>   But since we're moving towards supporting all block sizes, the
>   artifical limit can be lifted now.

Adding all of them at once feels a bit risky. I don't think that it has
enough exposure and testing because of number of the possible
combinations.

The shutdown is orthogonal to the rest so this can be enabled by
default. For the rest the bs/ps is namely an ARM thing with the 64K
pages, and large folios is using an internal API in a new way.
Here I'd pick just one and make sure we have it covered by CI. I'm
setting it up again on github actions but it's going slower than
expected.

