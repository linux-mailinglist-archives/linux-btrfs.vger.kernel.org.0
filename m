Return-Path: <linux-btrfs+bounces-15932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A585B1E771
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E7587CE7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010825A2DE;
	Fri,  8 Aug 2025 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gY2ySl2Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TQzUgrWq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0MYxIqjc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CfHCYOXf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6424DD00
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653052; cv=none; b=DwJMp+jOBd0lQt0CEmpkl9jqR4kR8XuaqhcwLDM+mzs0FT+icMFJYLu1fccPM4yPdBQplACmY8XIHKoPNico2k7z/ZYsxZy7REe7TW4YQ22n7/jz9/OqawLnJoCmgeZsxias6bWPL+o7sHXSPFqw34/HbmApnYDaSXrzeaKb+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653052; c=relaxed/simple;
	bh=qtJYL4tjWtVl/wN39WZ1Yly3NsHQP0tQrAGmIAkvidE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gII3a5zHTqthRr3bpWcnb6ImuYEjlB08dqd7BdEzzh2v9XGXXDniU5XXrxvxMA/FT4N5rcnycABIMLwgdflg7F8/Qm4H6FAYXLARV+QlHgG+5K58BH7jwHBrBOz742Uqc73SgurTgZoLSxAFUMh9rGWFc2CIoe+ugsb1+cdtLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gY2ySl2Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TQzUgrWq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0MYxIqjc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CfHCYOXf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE3F833E29;
	Fri,  8 Aug 2025 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754653048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnHXfeTzdD56oOOsL5zTUjy3brFNRYSN+JQdl3UbQ3I=;
	b=gY2ySl2YbOe3QCaofLnNvY6vJl9KpJeSvzpHfFlOBGmjTsz/tDzgflk1QONaEj3Qn5o5PR
	pa+HL15W4K3sCkElMIM0l4HgZ+DEMikhUpxrXuKqak4tpwSBkqfIqr9tPHJV2ZibeCq1w9
	EFEXkng/Tby+73Oq9VsbHjhB4DWlljs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754653048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnHXfeTzdD56oOOsL5zTUjy3brFNRYSN+JQdl3UbQ3I=;
	b=TQzUgrWqUtT6WxmfBrjljEC8wo9f6VGllU3BVKdgBs+/vurdCYlBy9j6/aymCuoCPGSum+
	pli50LBg7xIV/pAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754653047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnHXfeTzdD56oOOsL5zTUjy3brFNRYSN+JQdl3UbQ3I=;
	b=0MYxIqjciCI1Ic2nuAkHvZ0W1v9a3zvvLxt+wC/Ty/nDpkZj2lHahH6+VOIihbJJfzfjqs
	BYr3bNIM5f1MDCAk5lIxUKFNmTQCu6P5MCiNFRujg8fi9xI7uhmrczUJ5qPbLBFvH0AVrc
	ieBi/FSCde7odFChLXm69Q/bpn1jK3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754653047;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnHXfeTzdD56oOOsL5zTUjy3brFNRYSN+JQdl3UbQ3I=;
	b=CfHCYOXfLYbjzqan779ITFw7ZOPJjOwKjEhYg5VrhRlpOi8zb5kJBOYtstRTgpfDE6J85h
	6xdwjC7QD1GWauCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95BD91392A;
	Fri,  8 Aug 2025 11:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8xpkJHfhlWi/fgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 08 Aug 2025 11:37:27 +0000
Date: Fri, 8 Aug 2025 13:37:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: detect discard ability more correctly for
 btrfs_prepare_device()
Message-ID: <20250808113726.GS6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fb9da17fe4943acda28cdacc690400cf5bc08e49.1754522337.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9da17fe4943acda28cdacc690400cf5bc08e49.1754522337.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 07, 2025 at 08:49:12AM +0930, Qu Wenruo wrote:
> Instead of relying on sysfs interface which had some regression
> reporting the discard support, let btrfs_prepare_device() to use the
> discard_range() result to determine if we need to output the "Performing
> full device TRIM" message.
> 
> This is done by checking if the first discard succeeded or not.
> If the first discard call succeeded, then we know the device support
> discard and should output the message.
> 
> And to reduce the initial delay before outputting the message (old/lower
> end disks may take a long time even discarding 1 GiB), reduce the initial
> discard range to 1MiB.
> 
> By this it's more reliable to detect discard support for
> btrfs_prepare_device() and we can get rid of discard_supported(), and
> the timing of the meessage should still be pretty much the same as the
> original one, just with a small unobservable delay.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Ok, please add the patch to devel, thanks.

