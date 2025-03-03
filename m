Return-Path: <linux-btrfs+bounces-11975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3EBA4BA92
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438C63A8DC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFF71F0E3A;
	Mon,  3 Mar 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="voPIthnr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q/dAJvD6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yNZgPbBR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rr+8xZ9I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF771F0E2B
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993306; cv=none; b=QEunAzuaLZt7twm1Sm6nA+EWeSG17gGMCRS12bKJQp8/Q2CLoPY0M4VadwTn4J4hVH0yyc2ZffhU+Og5mXi2zVazLG5v+TjgMt4vfWeQNvHnOBkaBB8BbGambRQjc7YyNOPlhwyvXv8bpcYgV3sk+Q3rQsz0PCKa9TUJWuJBsG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993306; c=relaxed/simple;
	bh=Yt/OPT7sf4IDpKCGP2Axlk56Yw+a6vCMvgC7694aquw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZJn7+oTlA3tp9Ga6c2tlQKdoZw6Bpj5Kb9kDn2b65SHu2IXTlVnjd2oy0GFIulBtaFGJab7S4Fp6K8i9US7zlWk+KaILTWP3vNhbgbPbpUB0HPfzcDSszCL5lepbnU5pGtJn6M+TZ6xJw0updWifC8OByAZ8jPRc/+avTPm6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=voPIthnr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q/dAJvD6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yNZgPbBR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rr+8xZ9I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9DA62117D;
	Mon,  3 Mar 2025 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740993303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1cKBa7QKnEiaGTeaCOm7FTxnwDbQMNv52rwrKkoEs=;
	b=voPIthnrGmFjEr3BhncF0yKLQ3Sm9xZkzvg82jnOUKlB2m1XS1590qbPU+t146I4Tg8Yr5
	9LEr64VTTevCTUt55RT18BGwSksfn6eHNNckSZIxzdQr0JOwoG/T8c7MNckWwcL87JnBP/
	Xx3qw/sMvI3ajdbWVLdSiOLWEqycz2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740993303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1cKBa7QKnEiaGTeaCOm7FTxnwDbQMNv52rwrKkoEs=;
	b=q/dAJvD6YP1yHEKpFhe7SleoMC9rYhjVgSEz0pS5tTwePf6KGtkWHMcpZ2KG5zX6Gl9oje
	hRPPf7na7OHD27BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yNZgPbBR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rr+8xZ9I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740993301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1cKBa7QKnEiaGTeaCOm7FTxnwDbQMNv52rwrKkoEs=;
	b=yNZgPbBRm1WFIq2qKOvv3XaVjG6AX4m0F3hEbGm4qFxMt1MmuBmFa4hDZXm7hai+hf2ov8
	PwnT8sJ5JRLkSnVWw3A5JT3EHnmRbQ2laq/bYk9Afm6daC/LNkiim3GWE0mVpMN+7ThtH4
	PyOFMqCgEVfOB5IxnMh6/P+W4+owYzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740993301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FL1cKBa7QKnEiaGTeaCOm7FTxnwDbQMNv52rwrKkoEs=;
	b=Rr+8xZ9Is2J3s8TCMwedE1thVg8A7KognRhZc4Itb9LL9y00qwXYnvZ4s5HU5JKt6zpGxN
	PCp3015hYELs1JDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA15B13A23;
	Mon,  3 Mar 2025 09:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lUoJNRVzxWclfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Mar 2025 09:15:01 +0000
Date: Mon, 3 Mar 2025 10:14:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250303091456.GW5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250122122459.1148668-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122122459.1148668-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E9DA62117D
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 22, 2025 at 12:21:28PM +0000, Mark Harmstone wrote:
> Currently btrfs_get_free_objectid() uses a mutex to protect
> free_objectid; I'm guessing this was because of the inode cache that we
> used to have. The inode cache is no more, so simplify things by
> replacing it with an atomic.
> 
> There's no issues with ordering: free_objectid gets set to an initial
> value, then calls to btrfs_get_free_objectid() return a monotonically
> increasing value.
> 
> This change means that btrfs_get_free_objectid() will no longer
> potentially sleep, which was a blocker for adding a non-blocking mode
> for inode and subvol creation.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

As we've discussed the idea of atomic_t for inode and agreed this is ok,
if you want to get this patch merged please summarize the outcome of the
dicussion and resend. This is still possible to get to 6.15 (during this
week).

