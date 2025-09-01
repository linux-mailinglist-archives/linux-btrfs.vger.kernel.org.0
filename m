Return-Path: <linux-btrfs+bounces-16566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FBEB3EE8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 21:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC39C484F44
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11332ED47;
	Mon,  1 Sep 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ohVYjYyX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rP7qM9jg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ohVYjYyX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rP7qM9jg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3532ED2D
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755740; cv=none; b=oKcZRAdWBGnCFhvdw+sXme0Wzi74/LF3DI1Uiq6y/D5zc1dyiTvexgiqykKosUCG7p2HyYZ8z2ZrehmgKtCkjupxeIdWY7mevj/Od/YjRyT2SG1Y1d5MsI/QblCrimOBdMeWHCFBzpALuuKfnqy7SuOHetmfjkOk0Ifb6EfwQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755740; c=relaxed/simple;
	bh=ZULjEP4wPmnLlP52Q74L9hpN0R/J3NtJdFxzS7CO8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPVIKEokwJfqHxn4/EMsd052bMlhNDDhx55jFP8fMWtPxaUJw7igV7PmZrQpzLBAiNoF2mbsptsaKgbyS07cNZ7W0CWVVe4PCjD0iB9ApIy6DerizC/7vuCAb7RhPsm4kcsSQJKpKHFmHpVS/ZskaBIpe//iHLtBQw05BpbT9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ohVYjYyX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rP7qM9jg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ohVYjYyX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rP7qM9jg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3FD211C9;
	Mon,  1 Sep 2025 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756755736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9I8Bci2kmrkA6sH9Cg5w6kJmECHIACLmH3gwZq85Fk=;
	b=ohVYjYyXb5l4mYcpUTXNZVFnAmNkfimr1owSu6YrrZRtBMa0Ye2pAt5Gjc7da+9DZpVHUd
	0kA3UOPQo9ACYQVOO8ifmAfGVwFSfHOLHJhJq0e4yMyKuuwh/KTWO7t6W9TzvNc7q6OSgc
	MC50JrtggupMq1Ul9py3l/ZyIyMkxyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756755736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9I8Bci2kmrkA6sH9Cg5w6kJmECHIACLmH3gwZq85Fk=;
	b=rP7qM9jgttE132LYw7pKOG/wWnMIZ/OiPpIEnRwPKO5ZW3UMycgThiKeOHK6u2Czzz/PV+
	mWxfR25mZnTfEvCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ohVYjYyX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rP7qM9jg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756755736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9I8Bci2kmrkA6sH9Cg5w6kJmECHIACLmH3gwZq85Fk=;
	b=ohVYjYyXb5l4mYcpUTXNZVFnAmNkfimr1owSu6YrrZRtBMa0Ye2pAt5Gjc7da+9DZpVHUd
	0kA3UOPQo9ACYQVOO8ifmAfGVwFSfHOLHJhJq0e4yMyKuuwh/KTWO7t6W9TzvNc7q6OSgc
	MC50JrtggupMq1Ul9py3l/ZyIyMkxyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756755736;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9I8Bci2kmrkA6sH9Cg5w6kJmECHIACLmH3gwZq85Fk=;
	b=rP7qM9jgttE132LYw7pKOG/wWnMIZ/OiPpIEnRwPKO5ZW3UMycgThiKeOHK6u2Czzz/PV+
	mWxfR25mZnTfEvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A4151378C;
	Mon,  1 Sep 2025 19:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aoEHAhj3tWimKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Sep 2025 19:42:16 +0000
Date: Mon, 1 Sep 2025 21:42:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: replace max_t()/min_t() with clamp_t() in
 scrub_throttle_dev_io()
Message-ID: <20250901194214.GE5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250901150144.227149-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901150144.227149-2-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1A3FD211C9
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
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, Sep 01, 2025 at 05:01:44PM +0200, Thorsten Blum wrote:
> Replace max_t() followed by min_t() with a single clamp_t(). Manually
> casting 'bwlimit / (16 * 1024 * 1024)' to u32 is also redundant when
> using max_t(u32,,) or clamp_t(u32,,) and can be removed.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Added to for-next, thanks.

