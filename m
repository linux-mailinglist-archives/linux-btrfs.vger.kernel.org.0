Return-Path: <linux-btrfs+bounces-11048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC19A1ABEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7D4168F50
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2025 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0E1CAA7F;
	Thu, 23 Jan 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dCd+MD+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGXAyhTA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dCd+MD+B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGXAyhTA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B116EC19;
	Thu, 23 Jan 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667979; cv=none; b=R4DSqeobT5Tcg+TtxsoA1eRJNSBrlpcYd7odCTGSI0oOUgCSXPNVy8/jr3NxnGgTNLJPtKm71EUylwJnm+BXIMAvCMpKuBa6JveZrHE+uBFBBGJOgpBE1mdH/g9fsNdmF/o5ymU1wj7Wq0dqEzi2F3ETDca8Wvi5sEeE9iO4oNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667979; c=relaxed/simple;
	bh=RCiYPV6+4Y00tmS+wnEkC7Dz0HinWScQvMtPGx8vZME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTB5DjGHviaRE+dmRIUXKeSK106g8HGjV/W60FNL45RVNPpeCPBzJtJ2ZZmUiNDtB5xcpkfUznfcZTc5hmIlUeZvwzDD9D/VzjYDcTotWpsTl/bcH8i3KotFGsJvKn9VwyWvAi/7GNUvC9lBPB7BPM7CkcSGpe5CBqgut4t8zY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dCd+MD+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGXAyhTA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dCd+MD+B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGXAyhTA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5974F21172;
	Thu, 23 Jan 2025 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737667975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M92FNcMmTO49klCoBey9cGZIZPfRPbVB5TcmGuLarCA=;
	b=dCd+MD+B6fRNl6M2qZcRQnSWhkzCpfKmXUmdD1+6iKAcfMtU4K4ZQ9Hz/s9lWaXB4T0ed1
	OKFvUgqdFOEkYTSqVdGls3Cn3JKfaJhi49dWhvPRwl89DtIlScXXeuMHcLrrITa8XlkcQD
	G/b2O1Z5iXa4oEBlKGo8Liaz7Z3USCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737667975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M92FNcMmTO49klCoBey9cGZIZPfRPbVB5TcmGuLarCA=;
	b=KGXAyhTAGhrNcWgj6RYIk04AhAGVFYlKRhrZ8pDgD+i7FjM+lxlp4bd9tHSh5xcxPFFElg
	xu1K8fqeie/yYUDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dCd+MD+B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KGXAyhTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737667975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M92FNcMmTO49klCoBey9cGZIZPfRPbVB5TcmGuLarCA=;
	b=dCd+MD+B6fRNl6M2qZcRQnSWhkzCpfKmXUmdD1+6iKAcfMtU4K4ZQ9Hz/s9lWaXB4T0ed1
	OKFvUgqdFOEkYTSqVdGls3Cn3JKfaJhi49dWhvPRwl89DtIlScXXeuMHcLrrITa8XlkcQD
	G/b2O1Z5iXa4oEBlKGo8Liaz7Z3USCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737667975;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M92FNcMmTO49klCoBey9cGZIZPfRPbVB5TcmGuLarCA=;
	b=KGXAyhTAGhrNcWgj6RYIk04AhAGVFYlKRhrZ8pDgD+i7FjM+lxlp4bd9tHSh5xcxPFFElg
	xu1K8fqeie/yYUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E591136A1;
	Thu, 23 Jan 2025 21:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ecvOCoe1kmd3IAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 Jan 2025 21:32:55 +0000
Date: Thu, 23 Jan 2025 22:32:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Message-ID: <20250123213253.GM5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250115152458.3000892-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115152458.3000892-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5974F21172
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Jan 15, 2025 at 04:24:58PM +0100, Daniel Vacek wrote:
> Only allocate the `priv` struct from slab for asynchronous mode.
> 
> There's no need to allocate an object from slab in the synchronous mode. In
> such a case stack can be happily used as it used to be before 68d3b27e05c7
> ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> which was a preparation for the async mode.
> 
> While at it, fix the comment to reflect the atomic => refcount change in
> d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v2 reduces the patch only to functional changes as suggested by Johannes
> and Dave.

Added to for-next, thanks.

