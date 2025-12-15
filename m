Return-Path: <linux-btrfs+bounces-19762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA27CBFBD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE3730361DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9D30E84F;
	Mon, 15 Dec 2025 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ll9em4v3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Scix2hsr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ll9em4v3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Scix2hsr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C52C2374
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 20:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830168; cv=none; b=aAKR8ea1j58UQhVS7CTUGMuq9RpGigBzR9SNSJEyJY2jhRJwDxF1i55f4UNDG0x55BaU7oOwGdGRCAX2ZHj7uF6mNOSc1lnM/2Xm2jMx8GJFAos2lH9BkV8/ntnx6jg7OS0dZGxFN8RmlTBqt3j38kCQhkirip0ZYIMHFY1bRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830168; c=relaxed/simple;
	bh=ZPdXw/YRu2DwRbSFv6ZMP+CA5J9R8a8iQ8WVGkBtkj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHJJR1jEMPCYmcmoNf9Q7AIreYHZO0oZy8GXVTuyvM1JNn7A4PH8/qqphYL3shahifTqpbNQiMenECpAxZNqzqL4Mc4gl3ZLl/ZYSUSI01R+XHd9PfZd+YsiPdCGTIOCHdbS/68IUzdqF5bVAQ7VTCLN7xVERERdstFmdCffwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ll9em4v3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Scix2hsr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ll9em4v3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Scix2hsr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5443F3374D;
	Mon, 15 Dec 2025 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765830165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUFKWq01nCjaiGnl9SQYMDbUUD6dDT5SDUWgevfhCM=;
	b=ll9em4v3NH55PQdcATVumJ7uAfgsR9v+zgQbOsA0qXY+Bo5IPOkxn/aa0CgMdqNW0Eb24O
	hNBlcLgwNc6ZmlMD1PIsYRfmXtIk2Try/X3ACCyDwWIX3jpcd9oXt9VTqyxfSzpLquK+zd
	eDtdtDEfYcTnLatAuTfwK7Uy0d83PjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765830165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUFKWq01nCjaiGnl9SQYMDbUUD6dDT5SDUWgevfhCM=;
	b=Scix2hsrVIIJBWA/6fN5/FG2+6Dst55MmpqZw78FoNDWY27UXEmQk6BoIwudFCdtP0uj7a
	wBBg4Kfj+Zl6UdAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765830165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUFKWq01nCjaiGnl9SQYMDbUUD6dDT5SDUWgevfhCM=;
	b=ll9em4v3NH55PQdcATVumJ7uAfgsR9v+zgQbOsA0qXY+Bo5IPOkxn/aa0CgMdqNW0Eb24O
	hNBlcLgwNc6ZmlMD1PIsYRfmXtIk2Try/X3ACCyDwWIX3jpcd9oXt9VTqyxfSzpLquK+zd
	eDtdtDEfYcTnLatAuTfwK7Uy0d83PjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765830165;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUFKWq01nCjaiGnl9SQYMDbUUD6dDT5SDUWgevfhCM=;
	b=Scix2hsrVIIJBWA/6fN5/FG2+6Dst55MmpqZw78FoNDWY27UXEmQk6BoIwudFCdtP0uj7a
	wBBg4Kfj+Zl6UdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3647D3EA63;
	Mon, 15 Dec 2025 20:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P9EZDRVuQGnzWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 20:22:45 +0000
Date: Mon, 15 Dec 2025 21:22:44 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: david laight <david.laight@runbox.com>,
	Thorsten Blum <thorsten.blum@linux.dev>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Replace memcpy + NUL termination in _btrfs_printk
Message-ID: <20251215202244.GK3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251130005518.82065-1-thorsten.blum@linux.dev>
 <20251130110640.21eadec5@pumpkin>
 <20251203134558.GG13846@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203134558.GG13846@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[runbox.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[runbox.com,linux.dev,fb.com,suse.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: *
X-Spam-Flag: NO
X-Spam-Score: 1.00

On Wed, Dec 03, 2025 at 02:45:58PM +0100, David Sterba wrote:
> On Sun, Nov 30, 2025 at 11:06:40AM +0000, david laight wrote:
> > On Sun, 30 Nov 2025 01:55:17 +0100
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > 
> > > Use strscpy() to copy the NUL-terminated source string 'fmt' to the
> > > destination buffer 'lvl' instead of using memcpy() followed by a manual
> > > NUL termination.  No functional changes.
> > 
> > Why?
> > The code has just got the length of part of the format string, it wants
> > a copy of it with a '\0' terminator.
> > So memcpy() is correct and strscpy() just expensive.
> > The code is actually strange (and strangely written), but 'size' is always 2.
> > 
> > One might question why btrfs has to invent its own 'printk' scheme...
> 
> The first code of the printk helper was added in 2012 as 4da35113426d
> ("btrfs: add varargs to btrfs_error") and since then it evolved a lot
> and I'm not sure we still need it.
> 
> Own helpers for messages insert the filesystem identification in front
> of the message. There's per-level ratelimit which needs the parsing
> added in commit 35f4e5e6f198 ("btrfs: Add ratelimit to btrfs printing").
> This can be possibly removed as we can ratelimit specific messages if
> they're known to be noisy.

For the record the level parsing is now gone
https://lore.kernel.org/linux-btrfs/f884e72071839aeb0f8b77e79a6ae2d0bc8adf78.1765299883.git.dsterba@suse.com/

