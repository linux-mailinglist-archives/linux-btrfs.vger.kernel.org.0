Return-Path: <linux-btrfs+bounces-3377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3FB87F32E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820981F21A1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E15D5A4FF;
	Mon, 18 Mar 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhIFNXcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FHGSc644";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="acEF6Y44";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qSegJ5yC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501F1B94D
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801738; cv=none; b=FVJN6Qj5Vv6ZNeft2KQOlWSINHH9N7xasf3l6HslbzCEwilEx8nhd5qD4zjYga42ZAJCRq23KquhaVH3kcGRl6n1YnaiJW8lYf1mli6YKtc16C4RyGGnMxdNrdpTy8iTHmi/rTETp4jZxgns8wNQnLad5ptNGGD28K7FDC8jZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801738; c=relaxed/simple;
	bh=UzjvT3807RrHgqq07I3ARkdVskxQlOVGV1xKsARv7yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1fpmkeyZBosnogOmBdeD+cysbHuVU19eJMQuMr7dMgBuLwkpy2hseGRfYdaNOGpsdYxUhNxOqmIGd2I0JTPxfiQbNAmIlbXS+CRB9Df5KPUcV3GShAzzp4eQLE2WWueEgf6eCSpyWbXnDLGR5T7pqnoYTJGYbrYIl5/EqpLss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhIFNXcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FHGSc644; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=acEF6Y44; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qSegJ5yC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4AAC350CD;
	Mon, 18 Mar 2024 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710801734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZd0qtr2ifZi1htOjWY1i5YP9ey8pNF88LcP63PGzUk=;
	b=JhIFNXcVM5MXSUhMn1m4OnZAu14X6Io9gxtiqZZVHUi/NWRYARW+gtm7EoI+YbJhbzNzsZ
	zV+dPrv0l1rLyZp1HjbjJbSnfuUNfng2KH2BK0R3tsgUCM6vQ+u7xRgJ8/RYN7wKwvpVaO
	iffH5nJX1g5MhV6OWnoex5tsaBZuuXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710801734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZd0qtr2ifZi1htOjWY1i5YP9ey8pNF88LcP63PGzUk=;
	b=FHGSc644t+q28F0zjm+2nNFvLGiMLRH77lfEgeZKoZNauy1SODspxQ959kqOKfmkvse3xv
	UJOzgetQiR88iqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710801732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZd0qtr2ifZi1htOjWY1i5YP9ey8pNF88LcP63PGzUk=;
	b=acEF6Y44lc5fc5Wd6uQOAWx6MQwcF/f6yIhZzpHInC8hZNvsni7lzsqOweYLuVnv1GBWoF
	Mn/j5ckRej5hA33TYdeclNsIQLLQrLVNuDeITtjnP49BAI8Lptwmhq2LradgsMfD6j+V71
	h7vlOlJZsZgDUXrikWAYTndZs3Fm3cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710801732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZd0qtr2ifZi1htOjWY1i5YP9ey8pNF88LcP63PGzUk=;
	b=qSegJ5yCQ5scU2egtgv9Pbd3Xa9QMsIdTr2H9m0suorTeMG+3Y5T95ZDhH/imXFQE3PkSP
	yAxPgnZ7dTHXMPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A52136A5;
	Mon, 18 Mar 2024 22:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 93ciI0TD+GU/WQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 22:42:12 +0000
Date: Mon, 18 Mar 2024 23:34:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
Message-ID: <20240318223455.GL16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
 <0108b2de-56f5-4a7c-94a1-db415be8653c@oracle.com>
 <20240314165031.GB3483638@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314165031.GB3483638@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.99
X-Spamd-Result: default: False [-3.99 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.937];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu, Mar 14, 2024 at 09:50:31AM -0700, Boris Burkov wrote:
> On Thu, Mar 14, 2024 at 07:09:24PM +0530, Anand Jain wrote:
> > 
> > And this one as well, for the review. Thx.
> > 
> > 
> > On 3/9/24 19:16, Anand Jain wrote:
> > > When attempting to exclusive open a device which has no exclusive open
> > > permission, such as a physical device associated with the flakey dm
> > > device, the open operation will fail, resulting in a mount failure.
> > > 
> > > In this particular scenario, we erroneously return -EINVAL instead of the
> > > correct error code provided by the bdev_open_by_path() function, which is
> > > -EBUSY.
> > > 
> > > Fix this, by returning error code from the bdev_open_by_path() function.
> > > With this correction, the mount error message will align with that of
> > > ext4 and xfs.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> One small "nit", but LGTM.
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
> > > ---
> > >   fs/btrfs/volumes.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index bb0857cfbef2..8a35605822bf 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> > >   	struct btrfs_device *device;
> > >   	struct btrfs_device *latest_dev = NULL;
> > >   	struct btrfs_device *tmp_device;
> > > +	int ret_err = 0;
> 
> A quick grep shows that "err" is a much more common name for the
> variable when using this pattern in btrfs.

Well 'err' is there for historical reasons and the pattern we'd like to
use everywhere is to have 'ret' matching the function return type or a
common variable for any random function called. If there's need for more
than one 'ret' (so the function-wide is not overwritten) it's ret2 etc.
https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code

Patches to convert err -> ret are also welcome as it can be confusing
what to use in new code when there are two ways.

