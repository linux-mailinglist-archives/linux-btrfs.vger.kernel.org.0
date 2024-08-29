Return-Path: <linux-btrfs+bounces-7675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F4A9652CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B06284F28
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B71BA86D;
	Thu, 29 Aug 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EjYivnpo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kJIP6oF7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EjYivnpo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kJIP6oF7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19171BA286
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970228; cv=none; b=TOwjiYY5eujcIld/2owrkh+bn7VI2XhkjtS54mBxanXijDU9PWI8ohBz2USSs9gaDl6Q2I7mrSl//9EiwJ1nL76ayOiA1QnJpTUpzPWwjbZcryWn8gbgJ9UMRci4YlMgMHLHcJxOqXwDpJM7FfWV+9dT63y0jngz35zGPprISoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970228; c=relaxed/simple;
	bh=lxgaQq/KSbVraDTn+o73Fcurev1dhU+5GYSFQerzwsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUjHa7lx+SfXxFp+CvYdY9hJnJLWWoLLTPRhTg7Lc5nbSqtqlk5XRC7rODhhvp3Os0qQVIBgie77Wjhm555Ut/BnCW/8NoQpqJfWC8qh5wlE+J52CV717t3RTUAmQebumoxITd6V6N1IViM6KuqIJBDIZSjSoa0hdH0Z44qXCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EjYivnpo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kJIP6oF7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EjYivnpo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kJIP6oF7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 102F41F750;
	Thu, 29 Aug 2024 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724970225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcyUTXwngytKx3+q+75FoirVmgZ3mquAyYR2Tmnxqqc=;
	b=EjYivnpoRujE0G62UxGnMwrGfeW9rjhysxoU1rd17Qus+qGEdcyylxwe4adexlpTGQZtQ5
	FPNMj91DNYDQKMF4oEaGp/Bgcjk3NRlno8M+U9KIempDPylaM0qkaL0xGaKqCgkGniApY5
	iR0cMOc2PKr2rSQ+C7KEIBUW0j/J8as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724970225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcyUTXwngytKx3+q+75FoirVmgZ3mquAyYR2Tmnxqqc=;
	b=kJIP6oF7NNTVrQixrJGzK18h5hubRESTP8/9pFRza4aAMlV3i01dv7tGMUAkx89h07ika9
	d1V0TsSChODGEfDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724970225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcyUTXwngytKx3+q+75FoirVmgZ3mquAyYR2Tmnxqqc=;
	b=EjYivnpoRujE0G62UxGnMwrGfeW9rjhysxoU1rd17Qus+qGEdcyylxwe4adexlpTGQZtQ5
	FPNMj91DNYDQKMF4oEaGp/Bgcjk3NRlno8M+U9KIempDPylaM0qkaL0xGaKqCgkGniApY5
	iR0cMOc2PKr2rSQ+C7KEIBUW0j/J8as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724970225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcyUTXwngytKx3+q+75FoirVmgZ3mquAyYR2Tmnxqqc=;
	b=kJIP6oF7NNTVrQixrJGzK18h5hubRESTP8/9pFRza4aAMlV3i01dv7tGMUAkx89h07ika9
	d1V0TsSChODGEfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFDEC13408;
	Thu, 29 Aug 2024 22:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J1r8NfD00GZDVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 29 Aug 2024 22:23:44 +0000
Date: Fri, 30 Aug 2024 00:23:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Rolf Wentland <R.Wentland@gmx.de>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: interrupt long running operations if the
 current process is freezing
Message-ID: <20240829222343.GQ25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bbcd9ebaeccb3a9e5a875a2ffc1afb498d6b75fe.1724889346.git.wqu@suse.com>
 <20240829165948.GM25962@twin.jikos.cz>
 <a7aaf78c-4417-4f3e-b551-04b4898f1ba5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7aaf78c-4417-4f3e-b551-04b4898f1ba5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,gmx.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,suse.com,vger.kernel.org,gmx.de,toxicpanda.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 07:07:41AM +0930, Qu Wenruo wrote:
> >> different infrastructure.
> >>
> >> Unfortunately btrfs only checks fatal signals but not if the current
> >> task is being frozen.
> >>
> >> [FIX]
> >> Introduce a helper, btrfs_task_interrupted(), to check both fatal signals
> >> and freezing status, and apply to all long running operations, with
> >> dedicated error code:
> >>
> >> - reflink (-EINTR)
> >> - fstrim (-ERESTARTSYS)
> >> - relocation (-ECANCELD)
> >> - llseek (-EINTR)
> >> - defrag (-EAGAIN)
> >> - fiemap (-EINTR)
> >
> > Is it correct to interrupt the operations? If there's a reflink in
> > progress and system gets hibernated what's the reason to cancel it? It
> > should be possible to just freeze the state and continue after thaw, no?
> 
> One process trapped inside kernel can not be frozen.

I don't know how freezing works but know it's very complex and handles
lots of special cases so the above does not say much.

We have kernel threads that can do io, like the cleaner kthread and
others.  There's no explicit point where it would check for freezing
request, like it used to be with try_to_freeze() that got removed in
ce63f891e1a87ae79c4. There are flags for worker queues that mark them as
freezable and that's enough. There were series to make freezable block
devices, added in 6.8 and btrfs support was not added (but this may not
be relevant for the fstirm problem, I don't know).

> And it's really user-space programs' job to determine if they can resume
> the work.

Yes, but in this case this seems that it's suddenly changing behaviour
depending on freeze. And with this patch you change 6 operations while
the report was to fix fstrim.

> > Imagine a case when a long running file copy (reflink) is going on and
> > the system gets frozen. This is wrong from user perspective.

So, if this patch changes how cp --reflink behaves I claim it's a
usability regression. But we can skip discussing that, the fix needs to
be done for fstrim first. Here it's either to end prematurely with
ERESTARTSYS or to somehow make it work for freezing with some magic.

The patch as it is now cannot be merged as it breaks more than it fixes.

