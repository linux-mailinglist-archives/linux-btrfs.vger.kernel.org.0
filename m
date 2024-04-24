Return-Path: <linux-btrfs+bounces-4517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB08B09CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932F01F258D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5B33989;
	Wed, 24 Apr 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCavUgjz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Gqtdw3g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCavUgjz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Gqtdw3g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08A3398A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962142; cv=none; b=htfPb5ZZGbq/sgZ86RdgUomfjcr/K28Fcfqjvz6oGlVWK+TqaexI340xv+93VVj3mdel6j2HK4JKCAhUoCB1qBltKs55TSxZqR/wkUVaKY94HuFR/3HDhpYQaE0VNUQ67jD/ziU19cwKOAKFphIUv80EZ05Zehcnjys93Go5A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962142; c=relaxed/simple;
	bh=R0XrQmEc5P2dN0ZTl6imuczGjKLFY7Z7veuEsZA+Zjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lch/3x/UTPGoQZc+rUA/GCbO+91Qi4F19rlMAdrJgMX7KiZCqlm4Ee5VMtv8RGfe5Wg2yxtbbef21zIOkNif2+sONeGZ6iqWHMDSdYE3zY4oLhssj1C6EVq8mw5ez1Dd/kP2/A3MikUCG+umwHbmz1qOZQMRmzNLc4OKGLJrV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCavUgjz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Gqtdw3g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCavUgjz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Gqtdw3g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B28D66D92;
	Wed, 24 Apr 2024 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbq3CPP9DH0pfBqaQJp8cIJnSsf5b7I0xU+sxI2amI8=;
	b=cCavUgjzsmtqE4UZeJJMVDe637nitLfZqozXlRx1zQwWs/QazAUPNX6UwYxJ5OHxrUdYvq
	Iiql3BeZpZk0iAhPi6+UrLXR87NmJRBP1K5IzkzDMIh5Qd2CeFmTqo54/kxRkubGErg/Mf
	RMq6rDzQqh8rjKGBdWifEcjqZCxIyVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbq3CPP9DH0pfBqaQJp8cIJnSsf5b7I0xU+sxI2amI8=;
	b=/Gqtdw3gprOguSLMn7aw0INYaijhjPheKsCFMccR1ldMbAE/AGRxO866S8Ze1O7rnbq8Yx
	B6kDTeGZeKKq+jCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cCavUgjz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/Gqtdw3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbq3CPP9DH0pfBqaQJp8cIJnSsf5b7I0xU+sxI2amI8=;
	b=cCavUgjzsmtqE4UZeJJMVDe637nitLfZqozXlRx1zQwWs/QazAUPNX6UwYxJ5OHxrUdYvq
	Iiql3BeZpZk0iAhPi6+UrLXR87NmJRBP1K5IzkzDMIh5Qd2CeFmTqo54/kxRkubGErg/Mf
	RMq6rDzQqh8rjKGBdWifEcjqZCxIyVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mbq3CPP9DH0pfBqaQJp8cIJnSsf5b7I0xU+sxI2amI8=;
	b=/Gqtdw3gprOguSLMn7aw0INYaijhjPheKsCFMccR1ldMbAE/AGRxO866S8Ze1O7rnbq8Yx
	B6kDTeGZeKKq+jCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AEEB1393C;
	Wed, 24 Apr 2024 12:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NPzbHZr8KGYicQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 12:35:38 +0000
Date: Wed, 24 Apr 2024 14:28:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 07/17] btrfs: push extent lock into run_delalloc_nocow
Message-ID: <20240424122805.GM3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713363472.git.josef@toxicpanda.com>
 <60f8e6362e50086d796d8cdd44031d9496398b08.1713363472.git.josef@toxicpanda.com>
 <2dqiyvawsd6g3zxtfhgcmyv7i257l2hhgrd2zcpl3yumugbcnz@twvnaux5ahe6>
 <20240423164914.GA3019378@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423164914.GA3019378@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8B28D66D92
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Tue, Apr 23, 2024 at 12:49:14PM -0400, Josef Bacik wrote:
> On Tue, Apr 23, 2024 at 06:33:25AM -0500, Goldwyn Rodrigues wrote:
> > On 10:35 17/04, Josef Bacik wrote:
> > > run_delalloc_nocow is a bit special as it walks through the file extents
> > > for the inode and determines what it can nocow and what it can't.  This
> > > is the more complicated area for extent locking, so start with this
> > > function.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > 
> > > ---
> > >  fs/btrfs/inode.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 2083005f2828..f14b3cecce47 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -1977,6 +1977,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> > >  	 */
> > >  	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
> > >  
> > > +	lock_extent(&inode->io_tree, start, end, NULL);
> > > +
> > >  	path = btrfs_alloc_path();
> > >  	if (!path) {
> > >  		ret = -ENOMEM;
> > > @@ -2249,11 +2251,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
> > >  	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
> > >  	int ret;
> > >  
> > > -	/*
> > > -	 * We're unlocked by the different fill functions below.
> > > -	 */
> > > -	lock_extent(&inode->io_tree, start, end, NULL);
> > > -
> > 
> > So, you are adding this hunk in the previous patch and (re)moving it here.
> > Do you think it would be better to merge this with the previous patch?
> 
> It depends?  I did it like this so people could follow closely as I pushed the
> locking down.  Most of these "push extent lock into.." patches do a variation of
> this, where I push it down into a function and move the lock down in the set of
> things.  I'm happy to merge them together, but I split it this way so my logic
> could be followed.

The incremental changes are better for review, moving locks affects code
before and after and it's more convienient to review each step as the
amount of information and context is bearable. So I'm fine with the way
you did it.

