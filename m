Return-Path: <linux-btrfs+bounces-13610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C478AAA6FA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E1B7A9873
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68A23C4F8;
	Fri,  2 May 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYrg1DN7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZNfHJ6/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYrg1DN7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rZNfHJ6/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F26EB79
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181823; cv=none; b=bOUjStY6dvozzoPhlHZCaCtzHD0Qbqb4Yoi/EdixIix3VbmV/Qouab+GmTFvO6cp4AUxnRmFGuV6EKtwpex0cduntkvTPAwgdnpNDWPKSbskAdEJsRxqfIEMAb5b6B6jR5sL0SlMKw58g4gsEmU2ExuDSfetLeghy5W/3oMn53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181823; c=relaxed/simple;
	bh=3kNMqTh9H9ygp+57pUlvRr1l2ON0YKc8lAqIAihPrxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipbVm6OiVd1uenYZKkH87wxQbnZZqfur5mCMySbTsg2uNYeSRF3w5GUkqqA4IcPk8CEpEcNhaSc2jdJz6ifajsTlq0OYlH1ngfWYa73/9R58HAKl0dzI49AySzqlz6RXBPfTE+t5QZkS/2sT1bCNYwfVN98etSQBsM3lyvNtZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYrg1DN7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rZNfHJ6/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYrg1DN7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rZNfHJ6/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AC8721171;
	Fri,  2 May 2025 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746181820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Dg8FFm07x6o2vkfqnLLpP2hhONvlOQZM/jwx/yDq4=;
	b=MYrg1DN7xQ336giz5Istmut0rhBXoQd4Z1n26ZqffhPJTipcxlYr2F5UJf2TVEL1BaV62+
	Vd8kLw1tuVoUtY4aqZQEx4h8g0QYCnVxp/hQ5Ug8g3Wn/w7ZYuLowkcD5ScOcReVrlndB9
	GhDz2x9fnUBu6uYSEzGhBm88Gw5qzig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746181820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Dg8FFm07x6o2vkfqnLLpP2hhONvlOQZM/jwx/yDq4=;
	b=rZNfHJ6/FkYNSR3auvJuX6eLWW31hJONLMPz3XKx9pK1YsGnaNkjSiD96NCQSQN3RMMEyy
	7oy9AKqca5wvofBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746181820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Dg8FFm07x6o2vkfqnLLpP2hhONvlOQZM/jwx/yDq4=;
	b=MYrg1DN7xQ336giz5Istmut0rhBXoQd4Z1n26ZqffhPJTipcxlYr2F5UJf2TVEL1BaV62+
	Vd8kLw1tuVoUtY4aqZQEx4h8g0QYCnVxp/hQ5Ug8g3Wn/w7ZYuLowkcD5ScOcReVrlndB9
	GhDz2x9fnUBu6uYSEzGhBm88Gw5qzig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746181820;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3Dg8FFm07x6o2vkfqnLLpP2hhONvlOQZM/jwx/yDq4=;
	b=rZNfHJ6/FkYNSR3auvJuX6eLWW31hJONLMPz3XKx9pK1YsGnaNkjSiD96NCQSQN3RMMEyy
	7oy9AKqca5wvofBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02A6F13687;
	Fri,  2 May 2025 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QtBrALyeFGgIagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 10:30:20 +0000
Date: Fri, 2 May 2025 12:30:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <20250502103014.GN9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250429151800.649010-1-neelx@suse.com>
 <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
 <CAPjX3FdpjOfu61KTnQFKdGgh4u5eVz_AwenoPVNgP_eiuka3hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdpjOfu61KTnQFKdGgh4u5eVz_AwenoPVNgP_eiuka3hw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 30, 2025 at 02:31:33PM +0200, Daniel Vacek wrote:
> On Wed, 30 Apr 2025 at 10:21, Daniel Vacek <neelx@suse.com> wrote:
> >
> > On Wed, 30 Apr 2025 at 10:03, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 05:17:57PM +0200, Daniel Vacek wrote:
> > > > Even super block nowadays uses nodesize for eb->len. This is since commits
> > > >
> > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> > > >
> > > > With these the eb->len is not really useful anymore. Let's use the nodesize
> > > > directly where applicable.
> > >
> > > I've had this patch in my local branch for some years from the times we
> > > were optimizing extent buffer size. The size on release config is 240
> > > bytes. The goal was to get it under 256 and keep it aligned.
> > >
> > > Removing eb->len does not change the structure size and leaves a hole
> > >
> > >  struct extent_buffer {
> > >         u64                        start;                /*     0     8 */
> > > -       u32                        len;                  /*     8     4 */
> > > -       u32                        folio_size;           /*    12     4 */
> > > +       u32                        folio_size;           /*     8     4 */
> > > +
> > > +       /* XXX 4 bytes hole, try to pack */
> > > +
> > >         long unsigned int          bflags;               /*    16     8 */
> > >         struct btrfs_fs_info *     fs_info;              /*    24     8 */
> > >         void *                     addr;                 /*    32     8 */
> > > @@ -5554,8 +5556,8 @@ struct extent_buffer {
> > >         struct rw_semaphore        lock;                 /*    72    40 */
> > >         struct folio *             folios[16];           /*   112   128 */
> > >
> > > -       /* size: 240, cachelines: 4, members: 14 */
> > > -       /* sum members: 238, holes: 1, sum holes: 2 */
> > > +       /* size: 240, cachelines: 4, members: 13 */
> > > +       /* sum members: 234, holes: 2, sum holes: 6 */
> > >         /* forced alignments: 1, forced holes: 1, sum forced holes: 2 */
> > >         /* last cacheline: 48 bytes */
> > >  } __attribute__((__aligned__(8)));
> > >
> > > The benefit of duplicating the length in each eb is that it's in the
> > > same cacheline as the other members that are used for offset
> > > calculations or bit manipulations.
> > >
> > > Going to the fs_info->nodesize may or may not hit a cache, also because
> > > it needs to do 2 pointer dereferences, so from that perspective I think
> > > it's making it worse.
> >
> > I was considering that. Since fs_info is shared for all ebs and other
> > stuff like transactions, etc. I think the cache is hot most of the
> > time and there will be hardly any performance difference observable.
> > Though without benchmarks this is just a speculation (on both sides).
> >
> > > I don't think we need to do the optimization right now, but maybe in the
> > > future if there's a need to add something to eb. Still we can use the
> > > remaining 16 bytes up to 256 without making things worse.
> >
> > This really depends on configuration. On my laptop (Debian -rt kernel)
> > the eb struct is actually 272 bytes as the rt_mutex is significantly
> > heavier than raw spin lock. And -rt is a first class citizen nowadays,
> > often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> > I think it would be nice to slim the struct below 256 bytes even there
> > if that's your aim.
> 
> Eventually we can get there by using ushort for bflags and moving
> log_index and folio_shift to fill the hole.
> Let me know what you think.

The bflags are atomic bits and this requires unsigned long. Also the
short int type is something we want to avoid because it's not a natural
type on many architectures and generates worse code. I don't think we
need to optimize for RT kernels, it's now part of mainline kernel but by
far not a common configuration.

