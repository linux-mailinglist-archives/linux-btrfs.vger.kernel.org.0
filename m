Return-Path: <linux-btrfs+bounces-21850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H8VAOm4nGkqKAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21850-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 21:30:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9649C17CED5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA249301D0C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5F36D4EA;
	Mon, 23 Feb 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QAV9pkvJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="guiWv8G0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2IaIncf1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bRh/AN1Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA4347BC9
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878627; cv=none; b=Ns5HfOYtlbMQ4IjQDYiI1q5Q3xEB5Dg7dLSvZ1R3fW89wNDy3ICw4xdM79QNkDnjh65Up68zC4lrDceExsbR2Y4sgaDqKIhgtjEy/NF8XvS9zjZZL98S4xFCpUUx1eeAb94vAuYErQFAuoAQ8uAtb5LSGPmW/EKmM1CRj5HI5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878627; c=relaxed/simple;
	bh=7amBcQSDLkio8ag0cRMlDOSh+TO5lk2188FDaHOjh5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnhwyzn2ucRJLy+dnXqveR59QnUqPOMcIH39vdcG+gqZKJRPXR/A8rF/A22zZDya44wculHOENqsIUOTZT3bKuAe6rjTGmt4CLRM8JCcicQ50Vhjolif2/LsGVOA/UGgZdMHtzEypuWCW6m1dxXQYSEaw2z9KABk58n/VrFsLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QAV9pkvJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=guiWv8G0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2IaIncf1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bRh/AN1Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F17295BCE9;
	Mon, 23 Feb 2026 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771878623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SC/IaqixQPdjviB9CgBRZcLmSGCPDAzf3cSg7lkDBoM=;
	b=QAV9pkvJql9fL7yW44dlolX4+jS1z/3WsTgUbesIZr8oNqj4+BMS7VN6b1Tnmkh71X1hc9
	U2/7rYFytw7kRo8L0X/HCzua07CsWYdICkpIwopRgjrO8DDIE6M6qpTY5tC1kCNBdW9FoU
	k9E3dkGCrd6ZbOECF8PLvhyKdTtcIXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771878623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SC/IaqixQPdjviB9CgBRZcLmSGCPDAzf3cSg7lkDBoM=;
	b=guiWv8G0AUeUlj7FQ8EXfhJhO6E56kb35pTggmzdd5ZmPzdZ+tsVyTSBJug+JbQVIo/SC1
	ZcNnJzrN3OEh+zAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771878622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SC/IaqixQPdjviB9CgBRZcLmSGCPDAzf3cSg7lkDBoM=;
	b=2IaIncf1pj3NpuLUVH2W6JCsQ+uRZ2aTJE7JwSVPzb2J+oYpWbE4T1+NzViMLkoZNqbwkC
	Za8PwwD9YqUs+DO3Op2hVzLkasW/+WoJviko/ei9FBBf+TYFTjsqYJ7BDVLWOm/3EwpW/s
	dD8OvByWrzrZAOj39xxKiWqTkZDeIaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771878622;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SC/IaqixQPdjviB9CgBRZcLmSGCPDAzf3cSg7lkDBoM=;
	b=bRh/AN1Q6THpJGY3Yl0Hyoxeq/og2JhaiqD2yt2nRhyMxeNlVq8gadSOV07NeGzJDVpZu+
	LHD4lYAuRHiZsrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA8A23EA68;
	Mon, 23 Feb 2026 20:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HIJfLd64nGmybQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Feb 2026 20:30:22 +0000
Date: Mon, 23 Feb 2026 21:30:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>, vbabka@suse.cz,
	surenb@google.com, hao.li@linux.dev, leitao@debian.org,
	Liam.Howlett@oracle.com, zhao1.liu@intel.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to
 "slab: add sheaves to most caches")
Message-ID: <20260223203021.GP26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aZt2-oS9lkmwT7Ch@debian.local>
 <aZwSreGj9-HHdD-j@hyeyoo>
 <aZw2LyOjxMc-c3dl@debian.local>
 <aZxBIpE8R8DxO4eJ@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxBIpE8R8DxO4eJ@hyeyoo>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -6.50
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21850-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,google.com,linux.dev,debian.org,oracle.com,intel.com,vger.kernel.org,kvack.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: 9649C17CED5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:59:30PM +0900, Harry Yoo wrote:
> On Mon, Feb 23, 2026 at 11:12:47AM +0000, Chris Bainbridge wrote:
> > On Mon, Feb 23, 2026 at 05:41:17PM +0900, Harry Yoo wrote:
> > > On Sun, Feb 22, 2026 at 09:36:58PM +0000, Chris Bainbridge wrote:
> > > > Hi,
> > > > 
> > > > The latest mainline kernel (v6.19-11831-ga95f71ad3e2e) has page
> > > > allocation failures when doing things like compiling a kernel. I can
> > > > also reproduce this with a stress test like
> > > > `stress-ng --vm 2 --vm-bytes 110% --verify -v`
> > > 
> > > Hi, thanks for the report!
> > > 
> > > > [  104.032925] kswapd0: page allocation failure: order:0, mode:0xc0c40(GFP_NOFS|__GFP_COMP|__GFP_NOMEMALLOC), nodemask=(null),cpuset=/,mems_allowed=0
> > > > [  104.033307] CPU: 4 UID: 0 PID: 156 Comm: kswapd0 Not tainted 6.19.0-rc5-00027-g40fd0acc45d0 #435 PREEMPT(voluntary) 
> > > > [  104.033312] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
> > > > [  104.033314] Call Trace:
> > > > [  104.033316]  <TASK>
> > > > [  104.033319]  dump_stack_lvl+0x6a/0x90
> > > > [  104.033328]  warn_alloc.cold+0x95/0x1af
> > > > [  104.033334]  ? zone_watermark_ok+0x80/0x80
> > > > [  104.033350]  __alloc_frozen_pages_noprof+0xec3/0x2470
> > > > [  104.033353]  ? __lock_acquire+0x489/0x2600
> > > > [  104.033359]  ? stack_access_ok+0x1c0/0x1c0
> > > > [  104.033367]  ? warn_alloc+0x1d0/0x1d0
> > > > [  104.033371]  ? __lock_acquire+0x489/0x2600
> > > > [  104.033375]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > > > [  104.033379]  ? _raw_spin_unlock_irqrestore+0x48/0x60
> > > > [  104.033382]  ? lockdep_hardirqs_on+0x78/0x100
> > > > [  104.033394]  allocate_slab+0x2b7/0x510
> > > > [  104.033399]  refill_objects+0x25d/0x380
> > > > [  104.033407]  __pcs_replace_empty_main+0x193/0x5f0
> > > > [  104.033412]  kmem_cache_alloc_noprof+0x5b6/0x6f0
> > > > [  104.033415]  ? alloc_extent_state+0x1b/0x210 [btrfs]
> > > > [  104.033479]  alloc_extent_state+0x1b/0x210 [btrfs]
> > > > [  104.033527]  btrfs_clear_extent_bit_changeset+0x2be/0x9c0 [btrfs]
> > > 
> > > Hmm while bisect points out the first bad commit is
> > > commit e47c897a2949 ("slab: add sheaves to most caches"),
> > > 
> > > I think the caller is supposed to specify __GFP_NOWARN if it doesn't
> > > care about allocation failure?
> > > 
> > > btrfs_clear_extent_bit_changeset() says:
> > > >         if (!prealloc) {
> > > >                 /*
> > > >                  * Don't care for allocation failure here because we might end
> > > >                  * up not needing the pre-allocated extent state at all, which
> > > >                  * is the case if we only have in the tree extent states that 
> > > >                  * cover our input range and don't cover too any other range.
> > > >                  * If we end up needing a new extent state we allocate it later.
> > > >                  */
> > > >                 prealloc = alloc_extent_state(mask);
> > > >         }
> > > 
> > > Oh wait, I see what's going on. bisection pointed out the commit
> > > because slab tries to refill sheaves with __GFP_NOMEMALLOC (and then
> > > falls back to slowpath if it fails).
> > > 
> > > Since failing to refill sheaves doesn't mean the allocation will fail,
> > > it should specify __GFP_NOWARN with __GFP_NOMEMALLOC as long as there's
> > > fallback method.
> > > 
> > > But for __prefill_sheaf_pfmemalloc(), it should specify __GPF_NOWARN on
> > > the first attempt only when gfp_pfmemalloc_allowed() returns true.
> > 
> > Is this fix sufficient to do the right thing? I tested it, and it does
> > appear to prevent logging of the allocation failures for my test case.
> 
> I think we should do both both 1) setting __GFP_NOWARN from btrfs side
> and 2) making slab try to refill sheaves with __GFP_NOWARN when
> there's a fallback path.
> 
> I'm writing a fix for 2) and I'll send it soon.
> 
> > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > index d0dd50f7d279..d2e1083848e8 100644
> > --- a/fs/btrfs/extent-io-tree.c
> > +++ b/fs/btrfs/extent-io-tree.c
> > @@ -641,7 +641,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
> >  		 * cover our input range and don't cover too any other range.
> >  		 * If we end up needing a new extent state we allocate it later.
> >  		 */
> > -		prealloc = alloc_extent_state(mask);
> > +		prealloc = alloc_extent_state(mask | __GFP_NOWARN);
> 
> This seems to be a right thing to do to me, but as I'm not familiar
> with btrfs, I'll let btrfs folks leave comment on it :)

I agree the flag should be added, as the comment explains allocation
failures are not fatal at this place. There's another call to the
alloc_extent_state() with GFP_ATOMIC so we cannot simply sink NOWARN
there.

