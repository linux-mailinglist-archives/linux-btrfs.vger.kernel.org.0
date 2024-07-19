Return-Path: <linux-btrfs+bounces-6601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7099378A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77251F22080
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FEA142E7C;
	Fri, 19 Jul 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FQUVh+xh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8SgVdwys";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ld+U4fD0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="28zOF9C0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1910E6;
	Fri, 19 Jul 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396557; cv=none; b=jHfNAQIa7UW6svNX1bLMpVVbTHwqMK3VEZul9pki2VRSpAerqp1OAcj1J20SKNvCEvEH1EUtYBcI3OjsK0bh+u31nklgPsVCkX1q0iSn9/3r2sn3Q9ZzvDDloHnA6D13NuhvYgdbn+ABHRLFiSKW3Pr1NXy8WMs4c0ooLbtZYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396557; c=relaxed/simple;
	bh=xuqB6xK3CyfuUlLUm9eYl2GLbx8buMvoTqZw8s8DX44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnr9CVjJID4WOFnZDVj7/4XSL3TOfsyPbXkGgJSb719p3pi74E0LvBiITp+kmx2kukkXw5okwj+C0DAqUmEf8uKVdkB7o44tD0Z5NfONE+Hm2QGyLYluSeg/14IMDQAm1LU/ZIAtMZRJDUZrXpd2grHmyGrYXFb48Ty0n+iji6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FQUVh+xh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8SgVdwys; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ld+U4fD0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=28zOF9C0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A05FE219CF;
	Fri, 19 Jul 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721396553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibP3ajFY7VoDlJs/ObXG0yOj7xySN7nYaNLmFXNseaY=;
	b=FQUVh+xhV1alqJvZihIWUbGSISejdYr3vidHvH5JdRGElvwRxeXxRqlphcEZr/dy5MieGQ
	2YsdEjrJP0QqsknuvelY72MfRepuidSqpv9kloupGlw1GETE2hXUF6p4QzEi2yLFyhAtN8
	5WeBEMxZ+OITnCqMYQMwTdTLa+6cvAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721396553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibP3ajFY7VoDlJs/ObXG0yOj7xySN7nYaNLmFXNseaY=;
	b=8SgVdwysxcR7apNXS9OKh9Z4WDJysErG0jvhx5oMzJlPh7qpT4a4R8Sr/k+xSTEADXXQ9l
	Bs/AEPVO+C1cVFDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ld+U4fD0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=28zOF9C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721396552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibP3ajFY7VoDlJs/ObXG0yOj7xySN7nYaNLmFXNseaY=;
	b=Ld+U4fD0mOigTGvd8mGbePrUKz0jJgh1CDWOc67m0CFD1xXfCAKRJ5kmy4jR1MuNhlP9kV
	wQg4euDZWj8eoYjY5+2BDqSQFf9BKEeAccvncjjcSaKt7ssSi1Ssq6cvokvV6phwNiZv00
	nJBwDE2kSVlabeIjY01qVLy52kyVrKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721396552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibP3ajFY7VoDlJs/ObXG0yOj7xySN7nYaNLmFXNseaY=;
	b=28zOF9C0+H/ciiKlEI+cq3iRMaGlNIOIbkJxK3yaLnybcTEzf5qOzD1xz3TkyL8+o9crux
	vv4TFqHr90po1SCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB3E136F7;
	Fri, 19 Jul 2024 13:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIuNHkhtmmY0FQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jul 2024 13:42:32 +0000
Date: Fri, 19 Jul 2024 15:42:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.11
Message-ID: <20240719134216.GM8022@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1721066206.git.dsterba@suse.com>
 <CAMuHMdURvTtambJKd2uYqbRFYO_oBSsFHBunaXNfzvzqbPqbxQ@mail.gmail.com>
 <CAMuHMdVW7NZJhsxnp71Fc9=RQR=gXtOXPkSxreR3ZuMDbVxnjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVW7NZJhsxnp71Fc9=RQR=gXtOXPkSxreR3ZuMDbVxnjw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: A05FE219CF

On Fri, Jul 19, 2024 at 01:35:53PM +0200, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Fri, Jul 19, 2024 at 1:25 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Jul 15, 2024 at 8:12 PM David Sterba <dsterba@suse.com> wrote:
> > > please pull the changes described below. The hilights are new logic
> > > behind background block group reclaim, automatic removal of qgroup
> > > after removing a subvolume and new 'rescue=' mount options. The rest is
> > > optimizations, cleanups and refactoring.
> > >
> > > There's a merge conflict caused by the latency fixes from last week in
> > > extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> > > and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> > > been in linux-next for a few days.
> >
> > FTR, this is broken on 32-bit (doesn't build, good ;-) and on big-endian
> > (compiler warnings, no idea how it behaves :-(, so you better don't
> > trust your data to it in the latter case...

Internet forums are full of such quick and wrong conclusions, you don't
need to write more.

> I cannot find any other report of this, and don't know yet where it
> was introduced, but the bots started reporting this last May:
> 
>     3    fs/btrfs/inode.c:5711:5: warning: ‘location.type’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>     3    fs/btrfs/inode.c:5640:9: warning: ‘location.objectid’ may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> 
> https://lore.kernel.org/all/6655b55f.170a0220.406f9.2e0e@mx.google.com/
> 
> and I'm seeing failures in e.g. my m68k allmodconfig builds with
> gcc 9.5 due to CONFIG_WERROR=y.

Older compilers like 9.5 could not be able to reason about variable
validity in case it's passed by address, as is in this case:

 5707         ret = btrfs_inode_by_name(BTRFS_I(dir), dentry, &location, &di_type);
 5708         if (ret < 0)
 5709                 return ERR_PTR(ret);

and btrfs_inode_by_name() returns either a valid 'location' or an error that
the caller handles and does not use the variable.

> I suspect the big-endian accessors in fs/btrfs/accessors.h lack some
> initializations?

There are no special accessors on big endian hosts, same code, same
bytes in memory only a different order.

We fix warnings caused -Wmaybe-uninitialized even if it's because of old
compilers, but it's hard to notice reports if they're burried in some
mailinglist.

I do read your build reports after each -rcN but there are only some
modpost warnings in 6.10-rc7

https://lore.kernel.org/all/20240710083744.2885335-1-geert@linux-m68k.org/

