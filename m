Return-Path: <linux-btrfs+bounces-12622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB14A73DAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 19:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B847A7165
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137621A424;
	Thu, 27 Mar 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4yBVWTc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tjo/luPP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4yBVWTc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tjo/luPP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA37219A8C
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098478; cv=none; b=VwzcJbZU7U/+lNOPqFZbGekA0UpsRcsFhcF7piR9lklyYbjNtrJcgoPhcrX5vgRagCssOcJuw5nEEGcTnwUKxURMXorYzDnfe3JJxN++JkaJRF7De7ItBwAJUnEN59NAjG6j7qpU65fjkqtD2HJKlHq6DdVXEG1iosw1aNwMNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098478; c=relaxed/simple;
	bh=9XVDcpXoJ+xePDCjY00uy0FFuFEQQC06l5AODpCVRb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMVIWKIAdleCoY+xpVB3LRlTDNRnTEJLRT/7v1BGUEdksbNGOaWYTwrY1PlsQekELPeLvYQ3OHwwI03JR0482OQoBuItuExTW7HFv54DOCXde77ZBrzOpB222hs9otHxdUjXNCm5BeCmgu42j7+tKOlajAMu6MBw0FHC2BPh57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4yBVWTc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tjo/luPP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4yBVWTc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tjo/luPP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CDD41F388;
	Thu, 27 Mar 2025 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743098474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbN7nLSiqMl3uJLnyWUt1hx+kzaqh9kL+fYGcX+5mOE=;
	b=c4yBVWTc0Nl1bXU5gEvA60sDoMlndPDzbMHYS5JLWBpcTNuPzfWT9MPcKTqax8R7S1iHE2
	KGEuMrKFRP1dS1yLf+bpKOWLB4GGlmmXS1SLoG3IHqKd2vG2mrnqLv/Z+iL6Eak2GviI2q
	baPhIJkPXcgz0f8ja4SDL3g7vEWfKMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743098474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbN7nLSiqMl3uJLnyWUt1hx+kzaqh9kL+fYGcX+5mOE=;
	b=Tjo/luPPTUragqdFlWcKPQCyiJmoQG3vdhcuHogv78B5NHPouT9Ug5zkojMMEaTh3D3Gm7
	FGiH8kax8xEA36AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c4yBVWTc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Tjo/luPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743098474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbN7nLSiqMl3uJLnyWUt1hx+kzaqh9kL+fYGcX+5mOE=;
	b=c4yBVWTc0Nl1bXU5gEvA60sDoMlndPDzbMHYS5JLWBpcTNuPzfWT9MPcKTqax8R7S1iHE2
	KGEuMrKFRP1dS1yLf+bpKOWLB4GGlmmXS1SLoG3IHqKd2vG2mrnqLv/Z+iL6Eak2GviI2q
	baPhIJkPXcgz0f8ja4SDL3g7vEWfKMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743098474;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbN7nLSiqMl3uJLnyWUt1hx+kzaqh9kL+fYGcX+5mOE=;
	b=Tjo/luPPTUragqdFlWcKPQCyiJmoQG3vdhcuHogv78B5NHPouT9Ug5zkojMMEaTh3D3Gm7
	FGiH8kax8xEA36AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A608139D4;
	Thu, 27 Mar 2025 18:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O7GOIWqS5WeyJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 18:01:14 +0000
Date: Thu, 27 Mar 2025 19:01:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Message-ID: <20250327180113.GA32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250318095440.436685-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318095440.436685-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9CDD41F388
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> This flag is set after inserting the eb to the buffer tree and cleared on
> it's removal. But it does not bring any added value. Just kill it for good.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Added to for-next with the updated changelog, thanks.

