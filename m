Return-Path: <linux-btrfs+bounces-13901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE6AB407B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB3C8C268A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E0296D2E;
	Mon, 12 May 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1dEvlEPD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etow1BNE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1dEvlEPD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etow1BNE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35F295DA6
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072379; cv=none; b=cZfJn5Z90W5EMCDrjwqeDdF4jCypAryqa5DlU1QVxJuwR+gTyhkGvTByXddHXETa5xFrzRyAbWcUKZ97+LvD79aweGK4BYpdI3wa8WHsgpK/qVwLfZVBxAZn0ih7F3UAGBUrdjiWge+sN0uWPpO6v5lmJ0PpP6GFnuQkilfF+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072379; c=relaxed/simple;
	bh=6TsOOByB60yX56Jnu1S0p8T/6u+IEjSo7msEYo5wIbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTKP/x4SM3JcQPXgfYIttqov2dCLsgHlqYVdIPlQLkiBke1J+aXvbuMzjncvyATIvsx/7+pkijY5ykX1EdGzNNpMA1jRcs9UQWElp38xfOrupR8QOqAHjPWfDVH52IB2rJd8ys7Nb/ZUmo6Q1HGgTCYB0n6JyzIZje6OIZ+L51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1dEvlEPD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etow1BNE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1dEvlEPD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etow1BNE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 722811F388;
	Mon, 12 May 2025 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747072375;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rB4H1n4XBQQRLl1uQr+mfRYVx/F+iVVppfkyxBUJ94c=;
	b=1dEvlEPDq8hOMx2JOvLnIk6R6fsUau5SaRZdlcx6vuvCXtMgCdq5EIyHuRC3KodgdfOwex
	uDsnTP9+Q2dSsilPn7m+9xC1uPZQgKRNRp6TYDU1Zd0Oilm7nOD3jwhxPNyIhMOG+rF4KC
	5CCx7n1l6+G7hnIl8aHEPPjKdwADYuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747072375;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rB4H1n4XBQQRLl1uQr+mfRYVx/F+iVVppfkyxBUJ94c=;
	b=etow1BNE2tqlhEgY1j7Iplk+89gf/H+SDsh7rfsOIRjZVI+Mz9RVnpc5tBSy7jvBQ6OhG5
	fFLe+Yx3HYZnhwBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1dEvlEPD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=etow1BNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747072375;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rB4H1n4XBQQRLl1uQr+mfRYVx/F+iVVppfkyxBUJ94c=;
	b=1dEvlEPDq8hOMx2JOvLnIk6R6fsUau5SaRZdlcx6vuvCXtMgCdq5EIyHuRC3KodgdfOwex
	uDsnTP9+Q2dSsilPn7m+9xC1uPZQgKRNRp6TYDU1Zd0Oilm7nOD3jwhxPNyIhMOG+rF4KC
	5CCx7n1l6+G7hnIl8aHEPPjKdwADYuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747072375;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rB4H1n4XBQQRLl1uQr+mfRYVx/F+iVVppfkyxBUJ94c=;
	b=etow1BNE2tqlhEgY1j7Iplk+89gf/H+SDsh7rfsOIRjZVI+Mz9RVnpc5tBSy7jvBQ6OhG5
	fFLe+Yx3HYZnhwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41056137D2;
	Mon, 12 May 2025 17:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sKlVD3c1ImggewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:52:55 +0000
Date: Mon, 12 May 2025 19:52:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Sterba <dsterba@suse.cz>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20250512175245.GV9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
 <20250507121754.GE9140@suse.cz>
 <20250508041914.GA669573@sol>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508041914.GA669573@sol>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 722811F388
X-Rspamd-Action: no action
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
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.21

On Wed, May 07, 2025 at 09:19:14PM -0700, Eric Biggers wrote:
> On Wed, May 07, 2025 at 02:17:54PM +0200, David Sterba wrote:
> > Anyway, assuming there will be a maintained, packaged in distros and
> > user friendly tool to tweak the linux crypto subsystem I agree we don't
> > have to do it in the filesystem or other subsystems.
> 
> I don't think there ever will be.  NETLINK_CRYPTO is obscure and hardly anyone
> uses it.  The kernel's generic crypto infrastructure is also really cumbersome
> to use, so the trend in the kernel overall has been a move away from the generic
> crypto infrastructure and towards straightforward library APIs (e.g.
> lib/crypto/) that just do the right thing with no configuration needed.

Ok, so on hand the recommendation is to use an obscure tool and
interface and ont the other hand kernel is moving towards library API.
I don't mind using the library approach, as long as it provides the
automatic selection of the fastest implementation available (it could be
even an extra API call e.g. at mount time).

> btrfs already uses the compression library APIs.  Considering how disastrous
> crypto_acomp has been so far when other people tried to use it, most likely the
> right decision will be to keep using the library APIs for the vast majority of
> btrfs users, and have an alternative code path that uses crypto_acomp only when
> hardware offload is actually being used.

No problem with that. I once had a prototype to do async checksumming
and using the ahash was indeed cumbersome, with the mempools and request
handling to avoid deadlocks.

> There may also be a way to rework things so that the compression library APIs
> can use hardware offload, in which case the crypto API would play no role at
> all.  I understand the Zstandard library in userspace can use Intel QAT as an
> external sequence provider, so it's been proven that this can be done.

As along as the switch to library or QAT can be in a wrapper I don't
mind.

> BTW, I also have to wonder why this patchset is proposing accelerating zlib
> instead of Zstandard.  Zstandard is a much more modern algorithm.

I think the plan is to support zstd as well but the QAT integration
should be simpler on zlib. I'd like to see some up to date code first to
get better idea of what and how.

