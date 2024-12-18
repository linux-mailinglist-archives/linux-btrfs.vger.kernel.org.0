Return-Path: <linux-btrfs+bounces-10589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17F9F6EF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA571889E57
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661911FC0EE;
	Wed, 18 Dec 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RJVlXYb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSHkXVYK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LaSPg/jE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wzRBKFXH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABB154BF5
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554171; cv=none; b=smpLBqeDQaJVM+7qocc11E13DvOJTnhpA011dlEbwSZMtGyUzQPYBkjznLE7sDUdcYvfjMFESi5mvsvmUkXlHkPV4JXosd9G/uyd0RSMgMfTr7LCw8klIpDxS5Glq9adQEBE3wWJrCapZjpnLbSeBAfgVs8NTjVJR0bNiDFjxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554171; c=relaxed/simple;
	bh=/UuGBEJqTaBcad+i1ye+p9c6LEFmqpUSsHbhfpMofn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDamSVdhqv/cK5KmyZEMKEnje/8iP7AQgzzS2ZXnL6U1dTvL1MjZRpQrFXuuBtfV7EJbXIagNWkLUSj2kj4IsDNiRK/fdoYARLNrMdL0oYmNVIlx+nCH4RgpC5udC3J7SgyQmPT/4ktFJZLoHSWNmN+dYdU8Hs0s0OovQZi9iAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RJVlXYb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSHkXVYK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LaSPg/jE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wzRBKFXH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85D861F397;
	Wed, 18 Dec 2024 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734554167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czpN6XBO7vmj/gerXXMs7+mydLCdEmFEt1B1dSHa/U8=;
	b=RJVlXYb7WYyENnmLOlnSCCbaF7MzsuvO7o1rhQhPeJM/JtX6sTxb9xJjzYvL4qbv86jX8i
	Enr/UnzVRbWee0Ce+zlGa04dPt24RSUdcIrxUXQjRhZzcs6esF0z4CAkSj/JnQqpM9eWr4
	0x6/JGw1wDOvyTsLskUxA+/TIwUxgwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734554167;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czpN6XBO7vmj/gerXXMs7+mydLCdEmFEt1B1dSHa/U8=;
	b=kSHkXVYKja4gOAkDfEKwmEtLJAAHJ/3zqqvRFQrf4LVKGuw5KQLPiXgISoFOMEcui7W1Kf
	DKhtsE/EmNwlU9Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LaSPg/jE";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wzRBKFXH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734554166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czpN6XBO7vmj/gerXXMs7+mydLCdEmFEt1B1dSHa/U8=;
	b=LaSPg/jEMe8qwfKKNyepuu2b+cxT4bl48M+S3EJCj0G0c3NW6llxqbkiClgcxDZlTJZenc
	YvU6iD+6m5vn5NOsH1gtShkaA09DcaNpenubB6BeAERfGbyBZHpPGpNQkvkZz1YsPjKnHx
	lsMDdOs8QZNKyZN5+f8D093NImWcedI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734554166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czpN6XBO7vmj/gerXXMs7+mydLCdEmFEt1B1dSHa/U8=;
	b=wzRBKFXHAlI0Q9IuEiNFOobMkm0U8Va2gPAfFCQirLZqB78jEEtRs1XvXpUDdxoVxlQi7c
	AvPKKT4RygdqrACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57FA4137CF;
	Wed, 18 Dec 2024 20:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wb/JFDYyY2e0EAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 20:36:06 +0000
Date: Wed, 18 Dec 2024 21:36:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: migrate to "block size" to describe the
Message-ID: <20241218203601.GI31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734514696.git.wqu@suse.com>
 <20241218183155.GE31418@twin.jikos.cz>
 <73f9e7d0-9954-4507-a48a-2759cf3a2f2f@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73f9e7d0-9954-4507-a48a-2759cf3a2f2f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 85D861F397
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Dec 19, 2024 at 06:43:38AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/19 05:01, David Sterba 写道:
> > On Wed, Dec 18, 2024 at 08:11:16PM +1030, Qu Wenruo wrote:
> >> [IMPEMENTATION]
> >> To reduce the confusion, this patchset will do such a huge migration in
> >> different steps:
> > 
> > With some many changes everywhere this is going to make backports even
> > more tedious. I think it would be best to do the conversion gradually or
> > selectively to code that does not change so often. As you've split it to
> > files we can first pick a few obvious ones (like file-item.c) or gather
> > stats from stable.git.
> 
> For the backports, we can put the btrfs_fs_info union to older kernels 
> and call it a day without the remaining part.
> 
> So that both newer and older terminology can co-exist without any conflicts.
> 
> Although backport conflicts will still happen in the context.

This is what I'm concerned about. If patches don't apply cleanly they're
rejected from the automated stable workflow and have to be handled
manually.

> > A quick and rough estimate for all 6.x.y releases counting file
> > backports in the individual patches in the list below. This is period of
> > 2 years, 104 weeks (roughly matching number of releases). So if there
> > are 88 patches touching inode.c that's quite likely a conflict in every
> > backport.
> > 
> > This should be also correlated agains number of 'sectorsize' per file,
> > so it many not be that bad, for example in ioctl.c there are only 4
> > occurences so that's fine. The point is we can't do the renames without
> > some sensibility and respect to backports.
> 
> But at least, when a backport fails, we can easily fix the conflict.
> It will always be sectorsize -> blocksize, either in the context or the 
> modified lines.

Easily yes, but multiply that by number of failed patches and number of
stable trees to backport. This takes time and currently the upstream
backports are best-effort only, not all patches that fail to apply get
manually backported. Enough that there are CVEs of everything and we
have to care about them at $job so I'm not going to create more problems
with backports than we already have just to fix a naming inconvenience.

