Return-Path: <linux-btrfs+bounces-3876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F089717A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578E51C20803
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 13:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDC148826;
	Wed,  3 Apr 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZROkaKVV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MeK1dNqH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D091487FF
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152006; cv=none; b=CEPdiGVBcr5s57Jt/TaOgYFqg735t9VOrpR1EqJY2UEzklfnqfOmQHPsMCDqKdUb6p0guJNFTJwP0MgZI1WJs4vn7YyHg0vuZ9knnVvVserkv/Ach0YWLpiZ3GnLvUnUo0Iuypdj28h5VnHSnBp5hdFgbbRAnTVWKJlkhX/edsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152006; c=relaxed/simple;
	bh=MzK10fxOwjrS7RTIrVg51MZKTiQk3YGyzK8IsMhVE6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbZCCGJKgYNYcPDBmA1yoOURuc3R0wXP8ZFtUZrD6X1qCiulDtaCGwu7LaWfZNvE0z3fOmQ1H0UUIipS6k0lhWHshazgnDn0sM4xkE2xK/jgMsltJ74dG46S3RvSdvGXdH70sNzr7lfnYCM8XDMniIvTHMgTXGkxCQ9thzotesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZROkaKVV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MeK1dNqH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7770353CC;
	Wed,  3 Apr 2024 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712151995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/K5sd3rPPIFEN72AVAjqx9KhsbMQdnVI+ZbHHpmZ4E=;
	b=ZROkaKVVfWTcwxsrdc4fNb3CUvEw6qpxGz/3zvYxloutmTnGHoq59xmbvbxvbHoLr9GYZC
	CxSF1QFrWiYLvlDTKAOz6nqKwv8OPLrrRK32b4TCyCYiU0GmTk2Q7oLibA2idhlH9zoR2T
	IYOgChDsOcsFFtoRms1Coa/jhske3zU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712151995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/K5sd3rPPIFEN72AVAjqx9KhsbMQdnVI+ZbHHpmZ4E=;
	b=MeK1dNqHSv3gi1+8N4gNQal8shduXDe5jgM/TPucI1HZMDCpJ7GScCvUyiAlcvsu5EL1lr
	x0wv0yQrxWGy7PCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 98AB01331E;
	Wed,  3 Apr 2024 13:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PiLXJLtdDWZbUQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 03 Apr 2024 13:46:35 +0000
Date: Wed, 3 Apr 2024 15:39:14 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: remove some unused and pointless code
Message-ID: <20240403133914.GF14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712145320.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712145320.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A7770353CC
X-Spamd-Result: default: False [-2.49 / 50.00];
	BAYES_HAM(-2.51)[97.81%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.17)[-0.842];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -2.49
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Apr 03, 2024 at 01:05:45PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs. Trivial changes.
> 
> Filipe Manana (3):
>   btrfs: remove pointless return value assignment at btrfs_finish_one_ordered()
>   btrfs: remove list emptyness check at warn_about_uncommitted_trans()
>   btrfs: remove no longer used btrfs_clone_chunk_map()

Reviewed-by: David Sterba <dsterba@suse.com>

