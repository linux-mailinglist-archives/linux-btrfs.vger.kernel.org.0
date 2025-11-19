Return-Path: <linux-btrfs+bounces-19141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61213C6E619
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41EF8384D7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161E23587A9;
	Wed, 19 Nov 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0bsnqluh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5cMgSJoH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdmvFT6F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="18sqb41Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79A357A23
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554116; cv=none; b=h5sbrNTRbmRjcrqUb+M/v97NKZ8rIC/iSahcwcpYdM7p2867RACZj5uC+gDz3Pyxeoyp20uZpsI6rlWKjczhfjdWnOdjUoSPQwh+pMzd7haFMDr5pyUkvZrEtifRhz9VpVpoxXxcgGVYt3I5UbBMzhmXfhxW/Ev/l8qHYVHO8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554116; c=relaxed/simple;
	bh=cR6pt+3emFEaLIge9fVZ9DQunXYxuo6thMwQeem9dEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Siy2w6a99JqJ823hXMMk93Dz52gozPLsG9dAiI0AcEjw3z4PsSLzmmP4Ahr/ACA6nO7vZwfHs4JrozfuM4fyKKExUj/s/Wh6A4BpOVxBy5nIiaujMWde2DQA7YlOh6BmOCa5u2dE1Yq3KX7INyk8FJH+h9hbeGHtK4lnbGDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0bsnqluh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5cMgSJoH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdmvFT6F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=18sqb41Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5F3D211D1;
	Wed, 19 Nov 2025 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763554111;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwIzRwig6ae/dWfHx+LZai8ONhnLTBgrpp4+qYqM4k=;
	b=0bsnqluhruCDFrE3d0Wb5l++lSSMk6K+MrKAjiYb+tdMw011vcQOrnMmgj1v1biaOSpW2y
	tv7iU7HZIlrMoXEMss5A4eyOS3bmJ3JPNiEndcuAdTU6xHjRyTDEv4hHzWd2X7BzNvNsF9
	1sRVR7bkyUl+b6aPjKGPLyvqIYyiRyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763554111;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwIzRwig6ae/dWfHx+LZai8ONhnLTBgrpp4+qYqM4k=;
	b=5cMgSJoH1FVp3KAtN1kT/+XqYkj2ojIXVk4rhMhaaDZthE0u/qjBcU2U/MqyO28fwAHudc
	5809yEEEAFQ06mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fdmvFT6F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=18sqb41Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763554110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwIzRwig6ae/dWfHx+LZai8ONhnLTBgrpp4+qYqM4k=;
	b=fdmvFT6F5jKwKcpArGQwrGHnH6uU0GVtBLhFkku6TLccZS4cIJAKLE9B0Q6trThMdm/KjA
	YT3/C16BCPX0j7ApdjmgiBiURKW2Hm2cA3oSEVW0W176QUXt4tNBjnnuiejGmR2smkaP2A
	tUxLro1BAvbhyMTaSHWG/csFLyr2LKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763554110;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTwIzRwig6ae/dWfHx+LZai8ONhnLTBgrpp4+qYqM4k=;
	b=18sqb41YVNU+ldgR0brZUkHHJj5Vk1rtIuBKCilmBrGPD036QFjmhXGyAsH4HjVOtgFKLX
	x0ptgJOBEuEYgeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D155E3EA61;
	Wed, 19 Nov 2025 12:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0PRMj6zHWmhagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Nov 2025 12:08:30 +0000
Date: Wed, 19 Nov 2025 13:08:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/6] btrfs: don't rewrite ret from inode_permission
Message-ID: <20251119120829.GE13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-5-neelx@suse.com>
 <55cdc311-7b12-4dfc-ae79-9c4aab9153e0@wdc.com>
 <21e38a27-b589-486b-9825-79755987092c@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e38a27-b589-486b-9825-79755987092c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E5F3D211D1
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Wed, Nov 19, 2025 at 10:13:10AM +0000, Johannes Thumshirn wrote:
> On 11/19/25 11:08 AM, Johannes Thumshirn wrote:
> > This patch on it's own looks reasonable and IMHO should be merged ASAP
> > to not overwrite the inode_permisison() return value.
> >
> > I think also a
> >
> > Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
> >
> > would be appropriate
> >
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Yes this seems to have effects on user space, though hopefully nothing
really bad as the error codes from the permission checks is EACCESS or
EPERM, other than the ENOMEM and similar.

> Forgot to add, this needs your Signed-off-by as well as you've rebased 
> it. Same for the other patches.

I'll add it, the final list will be the original author, Daniel as he
touched it last and mine. The code hasn't evolved over the revisions so
adding everybody who submitted it at some point does not seem adequate.
Still I will also add a text to the changelog linking to the latest v5
series and mentioning people who handled the series in the past to give
credit.

