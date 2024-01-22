Return-Path: <linux-btrfs+bounces-1616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7308374A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4E28D862
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068947F51;
	Mon, 22 Jan 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFszQhK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YpyzOU6/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qFszQhK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YpyzOU6/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF147F46
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956837; cv=none; b=SmFmD1ekDnlL91c5bR3LUYrGJ5JNM+q1tsajwLs384YYin6dPk5Wz7LjwVRGIjrqVGoqSO4+PHCg8d7rYI/NU0CrLQY3OtU2qd+GHt9Ab8Lc87hgtsfp8v0x+tVsI2Nb/qcry62lh6UhcwzQLEWQQ3VlmHV4EtDvADpKnIDZ9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956837; c=relaxed/simple;
	bh=ksnddxl59Cpy8GT+e9HrFKCSyknMGZpbQ5ZlEh1h1fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC/ntOb2md1PMUM1WxGFU3oQVhzgnDS2+yWqDcTM/i/j9PlT6Qa1hE9lRSg1Vj+w4//DM0A/EMExJ4b+i3v6MrNjhTnbLybdO+erZQ51UX6Tw01XlWLrGFJoehrTx1AIoygz7Wo9PZXRTFoMbXXLTRQblXzdP/adLmWtyqMlgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFszQhK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YpyzOU6/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qFszQhK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YpyzOU6/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B922621F1C;
	Mon, 22 Jan 2024 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/lBhtIgK4rWuy0zJ5t4Iinu2l10X/5JpoAGXM2c7hI=;
	b=qFszQhK/jKZN+vpm+IVSa57h542MuKDiGCPSo3bRogjdIXVMibeBbVznFCiICPvUV3Kwqp
	XKP5cKK9ef0jgyMSx3bT8c0mugjaE2ap2LjCIK0GOXIVf/L5+YwiChRwX4QrocXPXangP9
	SCp7a89WmnMBYrz/J/NCMyZb3kOEKZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/lBhtIgK4rWuy0zJ5t4Iinu2l10X/5JpoAGXM2c7hI=;
	b=YpyzOU6/51vM/Vv7naMqWK6TMQGcz8nqqzkt1KX9MhGm0up6e41dMptZK3TThADs4kYSJV
	Z4OTTYlycjQi2aBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/lBhtIgK4rWuy0zJ5t4Iinu2l10X/5JpoAGXM2c7hI=;
	b=qFszQhK/jKZN+vpm+IVSa57h542MuKDiGCPSo3bRogjdIXVMibeBbVznFCiICPvUV3Kwqp
	XKP5cKK9ef0jgyMSx3bT8c0mugjaE2ap2LjCIK0GOXIVf/L5+YwiChRwX4QrocXPXangP9
	SCp7a89WmnMBYrz/J/NCMyZb3kOEKZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l/lBhtIgK4rWuy0zJ5t4Iinu2l10X/5JpoAGXM2c7hI=;
	b=YpyzOU6/51vM/Vv7naMqWK6TMQGcz8nqqzkt1KX9MhGm0up6e41dMptZK3TThADs4kYSJV
	Z4OTTYlycjQi2aBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D4A213310;
	Mon, 22 Jan 2024 20:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bxA0JuHVrmVbfAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:53:53 +0000
Date: Mon, 22 Jan 2024 21:53:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/4] btrfs: convert relocate_one_page() to
 relocate_one_folio()
Message-ID: <20240122205332.GZ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <b723970ca03542e6863442ded58651cfcdb8fe24.1705605787.git.rgoldwyn@suse.com>
 <20240118214347.GC1356080@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118214347.GC1356080@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[15.25%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Thu, Jan 18, 2024 at 01:43:47PM -0800, Boris Burkov wrote:
> On Thu, Jan 18, 2024 at 01:46:39PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > -static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
> > +static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
> >  			     const struct file_extent_cluster *cluster,
> > -			     int *cluster_nr, unsigned long page_index)
> > +			     int *cluster_nr, unsigned long index)
> >  {
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >  	u64 offset = BTRFS_I(inode)->index_cnt;
> >  	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
> >  	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
> > -	struct page *page;
> > -	u64 page_start;
> > -	u64 page_end;
> > +	struct folio *folio;
> > +	u64 start;
> > +	u64 end;
> 
> This patch throws out this function labelling the start/index/end with
> 'page_' which I think was pretty useful given the other starts/ends like
> 'extent_' and 'clamped_'. Namespacing the indices makes the code easier
> to follow, IMO.

With all the other prefixes around I agree that keeping folio_ (as
replacement of page_) would be useful.

