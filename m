Return-Path: <linux-btrfs+bounces-1902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55617840AA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 16:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9181B2124B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A51552F5;
	Mon, 29 Jan 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDw/saMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+3d39lg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDw/saMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+3d39lg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B55D747
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543774; cv=none; b=r2YRHV0vOdJdx0gdqxTW5P4kpzvWY9c5szTGtOyTrMCmDG+vvhbJRU+SsMJAq37z9zm1vUQg7qC/uqpDiSvG39M9mWOmdMChwu54jgvKINCgMB1MmSM1YKMMsMBG3OiicTOiNCrBcnw5P1a2Y9pmmqmewl0WmxvNb95/xutpe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543774; c=relaxed/simple;
	bh=YWHr5K5XN9UqXBZyL+NPML2jp6EMY29d9QyYuB8Z+Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf0TxA5rO73bwNFdhCA4iRzZi7N3/Naat8OST47VxzUp67P5nnI5lf+fT4Rjtjt0AWFJDYU4mQs1dHUOhSskCtzVVZ9MxZji7tLf9qBi6Q8FlSoA77wmUT9B4IFho/EK4p0ZKb/XkQEBriCxpgakF7tRDI65dfyISEMzsmADhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDw/saMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+3d39lg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDw/saMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+3d39lg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1797B1F7EF;
	Mon, 29 Jan 2024 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y66IN2rWBimuqaICL1JVaq6rvEv0gzqdtaCyeX1G/MM=;
	b=SDw/saMTC0pocDaHtFs6W+6ecYCKsCtXMSTKBItkllL7wikRT1acgtBZL0cLIroVG8Fd6J
	ImaTWSaS/T0Fsq4N55rR14tDuwdKmEt8+Gf2hQ/a1rpmDZNCTKZqPhoxRY9qufbmaQ6jTf
	X9IXSJGPmzGmHQyaw5KhCAUCSU6khqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y66IN2rWBimuqaICL1JVaq6rvEv0gzqdtaCyeX1G/MM=;
	b=b+3d39lgciqmmiG7jRNwlxyhjm8hczagApykLvUHP8WU/+hL8PKsUzzVDh8bbyGBbylAP3
	h4q4BXf0r3GBfrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706543771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y66IN2rWBimuqaICL1JVaq6rvEv0gzqdtaCyeX1G/MM=;
	b=SDw/saMTC0pocDaHtFs6W+6ecYCKsCtXMSTKBItkllL7wikRT1acgtBZL0cLIroVG8Fd6J
	ImaTWSaS/T0Fsq4N55rR14tDuwdKmEt8+Gf2hQ/a1rpmDZNCTKZqPhoxRY9qufbmaQ6jTf
	X9IXSJGPmzGmHQyaw5KhCAUCSU6khqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706543771;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y66IN2rWBimuqaICL1JVaq6rvEv0gzqdtaCyeX1G/MM=;
	b=b+3d39lgciqmmiG7jRNwlxyhjm8hczagApykLvUHP8WU/+hL8PKsUzzVDh8bbyGBbylAP3
	h4q4BXf0r3GBfrCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA579132FA;
	Mon, 29 Jan 2024 15:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WjQXNZrKt2VSIQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jan 2024 15:56:10 +0000
Date: Mon, 29 Jan 2024 16:55:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: handle invalid root reference found in
 btrfs_find_root()
Message-ID: <20240129155546.GY31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706130791.git.dsterba@suse.com>
 <0011782bc0af988fc393ae8cee8b2d761def05d4.1706130791.git.dsterba@suse.com>
 <73f3c94a-7661-411a-8c86-f309d3acd329@gmx.com>
 <20240125162818.GP31555@twin.jikos.cz>
 <94ce38d7-9a02-4d7a-a5d3-2e703eef121e@gmx.com>
 <20240126141927.GA1612357@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126141927.GA1612357@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.com,suse.cz,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Jan 26, 2024 at 09:19:27AM -0500, Josef Bacik wrote:
> On Fri, Jan 26, 2024 at 09:44:52AM +1030, Qu Wenruo wrote:
> > 
> > 
> > On 2024/1/26 02:58, David Sterba wrote:
> > > On Thu, Jan 25, 2024 at 02:33:53PM +1030, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > On 2024/1/25 07:48, David Sterba wrote:
> > > > > The btrfs_find_root() looks up a root by a key, allowing to do an
> > > > > inexact search when key->offset is -1.  It's never expected to find such
> > > > > item, as it would break allowed the range of a root id.
> > > > > 
> > > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > > ---
> > > > >    fs/btrfs/root-tree.c | 9 ++++++++-
> > > > >    1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > > > > index ba7e2181ff4e..326cd0d03287 100644
> > > > > --- a/fs/btrfs/root-tree.c
> > > > > +++ b/fs/btrfs/root-tree.c
> > > > > @@ -82,7 +82,14 @@ int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
> > > > >    		if (ret > 0)
> > > > >    			goto out;
> > > > >    	} else {
> > > > > -		BUG_ON(ret == 0);		/* Logical error */
> > > > > +		/*
> > > > > +		 * Key with offset -1 found, there would have to exist a root
> > > > > +		 * with such id, but this is out of the valid range.
> > > > > +		 */
> > > > > +		if (ret == 0) {
> > > > > +			ret = -EUCLEAN;
> > > > > +			goto out;
> > > > > +		}
> > > > 
> > > > Considering all root items would already be checked by tree-checker,
> > > > I'd prefer to add an extra "key.offset == (u64)-1" check, and convert
> > > > this to ASSERT(ret == 0), so that we won't need to bother the impossible
> > > > case (nor its error messages).
> > > 
> > > I did not think about tree-checker in this context and it actually does
> > > verify offsets of the item keys so it's already prevented, assuming such
> > > corrupted issue would come from the outside.
> > 
> > If the root item is fine, but it's some runtime memory bitflip, then I'd
> > say if hitting an ASSERT() is really the last time we need to consider.
> > 
> > Furthermore, we have further safenet at metadata write time, which would
> > definitely lead to a transaction abort.
> > 
> > > 
> > > Assertions are not very popular in release builds and distros turn them
> > > off. A real error handling prevents propagating an error further to the
> > > code, so this is for catching bugs that could happen after tree-checker
> > > lets it pass with valid data but something sets wrong value to offset.
> > > 
> > > The reasoning I'm using is to have full coverage of the error values as
> > > real handling with worst case throwing an EUCLEAN. Assertions are not
> > > popular in release builds and distros turn them off so it's effectively
> > > removing error handling and allowing silent errors.
> > > 
> > Yep, I know ASSERT() is not popular in release builds.
> > 
> > But in this case, if tree-checker didn't catch such corruption, but some
> > runtime memory biflip (well, no single bitflip can result to -1) or
> > memory corruption created such -1 key offset, and ASSERT() is ignoring it.
> > 
> > That would still be fine, as our final write time tree-checker would
> > catch and abort current transaction.
> > 
> > So yes, I want to use ASSERT() intentionally here, because we're still
> > fine even it's not properly caught.
> > 
> > And again back to the old discussion on EUCLEAN, I really want it to be
> > noisy enough immediately, not waiting for the caller layers up the call
> > chain to do their error handling.
> 
> We can have both.
> 
> This patch series is removing BUG_ON()'s, and this is the correct change for
> that.
> 
> If we need followups to harden the tree checker that's valuable work too, but
> that's a followup and doesn't mean this series needs changing.
> 
> With CONFIG_BTRFS_DEBUG on we're going to get a WARN_ON when this thing trips
> and we'll see it in fstests.  Thanks,

I'd propose something different than an ASSERT for handling the EUCLEAN
cases. To make it print a WARN_ON under debug and with a message (all
builds).

The first step is to handle all the errors so I'd like not to mix it
with series. There are about 255 EUCLEAN cases (and possibly more
missing), that's a lot so we need to have a common way to handle them
instead of randomly adding ASSERT(0), duplicating an error condition
in the assert or doing thinsg like WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG).

