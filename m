Return-Path: <linux-btrfs+bounces-19884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F32CCE78C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C99301895A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 04:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB857285CB9;
	Fri, 19 Dec 2025 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pYyUlSZP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q/bcX7CV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="twrITjK+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t+9FcmIY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3220B212
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766119903; cv=none; b=PI8QFjwyBrHBY4ywlOH8xnQQBzKLHNWhnD47rLBuoQbHmnMcCQCy3PUQmR64iBK8+UEI3q9CalKWLJ4GjId46Y+pCvXaoGYnoB3Ll1TumwHMOH+neT7+cgYT73xZiMUERHPgEOoauATPizq4ANu4Gr9DTEc+g1LbAlSkjN7LqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766119903; c=relaxed/simple;
	bh=oeJGmG33W6ktlwNCjhuOsTbf7P3SBKanu3vMJStKrPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiqXhuvQodYSXbJyRb37ZByOF0mAh74mKGv2A37N9FNdBPZRu+uC8WHfhkqMP+8G1D7mxvM0CqrbvsnYXJeuM1TZAC4z7eFA5MCFZGZe7meMUUtOIz6Ih2tzxiPnkBSm+Vfm1EBn4uz1Ji8YvvuSxR8weyYbgKqN4qQN8vuO71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pYyUlSZP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q/bcX7CV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=twrITjK+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t+9FcmIY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37C015BD05;
	Fri, 19 Dec 2025 04:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766119899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdJ/0kXsy2UarZzr+GTIpWi9ZRF4BQ4mDf0slnumfYk=;
	b=pYyUlSZPamQaHUUw+Djuowg/IjfG1Q7na+CEQuOD/PKE9E32zQVV4AKNJzXk63ADp8CLBL
	QlBb+toai7TvoQttzrGoD6wwXEoovRfivqBxyMudNhIcMHqAi4EwmPwVKQ/4/NJ4gFBnxX
	l9Pcd8zxqLvpfUURtLnAfudJZfceE0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766119899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdJ/0kXsy2UarZzr+GTIpWi9ZRF4BQ4mDf0slnumfYk=;
	b=q/bcX7CVl6Umx1F+y2oWSIbgcRJSnWzVCZRxPlPS46yzVbr9E7amEpaoX4jMbNxUhZCVCN
	kq6h6aWp0leFm9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766119898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdJ/0kXsy2UarZzr+GTIpWi9ZRF4BQ4mDf0slnumfYk=;
	b=twrITjK+KXJ5lA0EaJChIO5gsz4O3ZNeY0OojIvjo6PcIkGPICfNCFI/4mk6dmKFr12EfQ
	QedxhSi9V6LfHYWXmrz4mBmYIWtaFYBeETE/rfNFF1nW9e6V+h7Oy+8+io78squMmS4i5p
	w/DHBA6ryZ3sSgkmfUu1eM4qXPFj690=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766119898;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdJ/0kXsy2UarZzr+GTIpWi9ZRF4BQ4mDf0slnumfYk=;
	b=t+9FcmIYDFZrssXqDiwFH68HfccOXWUGHcp8Ffo1Mk15H7d+Zz4qxvHULEPwWg2lo77qWW
	rTVEVRIc7TJ5uIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1784B3EA63;
	Fri, 19 Dec 2025 04:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rSLBdrZRGkQVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 04:51:38 +0000
Date: Fri, 19 Dec 2025 05:51:21 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tag as unlikely error conditions in the
 transaction commit path
Message-ID: <20251219045121.GB3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bb3d28f50f56238ef6d8db65ddce28d1f53009d4.1765977733.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3d28f50f56238ef6d8db65ddce28d1f53009d4.1765977733.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.92 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.12)[-0.609];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.92

On Wed, Dec 17, 2025 at 01:22:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Errors are unexpected during the transaction commit path, and when they
> happen we abort the transaction (by calling cleanup_transaction() under
> the label 'cleanup_transaction' in btrfs_commit_transaction()). So mark
> every error check in the transaction commit path as unlikely, to hint the
> compiler so that it can possibly generate better code, and make it clear
> for a reader about being unexpected.
> 
> On a x86_84 box using gcc 14.2.0-19 from Debian, this resulted in a slight
> reduction of the module's text size.
> 
> Before:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1939476	 172568	  15592	2127636	 207714	fs/btrfs/btrfs.ko
> 
> After:
> 
>   $ size fs/btrfs/btrfs.ko
>      text	   data	    bss	    dec	    hex	filename
>   1939044	 172568	  15592	2127204	 207564	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

