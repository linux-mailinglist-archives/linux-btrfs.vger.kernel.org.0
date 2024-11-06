Return-Path: <linux-btrfs+bounces-9368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16B19BF2C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811FA1F224E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F32076D2;
	Wed,  6 Nov 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVlxQEKN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpiLxwRe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVlxQEKN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpiLxwRe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17591203707;
	Wed,  6 Nov 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909239; cv=none; b=BtzR9mdD4b+9TS6YiYApveTIa618ONN9Z+Aja0IlsbNqPaupQ3ACxfvR+G9XhiC5Jh9CBKfp4cXTXHpbeq4uFQrPSrSVWinnXV3l9K/8Y9gNJOEK4oN3McYYot4MRqOnwDv2jXHpzEghbElJvenaqQ3WKRfl9uEHn9Z/KFWV57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909239; c=relaxed/simple;
	bh=yrnpiJhy1J/7RqZ/+CyJugHSccwtATWWeukq81MaSCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nom28SspPsPRgQFo5vPiCghkuFbd+UQGcSN1pGv87/s342kDFdjswuUQcYbm4dvx5e+V+g7eoWlaozW/0GH/2u2JdBnlXvgTjdKGdjfUnsnJKZ7gvtZS0+1Ws7x4Jxg0xSsa115bMK47TWxF9+ET95xBHR0m8bOBKBZ0aPWFrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVlxQEKN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpiLxwRe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVlxQEKN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpiLxwRe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 410DE1FD16;
	Wed,  6 Nov 2024 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730909234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFK4lU6B12gDl5NcQ8bStKX2YCBIjE84h/WDX0M3oX0=;
	b=GVlxQEKN3N/ZUMBOshLxms6mGsMue3UYHWVi1mIDw1tBV2ZPdp8hmRhKTc2D2GXij2WUOv
	t8Hq06BbIeQd3N/c/ocBmmwjaAH9JW/ey6GolnmYyvA6vQ9VC3MA2r5aCZITpotTGEitmz
	224sR5GS3zq/J9+1J6kkSgt5kzEFNuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730909234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFK4lU6B12gDl5NcQ8bStKX2YCBIjE84h/WDX0M3oX0=;
	b=TpiLxwReKDl7e0yEg9XXcp1Uuush7wNq9HBMtCqDXUg9gHoPtPNXBSUrQjivAzEFj/uHRG
	7SDYa2bi1PlVhkDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GVlxQEKN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TpiLxwRe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730909234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFK4lU6B12gDl5NcQ8bStKX2YCBIjE84h/WDX0M3oX0=;
	b=GVlxQEKN3N/ZUMBOshLxms6mGsMue3UYHWVi1mIDw1tBV2ZPdp8hmRhKTc2D2GXij2WUOv
	t8Hq06BbIeQd3N/c/ocBmmwjaAH9JW/ey6GolnmYyvA6vQ9VC3MA2r5aCZITpotTGEitmz
	224sR5GS3zq/J9+1J6kkSgt5kzEFNuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730909234;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFK4lU6B12gDl5NcQ8bStKX2YCBIjE84h/WDX0M3oX0=;
	b=TpiLxwReKDl7e0yEg9XXcp1Uuush7wNq9HBMtCqDXUg9gHoPtPNXBSUrQjivAzEFj/uHRG
	7SDYa2bi1PlVhkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F49D137C4;
	Wed,  6 Nov 2024 16:07:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DkGAAzKUK2dLWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 16:07:14 +0000
Date: Wed, 6 Nov 2024 17:07:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hagar@microsoft.com, broonie@kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
Message-ID: <20241106160708.GE31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241106120319.234238499@linuxfoundation.org>
 <CA+G9fYtjpUJFFV=FdqvW+5K+JL5ZYN4sPfVDjQovqzd7cib39w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtjpUJFFV=FdqvW+5K+JL5ZYN4sPfVDjQovqzd7cib39w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 410DE1FD16
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,sladewatkins.net,gmx.de,microsoft.com,fb.com,toxicpanda.com,suse.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLe1zdo9uk7dz69twkrygihbgb)];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Nov 06, 2024 at 03:12:46PM +0000, Naresh Kamboju wrote:
> On Wed, 6 Nov 2024 at 12:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.11.7 release.
> > There are 245 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The mips gcc-12 allmodconfig build failed on the Linux stable-rc
> linux-6.11.y branch.
> 
> 
> First seen on Linux stable-rc v6.11.4-642-g0e21c72fc970
> 
>   Good: v6.11.4-397-g4ccf0b49d5b6
>   Bad:   v6.11.4-642-g0e21c72fc970
> 
> mips:
>   build:
>     * gcc-12-allmodconfig
> 
> Build errors:
> -------------
> ERROR: modpost: "__cmpxchg_small" [fs/btrfs/btrfs.ko] undefined!

The patch "btrfs: fix error propagation of split bios" needs
90a88784cdb7 ("MIPS: export __cmpxchg_small()")

