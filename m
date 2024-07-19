Return-Path: <linux-btrfs+bounces-6607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC6937A59
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060BE1C21B46
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E4146585;
	Fri, 19 Jul 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDvm3ZKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/10aWVd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDvm3ZKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/10aWVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB4146595;
	Fri, 19 Jul 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405257; cv=none; b=P4KH38ZJqH+RC28VuhxOZ1Sz/v5iQDCW+9xN/ElYGtcdsCWuMVUguEpzTQ8/EykQ84hu5X8Y5LWwtgnBi6fVKuyiUwpGj6QsISsRs4f4pWvFjU8pK5TI2fkykDt4pKAtF8z2OmVjfUFiyU2U57ExDEQ6k21/bP7Q8z4ibSo69rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405257; c=relaxed/simple;
	bh=d3u56dAkSLvTrB9lnDd2GBTT0GMZV9smwueD5L6qf0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9WFXHQd7yjgistJeK7NSTUYn2qqJstAq7hFnduUF++BMrqy9vl1LOBFGWTwmZr7aQOMr2aFdSyK017Y/XtnV8Re0vf3qmxVvAYDRG0YbuzuL/UXTNkbslCGloYckDGLF7io81ZkcC3hsuG6iwrFp2CGkXpLZ5MB0j0Gej7S9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDvm3ZKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/10aWVd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDvm3ZKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/10aWVd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2081921195;
	Fri, 19 Jul 2024 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721405254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxFeqn9yQIJ/4dvvgdLNmdCELO84SMgr40+VWkW0U7I=;
	b=MDvm3ZKMlgwdImkd4AfrbBJPEcS6uAydwTyUnQmLXrcwGwbt4/iCE1XECH9BVb9H8HWJaN
	iuT0e8jYFSgtPwotRsO52WhsteHXOa67VJKbsQzDz8UTffKYdpQvdYhGDGlv5ISJ7smip7
	dk5OLm5y3Oy4yzqLn0nBgYsJAZAdBm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721405254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxFeqn9yQIJ/4dvvgdLNmdCELO84SMgr40+VWkW0U7I=;
	b=w/10aWVdKf3ZuyxHW75o28HvrWU1ZN1UsZpiKjouuocqdMrGZalnl3X61xplRwoi5WQ50e
	9RBNWAqURWABEFCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721405254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxFeqn9yQIJ/4dvvgdLNmdCELO84SMgr40+VWkW0U7I=;
	b=MDvm3ZKMlgwdImkd4AfrbBJPEcS6uAydwTyUnQmLXrcwGwbt4/iCE1XECH9BVb9H8HWJaN
	iuT0e8jYFSgtPwotRsO52WhsteHXOa67VJKbsQzDz8UTffKYdpQvdYhGDGlv5ISJ7smip7
	dk5OLm5y3Oy4yzqLn0nBgYsJAZAdBm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721405254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxFeqn9yQIJ/4dvvgdLNmdCELO84SMgr40+VWkW0U7I=;
	b=w/10aWVdKf3ZuyxHW75o28HvrWU1ZN1UsZpiKjouuocqdMrGZalnl3X61xplRwoi5WQ50e
	9RBNWAqURWABEFCw==
Received: by ds.suse.cz (Postfix, from userid 10065)
	id C2B84DA9B3; Fri, 19 Jul 2024 18:07:33 +0200 (CEST)
Date: Fri, 19 Jul 2024 18:07:33 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: change mount_opt to u64
Message-ID: <20240719160733.GA23446@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240719103714.1217249-1-arnd@kernel.org>
 <20240719132454.GL8022@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719132454.GL8022@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: 0.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.30 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email]
X-Spam-Level: 

On Fri, Jul 19, 2024 at 03:24:54PM +0200, David Sterba wrote:
> On Fri, Jul 19, 2024 at 12:37:06PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The newly added BTRFS_MOUNT_IGNORESUPERFLAGS flag does not fit into a 32-bit
> > flags word, as shown by this warning on 32-bit architectures:
> > 
> > fs/btrfs/super.c: In function 'btrfs_check_options':
> > fs/btrfs/super.c:666:48: error: conversion from 'enum <anonymous>' to 'long unsigned int' changes value from '4294967296' to '0' [-Werror=overflow]
> >   666 |              check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNORESUPERFLAGS, "ignoresuperflags")))
> >       |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Change all interfaces that deal with mount flags to use a 64-bit type
> > on all architectures instead.
> > 
> > Fixes: 32e6216512b4 ("btrfs: introduce new "rescue=ignoresuperflags" mount option")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ----
> > Please double-check that I got all the instances. I only looked at where the
> > obvious users are, but did not actually try to run this on a 32-bit target
> 
> Thanks, the build issue is known and fix will be sent in 2nd pull
> reuqest on Monday.
             ^^^^^^

I'll send the pull request rather today.

