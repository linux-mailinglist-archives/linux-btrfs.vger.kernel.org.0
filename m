Return-Path: <linux-btrfs+bounces-9915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A759D9A99
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA81B244AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0B1D6DBC;
	Tue, 26 Nov 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="loPOIVvE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BU4H/zto";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="loPOIVvE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BU4H/zto"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82821D63C3;
	Tue, 26 Nov 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635862; cv=none; b=BCJFY2cKK3z5drzHcci+rZkFx6cm+LVPcUdZYaTf0s46wTVyzc/yvoLF/KhGjuaAhN9OBT+9sOWfnYjA7ne5mhIFXuq170f1vOpH61TK6ARvDI6C+Q9A2amkLdBk5eF8psFjoJHl4ttSTuvwReVqbK2Y+oxc3rHTu3WuO38A7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635862; c=relaxed/simple;
	bh=dV0BEZJ/fiejNnZb0FPDN9jZtJGMik4VX1qbNbpd/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTkD71BMd5ybHHt5S9RhVEbqtrhNSDH8VhmdYO94jMK8eD7NzCsXv+RtiTbOni2hSdj7E/WpNK8HPME9lGLBzSnu4vGv5OQYfeDvrLzp7igV2gwVE7L5O5eZzF6zgXymG6i3VzXcW5Yog35rKDLlPBeZkOGLGmH9Ep+yJIn36mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=loPOIVvE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BU4H/zto; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=loPOIVvE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BU4H/zto; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6A0E1F750;
	Tue, 26 Nov 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732635858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atQ1JLuzHbiSllcjUkI9N7vpjUs/iyWBVdUWMvFT+aU=;
	b=loPOIVvECIHZf2qZar1WBhELBbvsDiIZSUgHk1edhXl6es2DC0rWpIoGXQr9tmHVyMXsIc
	9cigwcBp5scU1bMECTdebLE0FDiZ48gKVlK+E1frBz1klwZlOYa2rc79v+0zuIvJGtvhwF
	Dj0YeBZc1oGWAoHVHWt60sOEde0ejXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732635858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atQ1JLuzHbiSllcjUkI9N7vpjUs/iyWBVdUWMvFT+aU=;
	b=BU4H/ztoPCT4G+Z+cJhfmUoRK6RrYNKwZ0Gwr8koLav29qv2xZ8qzA9TAz2WFVyDJQG16L
	LwtJUbZJT9zv8dDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=loPOIVvE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="BU4H/zto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732635858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atQ1JLuzHbiSllcjUkI9N7vpjUs/iyWBVdUWMvFT+aU=;
	b=loPOIVvECIHZf2qZar1WBhELBbvsDiIZSUgHk1edhXl6es2DC0rWpIoGXQr9tmHVyMXsIc
	9cigwcBp5scU1bMECTdebLE0FDiZ48gKVlK+E1frBz1klwZlOYa2rc79v+0zuIvJGtvhwF
	Dj0YeBZc1oGWAoHVHWt60sOEde0ejXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732635858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=atQ1JLuzHbiSllcjUkI9N7vpjUs/iyWBVdUWMvFT+aU=;
	b=BU4H/ztoPCT4G+Z+cJhfmUoRK6RrYNKwZ0Gwr8koLav29qv2xZ8qzA9TAz2WFVyDJQG16L
	LwtJUbZJT9zv8dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8743713890;
	Tue, 26 Nov 2024 15:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ojqfINLsRWcDEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 15:44:18 +0000
Date: Tue, 26 Nov 2024 16:44:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: send: remove redundant assignments to
 variable ret
Message-ID: <20241126154417.GH31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241113130012.1370782-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113130012.1370782-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A6A0E1F750
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Wed, Nov 13, 2024 at 01:00:12PM +0000, Colin Ian King wrote:
> The variable ret is being initialized to zero and also later
> re-assigned to zero. In both cases the assignment is redundant
> since the value is never read after the assignment and hence
> they can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Added to for-next, thanks.

