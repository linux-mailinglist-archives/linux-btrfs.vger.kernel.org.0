Return-Path: <linux-btrfs+bounces-21924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIbwIPYKn2neYgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21924-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 15:45:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0784198E81
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E4E8301492B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D63D34A3;
	Wed, 25 Feb 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SyLusrK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWKAd9JS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SyLusrK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWKAd9JS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87853BFE22
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030695; cv=none; b=maRkSuyo6nUneGLYrXIVqsbyjFMIJShARK8jMfOW6KB6aFFWmz5i8MKhiCjnU98+OY4XTK7K8a3eEXBTXaH/PQSlAagTMf82/YPsWJGN7uu3q4CRzqI52C8Gc0E2CxD/DjQRR35UPqHqQPrJ8D75M5igRoJYM+cl2RfNSMh8t2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030695; c=relaxed/simple;
	bh=tsPxjQXYon0ewScpxXfk85YhaHVG8t/jLW5G5cNwEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V46oet8SS6aI+dJllW6B4PwSUAPMyLmojSwjeoB/2N5hvfGs/p7XgpDrZYUIRMbjZVTs6SXqwbU/ENCf1WQ2cqA5sXFlKlmJssK8YrJG4E8L2973KFLPC/Tl32aasr1zSQrtSOYGNdhbvfARFPFen5GUXsSc6d7+JLoUYDTq44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SyLusrK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWKAd9JS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SyLusrK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWKAd9JS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0901F5BF6F;
	Wed, 25 Feb 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772030692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgIhBYKtSu+dhDosoEvGjNI3d0HKX7wLAqOgNtoBRg=;
	b=2SyLusrK2S/4jXpEWt19uKGKbj8jEuDd2+2xzXkUdUpChTJL6qw0xGQBWqhGnbzEW0ML0x
	CIuy3CT6NR0W2q3lHIvFczC6BWkpCdw3fDqJgDxwSQ3/Ggoqdt3sIxQNljk8WX2brgjuL1
	6LYPJ81JuALhe0P1zD9heo1WswBtU3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772030692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgIhBYKtSu+dhDosoEvGjNI3d0HKX7wLAqOgNtoBRg=;
	b=GWKAd9JS6hux8BDMKyt7FYMENIGK9gbQLiaTZp99pUAPtVZ12EPOBu3hr7uYlj3ufMyskn
	cjKnWWX3bpxAyHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772030692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgIhBYKtSu+dhDosoEvGjNI3d0HKX7wLAqOgNtoBRg=;
	b=2SyLusrK2S/4jXpEWt19uKGKbj8jEuDd2+2xzXkUdUpChTJL6qw0xGQBWqhGnbzEW0ML0x
	CIuy3CT6NR0W2q3lHIvFczC6BWkpCdw3fDqJgDxwSQ3/Ggoqdt3sIxQNljk8WX2brgjuL1
	6LYPJ81JuALhe0P1zD9heo1WswBtU3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772030692;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrgIhBYKtSu+dhDosoEvGjNI3d0HKX7wLAqOgNtoBRg=;
	b=GWKAd9JS6hux8BDMKyt7FYMENIGK9gbQLiaTZp99pUAPtVZ12EPOBu3hr7uYlj3ufMyskn
	cjKnWWX3bpxAyHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C92293EA65;
	Wed, 25 Feb 2026 14:44:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EIHrMOMKn2mUaQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 25 Feb 2026 14:44:51 +0000
Date: Wed, 25 Feb 2026 15:44:46 +0100
From: David Sterba <dsterba@suse.cz>
To: David Laight <david.laight.linux@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>,
	dsterba@suse.com, clm@fb.com, naohiro.aota@wdc.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kees@kernel.org
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
Message-ID: <20260225144446.GE26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260223234451.277369-1-mssola@mssola.com>
 <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
 <20260224145555.44a8096d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224145555.44a8096d@pumpkin>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21924-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,mssola.com,suse.com,fb.com,wdc.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,gmx.com:email]
X-Rspamd-Queue-Id: A0784198E81
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:55:55PM +0000, David Laight wrote:
> On Tue, 24 Feb 2026 15:07:10 +1030
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
> > 在 2026/2/24 10:14, Miquel Sabaté Solà 写道:
> > > Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
> > > introduced, among many others, the kzalloc_objs() helper, which has some
> > > benefits over kcalloc().
> > > 
> > > Cc: Kees Cook <kees@kernel.org>
> > > Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
> > > ---
> > >   fs/btrfs/block-group.c       | 2 +-
> > >   fs/btrfs/raid56.c            | 8 ++++----
> > >   fs/btrfs/tests/zoned-tests.c | 2 +-
> > >   fs/btrfs/volumes.c           | 6 ++----
> > >   fs/btrfs/zoned.c             | 5 ++---
> > >   5 files changed, 10 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 37bea850b3f0..8d85b4707690 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
> > >   	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
> > >   		io_stripe_size = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
> > >   
> > > -	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
> > > +	buf = kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);  
> > 
> > Not sure if we should use *buf for the type.
> > 
> > I still remember we had some bugs related to incorrect type usage.
> 
> The global change really ought to have used u64 to add the type-check.
> Otherwise it will have added 'very hard to find' bugs in the very code
> it is trying to make better.
> 
> Using *buf for the type might be a reasonable pattern for new code.

I find this a bit contradictory: I agree that using *buf as the argument
can cause bugs hard to find, yet the next sentence recommends to use it.

This kzalloc_obj way is new I'm analyzing what would be a good pattern
and so far I don't like the "*buf" style of 1st argument. As the
function is really a macro it does not dereference it but it still
appears as it does.

Writing the type explicitly looks still more like a C to me. Types in
arguments are in helpers like container_of or rb_entry and it makes it
obvious that there's something special while for the kzalloc_obj I need
to remember it.

The whole thing would read better as "allocate object of type", so I'm
probably going to convert it to this pattern in btrfs code.

