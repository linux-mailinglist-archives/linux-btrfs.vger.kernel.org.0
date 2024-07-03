Return-Path: <linux-btrfs+bounces-6182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE2926C43
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE6F284FC1
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA0194A56;
	Wed,  3 Jul 2024 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNHO0yl4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTV9e9Iy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNHO0yl4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTV9e9Iy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE34964E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047956; cv=none; b=HEhl0T9C5xoTcamgUeXyndOmUgQtMtdxSQFeEVM9ysBnFuNRIUCY3w+iy/nCq0ojsh/rb+25kWQ6AAbqUkPijVg6OMESGIOlZScsNQhoMoJZGDinaTEUdVecUzB+4bdZ96tanublCX9gUJBdMmT3ASwpBanQxwsOlhkc35jyaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047956; c=relaxed/simple;
	bh=h9S1e3ukkjOYXDdOlGaM8SBxA9G3f5UN1ib6Ogz0yh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMVRVCJqw1r6PCBNqsrYFIIOFAaHkJkkBEpdgTh63EGehl+VCwuUBA8hx9blpGw+gvyLaXo75ayFl5ZkXBPU9pX3UCUrY8BJQJfBubBKDgiPpOzUmkQ/8D8ylX2KWGa7ihlv+yWR8Bqo28LzesM9edtvq4+QljvBQM9SRELKp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNHO0yl4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTV9e9Iy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNHO0yl4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTV9e9Iy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D69121AAD;
	Wed,  3 Jul 2024 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720047952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juil22cwn4ypV8mvTP3Qw/nmy3HKAr3D3qO3FxYD3Es=;
	b=KNHO0yl4spMcTdIojhWQFuYhAEGLo/1ZeMUYNRlUIw7WpliBWIYM4Xu5Kh/GcEKDw3jcay
	Uu4cpCk7NtbFHksqijGf275ns/KlUpgZWuNLWpGgtLthEYPkcGqwfK7B5h5A3WyPkOCSj1
	ZsUANe5iEzNF7kxSkVvV1rwJ6Vpm5Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720047952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juil22cwn4ypV8mvTP3Qw/nmy3HKAr3D3qO3FxYD3Es=;
	b=aTV9e9IyjrFj4Xg0PFHfdKShwpRDF+dPZ8cUslcxHFv0PnR14w8wFKyfQfGSomD5paoa+B
	+vlhwgaVP+qdcnAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KNHO0yl4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aTV9e9Iy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720047952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juil22cwn4ypV8mvTP3Qw/nmy3HKAr3D3qO3FxYD3Es=;
	b=KNHO0yl4spMcTdIojhWQFuYhAEGLo/1ZeMUYNRlUIw7WpliBWIYM4Xu5Kh/GcEKDw3jcay
	Uu4cpCk7NtbFHksqijGf275ns/KlUpgZWuNLWpGgtLthEYPkcGqwfK7B5h5A3WyPkOCSj1
	ZsUANe5iEzNF7kxSkVvV1rwJ6Vpm5Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720047952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juil22cwn4ypV8mvTP3Qw/nmy3HKAr3D3qO3FxYD3Es=;
	b=aTV9e9IyjrFj4Xg0PFHfdKShwpRDF+dPZ8cUslcxHFv0PnR14w8wFKyfQfGSomD5paoa+B
	+vlhwgaVP+qdcnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F9013A7F;
	Wed,  3 Jul 2024 23:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HoFhBVDZhWbDRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Jul 2024 23:05:52 +0000
Date: Thu, 4 Jul 2024 01:05:46 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
Message-ID: <20240703230546.GR21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
 <20240702145200.GF21023@twin.jikos.cz>
 <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
 <20240702154606.GG21023@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702154606.GG21023@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D69121AAD
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jul 02, 2024 at 05:46:06PM +0200, David Sterba wrote:
> On Tue, Jul 02, 2024 at 04:09:42PM +0100, Filipe Manana wrote:
> > On Tue, Jul 2, 2024 at 3:52 PM David Sterba <dsterba@suse.cz> wrote:
> > > On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote:
> > > >   [  199.564372]  __s390x_sys_write+0x68/0x88
> > > >   [  199.564397]  do_syscall+0x1c6/0x210
> > > >   [  199.564424]  __do_syscall+0xc8/0xf0
> > > >   [  199.564452]  system_call+0x70/0x98
> > > >
> > > > This is because we update and read last_trans concurrently without any
> > > > type of synchronization. This should be generally harmless and in the
> > > > worst case it can make us do extra locking (btrfs_record_root_in_trans())
> > > > trigger some warnings at ctree.c or do extra work during relocation - this
> > > > would probably only happen in case of load or store tearing.
> > > >
> > > > So fix this by always reading and updating the field using READ_ONCE()
> > > > and WRITE_ONCE(), this silences KCSAN and prevents load and store tearing.
> > >
> > > I'm curious why you mention the load/store tearing, as we discussed this
> > > last time under some READ_ONCE/WRITE_ONCE change it's not happening on
> > > aligned addresses for any integer type, I provided links to intel manuals.
> > 
> > Yes, I do remember that.
> > But that was a different case, it was about a pointer type.
> > 
> > This is a u64. Can't the load/store tearing happen at the very least
> > on 32 bits systems?
> 
> Right, it was for a pointer type. I'll continue searching for a
> definitive answer regarding 64bit types on 32bit architectures.

I have a counter example, but this is a weak "proof by compiler", yet at
least something tangible:

in space-info.c:
void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
                                        u64 chunk_size)
{
        WRITE_ONCE(space_info->chunk_size, chunk_size);
}

This uses _ONCE for the sysfs use case but demonstrates that it does not
prevent load tearing on 32bit:

000012f4 <btrfs_update_space_info_chunk_size>:
    12f4:       /-- e8 fc ff ff ff                      calll  12f5 <btrfs_update_space_info_chunk_size+0x1>
                        12f5: R_386_PC32        __fentry__
    12f9:           55                                  pushl  %ebp
    12fa:           89 e5                               movl   %esp,%ebp
    12fc:           53                                  pushl  %ebx
    12fd:           5b                                  popl   %ebx

    12fe:           89 50 44                            movl   %edx,0x44(%eax)
    1301:           89 48 48                            movl   %ecx,0x48(%eax)

    1304:           5d                                  popl   %ebp
    1305:       /-- e9 fc ff ff ff                      jmpl   1306 <btrfs_update_space_info_chunk_size+0x12>
                        1306: R_386_PC32        __x86_return_thunk
    130a:           66 90                               xchgw  %ax,%ax


eax - first parameter, a pointer to struct
edx - first half of the first parameter (u64)
ecx - second half of the first parameter

I found this example as it easy to identify, many other _ONCE uses are
static inlines or mixed in other code.

I've also tried various compilers on godbolt.org, on 32bit architectures
like MIPS32, SPARC32 and maybe others, there are two (or more)
instructions needed.

The question that remains is if the 2 instruction load/store matters in
case if the value is in one cache line as this depends on the MESI cache
synchronization protocol. The only case I see where it could tear it is
when the process gets rescheduled exactly between the instructions. An
outer lock/mutex synchronization could prevent it so it depends.

