Return-Path: <linux-btrfs+bounces-13805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABFAAE811
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F326521B28
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7D28D834;
	Wed,  7 May 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9R3YFc+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGt08vyN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="baiS1rQX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IhncIIog"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A71B87D5
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746639814; cv=none; b=pF0nrMFWrnNJBRpqxd3c7FKNRkDWisBkHJYyDy161jTzMrrtiO2Af8JrBCI3Jpxe0iobfsJ48UCcKeN3iuFJ7iqzhHUhfbN1PrR124/cDk12T3fcnTHOkhDxVoy+nIoiijY1c4OMgTJjimH0TkJzkZSGyII9LE8JRDei1iP5dy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746639814; c=relaxed/simple;
	bh=6ck0dr4xl6fV5+R+BLalK8Vf7V7yOGQzPRdlpb3yikM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6H+VsChdN3Zph1EDVJP2FEl1mQ0KcKIGkB9/AJbkbuLa0bIIfnDbAM17zviyStvw1JySKlEV/MjHKeSWctFBG/eJImqeOjRFNcD/BnLiBkecLK1IULEnse1VCM4cH1iudNF65c7Ga7dXjIckSHHOxXDl/RdRCKdy5OyDPibb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9R3YFc+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGt08vyN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=baiS1rQX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IhncIIog; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C263B1F393;
	Wed,  7 May 2025 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746639810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33nymwt6DaWWp+zyeFbwXLf05bV3795J5XuKhbELY/o=;
	b=b9R3YFc++SzmspLQSeTGD8UcZgwvTHVUDm+e7IV9emC6I9KWi87P8MvUNsFYHO2W9MVziy
	tjESfX2HtMBb6pQqYQzEjajTItfhOingwBXyCDKNTPZhqrC9WulRRmlB/wWwFPGbMTX7i4
	thnPxd2GdB4my1fZtVJqOzMxX71nIz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746639810;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33nymwt6DaWWp+zyeFbwXLf05bV3795J5XuKhbELY/o=;
	b=kGt08vyNByrnk08FVivy2hBeU5XlWevFe1SJEpzQlvQ1rzDRTSDc31zvsMn4ouv0YCKG5m
	kbxrk/GvboXDFVAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=baiS1rQX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IhncIIog
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746639809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33nymwt6DaWWp+zyeFbwXLf05bV3795J5XuKhbELY/o=;
	b=baiS1rQXpQppoMqoskb2PgNBb2IK5LyrQtiYKzOD/4DTrHxskeLbdsXqlcQ0Fz+a65mjzv
	UHP4k2sH3OqUyU85/9ZECvNg3i9/fPpC9Nd3qdiWSvBkTNh0ESy8f28HZQ6azPYqbHRAwB
	rp1bPFhpCvnoX2xgD5eI76sTSYW2oqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746639809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33nymwt6DaWWp+zyeFbwXLf05bV3795J5XuKhbELY/o=;
	b=IhncIIogs1PyBoLD7elwY0Pbwi86s/vXWLVXWUGbOIdQElPtpJGCGQhKSVDZ3+aDPs0p2R
	7UWo95CBXVqQSkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A65FF13882;
	Wed,  7 May 2025 17:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aYNnKMGbG2gsDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 May 2025 17:43:29 +0000
Date: Wed, 7 May 2025 19:43:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use unsigned types for constants defined as bit
 shifts
Message-ID: <20250507174328.GK9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250422155541.296808-1-dsterba@suse.com>
 <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C263B1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21

On Wed, May 07, 2025 at 03:50:51PM +0200, Daniel Vacek wrote:
> > --- a/fs/btrfs/raid56.c
> > +++ b/fs/btrfs/raid56.c
> > @@ -203,8 +203,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
> >         struct btrfs_stripe_hash_table *x;
> >         struct btrfs_stripe_hash *cur;
> >         struct btrfs_stripe_hash *h;
> > -       int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
> > -       int i;
> > +       unsigned int num_entries = 1U << BTRFS_STRIPE_HASH_TABLE_BITS;
> 
> This one does not really make much sense. It is an isolated local thing.
> 
> >         if (info->stripe_hash_table)
> >                 return 0;
> > @@ -225,7 +224,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
> >
> >         h = table->table;
> >
> > -       for (i = 0; i < num_entries; i++) {
> > +       for (unsigned int i = 0; i < num_entries; i++) {
> 
> I'd just do:
> 
> for (int i = 0; i < 1 << BTRFS_STRIPE_HASH_TABLE_BITS; i++) {
> 
> The compiler will resolve the shift and the loop will compare to the
> immediate constant value.

Yes, it's a compile time constant. It's in num_entries because it's used
twice in the function, for that we usually have a local variable so we
don't have to open code the value everywhere.

> ---
> 
> Quite honestly the whole patch is questionable. The recommendations
> are about right shifts. Left shifts are not prone to any sinedness
> issues.
> 
> What is more important is where the constants are being used. They
> should honor the type they are compared with or assigned to. Like for
> example 0x80ULL for flags as these are usually declared unsigned long
> long, and so on...

Agreed, flags and masks should be unsigned.

> For example the LINK_LOWER is converted to int when used as
> btrfs_backref_link_edge(..., LINK_LOWER) parameter and then another
> LINK_LOWER is and-ed to that int argument. I know, the logical
> operations are not really influenced by the signedness, but still.

Well, it's more a matter of consistency and coding style. We did have a
real bug with signed bit defined on 32bit int that got promoted to u64
not as a single bit but 0xffffffff80000000 and this even got propagated
to on-disk data. We were lucky it never had any real impact but since
then I'm on the side of making bit shifts unconditionally on unsigned
types. 77eea05e7851d910b7992c8c237a6b5d462050da

> 
> And btw, the LINK_UPPER is not used at all anywhere in the code, if I
> see correctly.

$ git grep LINK_UPPER
backref.c:      if (link_which & LINK_UPPER)
backref.h:#define               LINK_UPPER      (1U << 1)

> ---
> 
> In theory the situation could be even worse at some places as
> incorrectly using an unsigned constant may force a signed variable to
> get promoted to unsigned one to match. This may result in an int
> variable with the value of -1 ending up as UINT_MAX instead. And now
> imagine if(i < (1U << 4)) where int i = -1;
> 
> I did not check all the places where the constants you are changing
> are being used, but it looks scary.

This is touching the core problem, mixing the signed and unsigned types
in the wrong and very unobvious way. But we maybe disagree that it
should be int, while I'd rather unify that to unsigned.

If you find a scary and potentially wrong use please send a RFC patch so
we can see how much we can avoid that by changing that to a safer
pattern.

