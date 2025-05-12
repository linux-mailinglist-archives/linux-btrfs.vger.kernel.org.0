Return-Path: <linux-btrfs+bounces-13893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E204AB3EE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB257A6D1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37335296D1E;
	Mon, 12 May 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r+Riyf+9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PD1+jqw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oqcVsUSo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZYjB72q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E8248F71
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070530; cv=none; b=LvK6axTjXF3+AIEI4pcXQXvbE0/3Lffhs2vCRr2H1KVVJ9kBCi+S0Q23EnDm1urHUOlgb9+qVNQ+0/9WQzhrRrNQjrq/uK/acQ09K7ark9CJBPt3mO6+0x+hSskszOtBpwcudwMmyb4kqGtftO+0RSch2raVKvXO16vlTpcUjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070530; c=relaxed/simple;
	bh=qz9+bQ5nA8XWQYLfhc1tZnHaykXsq5Vk7+3YargFnyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVym3TghbBvxuPeb1ZSxes62wqoFJoBWsB/oQs8ocNENMtWZHGwxCpLKoZqB5uX95RgDOOQ/O9JjCZ4gZ5dm+oqjtP2hadi5mErOJonBTu/rJJAHV4BONgVJcQ6nDYE2OupGGWvBWwW0rAT5yJeLLQohpH8JtC0JweWsPDYV114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r+Riyf+9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PD1+jqw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oqcVsUSo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZYjB72q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E26D821184;
	Mon, 12 May 2025 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVmkqWYR5zkUXobDHytjmMtNOMuOXDKEtLniUXb9R9k=;
	b=r+Riyf+9EqKF2dHp+i7m6alGaKj85/CNbcyp1l1a38fTDj6zNzvcMolyobGMw98JOxLQQw
	lYepVu8/lwL7INh2p/dTS/VihOndlMLZ4VwUqH9ZexJ/T5qdt6OQFwr0OfxMj6DK9WjJ95
	ixxBshHhbTpfKDlNIiKyRF7uBJe/Qvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070527;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVmkqWYR5zkUXobDHytjmMtNOMuOXDKEtLniUXb9R9k=;
	b=5PD1+jqwRHS5t3EXWjYLhrhBL2v+7QiTYHvpMCfTjYzAJNoQ1zuWy+e96sy6ewjUxGoJp8
	9CPxDPdwdDghkRBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oqcVsUSo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oZYjB72q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVmkqWYR5zkUXobDHytjmMtNOMuOXDKEtLniUXb9R9k=;
	b=oqcVsUSoxiIRkr9e353C2iwPJJLXMQHHEAId/mhfXSEmU3vLb7iA83iQz51PsQucVcuRvJ
	nKlLWbgVRmBEu8XgZ8WDi7gFq48IQXGW0STewepwtHpOK/HXHQbsIWPNoGohC3bKCLOXwz
	tLHUvvF7u4Fl1M86s7lPCdKhBXOm//c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVmkqWYR5zkUXobDHytjmMtNOMuOXDKEtLniUXb9R9k=;
	b=oZYjB72qpHPKPZtT0Eqblw5Sxr/PSP5ZIQXkwz1Pm+HxBt9uE/j4KwblJu16SRwtpYb7la
	y99mcyubii96spCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3ECE137D2;
	Mon, 12 May 2025 17:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 98P2Lj0uImhxcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:22:05 +0000
Date: Mon, 12 May 2025 19:21:56 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix harmless race getting delayed ref head count
 when running delayed refs
Message-ID: <20250512172156.GO9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <13e40ba1be5f87e2b79275f58f4defe11e6bd62d.1747050634.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e40ba1be5f87e2b79275f58f4defe11e6bd62d.1747050634.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E26D821184
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Action: no action

On Mon, May 12, 2025 at 12:51:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running delayed references we are reading the number of ready delayed
> ref heads without taking any lock which can make KCSAN report a race since
> we can have concurrent tasks updating that number, such as for example
> when freeing a tree block which will end up decrementing that counter or
> when adding a new delayed ref while COWing a tree block which will
> increment that counter.
> 
> This is a harmless race since running one more or one less delayed ref
> head doesn't result in any problem, in the critical section of a
> transaction commit we always run any remaining delayed refs and at that
> point no one can create more.
> 
> So fix this harmless race by annotating the read with data_race().
> 
> Reported-by: cen zhang <zzzccc427@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAFRLqsUCLMz0hY-GaPj1Z=fhkgRHjxVXHZ8kz0PvkFN0b=8L2Q@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

