Return-Path: <linux-btrfs+bounces-6145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930839242BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192921F25FC6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AED1BBBD4;
	Tue,  2 Jul 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P1C/WU2h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+j3Rztqp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P1C/WU2h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+j3Rztqp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088A2207A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935172; cv=none; b=gyco6AC8B1+Lw15jsOkqmh3H6X5nLDHNwh/vK6KGamvu/aBlu169mtWR4VLY+dnMqMhFJP0KrT9Y/4uHA7+5eTzScVuo4j+pBeZRoToYCgoy68QF9cpuvde9P69+fUSAKy/8dsH7G6Ldb6mDnZnYtJe0w5fNGwrBi5sRtJ/Qkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935172; c=relaxed/simple;
	bh=CDgSfgMftym3OZnpsfcsfu6KooiNNPM5tznQ1PZjZ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7Ne0OzOR9WerAJH0URq1xO/Z1VHJYYpi6ciw+l+S/MeBNlLmekxpBfYXJR0ntg/RPOGYGbTIt13q+80/d2qDXc6ECgGIp7OwWG2xXWMh/mJ8gLoFeyYf/uWQhMhxdYM7/ZwyaozcDPK7MBp135rsNEoaC78EoW2Bzf1nlsB/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P1C/WU2h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+j3Rztqp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P1C/WU2h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+j3Rztqp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD3F1FBAB;
	Tue,  2 Jul 2024 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719935168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Zsbbxyq2JqIxOpbhIRfNJkJrQLcR4/s5gSQW1etuw=;
	b=P1C/WU2hR+28S1EfsNlAzQA+BVR4GfAZAtSuJrxanAq8yihp8wcBx5/Bv6+rZQt/zgEEKe
	hlRg6sUFa26cMXoxIp3kjeiTtyCxFlWpTH2dZA5aAx3rrYwvkBNgaB0hH3+afs37G4Xu18
	hQbO89yh67HKrVOmmGe3SJP/DeP6fEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719935168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Zsbbxyq2JqIxOpbhIRfNJkJrQLcR4/s5gSQW1etuw=;
	b=+j3Rztqp+vJOJfYXNPjzDi8xqy3Ntl/Z9SsVOpZzaO+WhX9IR6yGK7WZvcQ02upaEHfHoE
	B8ImFalN5qYWjwAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719935168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Zsbbxyq2JqIxOpbhIRfNJkJrQLcR4/s5gSQW1etuw=;
	b=P1C/WU2hR+28S1EfsNlAzQA+BVR4GfAZAtSuJrxanAq8yihp8wcBx5/Bv6+rZQt/zgEEKe
	hlRg6sUFa26cMXoxIp3kjeiTtyCxFlWpTH2dZA5aAx3rrYwvkBNgaB0hH3+afs37G4Xu18
	hQbO89yh67HKrVOmmGe3SJP/DeP6fEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719935168;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Zsbbxyq2JqIxOpbhIRfNJkJrQLcR4/s5gSQW1etuw=;
	b=+j3Rztqp+vJOJfYXNPjzDi8xqy3Ntl/Z9SsVOpZzaO+WhX9IR6yGK7WZvcQ02upaEHfHoE
	B8ImFalN5qYWjwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E6D113A9A;
	Tue,  2 Jul 2024 15:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+NQA8AghGY3LQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 15:46:08 +0000
Date: Tue, 2 Jul 2024 17:46:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
Message-ID: <20240702154606.GG21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
 <20240702145200.GF21023@twin.jikos.cz>
 <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Jul 02, 2024 at 04:09:42PM +0100, Filipe Manana wrote:
> On Tue, Jul 2, 2024 at 3:52 PM David Sterba <dsterba@suse.cz> wrote:
> > On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote:
> > >   [  199.564372]  __s390x_sys_write+0x68/0x88
> > >   [  199.564397]  do_syscall+0x1c6/0x210
> > >   [  199.564424]  __do_syscall+0xc8/0xf0
> > >   [  199.564452]  system_call+0x70/0x98
> > >
> > > This is because we update and read last_trans concurrently without any
> > > type of synchronization. This should be generally harmless and in the
> > > worst case it can make us do extra locking (btrfs_record_root_in_trans())
> > > trigger some warnings at ctree.c or do extra work during relocation - this
> > > would probably only happen in case of load or store tearing.
> > >
> > > So fix this by always reading and updating the field using READ_ONCE()
> > > and WRITE_ONCE(), this silences KCSAN and prevents load and store tearing.
> >
> > I'm curious why you mention the load/store tearing, as we discussed this
> > last time under some READ_ONCE/WRITE_ONCE change it's not happening on
> > aligned addresses for any integer type, I provided links to intel manuals.
> 
> Yes, I do remember that.
> But that was a different case, it was about a pointer type.
> 
> This is a u64. Can't the load/store tearing happen at the very least
> on 32 bits systems?

Right, it was for a pointer type. I'll continue searching for a
definitive answer regarding 64bit types on 32bit architectures. The
tearing could likely happen when a 64bit type is split into two
cachelines, but I'd be very curious how this could happen within one
cacheline (assuming compiler will align 64bit types to 8 bytes).

> I believe that's the reason we use WRITE_ONCE/READ_ONCE in several
> places dealing with u64s.

AFAIK we do READ_ONCE/WRITE_ONCE for unlocked access as an annotation,
e.g. for the sysfs configuration values used in code. Or when there's a
fast path that reads a value outised of a lock and then under the lock,
there it needs the fresh value that's enforced by READ_ONCE.

The KCSAN reports should be fixed by data_race() annotation so it's not
confused by the above.

I don't see how READ_ONCE protects against load tearing on 32bit because
it's doing the same thing on 64bit and that's verifying that it's basic
scalar type and hen it's an ordinary access.

https://elixir.bootlin.com/linux/latest/source/include/asm-generic/rwonce.h#L47

#ifndef __READ_ONCE
#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
#endif

#define READ_ONCE(x)							\
({									\
	compiletime_assert_rwonce_type(x);				\
	__READ_ONCE(x);							\
})

__unqual_scalar_typeof() checks types from char to long long.

An x86_64 build and also i386 build use the same file
asm-generic/rwonce.h, no code that would prevent load tearing.
The only thing that comes to mind is that it's all hidden in the address
and pointer dereference, but that still says nothing about alignment or
cacheline-straddling.

There are arch-specific implementations of that header that do
workarounds some architectural oddities, but that's on Alpha (we don't
care) and ARM64 (64bit arch with 64bit pointers assumed).

Why I'm so picky about that? For one I want to understad it completely.
This has been bothering me for a long time as the arguments were not
always solid and more like cargo culting (happend in the past) or
scattered in comments to articles or mail threads. If we're really
missing correct use of the _ONCE accessors then we have potential bugs
lurking somewhere.

I don't mind if we add data_race() annotations as we do generally update
code to be able to use internal tools like that, or when we use _ONCE
for the fast path or as an annotation.

The article https://lwn.net/Articles/793253/ title says "Who's afraid of
a big bad optimizing compiler?" and in the first load/store tearing
example argues with a sample 16 bit architecture that could do 2 byte
loads of a pointer. That's good for a demonstration, I want something
real and relevant for linux kernel.

