Return-Path: <linux-btrfs+bounces-15288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C3AFB330
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7BB189FA31
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54B29ACC8;
	Mon,  7 Jul 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGrzxtpS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0bsudfV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2P4dA5r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvDH2Zmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486528934F
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891171; cv=none; b=h3Apch75qd8ImaChXZH7u0o0jXQ/gNxnSkJDOnxzdeoLoew3GTUq8Rq+47QFZ6yfcU9xxTlkDzGH2+q4ENmlvyWs0CyLyhE7rUcEyvQKxgy4K5sNdCgS/8LDFFEF0MawuWJSfGWr4Ig5fUroMZLGaqtLZIj0ZJIfF4Zone7DPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891171; c=relaxed/simple;
	bh=MtwbZNkusVge86OhZq6ObsntJYLyRZCamOmfyOb5/RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB+CipiftQVwM6ooVtjuZmaTVji8szzK1EbA0FF3GKYjSMy9oUkjQZceuINC6zqusWxwQ45D6xMsmEgfc2qMZ/RNpXJRHUOMyL5AeVhU5FjWECx1+I1S6nBgBTTQrfvlig2o3YEs0A1n5QZLWz+jYFSzZbXU0oiXhTt35TJ8bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGrzxtpS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0bsudfV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2P4dA5r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvDH2Zmt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E82BE2116F;
	Mon,  7 Jul 2025 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751891167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el09SJSbZgf7s38ex0cgbSTrXQ7Mj/f166RbTgneE0o=;
	b=oGrzxtpSmJ0s+VI5YETPh881uGCUWROkXsZt7tVZ0ooR67kWnI4DH1bUF8fzOnaynltorE
	pL4bLxWio5bZG8viXC2u6zMzqo5jxHvOxkApNajMfpJiC6zvD7LAcdB46wVRC6LoNMYwrK
	0nVaN8VI61nj5ZoIxfOmXtZWDKflIjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751891167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el09SJSbZgf7s38ex0cgbSTrXQ7Mj/f166RbTgneE0o=;
	b=Q0bsudfVdaBHqEHmWkNrWqXQW+Lc0ZpoomiBHBrsB48S22halUkk1tDdGlwNLDWPngx2fr
	L3AVcB05fHVIcPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751891166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el09SJSbZgf7s38ex0cgbSTrXQ7Mj/f166RbTgneE0o=;
	b=P2P4dA5rPTWRoB+hMMfRS+mJaiYyrEGqa0zhxW04hSRXSlODAYxhIvrnXO2bHFknG9Q+jS
	1tBMfoSA9wXrdQi/4Wo7goC4JWNuIFBPOZwqRrU60Era5GRC/7C3/B85KFAMj8Hk5txF28
	zfR29EteM9G3NyEIL4eKABWo9og91E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751891166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el09SJSbZgf7s38ex0cgbSTrXQ7Mj/f166RbTgneE0o=;
	b=xvDH2Zmt1TLzXnTb2NYVHc4OvFaP6TPDGYieb/F1eE4WGYHw3hLg39wKVY36YXZ/2sdnkt
	lCkfE88vh9FbBYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C87FF13A5E;
	Mon,  7 Jul 2025 12:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vH/DMN68a2i+BQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 12:26:06 +0000
Date: Mon, 7 Jul 2025 14:25:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
Message-ID: <20250707122557.GD4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -8.00

On Mon, Jul 07, 2025 at 09:55:12AM +0930, Qu Wenruo wrote:
> [PROBLEM]
> There are some reports that btrfs is unable to be frozen if there is a
> running scrub.
> 
> [CAUSE]
> If there is a running scrub, freeze_super() will wait for the running
> scrub as read-write scrub is holding sb_start_write():
> 
>            Scrub process             |         Freeze process
> -------------------------------------+--------------------------------
> btrfs_ioctl_scrub()                  |
> |- mnt_want_write_file()             |
> |  |- sb_start_write()               |
> |     This will block freezing       |
> |                                    | freeze_super()
> |- mnt_drop_write_file()             | |
>                                      | |- sb_wait_write()
>                                      | |  This will wait for any
>                                      | |  sb_start_write() to finish
> 
> This means freeze_super() will wait for any running scrub to finish.
> The same applies to all ioctls that requires mnt_want_write_file().
> 
> The most common long running ones are scrub and balance.
> 
> Since scrub and balance can be very long running operations, this will
> cause freezing to timeout.
> And since freezing the fs is required before suspension/hibernation,
> this means those two operations will fail too.
> 
> [FIX]
> Check if the fs is being frozen, and if so cancel the current running
> scrub or balance.
> 
> So far I didn't find a better way to solve the problem, the only way to
> drop the mnt_want_write_file() is to finish or cancel the scrub/balance.
> 
> There is no way to drop the mnt_want_write_file() meanwhile just pausing
> scrub/balance, at least not for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> I'm not sure if cancelling is the best solution, but it is the easiest
> one to implementation.

I don't think it's a good solution to cancel the operations, in case of
scrub like the most likely to run during freezing it's possible to do
the pause, drop and continue after unfreezing.

I haven't looked how this could be done for balance, possibly in a
similar way. And for trim.

> Pause the scrub/balance is not really feasible yet, as it will still hold the
> mnt_want_write_file(), thus blocking freezing.
> 
> Meanwhile for end users, pausing scrub/balance when freezing, and resume
> when thawing should be the best outcome.

Pausing the operations and keeping the in-memory state is easiest from
the POV of restarting the operation. Restarting from that exact point
from user space would be harder as there's no complete information
communicated back and the tools are not saving it anywhere.

