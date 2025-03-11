Return-Path: <linux-btrfs+bounces-12201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B3A5CE01
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16BB3B46DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085E2627F7;
	Tue, 11 Mar 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuhiJIl7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jb46Rm2W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuhiJIl7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jb46Rm2W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D67156F3C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718365; cv=none; b=U0Pp307crJxPPEjtQ9AUhQ90x1T/6I1s4KDTog9eUzElyHXia6+67AyITyZd9FFd0NQt/sFennPjjxN21nBMOJ17DbP1CBG1tfciK7aaKnfzq7EkbZnC8ggiXlT+8CZ8dQbKtnyx2fueRXeh/Ej9+qkePx8u5090taykEmwOuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718365; c=relaxed/simple;
	bh=86zmDZOCq62mDynuF5aOpgNGAuG9K0+PxXDOQ1v2j5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYAgiQdwDs+nJFO4Tzc8KUzJ0EivBi4CRCVs76b9TG4uifq5PN6R+BlnhEDagBHmc3nfTK91Dvk1nnjPyfHMVZx1tV3rbBQhVdbK4sPPBG73yyByj9aSejJIPmIkJrslhAIC9riueVH9aazMGhT1UUL71ct/1aoWMRsY5OKaFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuhiJIl7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jb46Rm2W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuhiJIl7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jb46Rm2W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B1A521167;
	Tue, 11 Mar 2025 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741718362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH/xden7Br1cQk3FpcY+BeC9INv8uck2aPvlw667gkk=;
	b=BuhiJIl7+CjXuAojIblAvduD3gFX84Va6nBwbPElxNurJlo6WgNV8L8k8xzukjbQePXD9u
	sbrpZQz2+YtWwmUV1J192SxBq0unDtiEbljm8xpe5E9pBAUz1QyM8ux5ocwaI4Vup60q0q
	2cdGkOFBs5VnOAMSub31k/4g5KRJnRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741718362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH/xden7Br1cQk3FpcY+BeC9INv8uck2aPvlw667gkk=;
	b=Jb46Rm2WQV5K5IRa3UTrAVeVEfp6slEUYoasR5kgZvXJZ/dEevPJRAht3d3K7HkP8yZ8Gp
	NqKjI3fc9/45KvDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741718362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH/xden7Br1cQk3FpcY+BeC9INv8uck2aPvlw667gkk=;
	b=BuhiJIl7+CjXuAojIblAvduD3gFX84Va6nBwbPElxNurJlo6WgNV8L8k8xzukjbQePXD9u
	sbrpZQz2+YtWwmUV1J192SxBq0unDtiEbljm8xpe5E9pBAUz1QyM8ux5ocwaI4Vup60q0q
	2cdGkOFBs5VnOAMSub31k/4g5KRJnRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741718362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TH/xden7Br1cQk3FpcY+BeC9INv8uck2aPvlw667gkk=;
	b=Jb46Rm2WQV5K5IRa3UTrAVeVEfp6slEUYoasR5kgZvXJZ/dEevPJRAht3d3K7HkP8yZ8Gp
	NqKjI3fc9/45KvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0784C132CB;
	Tue, 11 Mar 2025 18:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdZVAVqD0GdAJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 18:39:22 +0000
Date: Tue, 11 Mar 2025 19:39:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Message-ID: <20250311183916.GH32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740753608.git.dsterba@suse.com>
 <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
 <0cb33e7e-4390-4647-a277-221f9ddf3640@wdc.com>
 <46d9ffa1-3cad-4192-9d8a-5c37ea3a33e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d9ffa1-3cad-4192-9d8a-5c37ea3a33e8@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 11, 2025 at 09:11:52AM +0900, Damien Le Moal wrote:
> On 3/11/25 01:38, Johannes Thumshirn wrote:
> > On 28.02.25 15:49, David Sterba wrote:
> >> Add a new ioctl that is an extensible version of FITRIM. It currently
> >> does only the trim/discard and will be extended by other modes like
> >> zeroing or block unmapping.
> >>
> >> We need a new ioctl for that because struct fstrim_range does not
> >> provide any existing or reserved member for extensions. The new ioctl
> >> also supports TRIM as the operation type.
> >>
> >> Signed-off-by: David Sterba <dsterba@suse.com>
> > 
> > [...]
> > 
> > I /think/ we need some extra checks for zoned here. blkdev_issue_zeroout 
> > won't work on zoned devices IFF the 'start' range is not aligned to the 
> > write pointer. Also blkdev_issue_discard() on 'unused space' of a zoned 
> > filesystem won't do what a user is expecting.
> 
> Zoned SAS HDDs can support discard on conventional zones. And if they do not, we
> can still do the emulated zeroout on conventional zones.
> For sequential zones, we can do a zone reset of all zones that have been written
> but have all blocks free (so unused).
> 
> > 
> > I think this needs:
> > 
> >> +static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
> >> +{
> >> +	struct btrfs_fs_info *fs_info;
> >> +	struct btrfs_ioctl_clear_free_args args;
> >> +	u64 total_bytes;
> >> +	int ret;
> >> +
> >> +	if (!capable(CAP_SYS_ADMIN))
> >> +		return -EPERM;
> > 
> > 	if (btrfs_is_zoned(fs_info))
> > 		return -EOPNOTSUPP;
> 
> With the above observations, this may be a bit too harsh. Though it is probably
> fine for now for zones, but adding a comment mentioning the above things we
> could do may be good as a reminder for later improvements.

Thanks for the info, I'll update the comment.

