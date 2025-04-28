Return-Path: <linux-btrfs+bounces-13466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA8A9F3DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D027A32EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AFF26FD82;
	Mon, 28 Apr 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVpO6QOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1o0REJn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVpO6QOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1o0REJn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124AA25228B
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852022; cv=none; b=onzSenZj6uKmXIPlKDC1Hrp9S5w5E4c5SH+1g8IH1fZskFVnx+R7gt8wPwb+Mu+1tE8tRt0Vmb5LACUNhbwW4Mu17ZsprxcJZHkK7BT1lJGvkUoYlWePVILl+IaaZzioLocBMLzjpW7PnW9MO59y0e85E5/vuH7SC28lE8wK80w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852022; c=relaxed/simple;
	bh=JxlQcYfB4JkkwOMMshHxgSB0Kp8XfqN5F2JOn0sDpow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnbaSg1sf5/QwZh1mwC/MEXJ7RuJH0Q1811jeVqj7O6eo/ZY+i7OX+3Zsd2t8nyAJC+WSt3okDurJsjJk9ybRhsILWIg+BAcJ12wZFiDKU6IMCIGwDyyPF9zd16d+3Qd7w+j3oUFtuZ3Wbrk5uTIF1pNFTmsdneoTl3MvYuVLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVpO6QOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1o0REJn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVpO6QOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1o0REJn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10977211EA;
	Mon, 28 Apr 2025 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo+zlJv77MAghdEhC5AbNoIzuGUhMmD4Iq0UW6FYePI=;
	b=RVpO6QOF6tX7uh2U9KBh1BMVKJEHf6Tc9Gju3YXwxMIHwy4gg2wII6HI7V0Nxkb8aDcDoh
	/2nFtT4mCoCChUUsxtdloa4pY9oh/gVqACTSkWmkd1DMAcN4mgLsO1ZQX4hA+Y+Za+ysdY
	snqJmeyxTzfjz9DJv5RA2t/oSh3xUwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo+zlJv77MAghdEhC5AbNoIzuGUhMmD4Iq0UW6FYePI=;
	b=D1o0REJnTftnA6uJZMrJAUKUPbt+bo9YiA3NjojPG8OHNo9pYpANXKQhF1q1qRZiqLuQiV
	iUMzCfZjBwuJYKAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RVpO6QOF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D1o0REJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo+zlJv77MAghdEhC5AbNoIzuGUhMmD4Iq0UW6FYePI=;
	b=RVpO6QOF6tX7uh2U9KBh1BMVKJEHf6Tc9Gju3YXwxMIHwy4gg2wII6HI7V0Nxkb8aDcDoh
	/2nFtT4mCoCChUUsxtdloa4pY9oh/gVqACTSkWmkd1DMAcN4mgLsO1ZQX4hA+Y+Za+ysdY
	snqJmeyxTzfjz9DJv5RA2t/oSh3xUwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo+zlJv77MAghdEhC5AbNoIzuGUhMmD4Iq0UW6FYePI=;
	b=D1o0REJnTftnA6uJZMrJAUKUPbt+bo9YiA3NjojPG8OHNo9pYpANXKQhF1q1qRZiqLuQiV
	iUMzCfZjBwuJYKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8ABD13A25;
	Mon, 28 Apr 2025 14:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rmmSOHKWD2jHfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 28 Apr 2025 14:53:38 +0000
Date: Mon, 28 Apr 2025 16:53:37 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/22] btrfs: some io tree optimizations and cleanups
Message-ID: <20250428145337.GB7139@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 10977211EA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 03:19:40PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> An assorted set of optimizations and cleanups related to io trees.
> Details in the change logs.
> 
> Filipe Manana (22):
>   btrfs: remove duplicate error check at btrfs_clear_extent_bit_changeset()
>   btrfs: exit after state split error at btrfs_clear_extent_bit_changeset()
>   btrfs: add missing error return to btrfs_clear_extent_bit_changeset()
>   btrfs: use bools for local variables at btrfs_clear_extent_bit_changeset()
>   btrfs: avoid extra tree search at btrfs_clear_extent_bit_changeset()
>   btrfs: simplify last record detection at btrfs_clear_extent_bit_changeset()
>   btrfs: remove duplicate error check at btrfs_convert_extent_bit()
>   btrfs: exit after state split error at btrfs_convert_extent_bit()
>   btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
>   btrfs: avoid unnecessary next node searches when clearing bits from extent range
>   btrfs: avoid repeated extent state processing when converting extent bits
>   btrfs: avoid researching tree when converting bits in an extent range
>   btrfs: simplify last record detection at btrfs_convert_extent_bit()
>   btrfs: exit after state insertion failure at set_extent_bit()
>   btrfs: exit after state split error at set_extent_bit()
>   btrfs: simplify last record detection at set_extent_bit()
>   btrfs: avoid repeated extent state processing when setting extent bits
>   btrfs: avoid researching tree when setting bits in an extent range
>   btrfs: remove unnecessary NULL checks before freeing extent state
>   btrfs: don't BUG_ON() when unpinning extents during transaction commit
>   btrfs: remove variable to track trimmed bytes at btrfs_finish_extent_commit()
>   btrfs: make extent unpinning more efficient when committing transaction

Reviewed-by: David Sterba <dsterba@suse.com>

