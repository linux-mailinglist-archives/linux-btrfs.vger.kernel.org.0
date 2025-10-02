Return-Path: <linux-btrfs+bounces-17336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C0BB4461
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EFE19E36D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46A17332C;
	Thu,  2 Oct 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRRdCzic";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wv5QqB3U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRRdCzic";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wv5QqB3U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288C18DB26
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417814; cv=none; b=VZ/ISrjlybyOXY58+1Ll248kmCfWn4NQHvtXuip2aOXvVnc2tAQkftzWGAk8vvo6zcyVMPbdp28jmHFasSTBVLhWxBTTxGVY5FFEqXvLE2DUlKcjcfn6iMZiM67irXl3jXCWvTPu5q8WNTL6MfQJ/gQ2OCb8G/GSbFTkdUSCuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417814; c=relaxed/simple;
	bh=zIJiQvjeCsaONfkVuW2CSKe9yeSb5riAjSp95r2/v2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUWvnaj4MjDNyf5EJSwOLsJV7bVWjk/TkzsHKLbRMOBOV5PwROvA8FvUPQj/8Kud/yxq2+he5b2ABEawzYs7Xvh/ckUq1ddfvimEY/RfsVYEOu6XfuwRO9TlROzDS+p24bwe+CTQ+luD5FESS92DUa/85W8KtANM65HyrFaeLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRRdCzic; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wv5QqB3U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRRdCzic; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wv5QqB3U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC37E336AC;
	Thu,  2 Oct 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759417808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hVbyBFja5/i2PPs6E4D52VCs1xm54hVBtk40J/kT10=;
	b=FRRdCzic+IobdBMVrAx+QNsIZyFBPAG0kx0CEy3bAc5r9/kd9eDXxXhPnremHjIXxKfCjU
	166e50OHTGsiZ5J4k2omZihEos8dUC65BWyglcrlqXfVBIPQm+lyvgpa9U1SZDVSxpKr9y
	RI0ql5OZNXEh7UgZC1XDxVretW0KSbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759417808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hVbyBFja5/i2PPs6E4D52VCs1xm54hVBtk40J/kT10=;
	b=Wv5QqB3Uv62rPH2CQaxqU54A9egu3rLVSopWi5wHvTaDxXUY38da86SFUfHF5Sk/QsDCeG
	BeUtx+pHOpjoM6AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759417808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hVbyBFja5/i2PPs6E4D52VCs1xm54hVBtk40J/kT10=;
	b=FRRdCzic+IobdBMVrAx+QNsIZyFBPAG0kx0CEy3bAc5r9/kd9eDXxXhPnremHjIXxKfCjU
	166e50OHTGsiZ5J4k2omZihEos8dUC65BWyglcrlqXfVBIPQm+lyvgpa9U1SZDVSxpKr9y
	RI0ql5OZNXEh7UgZC1XDxVretW0KSbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759417808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hVbyBFja5/i2PPs6E4D52VCs1xm54hVBtk40J/kT10=;
	b=Wv5QqB3Uv62rPH2CQaxqU54A9egu3rLVSopWi5wHvTaDxXUY38da86SFUfHF5Sk/QsDCeG
	BeUtx+pHOpjoM6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96B1113990;
	Thu,  2 Oct 2025 15:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dUagJNCV3mgQXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Oct 2025 15:10:08 +0000
Date: Thu, 2 Oct 2025 17:10:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
Message-ID: <20251002151003.GH4052@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0d1622fd106eeefff16ae7f2d1b75a3058c3fa66.1759367390.git.boris@bur.io>
 <4a575172-4984-46b3-a82c-c3e3ba42819a@suse.com>
 <20251002022005.GA3549334@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002022005.GA3549334@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Wed, Oct 01, 2025 at 07:20:05PM -0700, Boris Burkov wrote:
> On Thu, Oct 02, 2025 at 11:19:42AM +0930, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/10/2 10:40, Boris Burkov 写道:
> > >  From the memory-barriers.txt document regarding memory barrier ordering
> > > guarantees:
> > > 
> > >   (*) These guarantees do not apply to bitfields, because compilers often
> > >       generate code to modify these using non-atomic read-modify-write
> > >       sequences.  Do not attempt to use bitfields to synchronize parallel
> > >       algorithms.
> > > 
> > >   (*) Even in cases where bitfields are protected by locks, all fields
> > >       in a given bitfield must be protected by one lock.  If two fields
> > >       in a given bitfield are protected by different locks, the compiler's
> > >       non-atomic read-modify-write sequences can cause an update to one
> > >       field to corrupt the value of an adjacent field.
> > > 
> > > btrfs_space_info has a bitfield sharing an underlying word consisting of
> > > the fields full, chunk_alloc, and flush:
> > > 
> > > struct btrfs_space_info {
> > >          struct btrfs_fs_info *     fs_info;              /*     0     8 */
> > >          struct btrfs_space_info *  parent;               /*     8     8 */
> > >          ...
> > >          int                        clamp;                /*   172     4 */
> > >          unsigned int               full:1;               /*   176: 0  4 */
> > >          unsigned int               chunk_alloc:1;        /*   176: 1  4 */
> > >          unsigned int               flush:1;              /*   176: 2  4 */
> > >          ...
> > > 
> > > Therefore, to be safe from parallel read-modify-writes losing a write to
> > > one of the bitfield members protected by a lock, all writes to all the
> > > bitfields must use the lock. They almost universally do, except for
> > > btrfs_clear_space_info_full() which iterates over the space_infos and
> > > writes out found->full = 0 without a lock.
> > > 
> > > Imagine that we have one thread completing a transaction in which we
> > > finished deleting a block_group and are thus calling
> > > btrfs_clear_space_info_full() while simultaneously the data reclaim
> > > ticket infrastructure is running do_async_reclaim_data_space():
> > > 
> > >            T1                                             T2
> > > btrfs_commit_transaction
> > >    btrfs_clear_space_info_full
> > >    data_sinfo->full = 0
> > >    READ: full:0, chunk_alloc:0, flush:1
> > >                                                do_async_reclaim_data_space(data_sinfo)
> > >                                                spin_lock(&space_info->lock);
> > >                                                if(list_empty(tickets))
> > >                                                  space_info->flush = 0;
> > >                                                  READ: full: 0, chunk_alloc:0, flush:1
> > >                                                  MOD/WRITE: full: 0, chunk_alloc:0, flush:0
> > >                                                  spin_unlock(&space_info->lock);
> > >                                                  return;
> > >    MOD/WRITE: full:0, chunk_alloc:0, flush:1
> > > 
> > > and now data_sinfo->flush is 1 but the reclaim worker has exited. This
> > > breaks the invariant that flush is 0 iff there is no work queued or
> > > running. Once this invariant is violated, future allocations that go
> > > into __reserve_bytes() will add tickets to space_info->tickets but will
> > > see space_info->flush is set to 1 and not queue the work. After this,
> > > they will block forever on the resulting ticket, as it is now impossible
> > > to kick the worker again.
> > > 
> > > I also confirmed by looking at the assembly of the affected kernel that
> > > it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
> > > the assembly is:
> > >    andb    $0xfb,0x60(%rbx)
> > > and similarly for setting the full (1st) bit to 0:
> > >    andb    $0xfe,-0x20(%rax)
> > > 
> > > So I think this is really a bug on practical systems.  I have observed
> > > a number of systems in this exact state, but am currently unable to
> > > reproduce it.
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >   fs/btrfs/space-info.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > > index 0e5c0c80e0fe..5c2e567f3e9a 100644
> > > --- a/fs/btrfs/space-info.c
> > > +++ b/fs/btrfs/space-info.c
> > > @@ -192,7 +192,11 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
> > >   	struct btrfs_space_info *found;
> > >   	list_for_each_entry(found, head, list)
> > > +	{
> > > +		spin_lock(&found->lock);
> > >   		found->full = 0;
> > > +		spin_unlock(&found->lock);
> > > +	}
> > 
> > Using spin lock for a bitfield member looks overkilled to me.
> 
> We've already bought into doing it by having space_info->flush=0 under
> space_info->lock be semantically important for the correct operation of
> queueing the flushing work.
> 
> > 
> > And it also means all accesses to that bit needs the lock, which looks
> > impractical to acquire the lock.
> 
> All writes to any of the bits in the bitfield need the lock. Reads from
> bit A can't harm bit B, as far as I know. All other writes to any of the
> three bits already take the lock.
> 
> > 
> > Can't we put all the 3 bits into a bitmap so that we can use all those
> > atomic bit helpers instead?
> > (Still a lot of change, but more practical)
> 
> We can of course do that, but I do believe that this change is
> sufficient. If we do go this way, I will also document it in struct
> btrfs_space_info.
> 
> Alternatively, there is a 29 bit gap in the struct after the bitfield
> anyway, so we can just make them bools and not make the struct bigger.
> 
> If people prefer, I can of course refactor them all into using a bitmap
> and atomic bit helpers, but I just wanted to send the minimal change
> first.

Please use bools for that, we don't really save anything with the
bitfields. The size of btrfs_space_info is 584 on my release config so
we're past the 512 byte mark for better slab packing. Some bytes can be
carved out of 'int clamp' as well, the rest of the structure seems be
hard to optimize for space.

