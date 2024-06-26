Return-Path: <linux-btrfs+bounces-5994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93087918572
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C6AB2D4F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFF184113;
	Wed, 26 Jun 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jo47Ae1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2h61z85k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8pDXdqw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YypKJHIL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713B219EB
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414257; cv=none; b=tL7xZd1ZwDOuDloOk5aI6cGWDPItuaLGiasllHS+X/UMqoKBs1kmZLJiHXDOH4/vvV1wVUpg6USPU2K12p6Zmw1gJLaoR5z92tI+L2/6tEMcrGGwpuF6rOOsUf58KuDxde7AsWtEwkxDZh5/ayK+TOvQEo8lls2zjdcBDFpZEHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414257; c=relaxed/simple;
	bh=Lnq94vfVZzDhKTIK+nVkdthJj8qxdzeshpLR7Owhe3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmQEe07Kc5Rs4QBU6Dcyjba/KLIjwKqDM6+FngujbzNJXcHEK74a6Rt8bq7G6phghfNDldTNHBc8kmvqZ4CzZk1dH8MqYjTAI6B3PGKz0yifsA4YHP9fACVJtuUtcYP3sfz5hw6pnnnuKDA5ERMRejFoJ+lScbPAWql+d1sZDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jo47Ae1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2h61z85k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8pDXdqw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YypKJHIL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29F721FB57;
	Wed, 26 Jun 2024 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719414253;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oEZTfv8EJDIIjXY1dSypqXLNiZvtgqv7xdEk+3I9jWE=;
	b=Jo47Ae1Ir9n2zEDbUZ+PI4QOW1v6kg5GWjZKOX83a5Qmbfx7Hzi+gpY+Xb7XdNiPeAb0K3
	pHcJpQNqmQNuViwdp16TFOp+YiwVWaiqTzwtG4XoCxVkNVz237xWkV1q/GoAB+uglAAzof
	0FGhacWWVdedGKYGKqvxc3EOvnwQjyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719414253;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oEZTfv8EJDIIjXY1dSypqXLNiZvtgqv7xdEk+3I9jWE=;
	b=2h61z85kcurwFsnXCRevTjW5uZ1jH9Noa+BKfCJ0OIwn4auarzR5lVHzua/VFFs3rrwg3I
	ZPdpQfDhjbL7maAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719414252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oEZTfv8EJDIIjXY1dSypqXLNiZvtgqv7xdEk+3I9jWE=;
	b=w8pDXdqwCVXKwRZWc/Ss1v4COdRAPDCFLStKLDRrwOrqGi/HGpMystit5j2U9TRYb+fA3u
	VFf+3Fv4dAQY/T4YfWmyrpAXxbU98F6l82ygM/KriJ8zgwWRSGC0pYl2/4w8QXiBEEmF4j
	3JO2bu07pW1Sy090YirW3PQdBFJhNDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719414252;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oEZTfv8EJDIIjXY1dSypqXLNiZvtgqv7xdEk+3I9jWE=;
	b=YypKJHILwWEu/Q3iRmJnIb5eb79C77VzH3vQ4Jh2kiWOYgwdCnF68/LUtHLWD6MG6jqAGr
	FLGnJoEqwqm1V2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CCA6139C2;
	Wed, 26 Jun 2024 15:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2pGpAuwtfGb1YQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Jun 2024 15:04:12 +0000
Date: Wed, 26 Jun 2024 17:04:10 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't check NULL ulist in ulist_prealloc
Message-ID: <20240626150410.GB25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
 <20240626132257.GZ25756@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626132257.GZ25756@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,bur.io:email];
	RCPT_COUNT_THREE(0.00)[4]

On Wed, Jun 26, 2024 at 03:22:57PM +0200, David Sterba wrote:
> On Tue, Jun 25, 2024 at 10:32:11AM -0700, Boris Burkov wrote:
> > There are no callers with a NULL ulist, so the check is not meaningful.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/ulist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> > index f35d3e93996b..fc59b57257d6 100644
> > --- a/fs/btrfs/ulist.c
> > +++ b/fs/btrfs/ulist.c
> > @@ -110,7 +110,7 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
> >  
> >  void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> >  {
> > -	if (ulist && !ulist->prealloc)
> > +	if (!ulist->prealloc)
> 
> You can also add an assert so it's visible that it's the assumption.

Reading the previous thread where this was discussed, for interfaces
that are self-contained the assertions are meant as a documentation of
the API but it's not done consistently. Without the assertion is fine
for me as well.

