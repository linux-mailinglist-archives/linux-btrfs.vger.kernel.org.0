Return-Path: <linux-btrfs+bounces-10901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7CA096A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C193A66D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C1212D7A;
	Fri, 10 Jan 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v017leiz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kRosTPzL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJ2JI2uo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="64RRlj2c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA77212D65
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524975; cv=none; b=IzL2EMPHYAgbF5hTtBPnCPjPtYR7mQJQah+ADV5Kz4FHqVy+adCa0fdp5TWb7DFkj+JRxWHGxoGsjnKGwYkmVgFahtmI4rsCGNgfeb8cJ/xn0s+pJr9bviexpafmlE0739tF4cYdnqs4VU1cI/uhvdLq/pFAWL+1FGLTAszC8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524975; c=relaxed/simple;
	bh=+wByT7fW/mrxTbGFqwSr2afEHP7tGjuLVbzVW8uEk6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVnNYu0XKzhggceENA14uYr6KsrEvKpvod9QluhaGNiadlb93ECZXbYMO8csp91QwzEKsgUdnuhMbzJy+b+nI8kcUF+RxZv7N+/8+JPb5foUmFPPSVVmyisuQkQB01WyCoGNMOfitRyFF1eGLxJA8LwrR5PkVuxVPl3/NMhnVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v017leiz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kRosTPzL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJ2JI2uo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=64RRlj2c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA4D921114;
	Fri, 10 Jan 2025 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736524971;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=642kkpP/VKssta7Vhjw5ooXEVk1eh+Uv9VuTKRxiko4=;
	b=v017leiz0fpMvyFc9S2JXhiBVutIu87LFsNCsQd00L57mFsfm3Oo/JbGYyHTy9OJk1fhaH
	tPE6qmVW9IWG/LVYkYH7uAAvs1zeNxvbDu5WTzepiFNZpyJKeUCWIoQZOoxyyCHhINMG0G
	bTVxp3dapldNd0CpSe8PkkW2gkI1ikE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736524971;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=642kkpP/VKssta7Vhjw5ooXEVk1eh+Uv9VuTKRxiko4=;
	b=kRosTPzLzpq1dZCBbU46V1Bl+sw/nEPeJ2F+0iH+U3H/NPFpBuTeW6JWZbxN1QzG8pt8Gc
	XgT7v2VQGtbc19Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736524970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=642kkpP/VKssta7Vhjw5ooXEVk1eh+Uv9VuTKRxiko4=;
	b=NJ2JI2uoEZTHacjpHkHTPn3dCKv17mXo/BOpRFTFHRj5FD+xm4dw0pJXDcMfrM2qYyOHNC
	vcHoGIfVE86ACbUA5WBzLo4uxcoBrWgfJfjniYAmoFxOQU+UHx9t1jEXyonpIgtCDw+Pe9
	VjO3+31Y0cDWDSoZU40mLyBN/uUKxbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736524970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=642kkpP/VKssta7Vhjw5ooXEVk1eh+Uv9VuTKRxiko4=;
	b=64RRlj2c0b6vEF3zanDXbZMXmdVhx/mIrVjcdw+Xp3quB2B6MHxq2T24mwbCHkXt80yfuM
	AyrnNA+9AafCkHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FD4E13A86;
	Fri, 10 Jan 2025 16:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UwbAJqpEgWfBEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 10 Jan 2025 16:02:50 +0000
Date: Fri, 10 Jan 2025 17:02:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/18] btrfs: switch grab_extent_buffer() to folios
Message-ID: <20250110160245.GB12628@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1736418116.git.dsterba@suse.com>
 <cfc1126823c5690264d55a5186bd60381498bd8b.1736418116.git.dsterba@suse.com>
 <8b046e03-6660-484e-9659-b18bac7ac5eb@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b046e03-6660-484e-9659-b18bac7ac5eb@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Jan 09, 2025 at 12:40:27PM +0000, Johannes Thumshirn wrote:
> On 09.01.25 11:27, David Sterba wrote:
> > -static struct extent_buffer *grab_extent_buffer(
> > -		struct btrfs_fs_info *fs_info, struct page *page)
> > +static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info, struct folio *folio)
> 
> I'd personally break the line after fs_info so it fits nicely into 80 
> chars. The 99 we have after folio seems excessive to me.

Yeah in this case it's a bit too much. The loose rule I use is if at
least part of the identifier is visible then the overflow is OK.

