Return-Path: <linux-btrfs+bounces-12892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7760A81874
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C51BC18C3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A962561B9;
	Tue,  8 Apr 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/eI/1Tx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uz+h5wv9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwMjlGII";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gZ8UCkQu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B111255E30
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151002; cv=none; b=EMleyzT4OPSBxTqmJ4q2jkqN8KBVdAeyUd6u99R4lYl+WSmsgBHekAUdHf0Da/B1DionsrDXMqNULWQESAqXnkJj1L4ht/MiZRvV4zZDM7B3IYKGB32FpOueZ/Di2IjlxQILfkpieI6rd1mK0lipY35PFZtNobJ+a6ac74kl3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151002; c=relaxed/simple;
	bh=jWnVkPDpycRlfn20lBqerAUyjWJSz3Xt6jJEFXsvEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9cbruhc0ny3Cy9KLcIj3niMNZik8QVHgDkKsnnbtGW1nyejteJ4KYRYgLCYqRViFCCmpK8fuOtC5hK/MGH2f1lTlt+m22wulMPEUGpyOAUotp3RMwSbKrfRe3mamGnedxT0cXZF+6KGfowguX+xjVwAbs5TA5QQE6uFyZ1b+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/eI/1Tx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uz+h5wv9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwMjlGII; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gZ8UCkQu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1FE81F388;
	Tue,  8 Apr 2025 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744150998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QocgbBGJQv6mDouX8da7CkNPhKfIh8AXkCQpA8EXGJA=;
	b=h/eI/1TxweL98iyGDxaRL15Yrvlknd4/Wva5odeG6ygwaBIP28DtmjreiCAjPOK1VuAMsX
	0wEknQryy0AntLLEvshr5lct3pR6rxDcobYxFG5x5ZS063TqJw54b9MzaGfhDAggYHJ2Do
	ix7fULYr3rCHr0CEM5GFatSzj6kQPAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744150998;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QocgbBGJQv6mDouX8da7CkNPhKfIh8AXkCQpA8EXGJA=;
	b=uz+h5wv9e0xFWXAuv5F2r/ZsqfR4y0KaHlDLaIlxjS3tbcw0yg01q2IMYd+8o4Ac64ZucV
	Gog4zEEO1l0dYIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744150997;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QocgbBGJQv6mDouX8da7CkNPhKfIh8AXkCQpA8EXGJA=;
	b=DwMjlGIIYkI0LjBdM3A8rXWzbnAHzZ0kqmVdCiIYUr77S4i+8XpxqOuEBbw2MXUOcGwdFt
	DXAFs+vYQ/9agtDgMbgrwZDbRcx/NRlTZvXQjffDhaDilGFO0jt3hoEfCyeP0oc0x7Sb8I
	bnMFrBFd4YRZyTsTZQTq4Jz+M6M+a5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744150997;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QocgbBGJQv6mDouX8da7CkNPhKfIh8AXkCQpA8EXGJA=;
	b=gZ8UCkQuisRzFCWgAHVMkthYy3Q7ZmFxDxn9yrFnVux49RgnUqH46BOwUznC7vdaPGJpUH
	hoyDuvt21Rr9suDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DE3D13A1E;
	Tue,  8 Apr 2025 22:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytjQJdWh9Wd3SQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Apr 2025 22:23:17 +0000
Date: Wed, 9 Apr 2025 00:23:12 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: rename a few tracepoints and remove unused
 ones
Message-ID: <20250408222312.GC13292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744124799.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744124799.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 08, 2025 at 04:09:42PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple trivial changes related to tracepoints.
> Details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: tracepoints: add btrfs prefix to names where it's missing
>   btrfs: tracepoints: remove no longer used tracepoints for eb locking

Reviewed-by: David Sterba <dsterba@suse.com>

