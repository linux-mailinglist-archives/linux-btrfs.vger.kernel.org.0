Return-Path: <linux-btrfs+bounces-12639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D0A74220
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 02:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420B7178584
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 01:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407FD1C7000;
	Fri, 28 Mar 2025 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ioPTotV0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKXRqATG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ioPTotV0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKXRqATG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43661A262A
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126428; cv=none; b=ncII6DIPqlhTy7RuP1gSPAl5VxXeEwfxpi2EHAERCy9MF7zoTD3Q2JUM36qbes2T5SXj7PNJKEejB62WJryPJI9XfzC2EcwSPp7GwK+GnFxRr7gL4l1quuXJZLytB5Vcqy/CWionB/tXSqW+nEDW5Hvfjc+YwcMDxw5GXlZa6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126428; c=relaxed/simple;
	bh=rYYdBxzN5i5YAbqv98pfWzYHhp0J0WEBQILGnRoBc38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFaOGcnD80cEDsJ7AAL9XbzTj0WQJLc2E4NJHfDW9rf0PEnD+a34mMpuhNaJGEDkLAo4nF8Mn+RqyICJVeKeDb2mijagqyFNj6k7yF0HcWMxBN9/tLeVbpPJ1JGzoJw4SDNdNRfkxCRP+OFDXpBuGjbih82Iezwka28ZcuYSJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ioPTotV0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKXRqATG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ioPTotV0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKXRqATG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B74811F388;
	Fri, 28 Mar 2025 01:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743126424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kl9aUB04fNZnJsoFFu+H4ffphOpCyALZJXRZYEzeKHk=;
	b=ioPTotV0trq//tl/Jel0ZiWElbUxgf0yEjsiuTK+pvwBMi351pQoO/EtgnXPc+iHE6uSp0
	w09fVtqa6AHsADdYbVIvaPednQMaKwErt3qJxiPvMGDfH2Z7gwaGpBPwrKsDLiCNZJhzRI
	xFI5r+IZ3OYcC7KS4iIzBTc/9WzgIwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743126424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kl9aUB04fNZnJsoFFu+H4ffphOpCyALZJXRZYEzeKHk=;
	b=wKXRqATG2mlyC12GTbm97BhIkak0UcOzFp5MC3X8BY/g7dfk9XWxespb6zfiAe+PwK7Z8z
	wPEJIK9ntcUE02CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ioPTotV0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wKXRqATG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743126424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kl9aUB04fNZnJsoFFu+H4ffphOpCyALZJXRZYEzeKHk=;
	b=ioPTotV0trq//tl/Jel0ZiWElbUxgf0yEjsiuTK+pvwBMi351pQoO/EtgnXPc+iHE6uSp0
	w09fVtqa6AHsADdYbVIvaPednQMaKwErt3qJxiPvMGDfH2Z7gwaGpBPwrKsDLiCNZJhzRI
	xFI5r+IZ3OYcC7KS4iIzBTc/9WzgIwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743126424;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kl9aUB04fNZnJsoFFu+H4ffphOpCyALZJXRZYEzeKHk=;
	b=wKXRqATG2mlyC12GTbm97BhIkak0UcOzFp5MC3X8BY/g7dfk9XWxespb6zfiAe+PwK7Z8z
	wPEJIK9ntcUE02CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94134137AC;
	Fri, 28 Mar 2025 01:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AkHxI5j/5WcWHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Mar 2025 01:47:04 +0000
Date: Fri, 28 Mar 2025 02:46:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: remove folio order ASSERT()s in super block
 writeback path
Message-ID: <20250328014655.GE32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <92a474470c6230241d7ebff3673c3d624c38ae6a.1743110853.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a474470c6230241d7ebff3673c3d624c38ae6a.1743110853.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B74811F388
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[34122898a11ab689518a];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Mar 28, 2025 at 07:59:12AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a syzbot report that the ASSERT() inside write_dev_supers() got
> triggered:
> 
>   assertion failed: folio_order(folio) == 0, in fs/btrfs/disk-io.c:3858
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/disk-io.c:3858!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 0 UID: 0 PID: 6730 Comm: syz-executor378 Not tainted 6.14.0-syzkaller-03565-gf6e0150b2003 #0 PREEMPT(full)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>   RIP: 0010:write_dev_supers fs/btrfs/disk-io.c:3858 [inline]
>   RIP: 0010:write_all_supers+0x400f/0x4090 fs/btrfs/disk-io.c:4155
>   Call Trace:
>    <TASK>
>    btrfs_commit_transaction+0x1eda/0x3750 fs/btrfs/transaction.c:2528
>    btrfs_quota_enable+0xfcc/0x21a0 fs/btrfs/qgroup.c:1226
>    btrfs_ioctl_quota_ctl+0x144/0x1c0 fs/btrfs/ioctl.c:3677
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:906 [inline]
>    __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   RIP: 0033:0x7f5ad1f20289
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> Since commit f93ee0df5139 ("btrfs: convert super block writes to folio
> in write_dev_supers()") and commit c94b7349b859 ("btrfs: convert super
> block writes to folio in wait_dev_supers()"), the super block writeback
> path is converted to use folio.
> 
> Since the original code is using page based interfaces, we have an
> "ASSERT(folio_order(folio) == 0);" added to make sure everything is not
> changed.
> 
> But the folio here is not from any btrfs inode, but from the block
> device, and we have no control on the folio order in bdev, the device
> can choose whatever folio size they want/need.
> 
> E.g. the bdev may even have a block size of multiple pages.
> 
> So the ASSERT() is triggered.
> 
> [FIX]
> The super block writeback path has taken larger folios into
> consideration, so there is no need for the ASSERT().
> 
> And since commit bc00965dbff7 ("btrfs: count super block write errors in
> device instead of tracking folio error state"), the wait path no longer
> checks the folio status but only wait for the folio writeback to finish,
> there is nothing requiring the ASSERT() either.
> 
> So we can remove both ASSERT()s safely now.
> 
> Reported-by: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
> Our super block read path is still using page interfaces, and I believe
> it's better to migrate to the folio interfaces with large folio support.

Yeah, it's the page API wrapping folios anyway.

