Return-Path: <linux-btrfs+bounces-13387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42597A9AC97
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC86441894
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD822A4E1;
	Thu, 24 Apr 2025 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6EdTVFZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwQcjzLk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6EdTVFZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iwQcjzLk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EC224B02
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495882; cv=none; b=uHBqNae9FMb8nB+ZIVWnRwi+P3ivRujVO8HFANiEbGse/TK/nX8+hFsRczkLDxXBfETf1izn08z8nw25bO6leEFc2LeXTeneMJe+0UuFP5G7nzUX2iAawvDVHkWN+UhrXoituQCLONPUBbO7PaHwSATv3upHW6gcQRVgSbwId7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495882; c=relaxed/simple;
	bh=qgbUBBfIhzlasJEeMV1oXbgIBjH0UgR5dY89tWz8d2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJgbW0XAo4AK1PSlmTOcq+lW3en9c7Aht9hOJDFEsramGl7FsQxZ4/1unXl93Vx7UScHVOHfgmrXiuxC0u+WGMI68sSYXtYGxFHQxdZfnE25KJsCygFREZOR3xbtQBxHiadvgE7xLtyvNuQ1KrjRUPqNe8NFeZY8n6fj8X2nTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6EdTVFZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwQcjzLk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6EdTVFZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iwQcjzLk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73F301F44E;
	Thu, 24 Apr 2025 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745495878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+0F6DVc0cgBLOl/GE6APhSwQgVMfO7uMPjrXlLfrww=;
	b=G6EdTVFZGUMmq/hfQFrws1MkYAel1p5YIRn9AOcHJqVpI+rrV5LMiLTTpalM9HBR8MQ/r4
	ogzJYklB5JFA+IfdaEnpPC9q8VOrJJaU1RPdFgeEE5Z/ttCDCkq8aPWql4LBG9fW7QxPrv
	tOMw8MPMrrdo5SeaFvSb53dG/aOsPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745495878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+0F6DVc0cgBLOl/GE6APhSwQgVMfO7uMPjrXlLfrww=;
	b=iwQcjzLkbgWLOxslGAMD/GOBK6DiCA2urQBBVQ3dlUvIMjF5DIsOaY0D/MkAEG6HcQFRSh
	BJWErjXkH3TA3UAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G6EdTVFZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iwQcjzLk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745495878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+0F6DVc0cgBLOl/GE6APhSwQgVMfO7uMPjrXlLfrww=;
	b=G6EdTVFZGUMmq/hfQFrws1MkYAel1p5YIRn9AOcHJqVpI+rrV5LMiLTTpalM9HBR8MQ/r4
	ogzJYklB5JFA+IfdaEnpPC9q8VOrJJaU1RPdFgeEE5Z/ttCDCkq8aPWql4LBG9fW7QxPrv
	tOMw8MPMrrdo5SeaFvSb53dG/aOsPo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745495878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+0F6DVc0cgBLOl/GE6APhSwQgVMfO7uMPjrXlLfrww=;
	b=iwQcjzLkbgWLOxslGAMD/GOBK6DiCA2urQBBVQ3dlUvIMjF5DIsOaY0D/MkAEG6HcQFRSh
	BJWErjXkH3TA3UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 566921393C;
	Thu, 24 Apr 2025 11:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KhviFEYnCmi3RAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Apr 2025 11:57:58 +0000
Date: Thu, 24 Apr 2025 13:57:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: unlock all extent buffer folios in failure case
Message-ID: <20250424115757.GM3659@suse.cz>
Reply-To: dsterba@suse.cz
References: <hd2uf7odgxxuadeym76nlsvsfxr5mvfveenaqv7rqwy2jyaan6@ts6gf2wpujsk>
 <6268df0f-e7a5-4b4f-84d0-082f5767f6d7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6268df0f-e7a5-4b4f-84d0-082f5767f6d7@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 73F301F44E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Apr 24, 2025 at 01:15:24PM +0200, Klara Modin wrote:
> 
> Hi,
> 
> On Tue, Apr 22, 2025 at 02:57:01PM +0200, Daniel Vacek wrote:
> > When attaching a folio fails, for example if another one is already mapped,
> > we need to unlock all newly allocated folios before putting them. And as a
> > consequence we do not need to flag the eb UNMAPPED anymore.
> > 
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> 
> I hit a null pointer dereference in next-20250424 which seems to point
> to this commit. Reverting it resolves the issue for me (did not bisect).

Thanks for the report, the patch has been removed from linux-next
branches.

