Return-Path: <linux-btrfs+bounces-5744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB04909F44
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97510282A03
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F144C9E;
	Sun, 16 Jun 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nwvrSp49";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kij6vkFs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iiI03uXx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fckqIxtu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2D1CA85
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563228; cv=none; b=u1a4cxNe6BrkzG3NtN3naH4UpK0OLcen0ba0lzDqo0dMxrIM+qKc/wrkAn1dgGisejdxCVzfwZI/LaR/Ib2Acqy2PTIxA0Ux4837yEkjH38DQwcvt70H+MUJ2maUAjXRi27RT9XGN3l2+x8zU9Td0ceYYlIScivH06F96eq7ts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563228; c=relaxed/simple;
	bh=IDCitr2RN70gOivuq5hr2j7d4SpCWN7e1x1OIJ4uiCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K75LMnYIlmDa4ledcyEDvG0NxwUxz/sJIySH0a9yaz2u14JemQ0tREa5wrdvdQttcr0zzSggHMmRr0iPp5pTtPqsjpYfochDgQV6M4N8z5Bm1rwwPB7xEMjcmPbrgvBHRIs8niwxXimkQTEBCMkBS8CestZhdsXU+tGiCil9wuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nwvrSp49; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kij6vkFs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iiI03uXx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fckqIxtu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2A335D5A5;
	Sun, 16 Jun 2024 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718563224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MPqJDY98z5ox+NPVjv2UznErXIsjzTMEXpW54Yqmsc=;
	b=nwvrSp49e06g76dT50WiVCqS6Pt2VWod5oxTakl7qfyUordLMXIS3jS2Z/Lx06VPjJOihP
	RdAWxNHCwo8X11RJgR8qeWdRg+5rDWT9FGjo8CzLM+mJhUbyIxhD24PcU3e7A498v1U5Mu
	bLhPwnYtl5JgsVkNYfLfjHzsoHwok2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718563224;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MPqJDY98z5ox+NPVjv2UznErXIsjzTMEXpW54Yqmsc=;
	b=kij6vkFsaAGbV2E33DnUvnu1BEToQKSyaLxpcPhb+ARSEkXyXBhBdNndlWdjUWar0O55OU
	rqClaH1X+BbTc/Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718563222;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MPqJDY98z5ox+NPVjv2UznErXIsjzTMEXpW54Yqmsc=;
	b=iiI03uXxXQQtwjXE2qjGpKD9jHDmsZGx4GXWQUOYmZA77bSfg+G1rrzoFbrMUd7xSGhAhz
	ZUeY3M3odZCn/nC+iWGUAFRBj5usBV9nVsCsp/TOePolar2HoJawD4Ayk8aNZ8btsBM4iB
	vU7U1bZmkcTmraEO/U4Z7/xRzyGpr/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718563222;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MPqJDY98z5ox+NPVjv2UznErXIsjzTMEXpW54Yqmsc=;
	b=fckqIxtuaPM1D+QiDNL7AE1ZG8msKblufF0Xi0+WLfh1hRc406QlXEBOFrXdRwTEI69WOP
	KmsHDmmzHAhoGTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD92613AA0;
	Sun, 16 Jun 2024 18:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id meIcLpYxb2ZVHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sun, 16 Jun 2024 18:40:22 +0000
Date: Sun, 16 Jun 2024 20:40:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: use NOFS context when getting inodes during
 logging and log replay
Message-ID: <20240616184021.GF25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718276261.git.fdmanana@suse.com>
 <818b41faf6260be972ffa3bd436dda518963384b.1718276261.git.fdmanana@suse.com>
 <04f49180-cdb0-4665-abe4-136dbc85fbb3@gmx.com>
 <CAL3q7H6CPShWF0ik8bgFu42dNySrnq=ZMdg07jUXdgRttHMqiQ@mail.gmail.com>
 <82aea39f-f895-469c-b973-9556980d7732@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82aea39f-f895-469c-b973-9556980d7732@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Jun 14, 2024 at 07:51:44AM +0930, Qu Wenruo wrote:
> >>>       do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
> >>>       vfs_writev+0x36f/0xde0 fs/read_write.c:971
> >>>       do_pwritev+0x1b2/0x260 fs/read_write.c:1072
> >>>       __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
> >>>       __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
> >>>       __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
> >>>       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
> >>>       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
> >>>       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
> >>>       entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> >>>      RIP: 0023:0xf7334579
> >>>      Code: b8 01 10 06 03 (...)
> >>>      RSP: 002b:00000000f5f265ac EFLAGS: 00000292 ORIG_RAX: 000000000000017b
> >>>      RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200002c0
> >>>      RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> >>>      RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> >>>      R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> >>>      R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >>>       </TASK>
> >>>
> >>> Fix this by ensuring we are under a NOFS scope whenever we call
> >>> btrfs_iget() during inode logging and log replay.
> >>>
> >>> Reported-by: syzbot+8576cfa84070dce4d59b@syzkaller.appspotmail.com
> >>> Link: https://lore.kernel.org/linux-btrfs/000000000000274a3a061abbd928@google.com/
> >>> Fixes: 712e36c5f2a7 ("btrfs: use GFP_KERNEL in btrfs_alloc_inode")
> >>
> >> I'm wondering if logging is the only location where we can trigger the
> >> deadlock.
> >>
> >> Would regular inode_get() causing such deadlock?
> >
> > What is inode_get()? I can't find anything with that exact name.
> 
> My bad, I mean iget().
> 
> >
> > If it's some path with a transaction handle open that can trigger
> > btrfs_alloc_inode() then yes, otherwise it depends on what locks are
> > held if any.
> >
> 
> Then would it be safer to revert the offending commit, aka make
> btrfs_alloc_inode() to use the old GFP_NOFS?
> 
> I just checked ext4_alloc_inode() and f2fs_alloc_inode(), both are still
> using NOFS instead.
> 
> Thus I'm wondering if it's really a good idea to go GFP_KERNEL in the
> first place.

In the long run we want to use the scoped NOFS and GFP_KERNEL. All easy
cases have been done (with occasional bugs like this patch fixes).

