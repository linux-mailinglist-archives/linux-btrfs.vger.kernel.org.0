Return-Path: <linux-btrfs+bounces-10027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344AD9E1850
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA6B2F3B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8F1DFE1E;
	Tue,  3 Dec 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2p9/NT09";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTsTuo6U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2p9/NT09";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTsTuo6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AF1DF25E
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217852; cv=none; b=gFT48Abyv3AdrViupeRLJinFU/Voa7D4O4fEmYv6LreZ2UYP49Oy8pbVcCbcl3dB+A2h8or6Bg08tih9/76zayBD7RBvDYYROD6ecaj3sskDnD2Zb/ULjLIc6d/6zKrsu2zJbuPGFf0U31Ox/b9NCiYnSpc/DJwMNX/6n5mW8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217852; c=relaxed/simple;
	bh=LsUOsE5cU5WPMi+WxpJv6i/j7iLcOO6Y3o6SxbekqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFC33iqquSAstcr6B7kQLCrvB9oB+yuhIRigrFUEuD3hU8Xv2au/32pQafwqmgq94+vzs6b4/nDjSifuaVTg624hlgEq57Df4SMZQJSLhKTLlFBs2W0RwVZgBMnijwQhZN7Jl7EqxSUKG+PJO6Ef8VYaFd8m7eCGdYyLnYmU/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2p9/NT09; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTsTuo6U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2p9/NT09; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTsTuo6U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DCA31F45F;
	Tue,  3 Dec 2024 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733217848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
	b=2p9/NT09YykfX9/YePV9seGkjgFlPo/WyHQzxDqrFPvJclImALC5Ok/xbFbNeWOF+cGk/x
	sl135vLcbN7OOoWgtiCuIk4LQA6ToZ8ycJXB+cpuo9mtA5QjZwLSKkIsjXzByduATNfVvd
	na8jEXrrIPGrAQK1C2pSG3UGiNsliNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733217848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
	b=GTsTuo6Ul+ByiMToYFtsrYs3PlWwRrHKlfTUcjWodtFbxARM6b63yKchyC57KBYcwRG9TV
	5RqUNvtrTBIhopBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733217848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
	b=2p9/NT09YykfX9/YePV9seGkjgFlPo/WyHQzxDqrFPvJclImALC5Ok/xbFbNeWOF+cGk/x
	sl135vLcbN7OOoWgtiCuIk4LQA6ToZ8ycJXB+cpuo9mtA5QjZwLSKkIsjXzByduATNfVvd
	na8jEXrrIPGrAQK1C2pSG3UGiNsliNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733217848;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODsK/8mmTcDdB3hwFYtQGvmNRskwsRdn9jzW54JPVuo=;
	b=GTsTuo6Ul+ByiMToYFtsrYs3PlWwRrHKlfTUcjWodtFbxARM6b63yKchyC57KBYcwRG9TV
	5RqUNvtrTBIhopBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFCD13A15;
	Tue,  3 Dec 2024 09:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TmC7ETjOTmelTgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 03 Dec 2024 09:24:08 +0000
Date: Tue, 3 Dec 2024 10:24:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it,
	linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <20241203092406.GB414034@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <Z03RB9JDmBVORPlf@yuki.lan>
 <20241203045310.GA414034@pevik>
 <Z066Fj9VQVlTOMp_@rei.lan>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z066Fj9VQVlTOMp_@rei.lan>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> Hi!
> > > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > > be skipped without need to manually enable the filesystem and recompile.
> > > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > > Therefore I would avoid this.

> > > I guess that this should be another env variable e.g.
> > > LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
> > > only for development purposes.

> > Well, LTP_SINGLE_FS_TYPE already has "Testing only"

> That was maybe how we intended it but we exposed the API and it seems
> that there is a usecase for it so people are possibly using it.

> > and that was the reason it just forced filesystem regardless "skip"
> > setup. Sure, we can turn it into "normal" variable and introduce
> > LTP_FORCE_SINGLE_FS_TYPE if it's needed.  But that would be an use
> > case if anybody uses LTP really to test particular filesystem. And it
> > would affect only .all_filesystem tests (e.g. user's responsibility
> > would be to point TMPDIR to that particular system on non-
> > .all_filesystem tests).

> There is a usecase we haven't figured out, when you want to test a
> single filesystem, you do not want to waste time on the rest of the
> filesystems and LTP_SINGlE_FS_TYPE nearly works for that usecase.

Yes, I understood this use case, this was probably the reason of this PR.
I'd appreciate Zorro's confirmation we understood him properly (e.g. that
somebody really needs this). I suppose you vote for this feature anyway
and it's fairly simple, thus I can prepare it.

Kind regards,
Petr

