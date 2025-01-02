Return-Path: <linux-btrfs+bounces-10686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DE9FF980
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36517188371A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFC3195B33;
	Thu,  2 Jan 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fg+YbBA/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2kMzVR6v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fc+6Taqd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S8D0KJjl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2B4431;
	Thu,  2 Jan 2025 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735822176; cv=none; b=QvipDpIm7rCsQRmklV6dvY3zc6Qshm7S5OcJ6hy9R0UZ9G38QGyR3EmlOXfVwskR0BEG/MiWwnodAsVAgwtOqjF9O3NGqJfNFYjmSfa0CHl/6M/fN5gR9Y7/ON/gcjU8wk1BZHPFbN1eUNLS2D+tqLnM4BP9dfgH9Xvc2yjfKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735822176; c=relaxed/simple;
	bh=4xB+S+Ix8VkXjliBTt0c5KipdJhwS0D9oUYYpIv7G+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6S8hiRRv+6fuwDIHOTEQ9UqCLDOhJwACM6gZ8y8dusXkoeAo55zMZthgYWnGKhRPl8zH2jdgTWok+HUAMcQQhSfXVSuAx0DGYe0rutsSgxBAZdlbAwx2Sfh628c17/fqIkCkoyes+chhLBV/ZRQ+T133uI7kP7S51+xPb8c3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fg+YbBA/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2kMzVR6v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fc+6Taqd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S8D0KJjl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C94591F38E;
	Thu,  2 Jan 2025 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735822173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt6Xdwy/EDCfqZQNdWknAlB6G5Cv74m0MD6CjXdI7Iw=;
	b=fg+YbBA/ivlNpGF12J4j7yp2tzxhZ/wHOioJsrENPyy3lKct7N+/Vs1KtgDnDVPEpbpiqW
	RzuOfpmgj+wQBF0baVP4eDVZKQaRrgtRjUVAGscuU+IvsbZy86eFHyshVX7o6qh4MzbRcL
	T1Ey6Kt9njH7vQEXhS33oYmcYn65QTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735822173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt6Xdwy/EDCfqZQNdWknAlB6G5Cv74m0MD6CjXdI7Iw=;
	b=2kMzVR6vYmzo8UvDDkx+JrG8OCGC2GInKHHA79Cwy7s1u96GOchu2QKdWCrYOoA/aMv6CF
	7Q1nDEChTE0ytNBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fc+6Taqd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S8D0KJjl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735822172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt6Xdwy/EDCfqZQNdWknAlB6G5Cv74m0MD6CjXdI7Iw=;
	b=fc+6TaqdRt8vlsK7kvXqdkW/3N1mde4mkCWLkbOOQG9RhBi0O9auCZrDq6GucxSjOE6YoQ
	+tfezf4pNbkE7hA6XbNQSMfksOmwYdAg/8k7qkn1ACb9gWBXNseGkZj25ml2A0q96KiTvV
	vg10vnJTvMEA+nuXyxoZ3sd/Bigq9Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735822172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nt6Xdwy/EDCfqZQNdWknAlB6G5Cv74m0MD6CjXdI7Iw=;
	b=S8D0KJjlsqh+O5SkQVyISk2J1IpghA6yyHMl/SY/IOcrz0OPNph9JVl9TpDhJId+alY1C9
	Ohmxf/+TMfTOQoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B2B13418;
	Thu,  2 Jan 2025 12:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aXpXK1yLdmfHewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Jan 2025 12:49:32 +0000
Date: Thu, 2 Jan 2025 13:49:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 6.13-rc5
Message-ID: <20250102124927.GO31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1735454878.git.dsterba@suse.com>
 <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjkHJSqXS6RnJnbMiDM9Rk58oLWLr9T4qyUO3omX74-fg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C94591F38E
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, Dec 29, 2024 at 09:41:08AM -0800, Linus Torvalds wrote:
> On Sat, 28 Dec 2024 at 23:40, David Sterba <dsterba@suse.com> wrote:
> >
> > - print various sizes in sysfs with correct endianity
> 
> "endianity"?
> 
> More commonly called "endianness".
> 
> I left it around, but I really don't think that's a word.

Right, it's not, it's close to the czech version. Feel free to fix such
obvious mistakes.

