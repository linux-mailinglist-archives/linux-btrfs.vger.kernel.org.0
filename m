Return-Path: <linux-btrfs+bounces-6918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DA9433DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A0286243
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221301BBBFC;
	Wed, 31 Jul 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYlY8ivd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/V3faE4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iYlY8ivd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/V3faE4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8F1CAA9
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442053; cv=none; b=SZmB0fVW0KHC1ffEnz7n2ch+3AmHDr64TSs0gYrsUnIjAFKpeaku6lYAPjcl0H7hsTXisl4EsA8i5je2Sc6B4tVJGR26V95MupDLQOKusRSnpz0osLT9sHIvOjGVU3MAhOZ2eI3UxzuF6VexQ+ZOElv4llfvo0t0MyyyZ7XyWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442053; c=relaxed/simple;
	bh=cA1rq/WgF8K1nIssWn1Y6eaqlTFH8dhvNvYDE5c/9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/1CJJL/+5j7iVdM5oQX65kIwX3M27EPvOWzrJGAsCDe8JdfAZDBSax0hvIY1YAA+XXLJQDu9csKnv4lbhZBF5sLMGJ/LIZdSnTapZ0ShIAOOTNp4YgNiG9srbu61tYgEsafsQDDj5ClGCwXHI3auxFTZ3y/QKT+BgnS7QRJdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYlY8ivd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/V3faE4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iYlY8ivd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/V3faE4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A5A221A70;
	Wed, 31 Jul 2024 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722442034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUjPwdIB3HA3igmDvvKmAtrL5b1qQenyQuWQHII12hk=;
	b=iYlY8ivd1+kQv30/v01ciFtonxZnr0TcTPgnc6mDP6RiSX7QjVvAS0CwiFdOsJkv4YJwLJ
	RHBhri5bblX78D8n5wx2DfCqpLA8mP3YM53IHg6Od2fM7JzLGyXte0hX4rAQnS6ZOhoMis
	JdsE/fk3YrRtjh0/jxAgC/tNK9jKyiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722442034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUjPwdIB3HA3igmDvvKmAtrL5b1qQenyQuWQHII12hk=;
	b=Z/V3faE4BNX8Ag1sSsA4t1xF0w4a1E2h6OU1Oj7nkLHoL0hLAF06uYE2MH95Rdx2TH/fdb
	cSis+9upU5eInmBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iYlY8ivd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Z/V3faE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722442034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUjPwdIB3HA3igmDvvKmAtrL5b1qQenyQuWQHII12hk=;
	b=iYlY8ivd1+kQv30/v01ciFtonxZnr0TcTPgnc6mDP6RiSX7QjVvAS0CwiFdOsJkv4YJwLJ
	RHBhri5bblX78D8n5wx2DfCqpLA8mP3YM53IHg6Od2fM7JzLGyXte0hX4rAQnS6ZOhoMis
	JdsE/fk3YrRtjh0/jxAgC/tNK9jKyiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722442034;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUjPwdIB3HA3igmDvvKmAtrL5b1qQenyQuWQHII12hk=;
	b=Z/V3faE4BNX8Ag1sSsA4t1xF0w4a1E2h6OU1Oj7nkLHoL0hLAF06uYE2MH95Rdx2TH/fdb
	cSis+9upU5eInmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69D1B1368F;
	Wed, 31 Jul 2024 16:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8hiWGTJhqmZBEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 16:07:14 +0000
Date: Wed, 31 Jul 2024 18:07:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Message-ID: <20240731160713.GR17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
 <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
 <20240729144150.GA3589837@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729144150.GA3589837@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 8A5A221A70

On Mon, Jul 29, 2024 at 10:41:50AM -0400, Josef Bacik wrote:
> On Mon, Jul 29, 2024 at 12:46:48PM +0100, Filipe Manana wrote:
> > On Mon, Jul 29, 2024 at 9:33 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> > What's this guard thing and why do we use it only here? We don't use
> > it anywhere else in btrfs' code base.
> > A quick search in the Documentation directory of the kernel and I
> > can't find anything there.
> > In the fs/ directory there's only two users of it.
> > 
> 
> It's relatively new, it's like the C++ guards.  If you look in the VFS we've
> started using it pretty heavily there.
> 
> But it does need to be documented, if you look at include/linux/cleanup.h it has
> documentation about it.
> 
> > Why not the usual spin_lock(&block_group->lock) call?
> 
> Because this is nice for error handling.  Here it doesn't look as helpful, but
> look at d842379313a2 ("fs: use guard for namespace_sem in statmount()") for an
> example of how much it cleans up the error paths.

I don't find this commit as a good example where guard improves things.
The code is factored to a helper do_statmount() and the guard is used as

	scoped_guard(rwsem_read, &lock)
		do_statmount();

With the rwsem this would be

	down_read(&lock);
	do_statmount();
	up_read(&lock);

> FWIW one of the tasks I have for one of our new people is to come through and
> utilize some of this new infrastructure to cleanup our error paths, so while it
> doesn't exist yet inside btrfs, I hope it gets used pretty liberally.  Thanks,

In some cases the guard() can improve the error handling, namely when
there are several branches and each of them ends with an unlock. But I
think this is rare.

The scoped_guard() can be useful more often but adds an indentation and
obscures that it's locking.

It can also make things worse when the scope is unnecessarily long,
covering function calls that don't need the protection but can take time
and keep the lock held. Like kfree(), "put structure" or similar cleanup
work.

