Return-Path: <linux-btrfs+bounces-4979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0E8C5A4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 19:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8213A1C21A70
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EF17F39E;
	Tue, 14 May 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqAKHvu3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WZFK3LzX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqAKHvu3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WZFK3LzX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AE17F378
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707747; cv=none; b=QalkXiC7iU7X+3nTho2XOm9GW5G/juI7zB1vQBdGBO9wSg6GoNu6JN/xs0ecixqmuTFEiIvNNfmTgauWSbq4Y0RV8nvR1z35st79OOk7DvOqeGP2mgE0YBnFBACkqJLMZu08Q6b2TxDHovm3afQo9VByI4FqXr4Gtpz3K1zgrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707747; c=relaxed/simple;
	bh=Co3klte+qf7cdqf+5JfvOGSdrvkvMCkDgAE+Fntcclc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ziqB8/hhYBbHzBbg0XfUlEkZ4uRimjlyFsDX8ntEkHMukHDnux1A6duR3wK4/xg6I7K4NQ910zNWsATAC0mTXtWSX2+Aq6Nsz806Z+8qtUd07WjTYbnKg1HPU4AOnh/CHl0vUdu1rStwollkAlqFPoDX9cP+seX3yqvGXT5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqAKHvu3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WZFK3LzX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqAKHvu3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WZFK3LzX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF15133690;
	Tue, 14 May 2024 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715707743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhFxqSph2Kpc8dlFIVs9yDYV0b1uK/DFQ8YJYTOnKik=;
	b=vqAKHvu3Ql6uZvaCLoCAzy3m0eZF7SWJ50iic37H1BEZi6Q40iVjQakRRUwqnsTTRw0vFg
	xUpyEBFFaJJGmyzSZ2LasKIdHIJ+sjv+XyHW0WBJkKKhlOG59BA60MCj9Jx0XkurrxqHMh
	JqplkbWWR8v9+Ib9lFINIeifPb94+a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715707743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhFxqSph2Kpc8dlFIVs9yDYV0b1uK/DFQ8YJYTOnKik=;
	b=WZFK3LzXuvrFESn0YFCs1M4GR5a+6OO33FcR6v9xfw88p6on1YJHqVnOuL1ig1G82FI37u
	XGGAOllxHGHrhRBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vqAKHvu3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WZFK3LzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715707743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhFxqSph2Kpc8dlFIVs9yDYV0b1uK/DFQ8YJYTOnKik=;
	b=vqAKHvu3Ql6uZvaCLoCAzy3m0eZF7SWJ50iic37H1BEZi6Q40iVjQakRRUwqnsTTRw0vFg
	xUpyEBFFaJJGmyzSZ2LasKIdHIJ+sjv+XyHW0WBJkKKhlOG59BA60MCj9Jx0XkurrxqHMh
	JqplkbWWR8v9+Ib9lFINIeifPb94+a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715707743;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhFxqSph2Kpc8dlFIVs9yDYV0b1uK/DFQ8YJYTOnKik=;
	b=WZFK3LzXuvrFESn0YFCs1M4GR5a+6OO33FcR6v9xfw88p6on1YJHqVnOuL1ig1G82FI37u
	XGGAOllxHGHrhRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5D57137C3;
	Tue, 14 May 2024 17:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tZ9UKF+fQ2Z0cQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 17:29:03 +0000
Date: Tue, 14 May 2024 19:21:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/7] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Message-ID: <20240514172142.GL4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
 <20240514153938.GE4449@twin.jikos.cz>
 <xbrkuvkwzzwufyiqgxve67zwhwf2pxqkiiqsorbnfb3jgdug35@cs32x5a5jkv2>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xbrkuvkwzzwufyiqgxve67zwhwf2pxqkiiqsorbnfb3jgdug35@cs32x5a5jkv2>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF15133690
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Tue, May 14, 2024 at 05:14:39PM +0000, Naohiro Aota wrote:
> On Tue, May 14, 2024 at 05:39:38PM +0200, David Sterba wrote:
> > On Mon, May 13, 2024 at 06:51:26PM -0600, Naohiro Aota wrote:
> > > mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
> > > below.
> > > 
> > > - The FS size needs to be larger than minimal size that can host a btrfs,
> > >   but its calculation does not consider non-SINGLE profile
> > > - The calculation also does not ensure tree-log BG and data relocation BG
> > > - It allows creating a FS not aligned to the zone boundary
> > > - It resets all device zones beyond the specified length
> > > 
> > > This series fixes the issues with some cleanups.
> > > 
> > > Patches 1 to 3 are clean up patches, so they should not change the behavior.
> > > 
> > > Patches 4 to 6 address the issues and the last patch adds a test case.
> > > 
> > > Naohiro Aota (7):
> > >   btrfs-progs: rename block_count to byte_count
> > >   btrfs-progs: mkfs: remove duplicated device size check
> > >   btrfs-progs: mkfs: unify zoned mode minimum size calc into
> > >     btrfs_min_dev_size()
> > >   btrfs-progs: mkfs: fix minimum size calculation for zoned
> > >   btrfs-progs: mkfs: check if byte_count is zone size aligned
> > >   btrfs-progs: support byte length for zone resetting
> > >   btrfs-progs: add test for zone resetting
> > 
> > I did a quick CI check, the mkfs tests fails. You can open a pull
> > request to get your changes tested (it can be just for the testing
> > purpose, if you note that I'll skip it until the final version).
> > 
> > https://github.com/kdave/btrfs-progs/actions/runs/9081685951
> 
> Thank you. I just noticed some workflows are running on my btrfs-progs
> repository too.

Yes, the jobs are matched by the branch names and will start if you have
Actions enabled in the repository.

