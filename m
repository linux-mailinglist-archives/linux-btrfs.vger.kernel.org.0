Return-Path: <linux-btrfs+bounces-6188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC103926CAA
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 02:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBDF283C0F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C4A41;
	Thu,  4 Jul 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUbLV2jt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogbsaVxS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUbLV2jt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogbsaVxS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C47E9
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052003; cv=none; b=nssv+/5ihGHb5apCq2QOdfRbSzMMy/lDUHWQhAiuiJprTK/ZpkEQoLKfWnlPGs052RW4WwxJRLLYNRkZHZbFyYEdlYZ1MVUJybRlbegqe971JcewxaWmlw21CNiGEVQ8rMEwEazZPiLKS+cbDTishrjJPTyZSuJ/K1ZSc2YEvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052003; c=relaxed/simple;
	bh=n6OHV7eJCL2PCDuim2ZVsze/esdDECAB296W5U89vlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maE7YzzeirqVdH+KkYQvRcqU78K2uxKjmdf0eFyh+YPleog7MPivdTQ+wZQqInXz6WEc9FEazqh6YA/hTqWEsD4MtDzE0+FDgqInT3JtbwbXqIjibkM4S94/p/VF08aIDGzZcqJnI3AM8dPuHwvdU8zrWfiK3vmD5ccWnTTMZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fUbLV2jt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogbsaVxS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fUbLV2jt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogbsaVxS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F75E21C01;
	Thu,  4 Jul 2024 00:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720051999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMqws0F5/u1iO8QytHsaXb6t99QQ4pDPx14GparNaU8=;
	b=fUbLV2jtcaQpiDUwcuxQJtLysvLKur/mXZucwmC792qYQYEw1ar4DpLAf66GQKF53bsJA7
	6ff4rIrUyDWQ6Y3CRqv0i9Y0rRYMlMFp6SAEK+HL3NHOMPy7Z+TrJeakfu2yHOiHjLhbr0
	ffEPBOzYtZzZXj4WBVUBl3JSJhxmgQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720051999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMqws0F5/u1iO8QytHsaXb6t99QQ4pDPx14GparNaU8=;
	b=ogbsaVxSZThTit+QV/J+XwdBb8oDsfqpOdelPVtSNPbGz8QfmMb7ArXu/3pORM4VO1ztF5
	cAb5/mNXidwQokDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fUbLV2jt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ogbsaVxS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720051999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMqws0F5/u1iO8QytHsaXb6t99QQ4pDPx14GparNaU8=;
	b=fUbLV2jtcaQpiDUwcuxQJtLysvLKur/mXZucwmC792qYQYEw1ar4DpLAf66GQKF53bsJA7
	6ff4rIrUyDWQ6Y3CRqv0i9Y0rRYMlMFp6SAEK+HL3NHOMPy7Z+TrJeakfu2yHOiHjLhbr0
	ffEPBOzYtZzZXj4WBVUBl3JSJhxmgQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720051999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMqws0F5/u1iO8QytHsaXb6t99QQ4pDPx14GparNaU8=;
	b=ogbsaVxSZThTit+QV/J+XwdBb8oDsfqpOdelPVtSNPbGz8QfmMb7ArXu/3pORM4VO1ztF5
	cAb5/mNXidwQokDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1153313889;
	Thu,  4 Jul 2024 00:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id emS7Ax/phWaNUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jul 2024 00:13:19 +0000
Date: Thu, 4 Jul 2024 02:13:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-prog: scrub: print message when scrubbing a
 read-only filesystem without r option
Message-ID: <20240704001309.GV21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1720028821-3094-1-git-send-email-zhanglikernel@gmail.com>
 <af92c238-a5d0-4023-8001-042f17085198@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af92c238-a5d0-4023-8001-042f17085198@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2F75E21C01
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jul 04, 2024 at 08:56:47AM +0930, Qu Wenruo wrote:
> > --- a/cmds/scrub.c
> > +++ b/cmds/scrub.c
> > @@ -957,7 +957,10 @@ static void *scrub_one_dev(void *ctx)
> >   		warning("setting ioprio failed: %m (ignored)");
> >
> >   	ret = ioctl(sp->fd, BTRFS_IOC_SCRUB, &sp->scrub_args);
> > -        pr_verbose(LOG_DEFAULT, "scrub ioctl devid:%llu ret:%d errno:%d\n",sp->scrub_args.devid, ret, errno);
> > +	if (ret){
> > +		pr_verbose(LOG_DEFAULT, "scrub on devid %llu failed ret=%d errno=%d (%m)\n",
> > +			sp->scrub_args.devid, ret, errno);
> > +	}
> 
> Doing direct output inside a thread can lead to race of the output.

We'd have to communicate the ioctl start errors back to the main thread,
or rely on internal locking of printf, that it can race is possible but
as long as the string is printed in one go we'll get only lines
reordered.

> And we do not know if the scrub ioctl would return error early or run
> for a long long time, that's the dilemma.
> 
> I'm wondering if it's possible to do a blkid/mountinfo based probe.
> Then it would avoid the possible output race and error out earilier.

We can detet read/write status of the block devices. I'm not sure about
the mount info, what function can we use for that?

