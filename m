Return-Path: <linux-btrfs+bounces-16910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F067B82621
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3263B7D8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB69155C88;
	Thu, 18 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWE1+iHC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="irLrXrsO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWE1+iHC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="irLrXrsO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468818DB26
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155638; cv=none; b=mjJajbZngM36cJuf6+QgRh5GGUAHz6OaZ3V9tpXmMcpNkbmajxOOIOEHutXBRwiOv3tDitxV8qvLUZYiMrWJeTzGif3jPsh8ZotI8Pz3Ybk4VU47HYAfqvkctbmJkDJanwoBxy1S9m40bIVh7z4pYSkL0wZ0qnaN8hxsIf5G5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155638; c=relaxed/simple;
	bh=SMXk1O2UaIXoPQuhUNIQh0KXhX4imt7+ZHGCJW99cvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBZfXOXzHSdzCDVPQeHMw5vvvt9e0oE0DD0VusNQ/78M0i0JqzzsrRusQjm1pk618CbKudj/LuxHAY3e9iCRPnlAG+ebdlAm04pHZvvycPPRflATUh0uqhvsdQxVsfQnyyqFVMXBGYnnvvmC/xmGr5/EL7suhxt3IYNBOdqsRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWE1+iHC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=irLrXrsO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWE1+iHC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=irLrXrsO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 096921FBB9;
	Thu, 18 Sep 2025 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758155634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Al0V2ZxaeP0Alz0tcxH/wf5lvNYz1IUQkL5koKUWJyU=;
	b=oWE1+iHCms4gWLGfUXWlXi6u+TGN1HKQlfqxZiyzRloJmeO4h5zCvX2raoxzStaJcwRH3A
	xs33gMQpG71KdRM6ywzS1gzsr16Dt49wjUSPzAFn9B42xVSWCK79nmphGHniRUCefWb5a2
	aXyrGrCDdGVelTzBFWa6BYhWMdXCvko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758155634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Al0V2ZxaeP0Alz0tcxH/wf5lvNYz1IUQkL5koKUWJyU=;
	b=irLrXrsOkSCm7nskehxssVwlR91mur7st93qKq6MdmoI8mgF+FAlollGZDab/Nk557A8UQ
	/Sx1hK6ZRBkaIeBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oWE1+iHC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=irLrXrsO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758155634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Al0V2ZxaeP0Alz0tcxH/wf5lvNYz1IUQkL5koKUWJyU=;
	b=oWE1+iHCms4gWLGfUXWlXi6u+TGN1HKQlfqxZiyzRloJmeO4h5zCvX2raoxzStaJcwRH3A
	xs33gMQpG71KdRM6ywzS1gzsr16Dt49wjUSPzAFn9B42xVSWCK79nmphGHniRUCefWb5a2
	aXyrGrCDdGVelTzBFWa6BYhWMdXCvko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758155634;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Al0V2ZxaeP0Alz0tcxH/wf5lvNYz1IUQkL5koKUWJyU=;
	b=irLrXrsOkSCm7nskehxssVwlR91mur7st93qKq6MdmoI8mgF+FAlollGZDab/Nk557A8UQ
	/Sx1hK6ZRBkaIeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12BC1368D;
	Thu, 18 Sep 2025 00:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /5GLNnFTy2jcOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Sep 2025 00:33:53 +0000
Date: Thu, 18 Sep 2025 02:33:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: Btrfs progs release 6.16.1
Message-ID: <20250918003344.GH5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250910175007.23176-1-dsterba@suse.com>
 <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 096921FBB9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Wed, Sep 17, 2025 at 04:41:43PM +0100, Filipe Manana wrote:
> With this btrfs-progs release, running 'btrfs check' fails on a
> filesystem created by an older mkfs.btrfs.

> A bisection points to:
> 
> commit e2cf6a03796b73d446b086022c0dfcf6a6552928
> Author: Mark Harmstone <maharmstone@fb.com>
> Date:   Fri Jul 18 15:26:27 2025 +0100
> 
>     btrfs-progs: use btrfs_lookup_block_group() in check_free_space_tree()

Thanks for the report, I'll do a release with this patch reverted unless
there's an updated fix.

