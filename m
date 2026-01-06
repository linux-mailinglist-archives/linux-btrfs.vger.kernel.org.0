Return-Path: <linux-btrfs+bounces-20143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18833CF7DD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B1D9301EF20
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D530AABC;
	Tue,  6 Jan 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CSDFpw1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ao4yf32+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CSDFpw1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ao4yf32+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAF1EC01B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696461; cv=none; b=JlKcDDcZLfwzQUvrAE7eAaMNCv+91TeSbvdQmpwFw0/tfVeoZ/YyLNp2N1bP5OFWfumNLd3v3BQlESKvroW4qWTUKZFdusIugWZlAJrAnS3baGglzHNE9HI4Sy1t5vVDkN9h/Mff0hFZzXBmbFDMJvTTw35jXXlEWq2womWkYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696461; c=relaxed/simple;
	bh=5A8nnPi5bP3OueZQn4Rb6wAWMUPxCPyG47BVL17WV44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik6ARXSjNC8LTUm0cGGgKJ5BDZkxD5SRNmOA9jloVtV8TekICGzDqzPIOzUXSrEU44bNUv1He1lhxwQstZo76/172Cb5vn8Qzd6rycsg2QgFxa6f7jl/TMxDwd5laucBffX8NMuRuqHVUm0NhAHOIZNj4tLtBYa4Js5AWVxx8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CSDFpw1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ao4yf32+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CSDFpw1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ao4yf32+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45FC3339D3;
	Tue,  6 Jan 2026 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767696458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwXqKSg2bp/DFmsxlOVXdU0k5jwzIzLj8dWej4rADk8=;
	b=CSDFpw1IFfho/thftucZ17fyDp42zKogpq+0/UYf9rlnsZYx/8li2EfQhbJxXE5pHxWg+C
	+eBCRll2+t3Qj+FJwh+AWp1WuJF0pqsyX4FnlIOCtnv4d3R4GAdL83duDWVRnXzVgXRPdH
	6NZaOvBrQSUOsMAilrsgb/gWg9vpp7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767696458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwXqKSg2bp/DFmsxlOVXdU0k5jwzIzLj8dWej4rADk8=;
	b=Ao4yf32+hUuTrGc3e+k8nIltdzgJqDBzYXpKE7XPLtFqIRhZr4sqHZQCJqP++qlbVBTOIJ
	M5+60yxvABanBPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767696458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwXqKSg2bp/DFmsxlOVXdU0k5jwzIzLj8dWej4rADk8=;
	b=CSDFpw1IFfho/thftucZ17fyDp42zKogpq+0/UYf9rlnsZYx/8li2EfQhbJxXE5pHxWg+C
	+eBCRll2+t3Qj+FJwh+AWp1WuJF0pqsyX4FnlIOCtnv4d3R4GAdL83duDWVRnXzVgXRPdH
	6NZaOvBrQSUOsMAilrsgb/gWg9vpp7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767696458;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwXqKSg2bp/DFmsxlOVXdU0k5jwzIzLj8dWej4rADk8=;
	b=Ao4yf32+hUuTrGc3e+k8nIltdzgJqDBzYXpKE7XPLtFqIRhZr4sqHZQCJqP++qlbVBTOIJ
	M5+60yxvABanBPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 202E23EA63;
	Tue,  6 Jan 2026 10:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FtevB0roXGkdLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Jan 2026 10:47:38 +0000
Date: Tue, 6 Jan 2026 11:47:32 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_put_transaction (5)
Message-ID: <20260106104732.GB21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <695c5f1d.050a0220.1c677c.0335.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695c5f1d.050a0220.1c677c.0335.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a94030c847137a18];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[6d30e046bbd449d3f6f1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.50

On Mon, Jan 05, 2026 at 05:02:21PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b69053dd3ffb wifi: mt76: Remove blank line after mt792x fi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=137c3fb4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d30e046bbd449d3f6f1
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18036fd3b399/disk-b69053dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bcf4c5ec9d8e/vmlinux-b69053dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b4101a9d1eed/bzImage-b69053dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: fs/btrfs/transaction.c:145 at btrfs_put_transaction+0x52d/0x560 fs/btrfs/transaction.c:145, CPU#0: btrfs-transacti/1033

 141 void btrfs_put_transaction(struct btrfs_transaction *transaction)
 142 {
 143         if (refcount_dec_and_test(&transaction->use_count)) {
 144                 BUG_ON(!list_empty(&transaction->list));
 145                 WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));

> Modules linked in:
> CPU: 0 UID: 0 PID: 1033 Comm: btrfs-transacti Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:btrfs_put_transaction+0x52d/0x560 fs/btrfs/transaction.c:145
> Code: 07 fc ff ff e8 94 2a f1 fd 4c 89 f7 be 03 00 00 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b9 1b be 00 e8 74 2a f1 fd 90 <0f> 0b 90 e9 6f fb ff ff e8 66 2a f1 fd 90 0f 0b 90 e9 8c fb ff ff
> RSP: 0018:ffffc900052e7970 EFLAGS: 00010293
> RAX: ffffffff83cfcd4c RBX: ffff8880a4cba000 RCX: ffff888034bf3d00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> RBP: dffffc0000000000 R08: ffff8880a4cba013 R09: 1ffff11014997402
> R10: dffffc0000000000 R11: ffffed1014997403 R12: ffff8880a4cba000
> R13: 0000000000000000 R14: ffff8880a4cba358 R15: ffff88803251cc88
> FS:  0000000000000000(0000) GS:ffff888125e1f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffde9f8b92c CR3: 000000000dd3a000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  btrfs_commit_transaction+0x22cf/0x3b10 fs/btrfs/transaction.c:2598
>  transaction_kthread+0x2b1/0x450 fs/btrfs/disk-io.c:1587
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>

