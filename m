Return-Path: <linux-btrfs+bounces-17297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0EBAE129
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4901618905C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA84246333;
	Tue, 30 Sep 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dtnu/vXb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0mQbVK/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgGl2cuK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7JfglqxA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3723D7F7
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250465; cv=none; b=Z/jvwQB1owGNrjbWWnh86BJyz0VaAXaRTLucMrUfiasXy+sANY08UqrKE5l3z9MFcXuf1QQZ7FnimWSCsXKQu6Y2CBYpbtWvYpUQkbO9xg0R4TpVU72aB2sWNZJKkJAYI8sEqUtW+YbcYxwJRrPuzKBte2Ab0Yx1kh98DWC3kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250465; c=relaxed/simple;
	bh=x9oNIxAMiVVfsz0EMuzFfrJGKf9BTUA6lWzUFAaQkUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctzUszGu16ix6OwbeBeIzFv6t9owkOUDo6g651/Uwp65vqiFO/4TDeRUyGyddx5For+4JWYqtlJ40KzI+Na+Y9Nlor2FRXbNZPJrCgwSyXVl5oZClnV6uUF+yXIZDAwX/j5XNJ8DU/S15QFUonPv7BzLBuGP5/whTojc24o348M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dtnu/vXb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0mQbVK/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgGl2cuK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7JfglqxA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF4602271B;
	Tue, 30 Sep 2025 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759250459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAknlAYqDUjge5R+NJq3RpP37NTMF/FhxmehxO22m/g=;
	b=Dtnu/vXbkOaHdwApg0GWxS9L++DIkLyjv8/ub7n8DG3+D/V4jLqYREQtM2uriW7XRa6mEf
	/NMPdhBRoBiGLhe3M4m63J3/BJEcNtPJLNCsnmoa8AdRd7wFguRvu403+k/z/kUdZuaYu2
	zMhL2pZzBv8jiqs26rW4L6cs4ZlBK7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759250459;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAknlAYqDUjge5R+NJq3RpP37NTMF/FhxmehxO22m/g=;
	b=r0mQbVK/dORkYyMDglrWOPMzdSuRTKtsgCFiwyCX+oQiSRseVOsjGhJtIZyN/kFbEQrxqF
	N1E2McpIRKHqplAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HgGl2cuK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7JfglqxA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759250458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAknlAYqDUjge5R+NJq3RpP37NTMF/FhxmehxO22m/g=;
	b=HgGl2cuKImRva3Oo17PYKjs4aAiAQymdDauJftGfWOL1BaD4YWLgiZMpRHszCWvMiQNxrJ
	zToUwKDPuSj6Tug3aGWGaqiIy9gBrfCiFCRGIZTvbl2+uKAUXsiEUGGw8kmWc3V2yi3SMF
	hKo3XJJxrPIOuA+qJ+coDzzkEYbJYx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759250458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pAknlAYqDUjge5R+NJq3RpP37NTMF/FhxmehxO22m/g=;
	b=7JfglqxAMA+g91QcAEJtphTkeA9q6wehP9dennLzOK1hUDAAmZaGZhRAZsGC30UwJHvvOl
	BsSOqwVjKkfxfPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B23D213A3F;
	Tue, 30 Sep 2025 16:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X8VWKxoI3GjOAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Sep 2025 16:40:58 +0000
Date: Tue, 30 Sep 2025 18:40:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+bde59221318c592e6346@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: do not use folio_test_partial_kmap() in ASSERT()s
Message-ID: <20250930164057.GD4052@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <035622656afa07c2f8aaaf35cf7f7dee65fb9fe2.1759184652.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035622656afa07c2f8aaaf35cf7f7dee65fb9fe2.1759184652.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CF4602271B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[bde59221318c592e6346];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Tue, Sep 30, 2025 at 07:54:30AM +0930, Qu Wenruo wrote:
> [BUG]
> Syzbot reported an ASSERT() triggered inside scrub:
> 
>   BTRFS info (device loop0): scrub: started on devid 1
>   assertion failed: !folio_test_partial_kmap(folio) :: 0, in fs/btrfs/scrub.c:697
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/scrub.c:697!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 6077 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>   RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
>   Call Trace:
>    <TASK>
>    scrub_bio_add_sector fs/btrfs/scrub.c:932 [inline]
>    scrub_submit_initial_read+0xf21/0x1120 fs/btrfs/scrub.c:1897
>    submit_initial_group_read+0x423/0x5b0 fs/btrfs/scrub.c:1952
>    flush_scrub_stripes+0x18f/0x1150 fs/btrfs/scrub.c:1973
>    scrub_stripe+0xbea/0x2a30 fs/btrfs/scrub.c:2516
>    scrub_chunk+0x2a3/0x430 fs/btrfs/scrub.c:2575
>    scrub_enumerate_chunks+0xa70/0x1350 fs/btrfs/scrub.c:2839
>    btrfs_scrub_dev+0x6e7/0x10e0 fs/btrfs/scrub.c:3153
>    btrfs_ioctl_scrub+0x249/0x4b0 fs/btrfs/ioctl.c:3163
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:597 [inline]
>    __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> Which doesn't make much sense, as all the folios we allocated for scrub
> should not be highmem.
> 
> [CAUSE]
> Thankfully syzbot has a detailed kernel config file, showing that
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is set to y.
> 
> And that debug option will force all folio_test_partial_kmap() to return
> true, to improve coverage on highmem tests.
> 
> But in our case we really just want to make sure the folios we allocated
> are not highmem (and they are indeed not). Such incorrect result from
> folio_test_partial_kmap() is just screwing up everything.
> 
> [FIX]
> Replace folio_test_partial_kmap() to folio_test_highmem() so that we
> won't bother those stupid highmem specific debug options.
> 
> Reported-by: syzbot+bde59221318c592e6346@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
> Upstream PR is not yet merged, thus no proper fixed tag available yet.

Most likely it will be merged without changes, so I'll add the Fixes:
tag.

