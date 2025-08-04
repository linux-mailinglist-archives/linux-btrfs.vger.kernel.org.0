Return-Path: <linux-btrfs+bounces-15836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11016B19EE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 11:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DBF16B5E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945324729D;
	Mon,  4 Aug 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jfhuEuSv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cf6krHgW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="txbbgEhO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8Ch1U9I1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DC246766
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300464; cv=none; b=m5SoBVZwQh2GNVCoPRPUnTyTsfZzxCVnkRGTAFQlGarrW6g4+tGCvmXVnJbG+/p6AFTryRRO/a8VVIIKcLjra6d9F8VWg+DCNZt4+KYX7s04Dq+TJIbbXrNOx50iP85FEL+VIwaBY1+4ZfhN/nE9YomzThcjF+80Kn4K2RUXw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300464; c=relaxed/simple;
	bh=kaqGhjJFnsLIZGXivtgYSgWQ1pF9y+XAW1ZNBqI9Zv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FisZVdI5FcsLqsFEC3Y9S+iq5rX2rCrGQ+jAc3yNsAFh/5/16+EbnJevSaX6W8eKWpnh6dVqBVuTnqIzSTkrqJwah2yh3XY6iidQi12FZD7UcLPVujkBMYMHCJw+2BmllCWHnTSIDE98TS5ufdTWTHbjeT/cgn0VsQ73MZ5uPnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jfhuEuSv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cf6krHgW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=txbbgEhO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8Ch1U9I1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECA821F445;
	Mon,  4 Aug 2025 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754300460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QKTrtBfRaFeYcq5sCBs8ZcBsoitqGHKJ+ei8bxSuC8=;
	b=jfhuEuSvsfurkVKdaEsTMCohFj/xlocxOAsDgv4g3/1GTlAUjcQfwTewx0KErCnPBk3q8i
	hxOJKVQwqgNGOL2x+kYjrZfoIvbRChOZqXuioyD4828ckg5AZsgNVfIvVxum6cHf9AilP6
	SCq0rjspgoZB0Nx4XEmlhuWYdJsqKGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754300460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QKTrtBfRaFeYcq5sCBs8ZcBsoitqGHKJ+ei8bxSuC8=;
	b=cf6krHgWmQfAaVf5+Q8Gs4jxPOKEN7A/x0wanxtFxM0pBESYMCmBlro96A8beECo6ytGvN
	d8MwLkkUwMZtc8DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754300459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QKTrtBfRaFeYcq5sCBs8ZcBsoitqGHKJ+ei8bxSuC8=;
	b=txbbgEhOuVKKJ/aWNSUUPy/ZEj1BqL66cq83qdlLtDb548//yTTCBfL41bLU3nBz9i7eUf
	rZeKVrdDki/aIe3bpTOmTDJwp8b0eN1hVfPiHC35wp1kGcMWQYfIGFqKFdQ5N5aM84JLEN
	yYqja/136xBjGaTzD6gih2Zl/OW7k2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754300459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7QKTrtBfRaFeYcq5sCBs8ZcBsoitqGHKJ+ei8bxSuC8=;
	b=8Ch1U9I1V3Qol0yAraBY581rQFgdA9CaDheCxi/l4Iv0HW+4int9JLs6mw3bFQo4Q7iX/l
	p/EeSnCfConB+YBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4A5813695;
	Mon,  4 Aug 2025 09:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /rXGMyuAkGj/CAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 04 Aug 2025 09:40:59 +0000
Date: Mon, 4 Aug 2025 11:40:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.17
Message-ID: <20250804094057.GJ6704@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1753226358.git.dsterba@suse.com>
 <20250729095557.30be0750@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729095557.30be0750@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jul 29, 2025 at 09:55:57AM +1000, Stephen Rothwell wrote:
> Hi David,
> 
> On Wed, 23 Jul 2025 01:23:47 +0200 David Sterba <dsterba@suse.com> wrote:
> >
> > Hi,
> > 
> > there's are number of usability and feature updates, scattered
> > performance improvements and fixes.  Highlight of the core changes is
> > getting closer to enabling large folios (now behind a config option).
> 
> It looks like this was all rebased from what is in linux-next :-(
> 
> Please clean up the btrfs trees in linux-next.

Sorry, I forgot to push the branch for linux-next.  The code there is
the same as was pulled, the difference is one merge commit generated by
my scripts (for-next commit 442ee950ea05968). Now updated at k.org, the
previous one is in for-next-prev should anybody wan to compare them.

