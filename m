Return-Path: <linux-btrfs+bounces-20298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6FFD06289
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 21:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56959301D0E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F452330D3B;
	Thu,  8 Jan 2026 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzZrAF9g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mlxd31bS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cRR1gSM/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/onstf33"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E831B815
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905111; cv=none; b=HFqma5UZoB3B2vVw8D1UuIUZ3p5FYirBng7brkxdcZhQ9Y2RryR8t9J0+FOGKZfxlkPJFMnUdIZcogwUsvqYu/oSoOrqEO5GRfXaIjjr6P2A6jvBKyrC7EFCorYeaZejtVa3rEzsMRbZYgbNfq+R/BYTuja8rGo5gnhZ8Y6uEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905111; c=relaxed/simple;
	bh=mJWRVoRrMRx6XMy3CfajuSYR3llMohc2rtNd5KWftZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYgSnqQem8OIbESsAatmMkP7Hbmytqhe/1X1JLXsY+H0yNve+/pBQYtD+7VtCkc9Pl2I4HRRA0x9MYYH4pezTJ3K08s1T0azBxdvUC1zF/LFWr33GCnok2eyj3LccOYo2aApV72Pxih0mXYueWICGAFsxvUV5IopjFnQRUPqXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzZrAF9g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mlxd31bS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cRR1gSM/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/onstf33; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 186095BF85;
	Thu,  8 Jan 2026 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767905108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQLnUVLkMj5/R3Yx8cj/bD2x2/Wqyv7hdkkysJyaXgw=;
	b=UzZrAF9gaGgKnkFLfqsDEwqxrAFZxLROYovmHM15fuQI1P/srC7V6ui4KYTmSFoh+4HmeP
	VKkOb1xsYw6INEsVst3oiVG/iLVmD8dsoQvi+0updCygaVc0krI+aGNX3zU4BuEA6Il3W3
	Jvt+5DjTiE/oLW1IwX+IzNc4zBdf2lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767905108;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQLnUVLkMj5/R3Yx8cj/bD2x2/Wqyv7hdkkysJyaXgw=;
	b=Mlxd31bSnbBsOOt6l/ITJ5w2yDHB0kbtkiLOyTuwGP2wdcg1gqxdDPxZ2a1vAUrMMxyEzA
	h/3UFtaYEoySmlAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767905107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQLnUVLkMj5/R3Yx8cj/bD2x2/Wqyv7hdkkysJyaXgw=;
	b=cRR1gSM/87r15GdzNgMLVEE8MdeEg4jaWU9yC5B8+klubO2uETGkqMG8h031/MzhbmMQ0j
	zP9UZmxqjAzhCKbTwvh+AJfpxF2f0Esu9aynxuSS4d6RJIz1S/P2BjzkaHD+ITgB5xMDql
	7UGuCKwlq9cmUHqThm2bCHEml23+x6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767905107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQLnUVLkMj5/R3Yx8cj/bD2x2/Wqyv7hdkkysJyaXgw=;
	b=/onstf33Cdk1IyrZvxfMbvf8lW+gpyWylB7Go+gsH/JJSWg5aB8evtddXht9hq29SlSgXm
	WeBLsnZ6P7L54tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 005403EA63;
	Thu,  8 Jan 2026 20:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Am+DO1IXYGkMNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 20:45:06 +0000
Date: Thu, 8 Jan 2026 21:45:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: unify types for binary search variables
Message-ID: <20260108204505.GI21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767716314.git.dsterba@suse.com>
 <3fb05ea43fb3967a6327c2c0bf81f23fe2e57c82.1767716314.git.dsterba@suse.com>
 <20260107193352.GC2216040@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107193352.GC2216040@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Jan 07, 2026 at 11:33:52AM -0800, Boris Burkov wrote:
> On Tue, Jan 06, 2026 at 05:20:25PM +0100, David Sterba wrote:
> > The variables calculating where to jump next are useing mixed in types
> > which requires some conversions on the instruction level. Using 'u32'
> > removes one call to 'movslq', making the main loop shorter.
> > 
> > This complements type conversion done in a724f313f84beb ("btrfs: do
> > unsigned integer division in the extent buffer binary search loop")
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/ctree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 1eef80c2108331..0a7ee47aa8aaab 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -766,7 +766,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
> 
> Does converting first_slot to u32 also add a movslq?

No, still a plain mov but there's some other effect that removes 2
reloads of the 2nd parameter to some other temporary register. I did not
expect that, there's more instruction level tuning ahead.

> Also, why the "q"? Isn't everything 32 bit sized here? surprised to see
> it go to quad.


> 
> >  		unsigned long offset;
> >  		struct btrfs_disk_key *tmp;
> >  		struct btrfs_disk_key unaligned;
> > -		int mid;
> > +		u32 mid;
> 
> shouldn't it be unsigned long long to theoretically avoid overflow? Not
> really sure why we are storing "nritems" as a u32, I doubt we ever want
> 4 billion items in a leaf :)

I don't think overflow can happen as the bounds are checked in many
place before it gets to the bin search. The type width
(btrfs_header::nritems) could be u16 and still cover the 64k leaves as
the item isu >=4 for this to work.

> If there was a format enforcable limit, I suppose we could make the
> low/high smaller unsigned types?

For the format it could be smaller in case we'd want to squeeze every
byte out of that, but this is for the time when the format is designed
and it's not now. At that time one does not know what would be needed so
the types are chosen to be enough, while today we know well how it's
used but can't go back to change the format.

The header size is 101 bytes, what could be reduced in size is flags and
nritems, potentialy reducing it by 8 bytes to 93 (92%). This is per
node/leaf, there are thousands per filesystem. On the biggest one I have
next to me (20T) there are about 1.2m nodes, the metadata size is 21G. The
savings translate to something like 160MiB. So yes it not zero.

For the calculations u32 is more convenient as it matches the native
register size on many architectures.

