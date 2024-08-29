Return-Path: <linux-btrfs+bounces-7666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB4964D5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 20:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EAC1F2677A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00771B5EC6;
	Thu, 29 Aug 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhUMgeS/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZakMSjY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhUMgeS/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZakMSjY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1324B28
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954414; cv=none; b=bkehZfDsQSZ5w16JCV/GoAm+Jc/hlYYxFySYFfUJ1gNdWaZ0tkPcuIYX7SANKLVhdxlcXt22fFf+GE3u0ESNkAbxcFWt3pN6brZRC7FcUa2XLCnq5HwXswepLEzBmgpf632FBnXzCEssV9lHjyX3KlPhBInP2kpp+ZbSaIswhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954414; c=relaxed/simple;
	bh=rIz51INiGPyISCbOZEB5fOwt0nenZA4W6xPpCZqfiKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY+qutsmeA3tCl6imkyNVGI+lja4rBjvU9+a92WHvyTc7dGOd9Jo/x96MgQRhEXXe8K/8RoD7BJ+DReCpvEHSpyPYPxMrGx+A+zeLZC0wxpulexExSSnM8zN4eWNLfBVmbv7x4mFM9NE3HF9C20zIUAiziKiUBfaSgpgeHWA3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhUMgeS/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZakMSjY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhUMgeS/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZakMSjY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 131EB1FD13;
	Thu, 29 Aug 2024 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724954411;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL9ngkfQhZck0ypVxs7z3+s6iPWZ729pozMt8ygVyJc=;
	b=qhUMgeS/C8yVhaBN7tMNLTEMQAZyidF0YVRJjQe/ZOe3Q7eQH0iTBzSgN/7vtscS/LOC4E
	AnOq05mlIxrpeWDIe5lgEIyoWq6gPPoTXEHgeoonWKFteLCEQ7e8K3nLQUugtkd9wk5pur
	+hAz7vZg4C6gsnvAtPcrHpf6HBI0RmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724954411;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL9ngkfQhZck0ypVxs7z3+s6iPWZ729pozMt8ygVyJc=;
	b=sZakMSjY/MKsSn7fMP25u4kiQnbSo/EINTgp4AmGRT3ifUInNx2KtDxOwyVY1Pzdo0vfYu
	fxryixib28BY7sBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qhUMgeS/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sZakMSjY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724954411;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL9ngkfQhZck0ypVxs7z3+s6iPWZ729pozMt8ygVyJc=;
	b=qhUMgeS/C8yVhaBN7tMNLTEMQAZyidF0YVRJjQe/ZOe3Q7eQH0iTBzSgN/7vtscS/LOC4E
	AnOq05mlIxrpeWDIe5lgEIyoWq6gPPoTXEHgeoonWKFteLCEQ7e8K3nLQUugtkd9wk5pur
	+hAz7vZg4C6gsnvAtPcrHpf6HBI0RmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724954411;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hL9ngkfQhZck0ypVxs7z3+s6iPWZ729pozMt8ygVyJc=;
	b=sZakMSjY/MKsSn7fMP25u4kiQnbSo/EINTgp4AmGRT3ifUInNx2KtDxOwyVY1Pzdo0vfYu
	fxryixib28BY7sBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9B9B13408;
	Thu, 29 Aug 2024 18:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u5+TOCq30GbkFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 18:00:10 +0000
Date: Thu, 29 Aug 2024 20:00:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: reduce extent map lookup overhead for data
 write
Message-ID: <20240829180009.GP25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1723096922.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723096922.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 131EB1FD13
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Aug 08, 2024 at 03:35:58PM +0930, Qu Wenruo wrote:
> Unlike data read path, which use cached extent map to reduce overhead,
> data write path always do the extent map lookup no matter what.
> 
> So this patchset will improve the situation by:
> 
> - Move em_cached into bio_ctrl
>   Since the lifespan of them is the same, it's a perfect match.
> 
> - Make data write path to use bio_ctrl::em_cached
> 
> Unfortunately since my last relocation, I no longer have any dedicated
> storage attached to my VMs (my laptop only has one NVME slot, and my main
> workhorse aarch64 board only has one NVME attached either).
> 
> So no benchmark yet, and any extra benchmark would be very appreciated.
> 
> Qu Wenruo (2):
>   btrfs: introduce extent_map::em_cached member
>   btrfs: utilize cached extent map for data writeback

This looks like a good optimization, we're approaching code freeze (next
week) so it would be good to get it merged by then. As it's an
optimization we can also postpone it if you're busy with other things.

