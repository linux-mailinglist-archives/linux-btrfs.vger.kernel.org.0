Return-Path: <linux-btrfs+bounces-10794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F768A06454
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 19:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9249C1887720
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E2201026;
	Wed,  8 Jan 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZ6ooFdN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FMoX8nSe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1hJGXjRJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B716NqNB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793615853B;
	Wed,  8 Jan 2025 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360867; cv=none; b=ikl3rYH8iZPnHNOCCwIknKDrb1beIFSRwMG+i2swe9AlJg4K7aRxNBdT0i/1roIxz5ENRiDzcLieuQbkplCwzOIx9AUf9RXMNTVl0kcnqogvpsjYPu+KVs9/D1iVTTIofSQsZcoWbXJfdjWTI41gkettyOWIsGLCde0jwjK/tZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360867; c=relaxed/simple;
	bh=y377k5RJbGQg8qQ3rxnaBhHybDLtWA7z7NPbC3H4/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIs6OqDATVJVjvAYjtyCW9ue7UOlTnfhz1z1wdxhg3uEZ2U2o3cERVT0hxeUVC0YMVYD3ne8Jf8mSxCqdJ6T+nQnhrayGQyqpNnzsBHyEKRvtIM/F7lsXT0BcF6VF4jc2FSvpzSKsm5Vp3kky9RUaFvkjfVTORd0CSd9aZnL67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZ6ooFdN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FMoX8nSe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1hJGXjRJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B716NqNB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10445210F8;
	Wed,  8 Jan 2025 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736360864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jME+hkoguLjTb/cIOCzDdvZcujhDit7chWi35SoURd4=;
	b=iZ6ooFdNWeMLKbCfDVvpEwCJkaoC45OW2nKFcA6b/G/2cHj5EBI916nyIEz0/+EWqc17Ht
	CjsFjXaRz0Ip2ljDeX99WzNao+Fq1TdNx/SP7DLyHpzyOANczhpNq5A1/gOBLMxS4hOmAb
	8OwWU7azhWYASAziP/rb4/OrI5YqTUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736360864;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jME+hkoguLjTb/cIOCzDdvZcujhDit7chWi35SoURd4=;
	b=FMoX8nSe9q4IKdXGg9xN+AG54f9iLMlDYsmsbejv5FlRznsvQq5gHBHupUmPyJNYcbWCF7
	N6cfIpIWsoMWbdBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736360863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jME+hkoguLjTb/cIOCzDdvZcujhDit7chWi35SoURd4=;
	b=1hJGXjRJFZZwHoE9jA1qC9tKYwsXSN5niINMTnVIbjBa//ZRiuKmHUsvjnfIFXQ1o1GSl6
	rSG4QCnOix5DMLfddhNAKiJ5girHlfFdf/169FBPMq9vcCHMI7lBaO5Y2wfyJPZ6C6WdqE
	fPePRnVnGnEH2HtktYsDeU1Q96N7ne4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736360863;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jME+hkoguLjTb/cIOCzDdvZcujhDit7chWi35SoURd4=;
	b=B716NqNBtddNkM6v6rE3GNjkxmoaiNQUCbEpz4tOyJ9Hro/GU+Bm3OxkpzhDCZyMyWwR9c
	sD4i06+l4U9mbjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC4801351A;
	Wed,  8 Jan 2025 18:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwSLNZ7DfmdVFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 08 Jan 2025 18:27:42 +0000
Date: Wed, 8 Jan 2025 19:27:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Message-ID: <20250108182315.GH31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250108114326.1729250-1-neelx@suse.com>
 <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,btrfs.readthedocs.io:url,suse.cz:replyto,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 08, 2025 at 04:24:19PM +0100, Daniel Vacek wrote:
> On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> > On 08.01.25 12:44, Daniel Vacek wrote:
> > > Only allocate the `priv` struct from slab for asynchronous mode.
> > >
> > > There's no need to allocate an object from slab in the synchronous mode. In
> > > such a case stack can be happily used as it used to be before 68d3b27e05c7
> > > ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> > > which was a preparation for the async mode.
> > >
> > > While at it, fix the comment to reflect the atomic => refcount change in
> > > d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> >
> > Generally I'm not a huge fan of conditional allocation/freeing. It just
> > complicates matters. I get it in case of the bio's bi_inline_vecs where
> > it's a optimization, but I fail to see why it would make a difference in
> > this case.
> >
> > If we're really going down that route, there should at least be a
> > justification other than "no need" to.
> 
> Well the main motivation was not to needlessly exercise the slab
> allocator when IO uring is not used. It is a bit of an overhead,
> though the object is not really big so I guess it's not a big deal
> after all (the slab should manage just fine even under low memory
> conditions).
> 
> 68d3b27e05c7 added the allocation for the async mode but also changed
> the original behavior of the sync mode which was using stack before.
> The async mode indeed requires the allocation as the object's lifetime
> extends over the function's one. The sync mode is perfectly contained
> within as it always was.
> 
> Simply, I tend not to do any allocations which are not strictly
> needed.

Nothing wrong about that and I think in kernel it's preferred to avoid
allocations in such cases. The sync case is calling the ioctl and
repeatedly too, so reducing the allocator overhead makes sense, at the
slight cost of code complexity. The worst case is when allocator has to
free memory by flushing or blocking the tasks, so we're actively
avoiding and reducing the chances for that.

> If you prefer to simply allocate the object unconditionally,
> we can just drop this patch.
> 
> > >   struct btrfs_encoded_read_private {
> > > -     struct completion done;
> > > +     struct completion *sync_reads;
> > >       void *uring_ctx;
> > > -     refcount_t pending_refs;
> > > +     refcount_t pending_reads;
> > >       blk_status_t status;
> > >   };
> >
> > These renames just make the diff harder to read (and yes I shouldn't
> > have renamed pending to pending_refs but that at least also changed the
> > type).
> 
> I see. But also the completion is changed to a pointer here for a
> reason and I tried to make it clear it's only used for sync reads,
> hence the rename.

Functional and cleanup/cosmetic changes are better kept separate. It's
keeping the scope of changes minimal and usually the fixes can get
backported so the cleanup changes are not wanted.

> > > -     if (refcount_dec_and_test(&priv->pending_refs)) {
> > > -             int err = blk_status_to_errno(READ_ONCE(priv->status));
> > > -
> > > +     if (refcount_dec_and_test(&priv->pending_reads)) {
> > >               if (priv->uring_ctx) {
> > > +                     int err = blk_status_to_errno(READ_ONCE(priv->status));
> >
> > Missing newline after the declaration.
> 
> Right. Clearly I did not run checkpatch before sending. Sorry.
> I was just trying to match this block to the same one later, which did
> not have the newline. (But it also did not have the declaration
> before.)

We don't stick to what checkpatch reports, I'm fixing a lot of coding
style when merging patches that would not pass checkpatch, the general
CodingStyle applies but we have a local fs/btrfs style too, loosely
documented at https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html .

