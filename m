Return-Path: <linux-btrfs+bounces-16526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA37B3BD6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886537B77A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595BF320398;
	Fri, 29 Aug 2025 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uedqGsrX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yEEx/HCw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uedqGsrX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yEEx/HCw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD9320388
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477399; cv=none; b=KxEo24FynAwNbazoHWz/Q4pYcVmyvNE2WE6WGP3SU+tp/F2dHpvXsmJ95H/XsvN+7Wlhrj5E0TKEPCPmFZ4sH4uLtG3oU/V0uQVBPLoQ1saHrnmD3V8T8Bz2fBM3FmQG6mNWM6B3jLTKaNDg1pJwgVGyGXzf0aPH6CJNrPr88/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477399; c=relaxed/simple;
	bh=rVjDOx+bAbVwqYj5OIvERXsPW/bcL3SXcqngZ43CR+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLslVuB+ug/xWzGhM3JXdtWsKxLyHdNCOMc9EAiCOP+tQky6ihwJDk5NY5x0ni8GLx3QXVVi2GHaHa70YyZyAyNUg2Qde0fn0+1OA+3Zq/RRsL6ihFk7brKHPXF7A+WTostqLeRXlKCFON9tOO2d6ObUl5ypchU1MfU0mcDV0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uedqGsrX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yEEx/HCw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uedqGsrX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yEEx/HCw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27380225FF;
	Fri, 29 Aug 2025 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756477396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTeI0W2thrMnJ8XZO2hw97yFU+IPnNrDxNwS3aAOU3c=;
	b=uedqGsrXlZRNXfLtELnSIhFqM0g21XGXAmySiBUhhGUdIJI/86C6zUDNID6CFV5LcYqhSY
	4C2uwN4BIJFBkfa2szeLlAvNltUDyG2ln0L8kxSzILZPrcHLwXr6xRsISvj496kpPwChg/
	qdsz597ND35SnQ0Ar/eT15bxmvovmcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756477396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTeI0W2thrMnJ8XZO2hw97yFU+IPnNrDxNwS3aAOU3c=;
	b=yEEx/HCwjCB9OJQyQ1EkNPA0wUIGq+scaslFngAd+HiD9dLHTDePefXjwF43V2nX+Fyc/g
	0H3Urmg4a259+yBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uedqGsrX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="yEEx/HCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756477396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTeI0W2thrMnJ8XZO2hw97yFU+IPnNrDxNwS3aAOU3c=;
	b=uedqGsrXlZRNXfLtELnSIhFqM0g21XGXAmySiBUhhGUdIJI/86C6zUDNID6CFV5LcYqhSY
	4C2uwN4BIJFBkfa2szeLlAvNltUDyG2ln0L8kxSzILZPrcHLwXr6xRsISvj496kpPwChg/
	qdsz597ND35SnQ0Ar/eT15bxmvovmcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756477396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTeI0W2thrMnJ8XZO2hw97yFU+IPnNrDxNwS3aAOU3c=;
	b=yEEx/HCwjCB9OJQyQ1EkNPA0wUIGq+scaslFngAd+HiD9dLHTDePefXjwF43V2nX+Fyc/g
	0H3Urmg4a259+yBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D32E13A3E;
	Fri, 29 Aug 2025 14:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yrUIA9S3sWheEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Aug 2025 14:23:16 +0000
Date: Fri, 29 Aug 2025 16:23:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
Message-ID: <20250829142314.GK29826@suse.cz>
Reply-To: dsterba@suse.cz
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
 <20250828232346.GD29826@twin.jikos.cz>
 <aLEfAc75VnQ5pcwu@telecaster>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLEfAc75VnQ5pcwu@telecaster>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,suse.com,gmail.com,bur.io];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 27380225FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71

On Thu, Aug 28, 2025 at 08:31:13PM -0700, Omar Sandoval wrote:
> On Fri, Aug 29, 2025 at 01:23:46AM +0200, David Sterba wrote:
> > On Tue, Aug 26, 2025 at 01:01:38PM -0700, Omar Sandoval wrote:
> > > Fix it by only deleting the xarray entry if it matches the given inode
> > > (using __xa_cmpxchg()).
> > > 
> > > Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root")
> > 
> > Is this correct Fixes commit? The xarray conversion was done in two
> > steps, first the rbtree to xarray and then the locking got changed in
> > e2844cce75c9e6 ("btrfs: remove inode_lock from struct btrfs_root and use
> > xarray locks").
> 
> Yes, this is the correct Fixes commit. inode_lock didn't synchronize
> with the VFS's inode hash at all, so it didn't help with this. The
> reason it was okay with the rbtree was that each struct btrfs_inode had
> its own rb_node, so deleting one wouldn't affect any others with the
> same ino.

I see, thanks.

