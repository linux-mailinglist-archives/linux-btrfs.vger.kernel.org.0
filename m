Return-Path: <linux-btrfs+bounces-20427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE5D16188
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 01:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDA09300A9A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 00:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D223EA90;
	Tue, 13 Jan 2026 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICpeS2Aa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/65CujzE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICpeS2Aa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/65CujzE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89202163
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265782; cv=none; b=ed4cW+/suL1IBJzmB997XNR0BAcr1dAhjA30PN82h6QKMqBigZwA1/m0zLD9rh68kOy1dvsaTQKVNetM9fT/inkRY7DnuYewi7mmW9LgF9pj4wEo/f6AikJKPZR4WeeZm+lVQdE05LTDanG5NB8o9HuV4zPoVTsNsa0IWHczNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265782; c=relaxed/simple;
	bh=rctb4KXo/vOSc0kCKfYc6zZXk+L9VpuQaAvf7lTFi/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDSt5GWmltsLpr+/C3LC7vxpIcprYTzOMLqVp4u5TQYxvjiA1FKY+AFri8Ty7AzXIMqpYi81hlpO0vf9u8jp2KtZsmX1iMJxRrSb5L85fF5YqjiqGxHv/J1vjxQd9r/7g7nhAfrMJVjlhTsRQZHUUYTPTDPbq8aGooURek4vqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICpeS2Aa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/65CujzE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICpeS2Aa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/65CujzE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBFFA33692;
	Tue, 13 Jan 2026 00:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768265772;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuvSZtImvGd3sJXDNlE3jKkgZJuQ5aAmOTqvvyG20w=;
	b=ICpeS2Aa6G2/TNdpwFtIshC1QeBYamHUxNHZAznx+EcTKu/G73EgAO+8CAZhL/yjILv1MB
	Q5rK2PiP0Q4c1ya1yhUK7wNG8Ddjsu+wm8dBhUKW6eM0f+8Qs3mVkVvzzLhee2EhEKs62v
	zC917S2QXuKQhpcRX6LPwgBD1C/O9gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768265772;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuvSZtImvGd3sJXDNlE3jKkgZJuQ5aAmOTqvvyG20w=;
	b=/65CujzEObYXOqgJQcp92fbUhmZza35TcyijbMfcAYEZ7uYd4uCDdNFK6zBlDOO7gZ8vQN
	q9AqzH0opETaLcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768265772;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuvSZtImvGd3sJXDNlE3jKkgZJuQ5aAmOTqvvyG20w=;
	b=ICpeS2Aa6G2/TNdpwFtIshC1QeBYamHUxNHZAznx+EcTKu/G73EgAO+8CAZhL/yjILv1MB
	Q5rK2PiP0Q4c1ya1yhUK7wNG8Ddjsu+wm8dBhUKW6eM0f+8Qs3mVkVvzzLhee2EhEKs62v
	zC917S2QXuKQhpcRX6LPwgBD1C/O9gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768265772;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRuvSZtImvGd3sJXDNlE3jKkgZJuQ5aAmOTqvvyG20w=;
	b=/65CujzEObYXOqgJQcp92fbUhmZza35TcyijbMfcAYEZ7uYd4uCDdNFK6zBlDOO7gZ8vQN
	q9AqzH0opETaLcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF8193EA63;
	Tue, 13 Jan 2026 00:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJmLLiyYZWmPQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 Jan 2026 00:56:12 +0000
Date: Tue, 13 Jan 2026 01:56:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: reorder members in btrfs_delayed_root for
 better packing
Message-ID: <20260113005607.GV21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767979013.git.dsterba@suse.com>
 <4ffb0817d978715cb34cef429c797f211a993551.1767979013.git.dsterba@suse.com>
 <60a3f79f-b337-4309-9689-3ce0dd90e69d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60a3f79f-b337-4309-9689-3ce0dd90e69d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, Jan 10, 2026 at 07:46:11AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/10 03:47, David Sterba 写道:
> > There are two unnecessary 4B holes in btrfs_delayed_root;
> > 
> > struct btrfs_delayed_root {
> >          spinlock_t                 lock;                 /*     0     4 */
> > 
> >          /* XXX 4 bytes hole, try to pack */
> > 
> >          struct list_head           node_list;            /*     8    16 */
> >          struct list_head           prepare_list;         /*    24    16 */
> >          atomic_t                   items;                /*    40     4 */
> >          atomic_t                   items_seq;            /*    44     4 */
> >          int                        nodes;                /*    48     4 */
> > 
> >          /* XXX 4 bytes hole, try to pack */
> > 
> >          wait_queue_head_t          wait;                 /*    56    24 */
> > 
> >          /* size: 80, cachelines: 2, members: 7 */
> >          /* sum members: 72, holes: 2, sum holes: 8 */
> >          /* last cacheline: 16 bytes */
> > };
> > 
> > Reordering 'nodes' after 'lock' reduces size by 8B, to 72 on release
> > config.
> 
> Not a huge thing, but can we put members in descend order of their sizes 
> if they are properly aligned.

We can do that but I'm not sure about the effects. Once there are no
holes left the automatic alignment is correct with respect to the types.
The structure is compact and the next thing to consider is cacheline
grouping, so we can decouple locks, atomics or implied locks in other
structures like the wait_queue_head or semaphores.

You suggest to reorder wait from 2nd cacheline to the first, so now the
atomics are in the 2nd. This groups wait + lock, and the items +
items_seq. I can't tell just form that which one is better, this depends
on access patterns and code would need to be analyzed. In many cases
this is not important because the access is not so parallel, so eg. one
access per function is hardly measurable. And we don't care in general,
so in this case I don't think either way is better or worse.

> For this particular case, wait_queue_heat_t itself isn't properly 
> power-of-2 sized, but with 2 32bits member, it can be shrink even futher:

The final size after my patch is the same, 72 bytes, what I posted was
the structure before reordering.

> struct btrfs_delayed_root {
>          wait_queue_head_t          wait;                 /*     0    24 */
>          int                        nodes;                /*    24     4 */
>          spinlock_t                 lock;                 /*    28     4 */
>          struct list_head           node_list;            /*    32    16 */
>          struct list_head           prepare_list;         /*    48    16 */
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          atomic_t                   items;                /*    64     4 */
>          atomic_t                   items_seq;            /*    68     4 */
> 
>          /* size: 72, cachelines: 2, members: 7 */
>          /* last cacheline: 8 bytes */
> };

