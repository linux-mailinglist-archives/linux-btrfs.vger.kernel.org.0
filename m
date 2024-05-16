Return-Path: <linux-btrfs+bounces-5045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF37A8C791B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6575D284ACE
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2614D42C;
	Thu, 16 May 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bh/Lcs3B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="peqCUhu9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bh/Lcs3B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="peqCUhu9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D461E491;
	Thu, 16 May 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872530; cv=none; b=UklfUP9ylM1T3dH/r4oXubFiby5r58DcYFlNBNbwVB3WtuDJ8kq/JxRWEIN4G6Byzhcj9YxqwMSDQTgQlnH3j1meP/pVq7AQ27sHy7lHpZ03y03Lv/0OulijRSHiH91egu6QkWLht0H74CH2SyADuEPWUaJFMU/M+QdGHwOFdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872530; c=relaxed/simple;
	bh=x7DdXYnCzFVdBqewRXoNz1fX6UgbGzwW5h5AT+08kj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvih4nf8eQ5GajfEcqQ3JODltszQ1jGapOubEvFtkdV4shuGcpD5j63Ap5mSbsR9s+FJAmR5nI7ICHaDo6x+yuU5eFWDCmJmXNI32xVhfo3dEcBW0APrtYs7U+DriNKnE7KhoVo+/m9xUtVjvfJ0QFh4Oy5APQ0XoOu7eGug55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bh/Lcs3B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=peqCUhu9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bh/Lcs3B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=peqCUhu9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C707734459;
	Thu, 16 May 2024 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715872526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0inhXTwA4YjeQwB4Bizlo9EYy4r9uL0TfMoT/ThxIc=;
	b=bh/Lcs3BgoBJfFVid6PVFu9vMlzBqbXKo49X/ayUHr4WE2yFU1o2GSgMVJtxFJrlS38qGe
	GqzZr9PEp+XzfMQv/DxYmh1SxR8YxUkcap6ELe770ZsOPO/22Uy5+pMYorxL2zriAsWohi
	1ogbSjJAlPbNPWwlk9tAw8GBDMYdcBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715872526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0inhXTwA4YjeQwB4Bizlo9EYy4r9uL0TfMoT/ThxIc=;
	b=peqCUhu9XBMEmd/EnpR2cjB/JKlvmq7y/sTu7cphgaiTw+wO3RbT5WkrmMz7MnNjc0jvNm
	v+CFs6rMareJ5mBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715872526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0inhXTwA4YjeQwB4Bizlo9EYy4r9uL0TfMoT/ThxIc=;
	b=bh/Lcs3BgoBJfFVid6PVFu9vMlzBqbXKo49X/ayUHr4WE2yFU1o2GSgMVJtxFJrlS38qGe
	GqzZr9PEp+XzfMQv/DxYmh1SxR8YxUkcap6ELe770ZsOPO/22Uy5+pMYorxL2zriAsWohi
	1ogbSjJAlPbNPWwlk9tAw8GBDMYdcBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715872526;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0inhXTwA4YjeQwB4Bizlo9EYy4r9uL0TfMoT/ThxIc=;
	b=peqCUhu9XBMEmd/EnpR2cjB/JKlvmq7y/sTu7cphgaiTw+wO3RbT5WkrmMz7MnNjc0jvNm
	v+CFs6rMareJ5mBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9216137C3;
	Thu, 16 May 2024 15:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3VkeKQ4jRmZNTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:15:26 +0000
Date: Thu, 16 May 2024 17:15:24 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+89700d262ed1fb9f9351@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in __set_extent_bit
Message-ID: <20240516151524.GB4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000006deae405f1fac97a@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006deae405f1fac97a@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2573056c6a11f00d];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[89700d262ed1fb9f9351];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Wed, Jan 11, 2023 at 02:51:47AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    358a161a6a9e Merge branch 'for-next/fixes' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=12115e1c480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2573056c6a11f00d
> dashboard link: https://syzkaller.appspot.com/bug?extid=89700d262ed1fb9f9351
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13abc0a6480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1153e53c480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/99d14e0f4c19/disk-358a161a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/23275b612976/vmlinux-358a161a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed79195fac61/Image-358a161a.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/fdb7b054a0c8/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+89700d262ed1fb9f9351@syzkaller.appspotmail.com
> 
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent-io-tree.c:379!

set_state_bits()

	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
	BUG_ON(ret < 0);
	state->state |= bits_to_set;

ret is -ENOMEM (returned in register x1), known problem in general in
the state helpers everywhere, it's hard to fix as there's little change
of rollback.

