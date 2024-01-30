Return-Path: <linux-btrfs+bounces-1941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE5842CD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 20:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1251C24C9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA347B3E5;
	Tue, 30 Jan 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kQC+sQOi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fD83dvTU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/C9XUTW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T6oby+pk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B97B3D2
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643175; cv=none; b=sYW5s8tC8Fm6y3Go8vm3/vM64x7PGLg8Q90wvVQBQ2BsvjDEZtPkZ0LBkUR1IU0ETgeVt2lnzKuBbn6ERDRfPz4GT3SKAcPvlULBdSTnaLQLe/iDCFPB6LQSZeNouGxpVOyELtU/nja5HdTcCFGTpAO++y1P5cmgimgUGDUg3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643175; c=relaxed/simple;
	bh=Z8orpvWNRbx48dIrNzJvW5aLz16Tvndo/N3mKrJjXLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBhyhu18nfVl+x23V8VmhMrm9RSO9ymKs5/FLJFQKLNJ5dmuSWiMPA0xaU0YCRNTVBN6IfE/1GZeCxUu+aZ47tH07aO3MvZEcoAyKt8K0RUeCW7kZ9Wt2Y76sDrVfBifFIgEu8sv1VWnp32xNuAEBtjPINOmkm0jA8+RUeEHHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kQC+sQOi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fD83dvTU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/C9XUTW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T6oby+pk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBBE622309;
	Tue, 30 Jan 2024 19:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706643172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6im0PKvCcMCpb3O8aQUYcu8OgkbRPOt1CnNOJL+PvY=;
	b=kQC+sQOi/BW4EiMH2ArXneO4V9vdGZ61+y0tZYapiFELADKJjybvukJmn+qKGG0t6Tk8RB
	89h9O/P5/p0aGj4dKhOr8OWLmA7L0otxHkqhAij77Mv69hM0zUAwZD96T3g1Yfis56brYV
	6ip+F4UjsPrXsm6Av4af6YPajfKdUkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706643172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6im0PKvCcMCpb3O8aQUYcu8OgkbRPOt1CnNOJL+PvY=;
	b=fD83dvTUQp4RMgLgekdmmOja4tMIlqZxG8wTJbkeN5YjDaTGjTzxOcvDYFnjYiSNLFg5fz
	6gOs+gyufG7rnlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706643171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6im0PKvCcMCpb3O8aQUYcu8OgkbRPOt1CnNOJL+PvY=;
	b=1/C9XUTWJVXoxVYGkALeWqHnb21ylsKt/VcO5TocQV4Tp40R6AosQydBuamiIo9WZinjaL
	FJ3DmJYYsI3qz9zr9O4elxvFZLuzVIVkcGa5AkMBkT/n5zPikgkFtyB6UQb5e5Kt2u7r21
	k/Jkxnsa/PC1nSFpsaST0JC7LqNV4+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706643171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6im0PKvCcMCpb3O8aQUYcu8OgkbRPOt1CnNOJL+PvY=;
	b=T6oby+pkz7XuLtDiVuebmGS7NLo3d/SbBTVJLVJs8JGnd6YEEB74wMacKPEL9mdFC6LvLQ
	pJQru946/F/umRCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B107813462;
	Tue, 30 Jan 2024 19:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1AEAK+NOuWVbAQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jan 2024 19:32:51 +0000
Date: Tue, 30 Jan 2024 20:32:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] btrfs: add helpers to get fs_info from page/folio
 pointers
Message-ID: <20240130193226.GE31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706553080.git.dsterba@suse.com>
 <b93ed05e42a65c5bb11a8c5a3bdad9facb3ed43a.1706553080.git.dsterba@suse.com>
 <2495e4f7-f389-46fa-a111-0e3e6deedaab@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2495e4f7-f389-46fa-a111-0e3e6deedaab@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1/C9XUTW";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T6oby+pk
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.11%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: CBBE622309
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, Jan 30, 2024 at 11:58:40AM +0000, Johannes Thumshirn wrote:
> On 29.01.24 19:34, David Sterba wrote:
> > @@ -1929,7 +1929,7 @@ int btree_write_cache_pages(struct address_space *mapping,
> >   				   struct writeback_control *wbc)
> >   {
> >   	struct btrfs_eb_write_context ctx = { .wbc = wbc };
> > -	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
> > +	struct btrfs_fs_info *fs_info = page_to_fs_info(mapping->host);
> 
> This is wrong, page_to_fs_info() expects a struct page, but 
> mapping->host gives you a struct inode.

Right, strange that it did not crash. We need the type checking for such
errors.

