Return-Path: <linux-btrfs+bounces-20353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56368D0C43B
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 22:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 864F73013E8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480531D725;
	Fri,  9 Jan 2026 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBzGR+Zu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gm2P89Uk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBzGR+Zu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gm2P89Uk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99122DF145
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992970; cv=none; b=ruPXaHd+a6D1Huw+g9cgemsR5M00/I7edr2iyGeStFfY/Wh6f8Q7PPeKxvLzmnKzGhhWpiHAEnwJwJNz1uZw1ELnTGwLbyQWOcvecAKv2BcWZUNtsuUpt7QzfJ68OaZEISR3ZSGolpjCQs69syIlrUyRGIZKLyZiKKa9jhrCaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992970; c=relaxed/simple;
	bh=oPgfmqIAzcyIu8H53JfGZjhU04YqJqPiBJke+Sqbw0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmvfeQYiC9sMTQR4WNVLuvc2EFcUM40cPM5B7POOtP9FuxsmtYOhjR5EPNBIi32IYzQg+SI8yaKqNtUJBh4U3A92obVc07rFuIPqzUSbLys5zMR0XTfbu9QrVd5SSI8sAj7N1YpNFCPHRzpjktuzKfW+D0/HlEbNgbcw/iCwmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBzGR+Zu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gm2P89Uk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBzGR+Zu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gm2P89Uk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09ACD5BD4F;
	Fri,  9 Jan 2026 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767992967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QADP+3eVp2acDOR7i5jfKUHG+j8MdehJI0Qg7s4pj1I=;
	b=KBzGR+Zu3KJno3IkPYpB74hQZyv/7Tsun2Kx3L6tUZjk0m6zonkr6V9rP7dbmDdml5CTRO
	jlXqtBaR2ABPFQVVGBtBLiew6wpxZEBowRGUPCyByFgP0zC0y5WAru6W30bQV9I5/aU/Kn
	vjFpUcY/tMfVz8FrVm1eFVE6B9OTozQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767992967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QADP+3eVp2acDOR7i5jfKUHG+j8MdehJI0Qg7s4pj1I=;
	b=Gm2P89Uk3PM+LzF6MWdqqpllLEgbIdomnNsggf62PHxbEgDTguJrTb3ZDMeh4j4S77xSov
	Rs0um99u6VkyR6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767992967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QADP+3eVp2acDOR7i5jfKUHG+j8MdehJI0Qg7s4pj1I=;
	b=KBzGR+Zu3KJno3IkPYpB74hQZyv/7Tsun2Kx3L6tUZjk0m6zonkr6V9rP7dbmDdml5CTRO
	jlXqtBaR2ABPFQVVGBtBLiew6wpxZEBowRGUPCyByFgP0zC0y5WAru6W30bQV9I5/aU/Kn
	vjFpUcY/tMfVz8FrVm1eFVE6B9OTozQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767992967;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QADP+3eVp2acDOR7i5jfKUHG+j8MdehJI0Qg7s4pj1I=;
	b=Gm2P89Uk3PM+LzF6MWdqqpllLEgbIdomnNsggf62PHxbEgDTguJrTb3ZDMeh4j4S77xSov
	Rs0um99u6VkyR6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD2C3EA63;
	Fri,  9 Jan 2026 21:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kiz5NIZuYWkUMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Jan 2026 21:09:26 +0000
Date: Fri, 9 Jan 2026 22:09:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260109210921.GT21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767979013.git.dsterba@suse.com>
 <20260109181627.GB3036615@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109181627.GB3036615@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Jan 09, 2026 at 10:16:27AM -0800, Boris Burkov wrote:
> On Fri, Jan 09, 2026 at 06:17:39PM +0100, David Sterba wrote:
> > Embed delayed root into btrfs_fs_info.
> 
> The patches all look fine to me, but I think it would be nice to give
> some justification for why it is desirable to make this change besides
> "it's possible". If anything, it is a regression on the size of struct
> btrfs_fs_info as you mention in the first patch.

A regression? That's an unusal way how to look at it and I did not cross
my mind. The motivation is that the two objects have same lifetime and
whe have spare bytes in the slab.

> If the answer is just that it's simpler and there is no need for a
> separate allocation, then fair enough. But then why not directly embed
> all the one-off structures pointed to by fs_info? Like all the global
> roots, for example. Are they too large? What constitutes too large?
> Later, when we slowly add stuff to fs_info till it is bigger than 4k,
> should we undo this patch set? Or look for other, bigger structs to
> unembed first?

Fair questions. If we embed everything the fs_info would be say 16K. The
threshold I'm considering is 4K, which is 4K page on the most common
architecture x86_64. ARM can be configured to have 4K or 64K on the most
common setups, so I'm not making it worse by the 4K choice.

So, if the structure for embedding is small enough not to cross 4K and
still leave some space then I consider it worth doing. In the case of
increasing the fs_info by required and small new members (spinlocks,
atomics, various stats etc) we can first look how to shring the size by
reordering it. Currently I see there are 97 bytes in holes. Then we can
look what is used optionally, eg. depends on a mount option and move it
to a separate structure.

The delayed root is a core data structure so we will not have to
separate it again and revert this patchset. What I'd start looking for
for a separate data structure would be some kind of static
almost-read-only information, like mount option bits or status flags
etc.

Also I don't want people to worry about fs_info size when there's
something new to implement. We have some space to use and I will notice
if we cross the boundary as I do random checks of the patch effects
every now and then. This applies to parameters and stack space
consumption. You may say this is pointless like in the other patchset
but even on machines with terabytes of memory a kernel thread is still
limited to 16K of stack and layering subsystems can use substantial
portions of it. My long term goal is to keep the level the same without
hindering development.

