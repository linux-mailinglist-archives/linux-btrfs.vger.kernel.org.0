Return-Path: <linux-btrfs+bounces-13398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21C9A9B6A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C2B3B5CE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB11F3BBE;
	Thu, 24 Apr 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIhOFWSG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0q79m1t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIhOFWSG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0q79m1t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681931A255C
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520340; cv=none; b=meGjCG8LJBbYF4Ib1Vs+pXRAc/UgGmx3UvZHEct+k0KSNU9GPa6v6llDwwhICz4gvrK8AghX4p4bwbek6APd1zoqLDKOy8rtaoIiyozInPoqxLf1mySscIdHzp88is0VkZpzbYaHGaZovhPTbkU8DWuubLNIxgGgHWpnhGI9VUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520340; c=relaxed/simple;
	bh=shfFawhGdTYZBfeROAUlh1GTeiiWBiQ4Dj6I9TP8V7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j67q53K7ZHHgh1MBUHcTjPrm6E0H2oqE0x8Bg0BoEuvU+PF+L57Vy2/rIZa0ZwvKrI5Qd+y1iXgyucwEzRh7tTA8+RhWaOMe466hQkAjGUsxtjKq1ijuxkC7pQHw9hbsqO1wuVaiUtq0gSjivBZrsu6TGc5JJ95VSSU0eCE1unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIhOFWSG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0q79m1t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIhOFWSG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0q79m1t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AB672117C;
	Thu, 24 Apr 2025 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745520336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shfFawhGdTYZBfeROAUlh1GTeiiWBiQ4Dj6I9TP8V7A=;
	b=yIhOFWSGPxMn4+8P6qbn78YLSUf6ZxE8acDWq2UL3qdkwaougdhi+CTDQWha6PaTQBJsh6
	Mi4GULKM1WXo5Dj2xy6lx+l8yNM7pEi1xRXn3Hwdgc30el+VyIu789G/k7DpNfM7ucLKz7
	anMoR7d5Iayj7FmbcYyqTyxPP7bQP+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745520336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shfFawhGdTYZBfeROAUlh1GTeiiWBiQ4Dj6I9TP8V7A=;
	b=a0q79m1tN5JzC5/LU7u1yVXLpkxg+B6IIKBQjp175mPV1IVATYV9fsFhQJUb24mY6CzY6j
	JxO4vI3BIRQWfXAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yIhOFWSG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a0q79m1t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745520336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shfFawhGdTYZBfeROAUlh1GTeiiWBiQ4Dj6I9TP8V7A=;
	b=yIhOFWSGPxMn4+8P6qbn78YLSUf6ZxE8acDWq2UL3qdkwaougdhi+CTDQWha6PaTQBJsh6
	Mi4GULKM1WXo5Dj2xy6lx+l8yNM7pEi1xRXn3Hwdgc30el+VyIu789G/k7DpNfM7ucLKz7
	anMoR7d5Iayj7FmbcYyqTyxPP7bQP+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745520336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shfFawhGdTYZBfeROAUlh1GTeiiWBiQ4Dj6I9TP8V7A=;
	b=a0q79m1tN5JzC5/LU7u1yVXLpkxg+B6IIKBQjp175mPV1IVATYV9fsFhQJUb24mY6CzY6j
	JxO4vI3BIRQWfXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A4AC139D0;
	Thu, 24 Apr 2025 18:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +sjxBdCGCmhqPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Apr 2025 18:45:36 +0000
Date: Thu, 24 Apr 2025 20:45:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: a small cleanup in attach_eb_folio_to_filemap()
Message-ID: <20250424184534.GN3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250423085123.4029320-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423085123.4029320-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3AB672117C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 10:51:22AM +0200, Daniel Vacek wrote:
> This is just a trivial change. The code looks a bit more readable this way, IMO.

Please be more descriptive in the changelogs, the subject and text is
too generic. Something like "move the initializations of folio to the
beginning of the retry loop". Otherwise agreed taht it's better this
way. I'll update the changelog when adding it to for-next. Thanks.

> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

