Return-Path: <linux-btrfs+bounces-14316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD879AC9169
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3860161A3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C56231827;
	Fri, 30 May 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeoEXYNc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TH/uv43m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xeoEXYNc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TH/uv43m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53585231832
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614920; cv=none; b=c48FZXVcEwFpVyqPldKPuHRxvaxN9NLMMqPpkpwjrpCJBBqVHZHPESbGcW9D8d1vacD//Jqz/G0GNDKcTumyO4LBKQVyofziT4nOev74uTpNtXkHGlgrg9wg/KaKgKLHV2mJnuncO5Dg04CnVPlsA6rC6LD4UzPvBUrCI4Ei3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614920; c=relaxed/simple;
	bh=uMD+0w6riKLd+wdRL9HcSFHgqjKXAOaD+oByVU6KlPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru2TVivS8tLHKH8NpV38diDhGr8utLam89w5GCcFKI4esLuzDQkZCDBNWeKZw8sTnHmsbciv67wB4ptOIXx5isZG+nfNsmilKNA7vbnDL2HHzHwKjm8au9m8XdsxQc+H5ybQcFjoV9kTqzahCAWDmQ4VknE7QYQ+NIi3C/cNmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeoEXYNc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TH/uv43m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xeoEXYNc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TH/uv43m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40B5D1F911;
	Fri, 30 May 2025 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748614916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxbU5DLTWyX0pKoeVygZQZtCrrWv6MDpKeVhUaBvzho=;
	b=xeoEXYNcOaId1terdZzA7jVqbg5f3nCNHzLXn/P95uiITv7CbI7SNk+8tR/iGSlxC/e50s
	hi2bTHN+pavVB7JcXMv/yOZ/H7IajAH0XYCkujnmBmdu6QRLo5cv5fhn5Z5wTg60KylBGj
	U+47DCGziStnwo1MBrN4Mmw/qzO53xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748614916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxbU5DLTWyX0pKoeVygZQZtCrrWv6MDpKeVhUaBvzho=;
	b=TH/uv43mYKLwf1fCvWJndUuveVnI3TbwjpOtMvvE+JXs3uTZLDU7POUdbubZK6H4xaPWuX
	ncDjG3POtsd3ubDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xeoEXYNc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TH/uv43m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748614916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxbU5DLTWyX0pKoeVygZQZtCrrWv6MDpKeVhUaBvzho=;
	b=xeoEXYNcOaId1terdZzA7jVqbg5f3nCNHzLXn/P95uiITv7CbI7SNk+8tR/iGSlxC/e50s
	hi2bTHN+pavVB7JcXMv/yOZ/H7IajAH0XYCkujnmBmdu6QRLo5cv5fhn5Z5wTg60KylBGj
	U+47DCGziStnwo1MBrN4Mmw/qzO53xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748614916;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxbU5DLTWyX0pKoeVygZQZtCrrWv6MDpKeVhUaBvzho=;
	b=TH/uv43mYKLwf1fCvWJndUuveVnI3TbwjpOtMvvE+JXs3uTZLDU7POUdbubZK6H4xaPWuX
	ncDjG3POtsd3ubDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BFB13889;
	Fri, 30 May 2025 14:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ikKBBAS/OWgBRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 14:21:56 +0000
Date: Fri, 30 May 2025 16:21:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs-progs: zoned: create a data block-group for
 relocation
Message-ID: <20250530142150.GA4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3a53de9f92bb6e28f56b610509f5363e6726140d.1748604502.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a53de9f92bb6e28f56b610509f5363e6726140d.1748604502.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 40B5D1F911
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, May 30, 2025 at 01:29:26PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Create a second data block-group to be used for relocation, in case a
> zoned filesystem in created.
> 
> This second data block-group will then be picked up by the kernel as the
> default data relocation block-group on mount.
> 
> This ensures we always have a target to relocate good data to when we
> need to do garbage collection.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to devel, thanks.

