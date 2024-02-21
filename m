Return-Path: <linux-btrfs+bounces-2613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E785E076
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DFE1C233CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BC7FBCE;
	Wed, 21 Feb 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hu+aLqj7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATltFRPy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hu+aLqj7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATltFRPy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6C38398
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527909; cv=none; b=f5OfYgriKkV1pAzsm1skkIcUy8KQPEPOppY7l9GqSYCyjcHCg+S7X7MruF/Iv4/0JrwoJcUwtWYqD2qaM3DDjL1Yl3+rVdtf+LjSTKx23MJZfx0ObA0brlnAWnju0KQbOkLaJ7Oe8ZgHv3LxhJfL+vy4Geh8eiey8vTCZoLg5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527909; c=relaxed/simple;
	bh=5/CeKzSJTlWdsRSQFuGFqknrP7KBcxyX8LqQ5ayzeaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE/G0M41jgbVv5vk+iZpyPDKSbva6v1nZv6a1qYz8bsACGNIhU1WyTYBMzSuU9rSiw26L8i0jdVtT4TeQvvbYWWkDMxMSQo6Cz+jbYSDl/6uauT4HlpQfUJ28uH4l6D3UBRxstHfEp2+EbcPp4szZvoP+kqvx/2J2AgExk10RCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hu+aLqj7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATltFRPy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hu+aLqj7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATltFRPy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C905A1FB61;
	Wed, 21 Feb 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708527905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPUatMOfeg+PJ9uvs/GnBBC89V3YwJdKrX0fb6Qfeck=;
	b=Hu+aLqj7vlv9tEy+nAMoJJUEzP+2z2JPxLQ+f8rsm2SQ+HlUdtOiCJhpQXct2iUkdVlvKs
	5NEVkq2W+DOKtvF8ViE3NTKhmkzt3hHAGApQRuBIJ5++FTUItWJ2p0f8G2v6Kg37+bk//1
	6zeXpPauym6xaI9o7QWcN2PZezeZTNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708527905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPUatMOfeg+PJ9uvs/GnBBC89V3YwJdKrX0fb6Qfeck=;
	b=ATltFRPyzhiZh61O5jcXONtTeTdcDF6wRzj3pwGmo2NSeEpDxasgrK9+PaxmAdIIe+L8aa
	r7/BPU2xozsplwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708527905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPUatMOfeg+PJ9uvs/GnBBC89V3YwJdKrX0fb6Qfeck=;
	b=Hu+aLqj7vlv9tEy+nAMoJJUEzP+2z2JPxLQ+f8rsm2SQ+HlUdtOiCJhpQXct2iUkdVlvKs
	5NEVkq2W+DOKtvF8ViE3NTKhmkzt3hHAGApQRuBIJ5++FTUItWJ2p0f8G2v6Kg37+bk//1
	6zeXpPauym6xaI9o7QWcN2PZezeZTNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708527905;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zPUatMOfeg+PJ9uvs/GnBBC89V3YwJdKrX0fb6Qfeck=;
	b=ATltFRPyzhiZh61O5jcXONtTeTdcDF6wRzj3pwGmo2NSeEpDxasgrK9+PaxmAdIIe+L8aa
	r7/BPU2xozsplwAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AC8CF139D1;
	Wed, 21 Feb 2024 15:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UmP0KSER1mW9UwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 15:05:05 +0000
Date: Wed, 21 Feb 2024 16:04:24 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: raid56: extra debug for raid6 syndrome
 generation
Message-ID: <20240221150424.GK355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ceaa8a9d4a19dbe017012d5cdbd78aafeac31cc9.1706239278.git.wqu@suse.com>
 <20240214073855.GO355@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214073855.GO355@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.09
X-Spamd-Result: default: False [-1.09 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.79%]
X-Spam-Flag: NO

On Wed, Feb 14, 2024 at 08:38:55AM +0100, David Sterba wrote:
> On Fri, Jan 26, 2024 at 01:51:32PM +1030, Qu Wenruo wrote:
> > [BUG]
> > I have got at least two crash report for RAID6 syndrome generation, no
> > matter if it's AVX2 or SSE2, they all seems to have a similar
> > calltrace with corrupted RAX:
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000000
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: 0000 [#1] PREEMPT SMP PTI
> >  Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
> >  RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
> >  RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
> >  RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000000000000000
> >  Call Trace:
> >   <TASK>
> >   rmw_rbio+0x5c8/0xa80 [btrfs]
> >   process_one_work+0x1c7/0x3d0
> >   worker_thread+0x4d/0x380
> >   kthread+0xf3/0x120
> >   ret_from_fork+0x2c/0x50
> >   </TASK>
> > 
> > [CAUSE]
> > In fact I don't have any clue.
> > 
> > Recently I also hit this in AVX512 path, and that's even in v5.15
> > backport, which doesn't have any of my RAID56 rework.
> > 
> > Furthermore according to the registers:
> > 
> >  RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
> > 
> > The RAX register is showing the number of stripes (including PQ),
> > which is not correct (0).
> > But the remaining two registers are all sane.
> > 
> > - RBX is the sectorsize
> >   For x86_64 it should always be 4K and matches the output.
> > 
> > - RCX is the pointers array
> >   Which is from rbio->finish_pointers, and it looks like a sane
> >   kernel address.
> > 
> > [WORKAROUND]
> > For now, I can only add extra debug ASSERT()s before we call raid6
> > gen_syndrome() helper and hopes to catch the problem.
> > 
> > The debug requires both CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT
> > enabled.
> > 
> > My current guess is some use-after-free, but every report is only having
> > corrupted RAX but seemingly valid pointers doesn't make much sense.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
> I haven't seen the crash for some time but with this patch I may add
> some info once it happens again.

For the record, I added this patch to for-next.

