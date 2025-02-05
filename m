Return-Path: <linux-btrfs+bounces-11297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BFA29680
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0439D7A0686
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF71DC185;
	Wed,  5 Feb 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWcuMIXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+MNxdhA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWcuMIXl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+MNxdhA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087218A6BA;
	Wed,  5 Feb 2025 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773622; cv=none; b=pBtiHqYXSfYUxZPFy6mVWmcy/MynBfZBCzVudpFJr8L4VmBL1YNt/8BoNK8WDPFjntkqPbtzVTVPjfltgB0/ZBMXqhX3WkA9YXZQSm/YXLkmYwsDrwPkDGCuQxMxJZp9yLwChr/MkjyBzHRUDBFxEE77ghzknXRmXRcoXq1hh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773622; c=relaxed/simple;
	bh=fZs/OAmjFCT482JymNcEu3wCL57eRyj9F/vXr3lzllw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T00DP9jo96tcp+gjKAL85Y005iS40vPFG0KgbLxe9CeQj5oytkXKEAvPxtQoiWBHTiaGFI+FvVMBad0FNx0+pchuNE16XK46l+JsDdd/YHKiHaMbs477n6A9pjGzYMqg8ipuqVp6lGcxayg5s3z4MOgnaXZpN7mk4vRtSOjYin4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWcuMIXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+MNxdhA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWcuMIXl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+MNxdhA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18E8E215D0;
	Wed,  5 Feb 2025 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738773619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njiCdnx+9RlYGgbEMg4uPaVX/eisLEx30KxioVp5A64=;
	b=JWcuMIXl5CDrmW/SqQQV6AQrNguGAYZ1qyzLuX0CJmwvJ33113koT/vOIrjr2xU4l8SNU7
	nENmfWESKmLAYFd2EMkAcJre0tjR4DNHWCV0I59C/f8Jd0l/NY/LPSxGDP8/Xky8XUgjjn
	8i7ryBtUay5XuG2GCuybRUpAQQRVjEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738773619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njiCdnx+9RlYGgbEMg4uPaVX/eisLEx30KxioVp5A64=;
	b=a+MNxdhAfufo7hnuR/NDOABzULdXY1/ckIxn1jXgkVvNOJ2VMETyLYP3wcDco9PRejpHlm
	irWr4soBeoaRp9AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JWcuMIXl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a+MNxdhA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738773619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njiCdnx+9RlYGgbEMg4uPaVX/eisLEx30KxioVp5A64=;
	b=JWcuMIXl5CDrmW/SqQQV6AQrNguGAYZ1qyzLuX0CJmwvJ33113koT/vOIrjr2xU4l8SNU7
	nENmfWESKmLAYFd2EMkAcJre0tjR4DNHWCV0I59C/f8Jd0l/NY/LPSxGDP8/Xky8XUgjjn
	8i7ryBtUay5XuG2GCuybRUpAQQRVjEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738773619;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njiCdnx+9RlYGgbEMg4uPaVX/eisLEx30KxioVp5A64=;
	b=a+MNxdhAfufo7hnuR/NDOABzULdXY1/ckIxn1jXgkVvNOJ2VMETyLYP3wcDco9PRejpHlm
	irWr4soBeoaRp9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E666313694;
	Wed,  5 Feb 2025 16:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V07UN3KUo2dqOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Feb 2025 16:40:18 +0000
Date: Wed, 5 Feb 2025 17:40:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount
 option
Message-ID: <20250205164012.GJ5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250124075558.530088-1-neelx@suse.com>
 <20250127180250.GQ5777@twin.jikos.cz>
 <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com>
 <20250129224253.GF5777@twin.jikos.cz>
 <CAPjX3FdJynRY91N-1aJ0wOrMJY+cKvSuhLDPGAuCybEvSzS0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdJynRY91N-1aJ0wOrMJY+cKvSuhLDPGAuCybEvSzS0KA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 18E8E215D0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:replyto,suse.cz:dkim,suse.cz:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Jan 30, 2025 at 10:13:36AM +0100, Daniel Vacek wrote:
> On Wed, 29 Jan 2025 at 23:42, David Sterba <dsterba@suse.cz> wrote:
> > Up to -15 it's 3x improvement which translates to about 33% of the
> > original size. And this is only for rough estimate, kernel compression
> > could be slightly worse due to slightly different parameters.
> >
> > We can let it to -15, so it's same number as the upper limit.
> 
> I was getting less favorable results with my testing which leads me to
> the ultimate rhetorical question:
> 
> What do we know about the dataset users are possibly going to apply?

This does not need to be a rhetorical question, this is what needs to be
asked when adding a new feature or use case. We do not know exactly but
in this case we can evaluate expected types of data regarding
compressibility, run benchmarks and do some predictions.

> And how do you want to assess the right cut-off having incomplete
> information about the nature of the data?

Analyze typical use cases, suggest a solution, evaluate and either take
it or repeat.

> Why doesn't zstd enforce any limit itself?

That can be answered by ZSTD people, that the realtime level number
translates to the internal parameters may be an outlier because the
normal level are defined in a big table that specifically defines what
each level should do so there's not predictable pattern.

https://elixir.bootlin.com/linux/v6.13.1/source/lib/zstd/compress/clevels.h#L23

> Is this even a matter (or responsibility) of the filesystem to force
> some arbitrary limit here? Maybe yes?

Yes and this is for practical reasons.

> As mentioned before, personally I'd leave it to the users so that they
> can freely choose whatever suits them the best. I don't see any
> technical or maintenance issues opening this limit.

As a user I see an unbounded number for relatime limit level and have no
idea which one to use. So I go to the documentation and see that
somebody evaluated the levels on various data sets with description of
compressibility and says that levels -1 and -15 can give some reasonable
results. I can also reevaluate it for my own data set or take some
recommendation.

What would IMHO look really strange is to see another 1000 levels
allowed by the parameter but docuented as "no obvious benefit, only
extra overhead".

If somebody comes later with a concrete numbers that it would be good to
have a few more levels allowed we can talk about it and adjust it again.

The level is currently not stored anywhere but we will want that
eventually for the properties so limiting the number is necessay anyway.
So this is a technical and compatibility reason.

