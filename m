Return-Path: <linux-btrfs+bounces-20245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E0D03C11
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 16:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8F7E306ACD9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED850E8BD;
	Thu,  8 Jan 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wulSuhaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhylc8AR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wulSuhaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhylc8AR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89050E8A3
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882934; cv=none; b=F1cx86j+a+h1kw9E0SwrfdAXo3H1qfADy9QLhzOIMi+6PgjB+EZrGCqKe1O+LzYi3ucXwFFcBr+dJSE0g5Z6j4tcYyIW933w+BYSKRGCjPMatl2kAcWbZY+lkOeyyE3mFZwTVe4h/c2PkEmV2nn7NgVo0BEFedWoZMJt313d3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882934; c=relaxed/simple;
	bh=ft4qOk0P/5rhosiOj1PJ3qfNVMZl2Z/CzyZK60HxHDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnzNnNxHN/UI9CQVJAGlOh/pBHmXXuOQp8Ky6poy7lxE350NHf+9A7xqh4emzVKzNt8tx8yJ8ffqnCfRMufGOmmHD62OP1+/YgVbLvwm8eP1kX1fI8D/4KGFeRMVuBuQbJpTjvo17Ljc+vA2/+8F1WgVOc+svEQT304K/5grNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wulSuhaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhylc8AR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wulSuhaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhylc8AR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D3BD342CE;
	Thu,  8 Jan 2026 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767882930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcROA4XOAhTexOPZ55ezvSeo6729A+GruqnuuEi3+e4=;
	b=wulSuhaw7JdDDRfhMb9+bBA5cszKL5/2BCSTU8gfW97084rg/BS7yOn8JCjCNtcWw/LQ/k
	qEyXfmzy7wFi+tQb3d2mHnf+D/30ZjxSqXtOwHjmJHOicX7SXIB8U0DCbExLpdz+EmGZfs
	4kW+E6YZ4GhZpg+ea2tUc95R+oNEnUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767882930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcROA4XOAhTexOPZ55ezvSeo6729A+GruqnuuEi3+e4=;
	b=hhylc8AROJUzXnqa7xjYMJZLdA8WJcplgw+hsC5rabWb3BLUEM2aRRhs77iwgFKHs+g2lu
	Aj0Df9FB0BhvFXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767882930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcROA4XOAhTexOPZ55ezvSeo6729A+GruqnuuEi3+e4=;
	b=wulSuhaw7JdDDRfhMb9+bBA5cszKL5/2BCSTU8gfW97084rg/BS7yOn8JCjCNtcWw/LQ/k
	qEyXfmzy7wFi+tQb3d2mHnf+D/30ZjxSqXtOwHjmJHOicX7SXIB8U0DCbExLpdz+EmGZfs
	4kW+E6YZ4GhZpg+ea2tUc95R+oNEnUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767882930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcROA4XOAhTexOPZ55ezvSeo6729A+GruqnuuEi3+e4=;
	b=hhylc8AROJUzXnqa7xjYMJZLdA8WJcplgw+hsC5rabWb3BLUEM2aRRhs77iwgFKHs+g2lu
	Aj0Df9FB0BhvFXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87A3B3EA63;
	Thu,  8 Jan 2026 14:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g+L1ILLAX2mgSgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 14:35:30 +0000
Date: Thu, 8 Jan 2026 15:35:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: simplify async csum synchronization
Message-ID: <20260108143529.GF21071@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251113101731.2624000-1-neelx@suse.com>
 <20251118120716.GT13846@twin.jikos.cz>
 <20251124180904.GR13846@twin.jikos.cz>
 <CAPjX3FftzNN1PZd+UbJU7WVCCX+J8hqktP20fwOFJ=OYx1-eMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FftzNN1PZd+UbJU7WVCCX+J8hqktP20fwOFJ=OYx1-eMA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Jan 07, 2026 at 06:00:37PM +0100, Daniel Vacek wrote:
> On Mon, 24 Nov 2025 at 19:09, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Nov 18, 2025 at 01:07:16PM +0100, David Sterba wrote:
> > > On Thu, Nov 13, 2025 at 11:17:30AM +0100, Daniel Vacek wrote:
> > > > We don't need the redundant completion csum_done which marks the
> > > > csum work has been executed. We can simply flush_work() instead.
> > > >
> > > > This way we can slim down the btrfs_bio structure by 32 bytes matching
> > > > it's size to what it used to be before introducing the async csums.
> > > > Hence not making any change with respect to the structure size.
> > > > ---
> > > > This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> > > > for-next and can be squashed into it.
> > > >
> > > > v2: metadata is not checksummed here so use the endio_workers workqueue
> > > >     unconditionally. Thanks to Qu Wenruo.
> > >
> > > This looks quite useful regarding the size reduction of btrfs_bio,
> > > please fold it to the patch. Thanks.
> >
> > The 6.19 branch is now frozen so this patch will be applied separately
> > later.
> 
> Gentle ping. It seems this one has not been picked yet.

Now added to for-next, thanks.

