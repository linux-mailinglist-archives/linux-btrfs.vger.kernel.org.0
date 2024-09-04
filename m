Return-Path: <linux-btrfs+bounces-7819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B901596C61C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FB2823AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973D1E1A3C;
	Wed,  4 Sep 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vi1vN08X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgQhpFRs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vi1vN08X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgQhpFRs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A01E1A26
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473648; cv=none; b=jaFbCT1I8Vyrk+cLsS70C3/QhzjQpvgyB1IrZdU3d57X4qUXYH+a4bPNW268eUqQGC9/BLvA8XjEC9sT369q+2QIFHMohhZQOW18ff2xJy9zTxT96+INhe2oaTsUdUHwf+QOgNxQdp5NV8+xFyj1xSEzQuRxAh+zL5AoiaSK18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473648; c=relaxed/simple;
	bh=H/2/GlaknOKdILw2aVnucb97S1yPRqmvCP39hshcyiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQDKbKpoUMAs65XvmNkPfOMQaCMREnjkXI709ZSD4pRIbcg1bAgZxgwzIEjdliFeOB0/qPm1eYu52OBJqcLH+xn2Z6g85YiJ5NO1pIDu1f6+rak+6No9eyjbhjRyi+bOyXKBgw9qXlwgvn1QVIT1R2/+leK7DCWFIkJF2YWCvPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vi1vN08X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgQhpFRs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vi1vN08X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgQhpFRs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E97D1F7DC;
	Wed,  4 Sep 2024 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725473644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12JFllJV9q9VHnhOlxCwwmfI9yG33pP/+FMflM4T/lw=;
	b=Vi1vN08XjpIdXJOpYZI3zsasNuLefe5SRrdz2GbxZtaZ+2/7UjSUkbSfg8X2INhdhAzX/H
	LTIXF5GhEZn61PZ4NuQEZ3NenPkhvcgvT4JR+Ex9ZBLNRbHAmb/IgVzzaSfe1/qYSn1GJC
	APULqEc096uyUesKbbK5ePksyTjztd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725473644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12JFllJV9q9VHnhOlxCwwmfI9yG33pP/+FMflM4T/lw=;
	b=qgQhpFRs+Rky+dgNmusAftwjGEbsqtMhM7ldupuwegFkSqB6WrKcuSImlmnf6575+v7YYe
	FayZ+R69zCsq1tDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725473644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12JFllJV9q9VHnhOlxCwwmfI9yG33pP/+FMflM4T/lw=;
	b=Vi1vN08XjpIdXJOpYZI3zsasNuLefe5SRrdz2GbxZtaZ+2/7UjSUkbSfg8X2INhdhAzX/H
	LTIXF5GhEZn61PZ4NuQEZ3NenPkhvcgvT4JR+Ex9ZBLNRbHAmb/IgVzzaSfe1/qYSn1GJC
	APULqEc096uyUesKbbK5ePksyTjztd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725473644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12JFllJV9q9VHnhOlxCwwmfI9yG33pP/+FMflM4T/lw=;
	b=qgQhpFRs+Rky+dgNmusAftwjGEbsqtMhM7ldupuwegFkSqB6WrKcuSImlmnf6575+v7YYe
	FayZ+R69zCsq1tDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55E22139D2;
	Wed,  4 Sep 2024 18:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +4JyFGyj2Ga/OQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 04 Sep 2024 18:14:04 +0000
Date: Wed, 4 Sep 2024 20:14:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"xuefer@gmail.com" <xuefer@gmail.com>, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: handle broken write pointer on zones
Message-ID: <20240904181402.GQ26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6a8b1550cef136b1d733d5c1016a7ba717335344.1725035560.git.naohiro.aota@wdc.com>
 <20240902203127.GD26776@twin.jikos.cz>
 <3ywwsqnv5zzsppcp6njl2tb4wtta57arokdnonkos6dp37ndy4@cirv6lhl4dpw>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ywwsqnv5zzsppcp6njl2tb4wtta57arokdnonkos6dp37ndy4@cirv6lhl4dpw>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com,bupt.moe];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Sep 04, 2024 at 12:31:34AM +0000, Naohiro Aota wrote:
> On Mon, Sep 02, 2024 at 10:31:27PM GMT, David Sterba wrote:
> > On Sat, Aug 31, 2024 at 01:32:49AM +0900, Naohiro Aota wrote:
> > > Btrfs rejects to mount a FS if it finds a block group with a broken write
> > > pointer (e.g, unequal write pointers on two zones of RAID1 block group).
> > > Since such case can happen easily with a power-loss or crash of a system,
> > > we need to handle the case more gently.
> > > 
> > > Handle such block group by making it unallocatable, so that there will be
> > > no writes into it. That can be done by setting the allocation pointer at
> > > the end of allocating region (= block_group->zone_capacity). Then, existing
> > > code handle zone_unusable properly.
> > 
> > This sounds like the best option, this makes the zone read-only and
> > relocation will reset it back to a good state. Alternatives like another
> > state or error bits would need tracking them and increase complexity.
> > 
> > > Having proper zone_capacity is necessary for the change. So, set it as fast
> > > as possible.
> > > 
> > > We cannot handle RAID0 and RAID10 case like this. But, they are anyway
> > > unable to read because of a missing stripe.
> > > 
> > > Fixes: 265f7237dd25 ("btrfs: zoned: allow DUP on meta-data block groups")
> > > Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
> > > CC: stable@vger.kernel.org # 6.1+
> > > Reported-by: HAN Yuwei <hrx@bupt.moe>
> > > Cc: Xuefer <xuefer@gmail.com>
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > 
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > 
> > > @@ -1650,6 +1653,23 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
> > >  		goto out;
> > >  	}
> > >  
> > > +	if (ret == -EIO && profile != 0 && profile != BTRFS_BLOCK_GROUP_RAID0 &&
> > > +	    profile != BTRFS_BLOCK_GROUP_RAID10) {
> > > +		/*
> > > +		 * Detected broken write pointer.  Make this block group
> > > +		 * unallocatable by setting the allocation pointer at the end of
> > > +		 * allocatable region. Relocating this block group will fix the
> > > +		 * mismatch.
> > > +		 *
> > > +		 * Currently, we cannot handle RAID0 or RAID10 case like this
> > > +		 * because we don't have a proper zone_capacity value. But,
> > > +		 * reading from this block group won't work anyway by a missing
> > > +		 * stripe.
> > > +		 */
> > > +		cache->alloc_offset = cache->zone_capacity;
> > 
> > Mabe print a warning, this looks like a condition that should be
> > communicated back to the user.
> 
> It already prints "zoned: write pointer offset mismatch of zones in %s
> profile". But, I'll add a message to inform that this block group is set
> read-only and btrfs balance is desired.

Ok good that there's another message. I've forwarded the unchanged patch
to master branch so if we really want the additional message please send
it as followup patch. Thanks.


