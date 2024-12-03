Return-Path: <linux-btrfs+bounces-10021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31FB9E15AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39243B2D09D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF81B0F14;
	Tue,  3 Dec 2024 07:59:45 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD31AF4C1
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212784; cv=none; b=DuZRiXD43tXYbCF9l3+d5U+LtzxtT8CgYG7sHHHM3m/P3WjfAfkp2M8wLLvM/7RvfOIUsRqYGIjz1hVSvojEQ3DrycK4ykODhSGF2rpXTssQmXeAVdyvi6I/SC621cb0KEKbusJHI3H5K9f59NPZ7xINSzuC1hkhYfsDWXILySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212784; c=relaxed/simple;
	bh=x3Qsug1I/v3QfANs8j7rwct3VO/UwO6d95OcOqQKhT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSEqEA81Q0ZwhjolfLuFL8duRJabF+Buoj06RM42MZBkudlldYGK3iHmH79YcCcXRR5vBHD03pezBxEMXjp2q7rtBaOrYlJhmoem0qYB0n7dgGChKX2T9jMl0F50jMvF92a+G3AlVhzZxWvsYB4mgTRS8rYawLrvv3naEQWgWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 268A3210F8;
	Tue,  3 Dec 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1697D13A15;
	Tue,  3 Dec 2024 07:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnB6BG26TmcgNAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 03 Dec 2024 07:59:41 +0000
Date: Tue, 3 Dec 2024 08:58:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it,
	linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <Z066Fj9VQVlTOMp_@rei.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <Z03RB9JDmBVORPlf@yuki.lan>
 <20241203045310.GA414034@pevik>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203045310.GA414034@pevik>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 268A3210F8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Hi!
> > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > be skipped without need to manually enable the filesystem and recompile.
> > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > Therefore I would avoid this.
> 
> > I guess that this should be another env variable e.g.
> > LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
> > only for development purposes.
> 
> Well, LTP_SINGLE_FS_TYPE already has "Testing only"

That was maybe how we intended it but we exposed the API and it seems
that there is a usecase for it so people are possibly using it.

> and that was the reason it just forced filesystem regardless "skip"
> setup. Sure, we can turn it into "normal" variable and introduce
> LTP_FORCE_SINGLE_FS_TYPE if it's needed.  But that would be an use
> case if anybody uses LTP really to test particular filesystem. And it
> would affect only .all_filesystem tests (e.g. user's responsibility
> would be to point TMPDIR to that particular system on non-
> .all_filesystem tests).

There is a usecase we haven't figured out, when you want to test a
single filesystem, you do not want to waste time on the rest of the
filesystems and LTP_SINGlE_FS_TYPE nearly works for that usecase.

-- 
Cyril Hrubis
chrubis@suse.cz

