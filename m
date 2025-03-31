Return-Path: <linux-btrfs+bounces-12696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5BA76FEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 23:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69613AA18E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938721B9D9;
	Mon, 31 Mar 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuPUSl3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySeR+uMF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuPUSl3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySeR+uMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36E211A0D
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455446; cv=none; b=sDJBCLPPu9K7BgZ9iKeDFI2O4pFZQlJqo8bb8g42XoC+jSjBcPzFM6saCuxzMy8vjXDKvnpTVNAAxWfAJ7B5SEKPTYHcETXBpxLtqglbYrgasijpzCEkQJ52cjMptqOHgfkZ1QY2BBXZLIOgtd6XpYoAc136fgSYj8eG3CTli+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455446; c=relaxed/simple;
	bh=CXAjLWLS+ZqhwyjOvFjTyS+AFIv0YDbu+2c/kZ4EpiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeUpZJ64ysLSR492Cn7W3nzW4WJVhPgfyiloh25PNwtcSAfExPzoLmaQXUbsbCJwj+2dG7U9P21+vUlnBRUthdw+BCYb2zfH/pRYILe2TvETdr8OEa90EwVIYnTTGv7N3oe5H0/aLOB6TUosO/cPpKlyRQMjh0LIfXnaqCxGl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuPUSl3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySeR+uMF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuPUSl3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySeR+uMF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CC55211EB;
	Mon, 31 Mar 2025 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743455442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8Bnx+lg9m+XmIAQJ5BLaUyxOdjCVKpspwLhTMVsKw=;
	b=uuPUSl3fHPXiAMponw6WggJ3MrXfnLX3qYvbGKrufU2jE0mSRw5kgClSD/mmVMBqXO6dgR
	kFsZClumUTrriQ7WZl9grDNo1x26NyEroxuGRYDl4y+prl3+D3FVRkNGL4vGijUyJ8um1+
	awAUaC0HsHtUMw1BFDrf63tGzHRlwsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743455442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8Bnx+lg9m+XmIAQJ5BLaUyxOdjCVKpspwLhTMVsKw=;
	b=ySeR+uMFFv4FVGjOf+ZC5H2UvYaSZhQwBVwG9XV32kThK3fk1fe4o3gMz3AsF8HexhlMGi
	EuvzBLL9VlqiqXCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uuPUSl3f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ySeR+uMF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743455442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8Bnx+lg9m+XmIAQJ5BLaUyxOdjCVKpspwLhTMVsKw=;
	b=uuPUSl3fHPXiAMponw6WggJ3MrXfnLX3qYvbGKrufU2jE0mSRw5kgClSD/mmVMBqXO6dgR
	kFsZClumUTrriQ7WZl9grDNo1x26NyEroxuGRYDl4y+prl3+D3FVRkNGL4vGijUyJ8um1+
	awAUaC0HsHtUMw1BFDrf63tGzHRlwsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743455442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB8Bnx+lg9m+XmIAQJ5BLaUyxOdjCVKpspwLhTMVsKw=;
	b=ySeR+uMFFv4FVGjOf+ZC5H2UvYaSZhQwBVwG9XV32kThK3fk1fe4o3gMz3AsF8HexhlMGi
	EuvzBLL9VlqiqXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43BF1139A1;
	Mon, 31 Mar 2025 21:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VfUGENIE62ebLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 31 Mar 2025 21:10:42 +0000
Date: Mon, 31 Mar 2025 23:10:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use rb_entry_safe() where possible to simplify
 code
Message-ID: <20250331211039.GK32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250327161918.1406913-1-dsterba@suse.com>
 <55112570-95ed-4a63-9f30-7d041cd8e72c@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55112570-95ed-4a63-9f30-7d041cd8e72c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 5CC55211EB
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 31, 2025 at 03:36:15PM +0000, Johannes Thumshirn wrote:
> On 27.03.25 17:19, David Sterba wrote:
> > diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> > index 7f46abbd6311b2..d62c36a0b7ba41 100644
> > --- a/fs/btrfs/extent_map.c
> > +++ b/fs/btrfs/extent_map.c
> > @@ -361,8 +361,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
> >   
> >   	if (em->start != 0) {
> >   		rb = rb_prev(&em->rb_node);
> > -		if (rb)
> > -			merge = rb_entry(rb, struct extent_map, rb_node);
> > +		merge = rb_entry_safe(rb, struct extent_map, rb_node);
> > +
> >   		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
> >   			em->start = merge->start;
> >   			em->len += merge->len;
> > @@ -379,8 +379,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
> >   	}
> >   
> >   	rb = rb_next(&em->rb_node);
> > -	if (rb)
> > -		merge = rb_entry(rb, struct extent_map, rb_node);
> > +	merge = rb_entry_safe(rb, struct extent_map, rb_node);
> > +
> >   	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
> >   		em->len += merge->len;
> >   		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
> 
> 
> Nothing to do with your patch, but how does this even work? If 'merge' 
> is NULL we pass it into can_merge_extent_map() which does not check if 
> it is NULL and goes ahead and dereferences ->flags right in the beginning.

If merge is NULL then rb was NULL and is checked in the 'if' before
passing it to can_merge_extent_map().

