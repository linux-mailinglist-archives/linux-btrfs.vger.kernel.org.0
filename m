Return-Path: <linux-btrfs+bounces-13620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E8AA7026
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332297B5D21
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9E241690;
	Fri,  2 May 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXeVB22s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Krbok58x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXeVB22s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Krbok58x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88E23C4FF
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183396; cv=none; b=A8nMt1AJrHAGQJsCtYJWjFYAmswpjMSyVACzRxKb7j/lgTpkGSjrxTwbxbVEAV6WBE4v4plVaSPGZeNuxUphQiHiN8e5/P3JYBt6Vhr0EByUUqwIWn7qEBNa4bMxag3509ULJ3KmPXKx24RTGdqnmggU6v/gi5NXiHQm8oLkyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183396; c=relaxed/simple;
	bh=PEEVry1iCCqtrUrfvYj3b9GbvcxdKuK9DCgLFhBIUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiMaDsTi+vC9QqdciGNS6t1wfPKmsj6PVL/Tnw+MZdp5mHg8kjzDlM8OCOtZvRtZAGW8Qsb53KsuFL7dx3CczjUQgE5xCHb0IG+spHKaKFUsBQRscNlFrrLs4Q4ke/yI9cyD7N7U77GLJ8OwzHIposCvlIaygVP7KgRQSn66By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXeVB22s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Krbok58x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXeVB22s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Krbok58x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CC811F385;
	Fri,  2 May 2025 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746183391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx54/hkfg5v8222j7qemtRP/CuDUw+kN4yaIY0YgUE4=;
	b=JXeVB22s2i/1NnUUrOgy0ywoA0jKEXY2dSoSe4sGe/xSgNcLZIEeqLsHO7LlLe/tvFlg4R
	apqJW5o14Ao7x4QyaO8UkzqMyaG6/IFKfpafNlE+lWmkTy0qMbeEiylCY4VCjkA4x0dQf4
	d6X7TVA6iQ47KBkb7lNB8NXi3MmJySQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746183391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx54/hkfg5v8222j7qemtRP/CuDUw+kN4yaIY0YgUE4=;
	b=Krbok58xVNkAwgA+ha8MPZTn6vpGOh5e0+oVgsd/Le1M+R96vsen/f6k9GgYrZvQmfpKdr
	rqL5ZM9R+DJV3gBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746183391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx54/hkfg5v8222j7qemtRP/CuDUw+kN4yaIY0YgUE4=;
	b=JXeVB22s2i/1NnUUrOgy0ywoA0jKEXY2dSoSe4sGe/xSgNcLZIEeqLsHO7LlLe/tvFlg4R
	apqJW5o14Ao7x4QyaO8UkzqMyaG6/IFKfpafNlE+lWmkTy0qMbeEiylCY4VCjkA4x0dQf4
	d6X7TVA6iQ47KBkb7lNB8NXi3MmJySQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746183391;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx54/hkfg5v8222j7qemtRP/CuDUw+kN4yaIY0YgUE4=;
	b=Krbok58xVNkAwgA+ha8MPZTn6vpGOh5e0+oVgsd/Le1M+R96vsen/f6k9GgYrZvQmfpKdr
	rqL5ZM9R+DJV3gBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF2613687;
	Fri,  2 May 2025 10:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XcwoD9+kFGjFcAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 10:56:31 +0000
Date: Fri, 2 May 2025 12:56:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <20250502105630.GO9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250429151800.649010-1-neelx@suse.com>
 <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
 <20250430133026.GH9140@suse.cz>
 <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdexSywSbJQfrj5pazrBRyVns3SdRCsw1VmvhrJv20bvw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid,suse.cz:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 30, 2025 at 04:13:20PM +0200, Daniel Vacek wrote:
> On Wed, 30 Apr 2025 at 15:30, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Apr 30, 2025 at 10:21:18AM +0200, Daniel Vacek wrote:
> > > > The benefit of duplicating the length in each eb is that it's in the
> > > > same cacheline as the other members that are used for offset
> > > > calculations or bit manipulations.
> > > >
> > > > Going to the fs_info->nodesize may or may not hit a cache, also because
> > > > it needs to do 2 pointer dereferences, so from that perspective I think
> > > > it's making it worse.
> > >
> > > I was considering that. Since fs_info is shared for all ebs and other
> > > stuff like transactions, etc. I think the cache is hot most of the
> > > time and there will be hardly any performance difference observable.
> > > Though without benchmarks this is just a speculation (on both sides).
> >
> > The comparison is between "always access 1 cacheline" and "hope that the
> > other cacheline is hot", yeah we don't have benchmarks for that but the
> > first access pattern is not conditional.
> 
> That's quite right. Though in many places we already have fs_info
> anyways so it's rather accessing a cacheline in eb vs. accessing a
> cacheline in fs_info. In the former case it's likely a hot memory due
> to accessing surrounding members anyways, while in the later case is
> hopefully hot as it's a heavily shared resource accessed when
> processing other ebs or transactions.
> But yeah, in some places we don't have the fs_info pointer yet and two
> accesses are still needed.

The fs_info got added to eb because it used to be passed as parameter to
many functions.

> In theory fs_info could be shuffled to move nodesize to the same
> cacheline with buffer_tree. Would that feel better to you?

We'd get conflicting requirements for ordering in fs_info. Right now
the nodesize/sectorsize/... are in once cacheline in fs_info and they're
often used together in many functions. Reordering it to fit eb usage
pattern may work but I'm not convinced we need it.

> > > > I don't think we need to do the optimization right now, but maybe in the
> > > > future if there's a need to add something to eb. Still we can use the
> > > > remaining 16 bytes up to 256 without making things worse.
> > >
> > > This really depends on configuration. On my laptop (Debian -rt kernel)
> > > the eb struct is actually 272 bytes as the rt_mutex is significantly
> > > heavier than raw spin lock. And -rt is a first class citizen nowadays,
> > > often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> > > I think it would be nice to slim the struct below 256 bytes even there
> > > if that's your aim.
> >
> > I configured and built RT kernel to see if it's possible to go to 256
> > bytes on RT and it seems yes with a big sacrifice of removing several
> > struct members that cache values like folio_size or folio_shift and
> > generating worse code.
> >
> > As 272 is a multiple of 16 it's a reasonable size and we don't need to
> > optimize further. The number of ebs in one slab is 30, with the non-rt
> > build it's 34, which sounds OK.
> 
> That sounds fair. Well the 256 bytes were your argument in the first place.

Yeah, 256 is a nice number because it aligns with cachelines on multiple
architectures, this is useful for splitting the structure to the "data
accessed together" and locking/refcounting. It's a tentative goal, we
used to have larger eb size due to own locking implementation but with
rwsems it got close/under 256.

The current size 240 is 1/4 of cacheline shifted so it's not all clean
but whe have some wiggle room for adding new members or cached values,
like folio_size/folio_shift/addr.


> 
> Still, with this:
> 
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -82,7 +82,10 @@ void __cold extent_buffer_free_cachep(void);
>  struct extent_buffer {
>         u64 start;
>         u32 folio_size;
> -       unsigned long bflags;
> +       u8 folio_shift;
> +       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> +       s8 log_index;
> +       unsigned short bflags;

This does not compile because of set_bit/clear_bit/wait_on_bit API
requirements.

>         struct btrfs_fs_info *fs_info;
> 
>         /*
> @@ -94,9 +97,6 @@ struct extent_buffer {
>         spinlock_t refs_lock;
>         atomic_t refs;
>         int read_mirror;
> -       /* >= 0 if eb belongs to a log tree, -1 otherwise */
> -       s8 log_index;
> -       u8 folio_shift;
>         struct rcu_head rcu_head;
> 
>         struct rw_semaphore lock;
> 
> you're down to 256 even on -rt. And the great part is I don't see any
> sacrifices (other than accessing a cacheline in fs_info). We're only
> using 8 flags now, so there is still some room left for another 8 if
> needed in the future.

Which means that the size on non-rt would be something like 228, roughly
calculating the savings and the increase due to spinloct_t going from
4 -> 32 bytes. Also I'd like to see the generated assembly after the
suggested reordering.

The eb may not be perfect, I think there could be false sharing of
refs_lock and refs but this is a wild guess and based only on code
observation. You may have more luck with other data structures with
unnecessary holes but please optimize for non-RT first.

