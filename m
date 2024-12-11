Return-Path: <linux-btrfs+bounces-10263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3EA9ED6AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1C0282BB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AF1C3F27;
	Wed, 11 Dec 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="At4m9Jgd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQ7RHTza";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="At4m9Jgd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQ7RHTza"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0478259491
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946066; cv=none; b=iH0ax7nBUWqqJvt9oqQ6bUPKOwv4NGkBlZa4ubS+2boN6qt7YwdJy5MNF0rZqkBCb1xUXldGirvsk0foNK4oAse15lNpWhNnLeMcET1wUZstvKodYtDIprXME4skaaWd6HiHoHzobVsqRc9k3buzKxNj5FqhDy4V/u9kyj2XDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946066; c=relaxed/simple;
	bh=avW0liXnfKYYfEpU0l9aaPz5SbmuXFTgsF+ZL7oHdKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5mISm5bCMb91OicuTKLaoxtev31WbbRvAZckMT1PVN79KpnCe1Mh5yvdKEgYHJsyWi5XnhFZcNM7UcItZIFqO3Kd6owGZ2hPp846yAssjtBBqEnB2yrVSCC7FMjSbxHFHABnEGLmAk6+XXYj00riMjvvas5FdFAdNInVK5zcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=At4m9Jgd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQ7RHTza; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=At4m9Jgd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQ7RHTza; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0AA52117B;
	Wed, 11 Dec 2024 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733946061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
	b=At4m9Jgd3smaYWoA/Z8R/Mk5KEYb00xBNwgYyQtswjH6ZnFAT7IMIyy7d9Y51B0HXmM9gy
	GlSzcWFy3Z6C7foX65zzu2NcOo8jWxj6upjYzspAuSk61bHoDUQpNKathuNqJDBVauXJJR
	bHe7yfWBY6fnfF3zKqxdm4eym4Aij14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733946061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
	b=RQ7RHTzaZcAFSBc0ZGA0RJpr1mIxY6/nIZf+Pa7gxZmI0jowo9j4zcnpS5S/xDIkdL6xoO
	hEaD363w58TLqNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733946061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
	b=At4m9Jgd3smaYWoA/Z8R/Mk5KEYb00xBNwgYyQtswjH6ZnFAT7IMIyy7d9Y51B0HXmM9gy
	GlSzcWFy3Z6C7foX65zzu2NcOo8jWxj6upjYzspAuSk61bHoDUQpNKathuNqJDBVauXJJR
	bHe7yfWBY6fnfF3zKqxdm4eym4Aij14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733946061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
	b=RQ7RHTzaZcAFSBc0ZGA0RJpr1mIxY6/nIZf+Pa7gxZmI0jowo9j4zcnpS5S/xDIkdL6xoO
	hEaD363w58TLqNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A95A1344A;
	Wed, 11 Dec 2024 19:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNGaIc3qWWeDEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:41:01 +0000
Date: Wed, 11 Dec 2024 20:40:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, linux-btrfs@vger.kernel.org,
	ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <20241211194059.GD443680@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241209061416.GB180329@pevik>
 <Z1mA2wzjW0hpQxUH@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mA2wzjW0hpQxUH@yuki.lan>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> Hi!
> > Well, "Testing only" in the help (-h) was added there to suggest it's for
> > testing/debugging LTP, not a production testing. But newer mind, I'll implement
> > Cyril's suggestion, real usage justify it. + I'll add LTP_FORCE_SINGLE_FS_TYPE.

> > We could allow more filesystems, e.g.  instead of running LTP few times with
> > different LTP_SINGLE_FS_TYPE value: e.g.

> > for fs in ext4 xfs btrfs; do LTP_SINGLE_FS_TYPE=fs ioctl_ficlone02; done

> > we could introduce support for particular filesystems
> > LTP_FILESYSTEMS="ext4,xfs,btrfs" ioctl_ficlone02

> That is stil not equivalent if you run it with a whole LTP. We would
> have to run each test that uses device for all LTP_FILESYSTEMS, since
> many of the testcases does use device but does not use .all_filesystems.

> So all in all I think that LTP_SINGLE_FS_TYPE is good enough solution.

> Or we can try to rething the whole thing, but it's getting quite
> complicated with all the options we have.

I guess LTP_SINGLE_FS_TYPE + LTP_FORCE_SINGLE_FS_TYPE LGTM.

What bothers me more how much time we spent with formatting loop device (done
for each test with .all_filesystems several times). Running all tests on single
filesystem, then reformat and run all of them on the other filesystem would be
faster. The only thing which is better on this is theoretical chance that
filesystem gets corrupted by some test, then other tests would be somehow
influenced.

Kind regards,
Petr

